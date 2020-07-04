package zpp_nape.space
{
   import nape.geom.Mat23;
   import nape.geom.RayResult;
   import nape.geom.RayResultList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyList;
   import nape.phys.BodyType;
   import nape.shape.Circle;
   import nape.shape.Polygon;
   import nape.shape.Shape;
   import nape.shape.ShapeList;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Ray;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.shape.ZPP_Edge;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZNPNode_ZPP_Edge;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_Broadphase
   {
       
      
      public var sweep:ZPP_SweepPhase;
      
      public var space:ZPP_Space;
      
      public var is_sweep:Boolean;
      
      public var dynab:ZPP_DynAABBPhase;
      
      public var circShape:Shape;
      
      public var aabbShape:Shape;
      
      public function ZPP_Broadphase()
      {
      }
      
      public function validateShape(param1:ZPP_Shape) : void
      {
         var _loc2_:* = null as ZPP_Polygon;
         var _loc3_:* = null as ZPP_Body;
         var _loc4_:* = null as ZNPNode_ZPP_Edge;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZPP_Edge;
         var _loc9_:* = null as ZPP_Circle;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:Number = NaN;
         var _loc13_:* = null as ZPP_Vec2;
         if(param1.type == ZPP_Flags.id_ShapeType_POLYGON)
         {
            _loc2_ = param1.polygon;
            if(_loc2_.zip_gaxi)
            {
               if(_loc2_.body != null)
               {
                  _loc2_.zip_gaxi = false;
                  _loc2_.validate_laxi();
                  _loc3_ = _loc2_.body;
                  if(_loc3_.zip_axis)
                  {
                     _loc3_.zip_axis = false;
                     _loc3_.axisx = Number(Math.sin(_loc3_.rot));
                     _loc3_.axisy = Number(Math.cos(_loc3_.rot));
                     null;
                  }
                  _loc4_ = _loc2_.edges.head;
                  _loc5_ = _loc2_.gverts.next;
                  _loc6_ = _loc5_;
                  _loc5_ = _loc5_.next;
                  while(_loc5_ != null)
                  {
                     _loc7_ = _loc5_;
                     _loc8_ = _loc4_.elt;
                     _loc4_ = _loc4_.next;
                     _loc8_.gp0 = _loc6_;
                     _loc8_.gp1 = _loc7_;
                     _loc8_.gnormx = _loc2_.body.axisy * _loc8_.lnormx - _loc2_.body.axisx * _loc8_.lnormy;
                     _loc8_.gnormy = Number(_loc8_.lnormx * _loc2_.body.axisx + _loc8_.lnormy * _loc2_.body.axisy);
                     _loc8_.gprojection = Number(Number(_loc2_.body.posx * _loc8_.gnormx + _loc2_.body.posy * _loc8_.gnormy) + _loc8_.lprojection);
                     if(_loc8_.wrap_gnorm != null)
                     {
                        _loc8_.wrap_gnorm.zpp_inner.x = _loc8_.gnormx;
                        _loc8_.wrap_gnorm.zpp_inner.y = _loc8_.gnormy;
                     }
                     _loc8_.tp0 = _loc8_.gp0.y * _loc8_.gnormx - _loc8_.gp0.x * _loc8_.gnormy;
                     _loc8_.tp1 = _loc8_.gp1.y * _loc8_.gnormx - _loc8_.gp1.x * _loc8_.gnormy;
                     _loc6_ = _loc7_;
                     _loc5_ = _loc5_.next;
                  }
                  _loc7_ = _loc2_.gverts.next;
                  _loc8_ = _loc4_.elt;
                  _loc4_ = _loc4_.next;
                  _loc8_.gp0 = _loc6_;
                  _loc8_.gp1 = _loc7_;
                  _loc8_.gnormx = _loc2_.body.axisy * _loc8_.lnormx - _loc2_.body.axisx * _loc8_.lnormy;
                  _loc8_.gnormy = Number(_loc8_.lnormx * _loc2_.body.axisx + _loc8_.lnormy * _loc2_.body.axisy);
                  _loc8_.gprojection = Number(Number(_loc2_.body.posx * _loc8_.gnormx + _loc2_.body.posy * _loc8_.gnormy) + _loc8_.lprojection);
                  if(_loc8_.wrap_gnorm != null)
                  {
                     _loc8_.wrap_gnorm.zpp_inner.x = _loc8_.gnormx;
                     _loc8_.wrap_gnorm.zpp_inner.y = _loc8_.gnormy;
                  }
                  _loc8_.tp0 = _loc8_.gp0.y * _loc8_.gnormx - _loc8_.gp0.x * _loc8_.gnormy;
                  _loc8_.tp1 = _loc8_.gp1.y * _loc8_.gnormx - _loc8_.gp1.x * _loc8_.gnormy;
               }
            }
         }
         if(param1.zip_aabb)
         {
            if(param1.body != null)
            {
               param1.zip_aabb = false;
               if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc9_ = param1.circle;
                  if(_loc9_.zip_worldCOM)
                  {
                     if(_loc9_.body != null)
                     {
                        _loc9_.zip_worldCOM = false;
                        if(_loc9_.zip_localCOM)
                        {
                           _loc9_.zip_localCOM = false;
                           if(_loc9_.type == ZPP_Flags.id_ShapeType_POLYGON)
                           {
                              _loc2_ = _loc9_.polygon;
                              if(_loc2_.lverts.next.next == null)
                              {
                                 _loc2_.localCOMx = _loc2_.lverts.next.x;
                                 _loc2_.localCOMy = _loc2_.lverts.next.y;
                                 null;
                              }
                              else if(_loc2_.lverts.next.next.next == null)
                              {
                                 _loc2_.localCOMx = _loc2_.lverts.next.x;
                                 _loc2_.localCOMy = _loc2_.lverts.next.y;
                                 _loc10_ = 1;
                                 _loc2_.localCOMx = Number(_loc2_.localCOMx + _loc2_.lverts.next.next.x * _loc10_);
                                 _loc2_.localCOMy = Number(_loc2_.localCOMy + _loc2_.lverts.next.next.y * _loc10_);
                                 _loc10_ = 0.5;
                                 _loc2_.localCOMx = _loc2_.localCOMx * _loc10_;
                                 _loc2_.localCOMy = _loc2_.localCOMy * _loc10_;
                              }
                              else
                              {
                                 _loc2_.localCOMx = 0;
                                 _loc2_.localCOMy = 0;
                                 _loc10_ = 0;
                                 _loc5_ = _loc2_.lverts.next;
                                 _loc6_ = _loc5_;
                                 _loc5_ = _loc5_.next;
                                 _loc7_ = _loc5_;
                                 _loc5_ = _loc5_.next;
                                 while(_loc5_ != null)
                                 {
                                    _loc11_ = _loc5_;
                                    _loc10_ = Number(_loc10_ + _loc7_.x * (_loc11_.y - _loc6_.y));
                                    _loc12_ = _loc11_.y * _loc7_.x - _loc11_.x * _loc7_.y;
                                    _loc2_.localCOMx = Number(_loc2_.localCOMx + (_loc7_.x + _loc11_.x) * _loc12_);
                                    _loc2_.localCOMy = Number(_loc2_.localCOMy + (_loc7_.y + _loc11_.y) * _loc12_);
                                    _loc6_ = _loc7_;
                                    _loc7_ = _loc11_;
                                    _loc5_ = _loc5_.next;
                                 }
                                 _loc5_ = _loc2_.lverts.next;
                                 _loc11_ = _loc5_;
                                 _loc10_ = Number(_loc10_ + _loc7_.x * (_loc11_.y - _loc6_.y));
                                 _loc12_ = _loc11_.y * _loc7_.x - _loc11_.x * _loc7_.y;
                                 _loc2_.localCOMx = Number(_loc2_.localCOMx + (_loc7_.x + _loc11_.x) * _loc12_);
                                 _loc2_.localCOMy = Number(_loc2_.localCOMy + (_loc7_.y + _loc11_.y) * _loc12_);
                                 _loc6_ = _loc7_;
                                 _loc7_ = _loc11_;
                                 _loc5_ = _loc5_.next;
                                 _loc13_ = _loc5_;
                                 _loc10_ = Number(_loc10_ + _loc7_.x * (_loc13_.y - _loc6_.y));
                                 _loc12_ = _loc13_.y * _loc7_.x - _loc13_.x * _loc7_.y;
                                 _loc2_.localCOMx = Number(_loc2_.localCOMx + (_loc7_.x + _loc13_.x) * _loc12_);
                                 _loc2_.localCOMy = Number(_loc2_.localCOMy + (_loc7_.y + _loc13_.y) * _loc12_);
                                 _loc10_ = 1 / (3 * _loc10_);
                                 _loc12_ = _loc10_;
                                 _loc2_.localCOMx = _loc2_.localCOMx * _loc12_;
                                 _loc2_.localCOMy = _loc2_.localCOMy * _loc12_;
                              }
                           }
                           if(_loc9_.wrap_localCOM != null)
                           {
                              _loc9_.wrap_localCOM.zpp_inner.x = _loc9_.localCOMx;
                              _loc9_.wrap_localCOM.zpp_inner.y = _loc9_.localCOMy;
                           }
                        }
                        _loc3_ = _loc9_.body;
                        if(_loc3_.zip_axis)
                        {
                           _loc3_.zip_axis = false;
                           _loc3_.axisx = Number(Math.sin(_loc3_.rot));
                           _loc3_.axisy = Number(Math.cos(_loc3_.rot));
                           null;
                        }
                        _loc9_.worldCOMx = Number(_loc9_.body.posx + (_loc9_.body.axisy * _loc9_.localCOMx - _loc9_.body.axisx * _loc9_.localCOMy));
                        _loc9_.worldCOMy = Number(_loc9_.body.posy + (Number(_loc9_.localCOMx * _loc9_.body.axisx + _loc9_.localCOMy * _loc9_.body.axisy)));
                        if(_loc9_.wrap_worldCOM != null)
                        {
                           _loc9_.wrap_worldCOM.zpp_inner.x = _loc9_.worldCOMx;
                           _loc9_.wrap_worldCOM.zpp_inner.y = _loc9_.worldCOMy;
                        }
                     }
                  }
                  _loc10_ = _loc9_.radius;
                  _loc12_ = _loc9_.radius;
                  _loc9_.aabb.minx = _loc9_.worldCOMx - _loc10_;
                  _loc9_.aabb.miny = _loc9_.worldCOMy - _loc12_;
                  _loc9_.aabb.maxx = Number(_loc9_.worldCOMx + _loc10_);
                  _loc9_.aabb.maxy = Number(_loc9_.worldCOMy + _loc12_);
               }
               else
               {
                  _loc2_ = param1.polygon;
                  if(_loc2_.zip_gverts)
                  {
                     if(_loc2_.body != null)
                     {
                        _loc2_.zip_gverts = false;
                        _loc2_.validate_lverts();
                        _loc3_ = _loc2_.body;
                        if(_loc3_.zip_axis)
                        {
                           _loc3_.zip_axis = false;
                           _loc3_.axisx = Number(Math.sin(_loc3_.rot));
                           _loc3_.axisy = Number(Math.cos(_loc3_.rot));
                           null;
                        }
                        _loc5_ = _loc2_.lverts.next;
                        _loc6_ = _loc2_.gverts.next;
                        while(_loc6_ != null)
                        {
                           _loc7_ = _loc6_;
                           _loc11_ = _loc5_;
                           _loc5_ = _loc5_.next;
                           _loc7_.x = Number(_loc2_.body.posx + (_loc2_.body.axisy * _loc11_.x - _loc2_.body.axisx * _loc11_.y));
                           _loc7_.y = Number(_loc2_.body.posy + (Number(_loc11_.x * _loc2_.body.axisx + _loc11_.y * _loc2_.body.axisy)));
                           _loc6_ = _loc6_.next;
                        }
                     }
                  }
                  _loc5_ = _loc2_.gverts.next;
                  _loc2_.aabb.minx = _loc5_.x;
                  _loc2_.aabb.miny = _loc5_.y;
                  _loc2_.aabb.maxx = _loc5_.x;
                  _loc2_.aabb.maxy = _loc5_.y;
                  _loc6_ = _loc2_.gverts.next.next;
                  while(_loc6_ != null)
                  {
                     _loc7_ = _loc6_;
                     if(_loc7_.x < _loc2_.aabb.minx)
                     {
                        _loc2_.aabb.minx = _loc7_.x;
                     }
                     if(_loc7_.x > _loc2_.aabb.maxx)
                     {
                        _loc2_.aabb.maxx = _loc7_.x;
                     }
                     if(_loc7_.y < _loc2_.aabb.miny)
                     {
                        _loc2_.aabb.miny = _loc7_.y;
                     }
                     if(_loc7_.y > _loc2_.aabb.maxy)
                     {
                        _loc2_.aabb.maxy = _loc7_.y;
                     }
                     _loc6_ = _loc6_.next;
                  }
               }
            }
         }
         if(param1.zip_worldCOM)
         {
            if(param1.body != null)
            {
               param1.zip_worldCOM = false;
               if(param1.zip_localCOM)
               {
                  param1.zip_localCOM = false;
                  if(param1.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc2_ = param1.polygon;
                     if(_loc2_.lverts.next.next == null)
                     {
                        _loc2_.localCOMx = _loc2_.lverts.next.x;
                        _loc2_.localCOMy = _loc2_.lverts.next.y;
                        null;
                     }
                     else if(_loc2_.lverts.next.next.next == null)
                     {
                        _loc2_.localCOMx = _loc2_.lverts.next.x;
                        _loc2_.localCOMy = _loc2_.lverts.next.y;
                        _loc10_ = 1;
                        _loc2_.localCOMx = Number(_loc2_.localCOMx + _loc2_.lverts.next.next.x * _loc10_);
                        _loc2_.localCOMy = Number(_loc2_.localCOMy + _loc2_.lverts.next.next.y * _loc10_);
                        _loc10_ = 0.5;
                        _loc2_.localCOMx = _loc2_.localCOMx * _loc10_;
                        _loc2_.localCOMy = _loc2_.localCOMy * _loc10_;
                     }
                     else
                     {
                        _loc2_.localCOMx = 0;
                        _loc2_.localCOMy = 0;
                        _loc10_ = 0;
                        _loc5_ = _loc2_.lverts.next;
                        _loc6_ = _loc5_;
                        _loc5_ = _loc5_.next;
                        _loc7_ = _loc5_;
                        _loc5_ = _loc5_.next;
                        while(_loc5_ != null)
                        {
                           _loc11_ = _loc5_;
                           _loc10_ = Number(_loc10_ + _loc7_.x * (_loc11_.y - _loc6_.y));
                           _loc12_ = _loc11_.y * _loc7_.x - _loc11_.x * _loc7_.y;
                           _loc2_.localCOMx = Number(_loc2_.localCOMx + (_loc7_.x + _loc11_.x) * _loc12_);
                           _loc2_.localCOMy = Number(_loc2_.localCOMy + (_loc7_.y + _loc11_.y) * _loc12_);
                           _loc6_ = _loc7_;
                           _loc7_ = _loc11_;
                           _loc5_ = _loc5_.next;
                        }
                        _loc5_ = _loc2_.lverts.next;
                        _loc11_ = _loc5_;
                        _loc10_ = Number(_loc10_ + _loc7_.x * (_loc11_.y - _loc6_.y));
                        _loc12_ = _loc11_.y * _loc7_.x - _loc11_.x * _loc7_.y;
                        _loc2_.localCOMx = Number(_loc2_.localCOMx + (_loc7_.x + _loc11_.x) * _loc12_);
                        _loc2_.localCOMy = Number(_loc2_.localCOMy + (_loc7_.y + _loc11_.y) * _loc12_);
                        _loc6_ = _loc7_;
                        _loc7_ = _loc11_;
                        _loc5_ = _loc5_.next;
                        _loc13_ = _loc5_;
                        _loc10_ = Number(_loc10_ + _loc7_.x * (_loc13_.y - _loc6_.y));
                        _loc12_ = _loc13_.y * _loc7_.x - _loc13_.x * _loc7_.y;
                        _loc2_.localCOMx = Number(_loc2_.localCOMx + (_loc7_.x + _loc13_.x) * _loc12_);
                        _loc2_.localCOMy = Number(_loc2_.localCOMy + (_loc7_.y + _loc13_.y) * _loc12_);
                        _loc10_ = 1 / (3 * _loc10_);
                        _loc12_ = _loc10_;
                        _loc2_.localCOMx = _loc2_.localCOMx * _loc12_;
                        _loc2_.localCOMy = _loc2_.localCOMy * _loc12_;
                     }
                  }
                  if(param1.wrap_localCOM != null)
                  {
                     param1.wrap_localCOM.zpp_inner.x = param1.localCOMx;
                     param1.wrap_localCOM.zpp_inner.y = param1.localCOMy;
                  }
               }
               _loc3_ = param1.body;
               if(_loc3_.zip_axis)
               {
                  _loc3_.zip_axis = false;
                  _loc3_.axisx = Number(Math.sin(_loc3_.rot));
                  _loc3_.axisy = Number(Math.cos(_loc3_.rot));
                  null;
               }
               param1.worldCOMx = Number(param1.body.posx + (param1.body.axisy * param1.localCOMx - param1.body.axisx * param1.localCOMy));
               param1.worldCOMy = Number(param1.body.posy + (Number(param1.localCOMx * param1.body.axisx + param1.localCOMy * param1.body.axisy)));
               if(param1.wrap_worldCOM != null)
               {
                  param1.wrap_worldCOM.zpp_inner.x = param1.worldCOMx;
                  param1.wrap_worldCOM.zpp_inner.y = param1.worldCOMy;
               }
            }
         }
      }
      
      public function updateCircShape(param1:Number, param2:Number, param3:Number) : void
      {
         var _loc4_:* = null as Body;
         var _loc5_:* = null as Shape;
         var _loc6_:* = null as ZPP_Circle;
         var _loc7_:Number = NaN;
         var _loc9_:* = null as ZPP_Polygon;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc13_:* = null as ZPP_Vec2;
         var _loc14_:Number = NaN;
         var _loc15_:* = null as ZPP_Vec2;
         var _loc16_:* = null as ZPP_Body;
         if(circShape == null)
         {
            §§push();
            if(ZPP_Flags.BodyType_STATIC == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.BodyType_STATIC = new BodyType();
               ZPP_Flags.§internal§ = false;
            }
            _loc4_ = new §§pop().Body(ZPP_Flags.BodyType_STATIC);
            _loc5_ = new Circle(param3,Vec2.get(param1,param2));
            circShape = _loc5_;
            _loc4_.zpp_inner.wrap_shapes.add(_loc5_);
         }
         else
         {
            _loc6_ = circShape.zpp_inner.circle;
            _loc7_ = param3 / _loc6_.radius;
            circShape.transform(new Mat23(_loc7_,0,0,_loc7_,param1 - _loc7_ * _loc6_.localCOMx,param2 - _loc7_ * _loc6_.localCOMy));
         }
         var _loc8_:ZPP_Shape = circShape.zpp_inner;
         if(_loc8_.zip_aabb)
         {
            if(_loc8_.body != null)
            {
               _loc8_.zip_aabb = false;
               if(_loc8_.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc6_ = _loc8_.circle;
                  if(_loc6_.zip_worldCOM)
                  {
                     if(_loc6_.body != null)
                     {
                        _loc6_.zip_worldCOM = false;
                        if(_loc6_.zip_localCOM)
                        {
                           _loc6_.zip_localCOM = false;
                           if(_loc6_.type == ZPP_Flags.id_ShapeType_POLYGON)
                           {
                              _loc9_ = _loc6_.polygon;
                              if(_loc9_.lverts.next.next == null)
                              {
                                 _loc9_.localCOMx = _loc9_.lverts.next.x;
                                 _loc9_.localCOMy = _loc9_.lverts.next.y;
                                 null;
                              }
                              else if(_loc9_.lverts.next.next.next == null)
                              {
                                 _loc9_.localCOMx = _loc9_.lverts.next.x;
                                 _loc9_.localCOMy = _loc9_.lverts.next.y;
                                 _loc7_ = 1;
                                 _loc9_.localCOMx = Number(_loc9_.localCOMx + _loc9_.lverts.next.next.x * _loc7_);
                                 _loc9_.localCOMy = Number(_loc9_.localCOMy + _loc9_.lverts.next.next.y * _loc7_);
                                 _loc7_ = 0.5;
                                 _loc9_.localCOMx = _loc9_.localCOMx * _loc7_;
                                 _loc9_.localCOMy = _loc9_.localCOMy * _loc7_;
                              }
                              else
                              {
                                 _loc9_.localCOMx = 0;
                                 _loc9_.localCOMy = 0;
                                 _loc7_ = 0;
                                 _loc10_ = _loc9_.lverts.next;
                                 _loc11_ = _loc10_;
                                 _loc10_ = _loc10_.next;
                                 _loc12_ = _loc10_;
                                 _loc10_ = _loc10_.next;
                                 while(_loc10_ != null)
                                 {
                                    _loc13_ = _loc10_;
                                    _loc7_ = Number(_loc7_ + _loc12_.x * (_loc13_.y - _loc11_.y));
                                    _loc14_ = _loc13_.y * _loc12_.x - _loc13_.x * _loc12_.y;
                                    _loc9_.localCOMx = Number(_loc9_.localCOMx + (_loc12_.x + _loc13_.x) * _loc14_);
                                    _loc9_.localCOMy = Number(_loc9_.localCOMy + (_loc12_.y + _loc13_.y) * _loc14_);
                                    _loc11_ = _loc12_;
                                    _loc12_ = _loc13_;
                                    _loc10_ = _loc10_.next;
                                 }
                                 _loc10_ = _loc9_.lverts.next;
                                 _loc13_ = _loc10_;
                                 _loc7_ = Number(_loc7_ + _loc12_.x * (_loc13_.y - _loc11_.y));
                                 _loc14_ = _loc13_.y * _loc12_.x - _loc13_.x * _loc12_.y;
                                 _loc9_.localCOMx = Number(_loc9_.localCOMx + (_loc12_.x + _loc13_.x) * _loc14_);
                                 _loc9_.localCOMy = Number(_loc9_.localCOMy + (_loc12_.y + _loc13_.y) * _loc14_);
                                 _loc11_ = _loc12_;
                                 _loc12_ = _loc13_;
                                 _loc10_ = _loc10_.next;
                                 _loc15_ = _loc10_;
                                 _loc7_ = Number(_loc7_ + _loc12_.x * (_loc15_.y - _loc11_.y));
                                 _loc14_ = _loc15_.y * _loc12_.x - _loc15_.x * _loc12_.y;
                                 _loc9_.localCOMx = Number(_loc9_.localCOMx + (_loc12_.x + _loc15_.x) * _loc14_);
                                 _loc9_.localCOMy = Number(_loc9_.localCOMy + (_loc12_.y + _loc15_.y) * _loc14_);
                                 _loc7_ = 1 / (3 * _loc7_);
                                 _loc14_ = _loc7_;
                                 _loc9_.localCOMx = _loc9_.localCOMx * _loc14_;
                                 _loc9_.localCOMy = _loc9_.localCOMy * _loc14_;
                              }
                           }
                           if(_loc6_.wrap_localCOM != null)
                           {
                              _loc6_.wrap_localCOM.zpp_inner.x = _loc6_.localCOMx;
                              _loc6_.wrap_localCOM.zpp_inner.y = _loc6_.localCOMy;
                           }
                        }
                        _loc16_ = _loc6_.body;
                        if(_loc16_.zip_axis)
                        {
                           _loc16_.zip_axis = false;
                           _loc16_.axisx = Number(Math.sin(_loc16_.rot));
                           _loc16_.axisy = Number(Math.cos(_loc16_.rot));
                           null;
                        }
                        _loc6_.worldCOMx = Number(_loc6_.body.posx + (_loc6_.body.axisy * _loc6_.localCOMx - _loc6_.body.axisx * _loc6_.localCOMy));
                        _loc6_.worldCOMy = Number(_loc6_.body.posy + (Number(_loc6_.localCOMx * _loc6_.body.axisx + _loc6_.localCOMy * _loc6_.body.axisy)));
                        if(_loc6_.wrap_worldCOM != null)
                        {
                           _loc6_.wrap_worldCOM.zpp_inner.x = _loc6_.worldCOMx;
                           _loc6_.wrap_worldCOM.zpp_inner.y = _loc6_.worldCOMy;
                        }
                     }
                  }
                  _loc7_ = _loc6_.radius;
                  _loc14_ = _loc6_.radius;
                  _loc6_.aabb.minx = _loc6_.worldCOMx - _loc7_;
                  _loc6_.aabb.miny = _loc6_.worldCOMy - _loc14_;
                  _loc6_.aabb.maxx = Number(_loc6_.worldCOMx + _loc7_);
                  _loc6_.aabb.maxy = Number(_loc6_.worldCOMy + _loc14_);
               }
               else
               {
                  _loc9_ = _loc8_.polygon;
                  if(_loc9_.zip_gverts)
                  {
                     if(_loc9_.body != null)
                     {
                        _loc9_.zip_gverts = false;
                        _loc9_.validate_lverts();
                        _loc16_ = _loc9_.body;
                        if(_loc16_.zip_axis)
                        {
                           _loc16_.zip_axis = false;
                           _loc16_.axisx = Number(Math.sin(_loc16_.rot));
                           _loc16_.axisy = Number(Math.cos(_loc16_.rot));
                           null;
                        }
                        _loc10_ = _loc9_.lverts.next;
                        _loc11_ = _loc9_.gverts.next;
                        while(_loc11_ != null)
                        {
                           _loc12_ = _loc11_;
                           _loc13_ = _loc10_;
                           _loc10_ = _loc10_.next;
                           _loc12_.x = Number(_loc9_.body.posx + (_loc9_.body.axisy * _loc13_.x - _loc9_.body.axisx * _loc13_.y));
                           _loc12_.y = Number(_loc9_.body.posy + (Number(_loc13_.x * _loc9_.body.axisx + _loc13_.y * _loc9_.body.axisy)));
                           _loc11_ = _loc11_.next;
                        }
                     }
                  }
                  _loc10_ = _loc9_.gverts.next;
                  _loc9_.aabb.minx = _loc10_.x;
                  _loc9_.aabb.miny = _loc10_.y;
                  _loc9_.aabb.maxx = _loc10_.x;
                  _loc9_.aabb.maxy = _loc10_.y;
                  _loc11_ = _loc9_.gverts.next.next;
                  while(_loc11_ != null)
                  {
                     _loc12_ = _loc11_;
                     if(_loc12_.x < _loc9_.aabb.minx)
                     {
                        _loc9_.aabb.minx = _loc12_.x;
                     }
                     if(_loc12_.x > _loc9_.aabb.maxx)
                     {
                        _loc9_.aabb.maxx = _loc12_.x;
                     }
                     if(_loc12_.y < _loc9_.aabb.miny)
                     {
                        _loc9_.aabb.miny = _loc12_.y;
                     }
                     if(_loc12_.y > _loc9_.aabb.maxy)
                     {
                        _loc9_.aabb.maxy = _loc12_.y;
                     }
                     _loc11_ = _loc11_.next;
                  }
               }
            }
         }
      }
      
      public function updateAABBShape(param1:ZPP_AABB) : void
      {
         var _loc2_:* = null as Body;
         var _loc3_:* = null as Shape;
         var _loc4_:* = null as ZPP_AABB;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc8_:* = null as ZPP_Circle;
         var _loc9_:* = null as ZPP_Polygon;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc13_:* = null as ZPP_Vec2;
         var _loc14_:* = null as ZPP_Vec2;
         var _loc15_:* = null as ZPP_Body;
         var _loc16_:* = null as ZNPNode_ZPP_Edge;
         var _loc17_:* = null as ZPP_Edge;
         if(aabbShape == null)
         {
            §§push();
            if(ZPP_Flags.BodyType_STATIC == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.BodyType_STATIC = new BodyType();
               ZPP_Flags.§internal§ = false;
            }
            _loc2_ = new §§pop().Body(ZPP_Flags.BodyType_STATIC);
            _loc3_ = new Polygon(Polygon.rect(param1.minx,param1.miny,param1.maxx - param1.minx,param1.maxy - param1.miny));
            aabbShape = _loc3_;
            _loc2_.zpp_inner.wrap_shapes.add(_loc3_);
         }
         else
         {
            _loc4_ = aabbShape.zpp_inner.aabb;
            _loc5_ = (param1.maxx - param1.minx) / (_loc4_.maxx - _loc4_.minx);
            _loc6_ = (param1.maxy - param1.miny) / (_loc4_.maxy - _loc4_.miny);
            aabbShape.transform(new Mat23(_loc5_,0,0,_loc6_,param1.minx - _loc5_ * _loc4_.minx,param1.miny - _loc6_ * _loc4_.miny));
         }
         var _loc7_:ZPP_Shape = aabbShape.zpp_inner;
         if(_loc7_.zip_aabb)
         {
            if(_loc7_.body != null)
            {
               _loc7_.zip_aabb = false;
               if(_loc7_.type == ZPP_Flags.id_ShapeType_CIRCLE)
               {
                  _loc8_ = _loc7_.circle;
                  if(_loc8_.zip_worldCOM)
                  {
                     if(_loc8_.body != null)
                     {
                        _loc8_.zip_worldCOM = false;
                        if(_loc8_.zip_localCOM)
                        {
                           _loc8_.zip_localCOM = false;
                           if(_loc8_.type == ZPP_Flags.id_ShapeType_POLYGON)
                           {
                              _loc9_ = _loc8_.polygon;
                              if(_loc9_.lverts.next.next == null)
                              {
                                 _loc9_.localCOMx = _loc9_.lverts.next.x;
                                 _loc9_.localCOMy = _loc9_.lverts.next.y;
                                 null;
                              }
                              else if(_loc9_.lverts.next.next.next == null)
                              {
                                 _loc9_.localCOMx = _loc9_.lverts.next.x;
                                 _loc9_.localCOMy = _loc9_.lverts.next.y;
                                 _loc5_ = 1;
                                 _loc9_.localCOMx = Number(_loc9_.localCOMx + _loc9_.lverts.next.next.x * _loc5_);
                                 _loc9_.localCOMy = Number(_loc9_.localCOMy + _loc9_.lverts.next.next.y * _loc5_);
                                 _loc5_ = 0.5;
                                 _loc9_.localCOMx = _loc9_.localCOMx * _loc5_;
                                 _loc9_.localCOMy = _loc9_.localCOMy * _loc5_;
                              }
                              else
                              {
                                 _loc9_.localCOMx = 0;
                                 _loc9_.localCOMy = 0;
                                 _loc5_ = 0;
                                 _loc10_ = _loc9_.lverts.next;
                                 _loc11_ = _loc10_;
                                 _loc10_ = _loc10_.next;
                                 _loc12_ = _loc10_;
                                 _loc10_ = _loc10_.next;
                                 while(_loc10_ != null)
                                 {
                                    _loc13_ = _loc10_;
                                    _loc5_ = Number(_loc5_ + _loc12_.x * (_loc13_.y - _loc11_.y));
                                    _loc6_ = _loc13_.y * _loc12_.x - _loc13_.x * _loc12_.y;
                                    _loc9_.localCOMx = Number(_loc9_.localCOMx + (_loc12_.x + _loc13_.x) * _loc6_);
                                    _loc9_.localCOMy = Number(_loc9_.localCOMy + (_loc12_.y + _loc13_.y) * _loc6_);
                                    _loc11_ = _loc12_;
                                    _loc12_ = _loc13_;
                                    _loc10_ = _loc10_.next;
                                 }
                                 _loc10_ = _loc9_.lverts.next;
                                 _loc13_ = _loc10_;
                                 _loc5_ = Number(_loc5_ + _loc12_.x * (_loc13_.y - _loc11_.y));
                                 _loc6_ = _loc13_.y * _loc12_.x - _loc13_.x * _loc12_.y;
                                 _loc9_.localCOMx = Number(_loc9_.localCOMx + (_loc12_.x + _loc13_.x) * _loc6_);
                                 _loc9_.localCOMy = Number(_loc9_.localCOMy + (_loc12_.y + _loc13_.y) * _loc6_);
                                 _loc11_ = _loc12_;
                                 _loc12_ = _loc13_;
                                 _loc10_ = _loc10_.next;
                                 _loc14_ = _loc10_;
                                 _loc5_ = Number(_loc5_ + _loc12_.x * (_loc14_.y - _loc11_.y));
                                 _loc6_ = _loc14_.y * _loc12_.x - _loc14_.x * _loc12_.y;
                                 _loc9_.localCOMx = Number(_loc9_.localCOMx + (_loc12_.x + _loc14_.x) * _loc6_);
                                 _loc9_.localCOMy = Number(_loc9_.localCOMy + (_loc12_.y + _loc14_.y) * _loc6_);
                                 _loc5_ = 1 / (3 * _loc5_);
                                 _loc6_ = _loc5_;
                                 _loc9_.localCOMx = _loc9_.localCOMx * _loc6_;
                                 _loc9_.localCOMy = _loc9_.localCOMy * _loc6_;
                              }
                           }
                           if(_loc8_.wrap_localCOM != null)
                           {
                              _loc8_.wrap_localCOM.zpp_inner.x = _loc8_.localCOMx;
                              _loc8_.wrap_localCOM.zpp_inner.y = _loc8_.localCOMy;
                           }
                        }
                        _loc15_ = _loc8_.body;
                        if(_loc15_.zip_axis)
                        {
                           _loc15_.zip_axis = false;
                           _loc15_.axisx = Number(Math.sin(_loc15_.rot));
                           _loc15_.axisy = Number(Math.cos(_loc15_.rot));
                           null;
                        }
                        _loc8_.worldCOMx = Number(_loc8_.body.posx + (_loc8_.body.axisy * _loc8_.localCOMx - _loc8_.body.axisx * _loc8_.localCOMy));
                        _loc8_.worldCOMy = Number(_loc8_.body.posy + (Number(_loc8_.localCOMx * _loc8_.body.axisx + _loc8_.localCOMy * _loc8_.body.axisy)));
                        if(_loc8_.wrap_worldCOM != null)
                        {
                           _loc8_.wrap_worldCOM.zpp_inner.x = _loc8_.worldCOMx;
                           _loc8_.wrap_worldCOM.zpp_inner.y = _loc8_.worldCOMy;
                        }
                     }
                  }
                  _loc5_ = _loc8_.radius;
                  _loc6_ = _loc8_.radius;
                  _loc8_.aabb.minx = _loc8_.worldCOMx - _loc5_;
                  _loc8_.aabb.miny = _loc8_.worldCOMy - _loc6_;
                  _loc8_.aabb.maxx = Number(_loc8_.worldCOMx + _loc5_);
                  _loc8_.aabb.maxy = Number(_loc8_.worldCOMy + _loc6_);
               }
               else
               {
                  _loc9_ = _loc7_.polygon;
                  if(_loc9_.zip_gverts)
                  {
                     if(_loc9_.body != null)
                     {
                        _loc9_.zip_gverts = false;
                        _loc9_.validate_lverts();
                        _loc15_ = _loc9_.body;
                        if(_loc15_.zip_axis)
                        {
                           _loc15_.zip_axis = false;
                           _loc15_.axisx = Number(Math.sin(_loc15_.rot));
                           _loc15_.axisy = Number(Math.cos(_loc15_.rot));
                           null;
                        }
                        _loc10_ = _loc9_.lverts.next;
                        _loc11_ = _loc9_.gverts.next;
                        while(_loc11_ != null)
                        {
                           _loc12_ = _loc11_;
                           _loc13_ = _loc10_;
                           _loc10_ = _loc10_.next;
                           _loc12_.x = Number(_loc9_.body.posx + (_loc9_.body.axisy * _loc13_.x - _loc9_.body.axisx * _loc13_.y));
                           _loc12_.y = Number(_loc9_.body.posy + (Number(_loc13_.x * _loc9_.body.axisx + _loc13_.y * _loc9_.body.axisy)));
                           _loc11_ = _loc11_.next;
                        }
                     }
                  }
                  _loc10_ = _loc9_.gverts.next;
                  _loc9_.aabb.minx = _loc10_.x;
                  _loc9_.aabb.miny = _loc10_.y;
                  _loc9_.aabb.maxx = _loc10_.x;
                  _loc9_.aabb.maxy = _loc10_.y;
                  _loc11_ = _loc9_.gverts.next.next;
                  while(_loc11_ != null)
                  {
                     _loc12_ = _loc11_;
                     if(_loc12_.x < _loc9_.aabb.minx)
                     {
                        _loc9_.aabb.minx = _loc12_.x;
                     }
                     if(_loc12_.x > _loc9_.aabb.maxx)
                     {
                        _loc9_.aabb.maxx = _loc12_.x;
                     }
                     if(_loc12_.y < _loc9_.aabb.miny)
                     {
                        _loc9_.aabb.miny = _loc12_.y;
                     }
                     if(_loc12_.y > _loc9_.aabb.maxy)
                     {
                        _loc9_.aabb.maxy = _loc12_.y;
                     }
                     _loc11_ = _loc11_.next;
                  }
               }
            }
         }
         _loc9_ = aabbShape.zpp_inner.polygon;
         if(_loc9_.zip_gaxi)
         {
            if(_loc9_.body != null)
            {
               _loc9_.zip_gaxi = false;
               _loc9_.validate_laxi();
               _loc15_ = _loc9_.body;
               if(_loc15_.zip_axis)
               {
                  _loc15_.zip_axis = false;
                  _loc15_.axisx = Number(Math.sin(_loc15_.rot));
                  _loc15_.axisy = Number(Math.cos(_loc15_.rot));
                  null;
               }
               _loc16_ = _loc9_.edges.head;
               _loc10_ = _loc9_.gverts.next;
               _loc11_ = _loc10_;
               _loc10_ = _loc10_.next;
               while(_loc10_ != null)
               {
                  _loc12_ = _loc10_;
                  _loc17_ = _loc16_.elt;
                  _loc16_ = _loc16_.next;
                  _loc17_.gp0 = _loc11_;
                  _loc17_.gp1 = _loc12_;
                  _loc17_.gnormx = _loc9_.body.axisy * _loc17_.lnormx - _loc9_.body.axisx * _loc17_.lnormy;
                  _loc17_.gnormy = Number(_loc17_.lnormx * _loc9_.body.axisx + _loc17_.lnormy * _loc9_.body.axisy);
                  _loc17_.gprojection = Number(Number(_loc9_.body.posx * _loc17_.gnormx + _loc9_.body.posy * _loc17_.gnormy) + _loc17_.lprojection);
                  if(_loc17_.wrap_gnorm != null)
                  {
                     _loc17_.wrap_gnorm.zpp_inner.x = _loc17_.gnormx;
                     _loc17_.wrap_gnorm.zpp_inner.y = _loc17_.gnormy;
                  }
                  _loc17_.tp0 = _loc17_.gp0.y * _loc17_.gnormx - _loc17_.gp0.x * _loc17_.gnormy;
                  _loc17_.tp1 = _loc17_.gp1.y * _loc17_.gnormx - _loc17_.gp1.x * _loc17_.gnormy;
                  _loc11_ = _loc12_;
                  _loc10_ = _loc10_.next;
               }
               _loc12_ = _loc9_.gverts.next;
               _loc17_ = _loc16_.elt;
               _loc16_ = _loc16_.next;
               _loc17_.gp0 = _loc11_;
               _loc17_.gp1 = _loc12_;
               _loc17_.gnormx = _loc9_.body.axisy * _loc17_.lnormx - _loc9_.body.axisx * _loc17_.lnormy;
               _loc17_.gnormy = Number(_loc17_.lnormx * _loc9_.body.axisx + _loc17_.lnormy * _loc9_.body.axisy);
               _loc17_.gprojection = Number(Number(_loc9_.body.posx * _loc17_.gnormx + _loc9_.body.posy * _loc17_.gnormy) + _loc17_.lprojection);
               if(_loc17_.wrap_gnorm != null)
               {
                  _loc17_.wrap_gnorm.zpp_inner.x = _loc17_.gnormx;
                  _loc17_.wrap_gnorm.zpp_inner.y = _loc17_.gnormy;
               }
               _loc17_.tp0 = _loc17_.gp0.y * _loc17_.gnormx - _loc17_.gp0.x * _loc17_.gnormy;
               _loc17_.tp1 = _loc17_.gp1.y * _loc17_.gnormx - _loc17_.gp1.x * _loc17_.gnormy;
            }
         }
      }
      
      public function sync(param1:ZPP_Shape) : void
      {
         var _loc2_:* = null as ZPP_DynAABBPhase;
         var _loc3_:* = null as ZPP_AABBNode;
         var _loc4_:* = null as ZPP_Circle;
         var _loc5_:* = null as ZPP_Polygon;
         var _loc6_:Number = NaN;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:Number = NaN;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc13_:* = null as ZPP_Body;
         var _loc14_:Boolean = false;
         var _loc15_:* = null as ZPP_AABB;
         var _loc16_:* = null as ZPP_AABB;
         if(!is_sweep)
         {
            _loc2_ = dynab;
            _loc3_ = param1.node;
            if(!_loc3_.synced)
            {
               if(param1.zip_aabb)
               {
                  if(param1.body != null)
                  {
                     param1.zip_aabb = false;
                     if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        _loc4_ = param1.circle;
                        if(_loc4_.zip_worldCOM)
                        {
                           if(_loc4_.body != null)
                           {
                              _loc4_.zip_worldCOM = false;
                              if(_loc4_.zip_localCOM)
                              {
                                 _loc4_.zip_localCOM = false;
                                 if(_loc4_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                 {
                                    _loc5_ = _loc4_.polygon;
                                    if(_loc5_.lverts.next.next == null)
                                    {
                                       _loc5_.localCOMx = _loc5_.lverts.next.x;
                                       _loc5_.localCOMy = _loc5_.lverts.next.y;
                                       null;
                                    }
                                    else if(_loc5_.lverts.next.next.next == null)
                                    {
                                       _loc5_.localCOMx = _loc5_.lverts.next.x;
                                       _loc5_.localCOMy = _loc5_.lverts.next.y;
                                       _loc6_ = 1;
                                       _loc5_.localCOMx = Number(_loc5_.localCOMx + _loc5_.lverts.next.next.x * _loc6_);
                                       _loc5_.localCOMy = Number(_loc5_.localCOMy + _loc5_.lverts.next.next.y * _loc6_);
                                       _loc6_ = 0.5;
                                       _loc5_.localCOMx = _loc5_.localCOMx * _loc6_;
                                       _loc5_.localCOMy = _loc5_.localCOMy * _loc6_;
                                    }
                                    else
                                    {
                                       _loc5_.localCOMx = 0;
                                       _loc5_.localCOMy = 0;
                                       _loc6_ = 0;
                                       _loc7_ = _loc5_.lverts.next;
                                       _loc8_ = _loc7_;
                                       _loc7_ = _loc7_.next;
                                       _loc9_ = _loc7_;
                                       _loc7_ = _loc7_.next;
                                       while(_loc7_ != null)
                                       {
                                          _loc10_ = _loc7_;
                                          _loc6_ = Number(_loc6_ + _loc9_.x * (_loc10_.y - _loc8_.y));
                                          _loc11_ = _loc10_.y * _loc9_.x - _loc10_.x * _loc9_.y;
                                          _loc5_.localCOMx = Number(_loc5_.localCOMx + (_loc9_.x + _loc10_.x) * _loc11_);
                                          _loc5_.localCOMy = Number(_loc5_.localCOMy + (_loc9_.y + _loc10_.y) * _loc11_);
                                          _loc8_ = _loc9_;
                                          _loc9_ = _loc10_;
                                          _loc7_ = _loc7_.next;
                                       }
                                       _loc7_ = _loc5_.lverts.next;
                                       _loc10_ = _loc7_;
                                       _loc6_ = Number(_loc6_ + _loc9_.x * (_loc10_.y - _loc8_.y));
                                       _loc11_ = _loc10_.y * _loc9_.x - _loc10_.x * _loc9_.y;
                                       _loc5_.localCOMx = Number(_loc5_.localCOMx + (_loc9_.x + _loc10_.x) * _loc11_);
                                       _loc5_.localCOMy = Number(_loc5_.localCOMy + (_loc9_.y + _loc10_.y) * _loc11_);
                                       _loc8_ = _loc9_;
                                       _loc9_ = _loc10_;
                                       _loc7_ = _loc7_.next;
                                       _loc12_ = _loc7_;
                                       _loc6_ = Number(_loc6_ + _loc9_.x * (_loc12_.y - _loc8_.y));
                                       _loc11_ = _loc12_.y * _loc9_.x - _loc12_.x * _loc9_.y;
                                       _loc5_.localCOMx = Number(_loc5_.localCOMx + (_loc9_.x + _loc12_.x) * _loc11_);
                                       _loc5_.localCOMy = Number(_loc5_.localCOMy + (_loc9_.y + _loc12_.y) * _loc11_);
                                       _loc6_ = 1 / (3 * _loc6_);
                                       _loc11_ = _loc6_;
                                       _loc5_.localCOMx = _loc5_.localCOMx * _loc11_;
                                       _loc5_.localCOMy = _loc5_.localCOMy * _loc11_;
                                    }
                                 }
                                 if(_loc4_.wrap_localCOM != null)
                                 {
                                    _loc4_.wrap_localCOM.zpp_inner.x = _loc4_.localCOMx;
                                    _loc4_.wrap_localCOM.zpp_inner.y = _loc4_.localCOMy;
                                 }
                              }
                              _loc13_ = _loc4_.body;
                              if(_loc13_.zip_axis)
                              {
                                 _loc13_.zip_axis = false;
                                 _loc13_.axisx = Number(Math.sin(_loc13_.rot));
                                 _loc13_.axisy = Number(Math.cos(_loc13_.rot));
                                 null;
                              }
                              _loc4_.worldCOMx = Number(_loc4_.body.posx + (_loc4_.body.axisy * _loc4_.localCOMx - _loc4_.body.axisx * _loc4_.localCOMy));
                              _loc4_.worldCOMy = Number(_loc4_.body.posy + (Number(_loc4_.localCOMx * _loc4_.body.axisx + _loc4_.localCOMy * _loc4_.body.axisy)));
                              if(_loc4_.wrap_worldCOM != null)
                              {
                                 _loc4_.wrap_worldCOM.zpp_inner.x = _loc4_.worldCOMx;
                                 _loc4_.wrap_worldCOM.zpp_inner.y = _loc4_.worldCOMy;
                              }
                           }
                        }
                        _loc6_ = _loc4_.radius;
                        _loc11_ = _loc4_.radius;
                        _loc4_.aabb.minx = _loc4_.worldCOMx - _loc6_;
                        _loc4_.aabb.miny = _loc4_.worldCOMy - _loc11_;
                        _loc4_.aabb.maxx = Number(_loc4_.worldCOMx + _loc6_);
                        _loc4_.aabb.maxy = Number(_loc4_.worldCOMy + _loc11_);
                     }
                     else
                     {
                        _loc5_ = param1.polygon;
                        if(_loc5_.zip_gverts)
                        {
                           if(_loc5_.body != null)
                           {
                              _loc5_.zip_gverts = false;
                              _loc5_.validate_lverts();
                              _loc13_ = _loc5_.body;
                              if(_loc13_.zip_axis)
                              {
                                 _loc13_.zip_axis = false;
                                 _loc13_.axisx = Number(Math.sin(_loc13_.rot));
                                 _loc13_.axisy = Number(Math.cos(_loc13_.rot));
                                 null;
                              }
                              _loc7_ = _loc5_.lverts.next;
                              _loc8_ = _loc5_.gverts.next;
                              while(_loc8_ != null)
                              {
                                 _loc9_ = _loc8_;
                                 _loc10_ = _loc7_;
                                 _loc7_ = _loc7_.next;
                                 _loc9_.x = Number(_loc5_.body.posx + (_loc5_.body.axisy * _loc10_.x - _loc5_.body.axisx * _loc10_.y));
                                 _loc9_.y = Number(_loc5_.body.posy + (Number(_loc10_.x * _loc5_.body.axisx + _loc10_.y * _loc5_.body.axisy)));
                                 _loc8_ = _loc8_.next;
                              }
                           }
                        }
                        _loc7_ = _loc5_.gverts.next;
                        _loc5_.aabb.minx = _loc7_.x;
                        _loc5_.aabb.miny = _loc7_.y;
                        _loc5_.aabb.maxx = _loc7_.x;
                        _loc5_.aabb.maxy = _loc7_.y;
                        _loc8_ = _loc5_.gverts.next.next;
                        while(_loc8_ != null)
                        {
                           _loc9_ = _loc8_;
                           if(_loc9_.x < _loc5_.aabb.minx)
                           {
                              _loc5_.aabb.minx = _loc9_.x;
                           }
                           if(_loc9_.x > _loc5_.aabb.maxx)
                           {
                              _loc5_.aabb.maxx = _loc9_.x;
                           }
                           if(_loc9_.y < _loc5_.aabb.miny)
                           {
                              _loc5_.aabb.miny = _loc9_.y;
                           }
                           if(_loc9_.y > _loc5_.aabb.maxy)
                           {
                              _loc5_.aabb.maxy = _loc9_.y;
                           }
                           _loc8_ = _loc8_.next;
                        }
                     }
                  }
               }
               _loc14_ = _loc3_.dyn != (param1.body.type == ZPP_Flags.id_BodyType_STATIC?false:!param1.body.component.sleeping) || !(_loc16_.minx >= _loc15_.minx && _loc16_.miny >= _loc15_.miny && _loc16_.maxx <= _loc15_.maxx && _loc16_.maxy <= _loc15_.maxy);
               if(_loc14_)
               {
                  _loc3_.synced = true;
                  _loc3_.snext = _loc2_.syncs;
                  _loc2_.syncs = _loc3_;
               }
            }
         }
      }
      
      public function shapesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter) : ShapeList
      {
         return null;
      }
      
      public function shapesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter) : ShapeList
      {
         return null;
      }
      
      public function shapesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter) : ShapeList
      {
         return null;
      }
      
      public function shapesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter) : ShapeList
      {
         return null;
      }
      
      public function remove(param1:ZPP_Shape) : void
      {
         if(is_sweep)
         {
            sweep.__remove(param1);
         }
         else
         {
            dynab.__remove(param1);
         }
      }
      
      public function rayMultiCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter) : RayResultList
      {
         return null;
      }
      
      public function rayCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter) : RayResult
      {
         return null;
      }
      
      public function insert(param1:ZPP_Shape) : void
      {
         if(is_sweep)
         {
            sweep.__insert(param1);
         }
         else
         {
            dynab.__insert(param1);
         }
      }
      
      public function clear() : void
      {
      }
      
      public function broadphase() : void
      {
      }
      
      public function bodiesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter) : BodyList
      {
         return null;
      }
      
      public function bodiesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter) : BodyList
      {
         return null;
      }
      
      public function bodiesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter) : BodyList
      {
         return null;
      }
      
      public function bodiesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter) : BodyList
      {
         return null;
      }
   }
}
