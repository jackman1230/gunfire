package zpp_nape.geom
{
   import nape.geom.Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.shape.ZPP_Edge;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZNPNode_ZPP_Edge;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_Geom
   {
       
      
      public function ZPP_Geom()
      {
      }
      
      public static function validateShape(param1:ZPP_Shape) : void
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
   }
}
