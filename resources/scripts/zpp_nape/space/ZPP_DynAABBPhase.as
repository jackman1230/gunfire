package zpp_nape.space
{
   import flash.Boot;
   import nape.geom.AABB;
   import nape.geom.RayResult;
   import nape.geom.RayResultList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyList;
   import nape.shape.ShapeList;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Collide;
   import zpp_nape.geom.ZPP_Ray;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZNPList_ZPP_AABBNode;
   import zpp_nape.util.ZNPList_ZPP_AABBPair;
   import zpp_nape.util.ZNPNode_ZPP_AABBNode;
   import zpp_nape.util.ZNPNode_ZPP_AABBPair;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_DynAABBPhase extends ZPP_Broadphase
   {
      
      public static var FATTEN:Number = 3;
      
      public static var VEL_STEPS:Number = 2;
       
      
      public var syncs:ZPP_AABBNode;
      
      public var stree:ZPP_AABBTree;
      
      public var pairs:ZPP_AABBPair;
      
      public var openlist:ZNPList_ZPP_AABBNode;
      
      public var moves:ZPP_AABBNode;
      
      public var dtree:ZPP_AABBTree;
      
      public function ZPP_DynAABBPhase(param1:ZPP_Space = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         space = param1;
         is_sweep = false;
         dynab = this;
         stree = new ZPP_AABBTree();
         dtree = new ZPP_AABBTree();
      }
      
      public function sync_broadphase() : void
      {
         var _loc1_:* = null as ZPP_AABBNode;
         var _loc2_:* = null as ZPP_Shape;
         var _loc3_:* = null as ZPP_AABBTree;
         var _loc4_:* = null as ZPP_AABBNode;
         var _loc5_:* = null as ZPP_AABBNode;
         var _loc6_:* = null as ZPP_AABBNode;
         var _loc7_:* = null as ZPP_AABBNode;
         var _loc8_:* = null as ZPP_AABB;
         var _loc9_:* = null as Vec2;
         var _loc10_:* = null as ZPP_AABBNode;
         var _loc11_:* = null as ZPP_AABBNode;
         var _loc12_:* = 0;
         var _loc13_:* = null as ZPP_AABBNode;
         var _loc14_:* = null as ZPP_AABBNode;
         var _loc15_:* = null as ZPP_AABB;
         var _loc16_:* = null as ZPP_AABB;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:* = null as ZPP_Circle;
         var _loc20_:* = null as ZPP_Polygon;
         var _loc21_:Number = NaN;
         var _loc22_:* = null as ZPP_Vec2;
         var _loc23_:* = null as ZPP_Vec2;
         var _loc24_:* = null as ZPP_Vec2;
         var _loc25_:* = null as ZPP_Vec2;
         var _loc26_:Number = NaN;
         var _loc27_:* = null as ZPP_Vec2;
         var _loc28_:* = null as ZPP_Body;
         var _loc29_:Boolean = false;
         var _loc30_:* = null as ZPP_AABB;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:* = null as ZPP_AABB;
         space.validation();
         if(syncs != null)
         {
            if(moves == null)
            {
               _loc1_ = syncs;
               while(_loc1_ != null)
               {
                  _loc2_ = _loc1_.shape;
                  if(!_loc1_.first_sync)
                  {
                     _loc3_ = !!_loc1_.dyn?dtree:stree;
                     if(_loc1_ == _loc3_.root)
                     {
                        _loc3_.root = null;
                        null;
                     }
                     else
                     {
                        _loc4_ = _loc1_.parent;
                        _loc5_ = _loc4_.parent;
                        _loc6_ = _loc4_.child1 == _loc1_?_loc4_.child2:_loc4_.child1;
                        if(_loc5_ != null)
                        {
                           if(_loc5_.child1 == _loc4_)
                           {
                              _loc5_.child1 = _loc6_;
                           }
                           else
                           {
                              _loc5_.child2 = _loc6_;
                           }
                           _loc6_.parent = _loc5_;
                           _loc7_ = _loc4_;
                           _loc7_.height = -1;
                           _loc8_ = _loc7_.aabb;
                           if(_loc8_.outer != null)
                           {
                              _loc8_.outer.zpp_inner = null;
                              _loc8_.outer = null;
                           }
                           _loc9_ = null;
                           _loc8_.wrap_max = _loc9_;
                           _loc8_.wrap_min = _loc9_;
                           _loc8_._invalidate = null;
                           _loc8_._validate = null;
                           _loc8_.next = ZPP_AABB.zpp_pool;
                           ZPP_AABB.zpp_pool = _loc8_;
                           _loc10_ = null;
                           _loc7_.parent = _loc10_;
                           _loc10_ = _loc10_;
                           _loc7_.child2 = _loc10_;
                           _loc7_.child1 = _loc10_;
                           _loc7_.next = null;
                           _loc7_.snext = null;
                           _loc7_.mnext = null;
                           _loc7_.next = ZPP_AABBNode.zpp_pool;
                           ZPP_AABBNode.zpp_pool = _loc7_;
                           _loc7_ = _loc5_;
                           while(_loc7_ != null)
                           {
                              if(_loc7_.child1 == null || _loc7_.height < 2)
                              {
                                 §§push(_loc7_);
                              }
                              else
                              {
                                 _loc10_ = _loc7_.child1;
                                 _loc11_ = _loc7_.child2;
                                 _loc12_ = _loc11_.height - _loc10_.height;
                                 if(_loc12_ > 1)
                                 {
                                    _loc13_ = _loc11_.child1;
                                    _loc14_ = _loc11_.child2;
                                    _loc11_.child1 = _loc7_;
                                    _loc11_.parent = _loc7_.parent;
                                    _loc7_.parent = _loc11_;
                                    if(_loc11_.parent != null)
                                    {
                                       if(_loc11_.parent.child1 == _loc7_)
                                       {
                                          _loc11_.parent.child1 = _loc11_;
                                       }
                                       else
                                       {
                                          _loc11_.parent.child2 = _loc11_;
                                       }
                                    }
                                    else
                                    {
                                       _loc3_.root = _loc11_;
                                    }
                                    if(_loc13_.height > _loc14_.height)
                                    {
                                       _loc11_.child2 = _loc13_;
                                       _loc7_.child2 = _loc14_;
                                       _loc14_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc10_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc8_ = _loc11_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc17_ = _loc10_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc11_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                    }
                                    else
                                    {
                                       _loc11_.child2 = _loc14_;
                                       _loc7_.child2 = _loc13_;
                                       _loc13_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc10_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc8_ = _loc11_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc17_ = _loc10_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc11_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                    }
                                    §§push(_loc11_);
                                 }
                                 else if(_loc12_ < -1)
                                 {
                                    _loc13_ = _loc10_.child1;
                                    _loc14_ = _loc10_.child2;
                                    _loc10_.child1 = _loc7_;
                                    _loc10_.parent = _loc7_.parent;
                                    _loc7_.parent = _loc10_;
                                    if(_loc10_.parent != null)
                                    {
                                       if(_loc10_.parent.child1 == _loc7_)
                                       {
                                          _loc10_.parent.child1 = _loc10_;
                                       }
                                       else
                                       {
                                          _loc10_.parent.child2 = _loc10_;
                                       }
                                    }
                                    else
                                    {
                                       _loc3_.root = _loc10_;
                                    }
                                    if(_loc13_.height > _loc14_.height)
                                    {
                                       _loc10_.child2 = _loc13_;
                                       _loc7_.child1 = _loc14_;
                                       _loc14_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc11_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc8_ = _loc10_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc17_ = _loc11_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc10_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                    }
                                    else
                                    {
                                       _loc10_.child2 = _loc14_;
                                       _loc7_.child1 = _loc13_;
                                       _loc13_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc11_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc8_ = _loc10_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc17_ = _loc11_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc10_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                    }
                                    §§push(_loc10_);
                                 }
                                 else
                                 {
                                    §§push(_loc7_);
                                 }
                              }
                              _loc7_ = §§pop();
                              _loc10_ = _loc7_.child1;
                              _loc11_ = _loc7_.child2;
                              _loc8_ = _loc7_.aabb;
                              _loc15_ = _loc10_.aabb;
                              _loc16_ = _loc11_.aabb;
                              _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                              _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                              _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                              _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                              _loc12_ = int(_loc10_.height);
                              _loc17_ = _loc11_.height;
                              _loc7_.height = 1 + (_loc12_ > _loc17_?_loc12_:_loc17_);
                              _loc7_ = _loc7_.parent;
                           }
                        }
                        else
                        {
                           _loc3_.root = _loc6_;
                           _loc6_.parent = null;
                           _loc7_ = _loc4_;
                           _loc7_.height = -1;
                           _loc8_ = _loc7_.aabb;
                           if(_loc8_.outer != null)
                           {
                              _loc8_.outer.zpp_inner = null;
                              _loc8_.outer = null;
                           }
                           _loc9_ = null;
                           _loc8_.wrap_max = _loc9_;
                           _loc8_.wrap_min = _loc9_;
                           _loc8_._invalidate = null;
                           _loc8_._validate = null;
                           _loc8_.next = ZPP_AABB.zpp_pool;
                           ZPP_AABB.zpp_pool = _loc8_;
                           _loc10_ = null;
                           _loc7_.parent = _loc10_;
                           _loc10_ = _loc10_;
                           _loc7_.child2 = _loc10_;
                           _loc7_.child1 = _loc10_;
                           _loc7_.next = null;
                           _loc7_.snext = null;
                           _loc7_.mnext = null;
                           _loc7_.next = ZPP_AABBNode.zpp_pool;
                           ZPP_AABBNode.zpp_pool = _loc7_;
                        }
                     }
                  }
                  else
                  {
                     _loc1_.first_sync = false;
                  }
                  _loc8_ = _loc1_.aabb;
                  if(_loc2_.zip_aabb)
                  {
                     if(_loc2_.body != null)
                     {
                        _loc2_.zip_aabb = false;
                        if(_loc2_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                           _loc19_ = _loc2_.circle;
                           if(_loc19_.zip_worldCOM)
                           {
                              if(_loc19_.body != null)
                              {
                                 _loc19_.zip_worldCOM = false;
                                 if(_loc19_.zip_localCOM)
                                 {
                                    _loc19_.zip_localCOM = false;
                                    if(_loc19_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                    {
                                       _loc20_ = _loc19_.polygon;
                                       if(_loc20_.lverts.next.next == null)
                                       {
                                          _loc20_.localCOMx = _loc20_.lverts.next.x;
                                          _loc20_.localCOMy = _loc20_.lverts.next.y;
                                          null;
                                       }
                                       else if(_loc20_.lverts.next.next.next == null)
                                       {
                                          _loc20_.localCOMx = _loc20_.lverts.next.x;
                                          _loc20_.localCOMy = _loc20_.lverts.next.y;
                                          _loc21_ = 1;
                                          _loc20_.localCOMx = Number(_loc20_.localCOMx + _loc20_.lverts.next.next.x * _loc21_);
                                          _loc20_.localCOMy = Number(_loc20_.localCOMy + _loc20_.lverts.next.next.y * _loc21_);
                                          _loc21_ = 0.5;
                                          _loc20_.localCOMx = _loc20_.localCOMx * _loc21_;
                                          _loc20_.localCOMy = _loc20_.localCOMy * _loc21_;
                                       }
                                       else
                                       {
                                          _loc20_.localCOMx = 0;
                                          _loc20_.localCOMy = 0;
                                          _loc21_ = 0;
                                          _loc22_ = _loc20_.lverts.next;
                                          _loc23_ = _loc22_;
                                          _loc22_ = _loc22_.next;
                                          _loc24_ = _loc22_;
                                          _loc22_ = _loc22_.next;
                                          while(_loc22_ != null)
                                          {
                                             _loc25_ = _loc22_;
                                             _loc21_ = Number(_loc21_ + _loc24_.x * (_loc25_.y - _loc23_.y));
                                             _loc26_ = _loc25_.y * _loc24_.x - _loc25_.x * _loc24_.y;
                                             _loc20_.localCOMx = Number(_loc20_.localCOMx + (_loc24_.x + _loc25_.x) * _loc26_);
                                             _loc20_.localCOMy = Number(_loc20_.localCOMy + (_loc24_.y + _loc25_.y) * _loc26_);
                                             _loc23_ = _loc24_;
                                             _loc24_ = _loc25_;
                                             _loc22_ = _loc22_.next;
                                          }
                                          _loc22_ = _loc20_.lverts.next;
                                          _loc25_ = _loc22_;
                                          _loc21_ = Number(_loc21_ + _loc24_.x * (_loc25_.y - _loc23_.y));
                                          _loc26_ = _loc25_.y * _loc24_.x - _loc25_.x * _loc24_.y;
                                          _loc20_.localCOMx = Number(_loc20_.localCOMx + (_loc24_.x + _loc25_.x) * _loc26_);
                                          _loc20_.localCOMy = Number(_loc20_.localCOMy + (_loc24_.y + _loc25_.y) * _loc26_);
                                          _loc23_ = _loc24_;
                                          _loc24_ = _loc25_;
                                          _loc22_ = _loc22_.next;
                                          _loc27_ = _loc22_;
                                          _loc21_ = Number(_loc21_ + _loc24_.x * (_loc27_.y - _loc23_.y));
                                          _loc26_ = _loc27_.y * _loc24_.x - _loc27_.x * _loc24_.y;
                                          _loc20_.localCOMx = Number(_loc20_.localCOMx + (_loc24_.x + _loc27_.x) * _loc26_);
                                          _loc20_.localCOMy = Number(_loc20_.localCOMy + (_loc24_.y + _loc27_.y) * _loc26_);
                                          _loc21_ = 1 / (3 * _loc21_);
                                          _loc26_ = _loc21_;
                                          _loc20_.localCOMx = _loc20_.localCOMx * _loc26_;
                                          _loc20_.localCOMy = _loc20_.localCOMy * _loc26_;
                                       }
                                    }
                                    if(_loc19_.wrap_localCOM != null)
                                    {
                                       _loc19_.wrap_localCOM.zpp_inner.x = _loc19_.localCOMx;
                                       _loc19_.wrap_localCOM.zpp_inner.y = _loc19_.localCOMy;
                                    }
                                 }
                                 _loc28_ = _loc19_.body;
                                 if(_loc28_.zip_axis)
                                 {
                                    _loc28_.zip_axis = false;
                                    _loc28_.axisx = Number(Math.sin(_loc28_.rot));
                                    _loc28_.axisy = Number(Math.cos(_loc28_.rot));
                                    null;
                                 }
                                 _loc19_.worldCOMx = Number(_loc19_.body.posx + (_loc19_.body.axisy * _loc19_.localCOMx - _loc19_.body.axisx * _loc19_.localCOMy));
                                 _loc19_.worldCOMy = Number(_loc19_.body.posy + (Number(_loc19_.localCOMx * _loc19_.body.axisx + _loc19_.localCOMy * _loc19_.body.axisy)));
                                 if(_loc19_.wrap_worldCOM != null)
                                 {
                                    _loc19_.wrap_worldCOM.zpp_inner.x = _loc19_.worldCOMx;
                                    _loc19_.wrap_worldCOM.zpp_inner.y = _loc19_.worldCOMy;
                                 }
                              }
                           }
                           _loc21_ = _loc19_.radius;
                           _loc26_ = _loc19_.radius;
                           _loc19_.aabb.minx = _loc19_.worldCOMx - _loc21_;
                           _loc19_.aabb.miny = _loc19_.worldCOMy - _loc26_;
                           _loc19_.aabb.maxx = Number(_loc19_.worldCOMx + _loc21_);
                           _loc19_.aabb.maxy = Number(_loc19_.worldCOMy + _loc26_);
                        }
                        else
                        {
                           _loc20_ = _loc2_.polygon;
                           if(_loc20_.zip_gverts)
                           {
                              if(_loc20_.body != null)
                              {
                                 _loc20_.zip_gverts = false;
                                 _loc20_.validate_lverts();
                                 _loc28_ = _loc20_.body;
                                 if(_loc28_.zip_axis)
                                 {
                                    _loc28_.zip_axis = false;
                                    _loc28_.axisx = Number(Math.sin(_loc28_.rot));
                                    _loc28_.axisy = Number(Math.cos(_loc28_.rot));
                                    null;
                                 }
                                 _loc22_ = _loc20_.lverts.next;
                                 _loc23_ = _loc20_.gverts.next;
                                 while(_loc23_ != null)
                                 {
                                    _loc24_ = _loc23_;
                                    _loc25_ = _loc22_;
                                    _loc22_ = _loc22_.next;
                                    _loc24_.x = Number(_loc20_.body.posx + (_loc20_.body.axisy * _loc25_.x - _loc20_.body.axisx * _loc25_.y));
                                    _loc24_.y = Number(_loc20_.body.posy + (Number(_loc25_.x * _loc20_.body.axisx + _loc25_.y * _loc20_.body.axisy)));
                                    _loc23_ = _loc23_.next;
                                 }
                              }
                           }
                           _loc22_ = _loc20_.gverts.next;
                           _loc20_.aabb.minx = _loc22_.x;
                           _loc20_.aabb.miny = _loc22_.y;
                           _loc20_.aabb.maxx = _loc22_.x;
                           _loc20_.aabb.maxy = _loc22_.y;
                           _loc23_ = _loc20_.gverts.next.next;
                           while(_loc23_ != null)
                           {
                              _loc24_ = _loc23_;
                              if(_loc24_.x < _loc20_.aabb.minx)
                              {
                                 _loc20_.aabb.minx = _loc24_.x;
                              }
                              if(_loc24_.x > _loc20_.aabb.maxx)
                              {
                                 _loc20_.aabb.maxx = _loc24_.x;
                              }
                              if(_loc24_.y < _loc20_.aabb.miny)
                              {
                                 _loc20_.aabb.miny = _loc24_.y;
                              }
                              if(_loc24_.y > _loc20_.aabb.maxy)
                              {
                                 _loc20_.aabb.maxy = _loc24_.y;
                              }
                              _loc23_ = _loc23_.next;
                           }
                        }
                     }
                  }
                  _loc15_ = _loc2_.aabb;
                  _loc8_.minx = _loc15_.minx - 3;
                  _loc8_.miny = _loc15_.miny - 3;
                  _loc8_.maxx = Number(_loc15_.maxx + 3);
                  _loc8_.maxy = Number(_loc15_.maxy + 3);
                  _loc29_ = _loc2_.body.type == ZPP_Flags.id_BodyType_STATIC?false:!_loc2_.body.component.sleeping;
                  _loc1_.dyn = _loc29_;
                  _loc3_ = !!_loc29_?dtree:stree;
                  if(_loc3_.root == null)
                  {
                     _loc3_.root = _loc1_;
                     _loc3_.root.parent = null;
                  }
                  else
                  {
                     _loc15_ = _loc1_.aabb;
                     _loc4_ = _loc3_.root;
                     while(_loc4_.child1 != null)
                     {
                        _loc5_ = _loc4_.child1;
                        _loc6_ = _loc4_.child2;
                        _loc16_ = _loc4_.aabb;
                        _loc21_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc30_ = _loc4_.aabb;
                        _loc16_.minx = _loc30_.minx < _loc15_.minx?_loc30_.minx:_loc15_.minx;
                        _loc16_.miny = _loc30_.miny < _loc15_.miny?_loc30_.miny:_loc15_.miny;
                        _loc16_.maxx = _loc30_.maxx > _loc15_.maxx?_loc30_.maxx:_loc15_.maxx;
                        _loc16_.maxy = _loc30_.maxy > _loc15_.maxy?_loc30_.maxy:_loc15_.maxy;
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc26_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                        _loc31_ = 2 * _loc26_;
                        _loc32_ = 2 * (_loc26_ - _loc21_);
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc30_ = _loc5_.aabb;
                        _loc16_.minx = _loc15_.minx < _loc30_.minx?_loc15_.minx:_loc30_.minx;
                        _loc16_.miny = _loc15_.miny < _loc30_.miny?_loc15_.miny:_loc30_.miny;
                        _loc16_.maxx = _loc15_.maxx > _loc30_.maxx?_loc15_.maxx:_loc30_.maxx;
                        _loc16_.maxy = _loc15_.maxy > _loc30_.maxy?_loc15_.maxy:_loc30_.maxy;
                        if(_loc5_.child1 == null)
                        {
                           _loc16_ = ZPP_AABBTree.tmpaabb;
                           §§push(Number((_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2 + _loc32_));
                        }
                        else
                        {
                           _loc16_ = _loc5_.aabb;
                           _loc34_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                           _loc16_ = ZPP_AABBTree.tmpaabb;
                           _loc35_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                           §§push(Number(_loc35_ - _loc34_ + _loc32_));
                        }
                        _loc33_ = §§pop();
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc30_ = _loc6_.aabb;
                        _loc16_.minx = _loc15_.minx < _loc30_.minx?_loc15_.minx:_loc30_.minx;
                        _loc16_.miny = _loc15_.miny < _loc30_.miny?_loc15_.miny:_loc30_.miny;
                        _loc16_.maxx = _loc15_.maxx > _loc30_.maxx?_loc15_.maxx:_loc30_.maxx;
                        _loc16_.maxy = _loc15_.maxy > _loc30_.maxy?_loc15_.maxy:_loc30_.maxy;
                        if(_loc6_.child1 == null)
                        {
                           _loc16_ = ZPP_AABBTree.tmpaabb;
                           §§push(Number((_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2 + _loc32_));
                        }
                        else
                        {
                           _loc16_ = _loc6_.aabb;
                           _loc35_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                           _loc16_ = ZPP_AABBTree.tmpaabb;
                           _loc36_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                           §§push(Number(_loc36_ - _loc35_ + _loc32_));
                        }
                        _loc34_ = §§pop();
                        if(!(_loc31_ < _loc33_ && _loc31_ < _loc34_))
                        {
                           _loc4_ = _loc33_ < _loc34_?_loc5_:_loc6_;
                           continue;
                        }
                        break;
                     }
                     _loc5_ = _loc4_;
                     _loc6_ = _loc5_.parent;
                     if(ZPP_AABBNode.zpp_pool == null)
                     {
                        _loc7_ = new ZPP_AABBNode();
                     }
                     else
                     {
                        _loc7_ = ZPP_AABBNode.zpp_pool;
                        ZPP_AABBNode.zpp_pool = _loc7_.next;
                        _loc7_.next = null;
                     }
                     if(ZPP_AABB.zpp_pool == null)
                     {
                        _loc7_.aabb = new ZPP_AABB();
                     }
                     else
                     {
                        _loc7_.aabb = ZPP_AABB.zpp_pool;
                        ZPP_AABB.zpp_pool = _loc7_.aabb.next;
                        _loc7_.aabb.next = null;
                     }
                     null;
                     _loc7_.moved = false;
                     _loc7_.synced = false;
                     _loc7_.first_sync = false;
                     _loc7_.parent = _loc6_;
                     _loc16_ = _loc7_.aabb;
                     _loc30_ = _loc5_.aabb;
                     _loc16_.minx = _loc15_.minx < _loc30_.minx?_loc15_.minx:_loc30_.minx;
                     _loc16_.miny = _loc15_.miny < _loc30_.miny?_loc15_.miny:_loc30_.miny;
                     _loc16_.maxx = _loc15_.maxx > _loc30_.maxx?_loc15_.maxx:_loc30_.maxx;
                     _loc16_.maxy = _loc15_.maxy > _loc30_.maxy?_loc15_.maxy:_loc30_.maxy;
                     _loc7_.height = _loc5_.height + 1;
                     if(_loc6_ != null)
                     {
                        if(_loc6_.child1 == _loc5_)
                        {
                           _loc6_.child1 = _loc7_;
                        }
                        else
                        {
                           _loc6_.child2 = _loc7_;
                        }
                        _loc7_.child1 = _loc5_;
                        _loc7_.child2 = _loc1_;
                        _loc5_.parent = _loc7_;
                        _loc1_.parent = _loc7_;
                     }
                     else
                     {
                        _loc7_.child1 = _loc5_;
                        _loc7_.child2 = _loc1_;
                        _loc5_.parent = _loc7_;
                        _loc1_.parent = _loc7_;
                        _loc3_.root = _loc7_;
                     }
                     _loc4_ = _loc1_.parent;
                     while(_loc4_ != null)
                     {
                        if(_loc4_.child1 == null || _loc4_.height < 2)
                        {
                           §§push(_loc4_);
                        }
                        else
                        {
                           _loc10_ = _loc4_.child1;
                           _loc11_ = _loc4_.child2;
                           _loc12_ = _loc11_.height - _loc10_.height;
                           if(_loc12_ > 1)
                           {
                              _loc13_ = _loc11_.child1;
                              _loc14_ = _loc11_.child2;
                              _loc11_.child1 = _loc4_;
                              _loc11_.parent = _loc4_.parent;
                              _loc4_.parent = _loc11_;
                              if(_loc11_.parent != null)
                              {
                                 if(_loc11_.parent.child1 == _loc4_)
                                 {
                                    _loc11_.parent.child1 = _loc11_;
                                 }
                                 else
                                 {
                                    _loc11_.parent.child2 = _loc11_;
                                 }
                              }
                              else
                              {
                                 _loc3_.root = _loc11_;
                              }
                              if(_loc13_.height > _loc14_.height)
                              {
                                 _loc11_.child2 = _loc13_;
                                 _loc4_.child2 = _loc14_;
                                 _loc14_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc10_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc16_ = _loc11_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc17_ = _loc10_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc11_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                              }
                              else
                              {
                                 _loc11_.child2 = _loc14_;
                                 _loc4_.child2 = _loc13_;
                                 _loc13_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc10_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc16_ = _loc11_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc17_ = _loc10_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc11_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                              }
                              §§push(_loc11_);
                           }
                           else if(_loc12_ < -1)
                           {
                              _loc13_ = _loc10_.child1;
                              _loc14_ = _loc10_.child2;
                              _loc10_.child1 = _loc4_;
                              _loc10_.parent = _loc4_.parent;
                              _loc4_.parent = _loc10_;
                              if(_loc10_.parent != null)
                              {
                                 if(_loc10_.parent.child1 == _loc4_)
                                 {
                                    _loc10_.parent.child1 = _loc10_;
                                 }
                                 else
                                 {
                                    _loc10_.parent.child2 = _loc10_;
                                 }
                              }
                              else
                              {
                                 _loc3_.root = _loc10_;
                              }
                              if(_loc13_.height > _loc14_.height)
                              {
                                 _loc10_.child2 = _loc13_;
                                 _loc4_.child1 = _loc14_;
                                 _loc14_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc11_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc16_ = _loc10_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc17_ = _loc11_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc10_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                              }
                              else
                              {
                                 _loc10_.child2 = _loc14_;
                                 _loc4_.child1 = _loc13_;
                                 _loc13_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc11_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc16_ = _loc10_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc17_ = _loc11_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc10_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                              }
                              §§push(_loc10_);
                           }
                           else
                           {
                              §§push(_loc4_);
                           }
                        }
                        _loc4_ = §§pop();
                        _loc10_ = _loc4_.child1;
                        _loc11_ = _loc4_.child2;
                        _loc12_ = int(_loc10_.height);
                        _loc17_ = _loc11_.height;
                        _loc4_.height = 1 + (_loc12_ > _loc17_?_loc12_:_loc17_);
                        _loc16_ = _loc4_.aabb;
                        _loc30_ = _loc10_.aabb;
                        _loc37_ = _loc11_.aabb;
                        _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                        _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                        _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                        _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                        _loc4_ = _loc4_.parent;
                     }
                  }
                  _loc1_.synced = false;
                  _loc1_.moved = true;
                  _loc1_.mnext = _loc1_.snext;
                  _loc1_.snext = null;
                  _loc1_ = _loc1_.mnext;
               }
               _loc4_ = syncs;
               syncs = moves;
               moves = _loc4_;
            }
            else
            {
               while(syncs != null)
               {
                  _loc4_ = syncs;
                  syncs = _loc4_.snext;
                  _loc4_.snext = null;
                  _loc1_ = _loc4_;
                  _loc2_ = _loc1_.shape;
                  if(!_loc1_.first_sync)
                  {
                     _loc3_ = !!_loc1_.dyn?dtree:stree;
                     if(_loc1_ == _loc3_.root)
                     {
                        _loc3_.root = null;
                        null;
                     }
                     else
                     {
                        _loc4_ = _loc1_.parent;
                        _loc5_ = _loc4_.parent;
                        _loc6_ = _loc4_.child1 == _loc1_?_loc4_.child2:_loc4_.child1;
                        if(_loc5_ != null)
                        {
                           if(_loc5_.child1 == _loc4_)
                           {
                              _loc5_.child1 = _loc6_;
                           }
                           else
                           {
                              _loc5_.child2 = _loc6_;
                           }
                           _loc6_.parent = _loc5_;
                           _loc7_ = _loc4_;
                           _loc7_.height = -1;
                           _loc8_ = _loc7_.aabb;
                           if(_loc8_.outer != null)
                           {
                              _loc8_.outer.zpp_inner = null;
                              _loc8_.outer = null;
                           }
                           _loc9_ = null;
                           _loc8_.wrap_max = _loc9_;
                           _loc8_.wrap_min = _loc9_;
                           _loc8_._invalidate = null;
                           _loc8_._validate = null;
                           _loc8_.next = ZPP_AABB.zpp_pool;
                           ZPP_AABB.zpp_pool = _loc8_;
                           _loc10_ = null;
                           _loc7_.parent = _loc10_;
                           _loc10_ = _loc10_;
                           _loc7_.child2 = _loc10_;
                           _loc7_.child1 = _loc10_;
                           _loc7_.next = null;
                           _loc7_.snext = null;
                           _loc7_.mnext = null;
                           _loc7_.next = ZPP_AABBNode.zpp_pool;
                           ZPP_AABBNode.zpp_pool = _loc7_;
                           _loc7_ = _loc5_;
                           while(_loc7_ != null)
                           {
                              if(_loc7_.child1 == null || _loc7_.height < 2)
                              {
                                 §§push(_loc7_);
                              }
                              else
                              {
                                 _loc10_ = _loc7_.child1;
                                 _loc11_ = _loc7_.child2;
                                 _loc12_ = _loc11_.height - _loc10_.height;
                                 if(_loc12_ > 1)
                                 {
                                    _loc13_ = _loc11_.child1;
                                    _loc14_ = _loc11_.child2;
                                    _loc11_.child1 = _loc7_;
                                    _loc11_.parent = _loc7_.parent;
                                    _loc7_.parent = _loc11_;
                                    if(_loc11_.parent != null)
                                    {
                                       if(_loc11_.parent.child1 == _loc7_)
                                       {
                                          _loc11_.parent.child1 = _loc11_;
                                       }
                                       else
                                       {
                                          _loc11_.parent.child2 = _loc11_;
                                       }
                                    }
                                    else
                                    {
                                       _loc3_.root = _loc11_;
                                    }
                                    if(_loc13_.height > _loc14_.height)
                                    {
                                       _loc11_.child2 = _loc13_;
                                       _loc7_.child2 = _loc14_;
                                       _loc14_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc10_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc8_ = _loc11_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc17_ = _loc10_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc11_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                    }
                                    else
                                    {
                                       _loc11_.child2 = _loc14_;
                                       _loc7_.child2 = _loc13_;
                                       _loc13_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc10_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc8_ = _loc11_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc17_ = _loc10_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc11_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                    }
                                    §§push(_loc11_);
                                 }
                                 else if(_loc12_ < -1)
                                 {
                                    _loc13_ = _loc10_.child1;
                                    _loc14_ = _loc10_.child2;
                                    _loc10_.child1 = _loc7_;
                                    _loc10_.parent = _loc7_.parent;
                                    _loc7_.parent = _loc10_;
                                    if(_loc10_.parent != null)
                                    {
                                       if(_loc10_.parent.child1 == _loc7_)
                                       {
                                          _loc10_.parent.child1 = _loc10_;
                                       }
                                       else
                                       {
                                          _loc10_.parent.child2 = _loc10_;
                                       }
                                    }
                                    else
                                    {
                                       _loc3_.root = _loc10_;
                                    }
                                    if(_loc13_.height > _loc14_.height)
                                    {
                                       _loc10_.child2 = _loc13_;
                                       _loc7_.child1 = _loc14_;
                                       _loc14_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc11_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc8_ = _loc10_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc17_ = _loc11_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc10_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                    }
                                    else
                                    {
                                       _loc10_.child2 = _loc14_;
                                       _loc7_.child1 = _loc13_;
                                       _loc13_.parent = _loc7_;
                                       _loc8_ = _loc7_.aabb;
                                       _loc15_ = _loc11_.aabb;
                                       _loc16_ = _loc13_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc8_ = _loc10_.aabb;
                                       _loc15_ = _loc7_.aabb;
                                       _loc16_ = _loc14_.aabb;
                                       _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                       _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                       _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                       _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                       _loc17_ = _loc11_.height;
                                       _loc18_ = _loc13_.height;
                                       _loc7_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                       _loc17_ = _loc7_.height;
                                       _loc18_ = _loc14_.height;
                                       _loc10_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                    }
                                    §§push(_loc10_);
                                 }
                                 else
                                 {
                                    §§push(_loc7_);
                                 }
                              }
                              _loc7_ = §§pop();
                              _loc10_ = _loc7_.child1;
                              _loc11_ = _loc7_.child2;
                              _loc8_ = _loc7_.aabb;
                              _loc15_ = _loc10_.aabb;
                              _loc16_ = _loc11_.aabb;
                              _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                              _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                              _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                              _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                              _loc12_ = int(_loc10_.height);
                              _loc17_ = _loc11_.height;
                              _loc7_.height = 1 + (_loc12_ > _loc17_?_loc12_:_loc17_);
                              _loc7_ = _loc7_.parent;
                           }
                        }
                        else
                        {
                           _loc3_.root = _loc6_;
                           _loc6_.parent = null;
                           _loc7_ = _loc4_;
                           _loc7_.height = -1;
                           _loc8_ = _loc7_.aabb;
                           if(_loc8_.outer != null)
                           {
                              _loc8_.outer.zpp_inner = null;
                              _loc8_.outer = null;
                           }
                           _loc9_ = null;
                           _loc8_.wrap_max = _loc9_;
                           _loc8_.wrap_min = _loc9_;
                           _loc8_._invalidate = null;
                           _loc8_._validate = null;
                           _loc8_.next = ZPP_AABB.zpp_pool;
                           ZPP_AABB.zpp_pool = _loc8_;
                           _loc10_ = null;
                           _loc7_.parent = _loc10_;
                           _loc10_ = _loc10_;
                           _loc7_.child2 = _loc10_;
                           _loc7_.child1 = _loc10_;
                           _loc7_.next = null;
                           _loc7_.snext = null;
                           _loc7_.mnext = null;
                           _loc7_.next = ZPP_AABBNode.zpp_pool;
                           ZPP_AABBNode.zpp_pool = _loc7_;
                        }
                     }
                  }
                  else
                  {
                     _loc1_.first_sync = false;
                  }
                  _loc8_ = _loc1_.aabb;
                  if(_loc2_.zip_aabb)
                  {
                     if(_loc2_.body != null)
                     {
                        _loc2_.zip_aabb = false;
                        if(_loc2_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                           _loc19_ = _loc2_.circle;
                           if(_loc19_.zip_worldCOM)
                           {
                              if(_loc19_.body != null)
                              {
                                 _loc19_.zip_worldCOM = false;
                                 if(_loc19_.zip_localCOM)
                                 {
                                    _loc19_.zip_localCOM = false;
                                    if(_loc19_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                    {
                                       _loc20_ = _loc19_.polygon;
                                       if(_loc20_.lverts.next.next == null)
                                       {
                                          _loc20_.localCOMx = _loc20_.lverts.next.x;
                                          _loc20_.localCOMy = _loc20_.lverts.next.y;
                                          null;
                                       }
                                       else if(_loc20_.lverts.next.next.next == null)
                                       {
                                          _loc20_.localCOMx = _loc20_.lverts.next.x;
                                          _loc20_.localCOMy = _loc20_.lverts.next.y;
                                          _loc21_ = 1;
                                          _loc20_.localCOMx = Number(_loc20_.localCOMx + _loc20_.lverts.next.next.x * _loc21_);
                                          _loc20_.localCOMy = Number(_loc20_.localCOMy + _loc20_.lverts.next.next.y * _loc21_);
                                          _loc21_ = 0.5;
                                          _loc20_.localCOMx = _loc20_.localCOMx * _loc21_;
                                          _loc20_.localCOMy = _loc20_.localCOMy * _loc21_;
                                       }
                                       else
                                       {
                                          _loc20_.localCOMx = 0;
                                          _loc20_.localCOMy = 0;
                                          _loc21_ = 0;
                                          _loc22_ = _loc20_.lverts.next;
                                          _loc23_ = _loc22_;
                                          _loc22_ = _loc22_.next;
                                          _loc24_ = _loc22_;
                                          _loc22_ = _loc22_.next;
                                          while(_loc22_ != null)
                                          {
                                             _loc25_ = _loc22_;
                                             _loc21_ = Number(_loc21_ + _loc24_.x * (_loc25_.y - _loc23_.y));
                                             _loc26_ = _loc25_.y * _loc24_.x - _loc25_.x * _loc24_.y;
                                             _loc20_.localCOMx = Number(_loc20_.localCOMx + (_loc24_.x + _loc25_.x) * _loc26_);
                                             _loc20_.localCOMy = Number(_loc20_.localCOMy + (_loc24_.y + _loc25_.y) * _loc26_);
                                             _loc23_ = _loc24_;
                                             _loc24_ = _loc25_;
                                             _loc22_ = _loc22_.next;
                                          }
                                          _loc22_ = _loc20_.lverts.next;
                                          _loc25_ = _loc22_;
                                          _loc21_ = Number(_loc21_ + _loc24_.x * (_loc25_.y - _loc23_.y));
                                          _loc26_ = _loc25_.y * _loc24_.x - _loc25_.x * _loc24_.y;
                                          _loc20_.localCOMx = Number(_loc20_.localCOMx + (_loc24_.x + _loc25_.x) * _loc26_);
                                          _loc20_.localCOMy = Number(_loc20_.localCOMy + (_loc24_.y + _loc25_.y) * _loc26_);
                                          _loc23_ = _loc24_;
                                          _loc24_ = _loc25_;
                                          _loc22_ = _loc22_.next;
                                          _loc27_ = _loc22_;
                                          _loc21_ = Number(_loc21_ + _loc24_.x * (_loc27_.y - _loc23_.y));
                                          _loc26_ = _loc27_.y * _loc24_.x - _loc27_.x * _loc24_.y;
                                          _loc20_.localCOMx = Number(_loc20_.localCOMx + (_loc24_.x + _loc27_.x) * _loc26_);
                                          _loc20_.localCOMy = Number(_loc20_.localCOMy + (_loc24_.y + _loc27_.y) * _loc26_);
                                          _loc21_ = 1 / (3 * _loc21_);
                                          _loc26_ = _loc21_;
                                          _loc20_.localCOMx = _loc20_.localCOMx * _loc26_;
                                          _loc20_.localCOMy = _loc20_.localCOMy * _loc26_;
                                       }
                                    }
                                    if(_loc19_.wrap_localCOM != null)
                                    {
                                       _loc19_.wrap_localCOM.zpp_inner.x = _loc19_.localCOMx;
                                       _loc19_.wrap_localCOM.zpp_inner.y = _loc19_.localCOMy;
                                    }
                                 }
                                 _loc28_ = _loc19_.body;
                                 if(_loc28_.zip_axis)
                                 {
                                    _loc28_.zip_axis = false;
                                    _loc28_.axisx = Number(Math.sin(_loc28_.rot));
                                    _loc28_.axisy = Number(Math.cos(_loc28_.rot));
                                    null;
                                 }
                                 _loc19_.worldCOMx = Number(_loc19_.body.posx + (_loc19_.body.axisy * _loc19_.localCOMx - _loc19_.body.axisx * _loc19_.localCOMy));
                                 _loc19_.worldCOMy = Number(_loc19_.body.posy + (Number(_loc19_.localCOMx * _loc19_.body.axisx + _loc19_.localCOMy * _loc19_.body.axisy)));
                                 if(_loc19_.wrap_worldCOM != null)
                                 {
                                    _loc19_.wrap_worldCOM.zpp_inner.x = _loc19_.worldCOMx;
                                    _loc19_.wrap_worldCOM.zpp_inner.y = _loc19_.worldCOMy;
                                 }
                              }
                           }
                           _loc21_ = _loc19_.radius;
                           _loc26_ = _loc19_.radius;
                           _loc19_.aabb.minx = _loc19_.worldCOMx - _loc21_;
                           _loc19_.aabb.miny = _loc19_.worldCOMy - _loc26_;
                           _loc19_.aabb.maxx = Number(_loc19_.worldCOMx + _loc21_);
                           _loc19_.aabb.maxy = Number(_loc19_.worldCOMy + _loc26_);
                        }
                        else
                        {
                           _loc20_ = _loc2_.polygon;
                           if(_loc20_.zip_gverts)
                           {
                              if(_loc20_.body != null)
                              {
                                 _loc20_.zip_gverts = false;
                                 _loc20_.validate_lverts();
                                 _loc28_ = _loc20_.body;
                                 if(_loc28_.zip_axis)
                                 {
                                    _loc28_.zip_axis = false;
                                    _loc28_.axisx = Number(Math.sin(_loc28_.rot));
                                    _loc28_.axisy = Number(Math.cos(_loc28_.rot));
                                    null;
                                 }
                                 _loc22_ = _loc20_.lverts.next;
                                 _loc23_ = _loc20_.gverts.next;
                                 while(_loc23_ != null)
                                 {
                                    _loc24_ = _loc23_;
                                    _loc25_ = _loc22_;
                                    _loc22_ = _loc22_.next;
                                    _loc24_.x = Number(_loc20_.body.posx + (_loc20_.body.axisy * _loc25_.x - _loc20_.body.axisx * _loc25_.y));
                                    _loc24_.y = Number(_loc20_.body.posy + (Number(_loc25_.x * _loc20_.body.axisx + _loc25_.y * _loc20_.body.axisy)));
                                    _loc23_ = _loc23_.next;
                                 }
                              }
                           }
                           _loc22_ = _loc20_.gverts.next;
                           _loc20_.aabb.minx = _loc22_.x;
                           _loc20_.aabb.miny = _loc22_.y;
                           _loc20_.aabb.maxx = _loc22_.x;
                           _loc20_.aabb.maxy = _loc22_.y;
                           _loc23_ = _loc20_.gverts.next.next;
                           while(_loc23_ != null)
                           {
                              _loc24_ = _loc23_;
                              if(_loc24_.x < _loc20_.aabb.minx)
                              {
                                 _loc20_.aabb.minx = _loc24_.x;
                              }
                              if(_loc24_.x > _loc20_.aabb.maxx)
                              {
                                 _loc20_.aabb.maxx = _loc24_.x;
                              }
                              if(_loc24_.y < _loc20_.aabb.miny)
                              {
                                 _loc20_.aabb.miny = _loc24_.y;
                              }
                              if(_loc24_.y > _loc20_.aabb.maxy)
                              {
                                 _loc20_.aabb.maxy = _loc24_.y;
                              }
                              _loc23_ = _loc23_.next;
                           }
                        }
                     }
                  }
                  _loc15_ = _loc2_.aabb;
                  _loc8_.minx = _loc15_.minx - 3;
                  _loc8_.miny = _loc15_.miny - 3;
                  _loc8_.maxx = Number(_loc15_.maxx + 3);
                  _loc8_.maxy = Number(_loc15_.maxy + 3);
                  _loc29_ = _loc2_.body.type == ZPP_Flags.id_BodyType_STATIC?false:!_loc2_.body.component.sleeping;
                  _loc1_.dyn = _loc29_;
                  _loc3_ = !!_loc29_?dtree:stree;
                  if(_loc3_.root == null)
                  {
                     _loc3_.root = _loc1_;
                     _loc3_.root.parent = null;
                  }
                  else
                  {
                     _loc15_ = _loc1_.aabb;
                     _loc4_ = _loc3_.root;
                     while(_loc4_.child1 != null)
                     {
                        _loc5_ = _loc4_.child1;
                        _loc6_ = _loc4_.child2;
                        _loc16_ = _loc4_.aabb;
                        _loc21_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc30_ = _loc4_.aabb;
                        _loc16_.minx = _loc30_.minx < _loc15_.minx?_loc30_.minx:_loc15_.minx;
                        _loc16_.miny = _loc30_.miny < _loc15_.miny?_loc30_.miny:_loc15_.miny;
                        _loc16_.maxx = _loc30_.maxx > _loc15_.maxx?_loc30_.maxx:_loc15_.maxx;
                        _loc16_.maxy = _loc30_.maxy > _loc15_.maxy?_loc30_.maxy:_loc15_.maxy;
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc26_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                        _loc31_ = 2 * _loc26_;
                        _loc32_ = 2 * (_loc26_ - _loc21_);
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc30_ = _loc5_.aabb;
                        _loc16_.minx = _loc15_.minx < _loc30_.minx?_loc15_.minx:_loc30_.minx;
                        _loc16_.miny = _loc15_.miny < _loc30_.miny?_loc15_.miny:_loc30_.miny;
                        _loc16_.maxx = _loc15_.maxx > _loc30_.maxx?_loc15_.maxx:_loc30_.maxx;
                        _loc16_.maxy = _loc15_.maxy > _loc30_.maxy?_loc15_.maxy:_loc30_.maxy;
                        if(_loc5_.child1 == null)
                        {
                           _loc16_ = ZPP_AABBTree.tmpaabb;
                           §§push(Number((_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2 + _loc32_));
                        }
                        else
                        {
                           _loc16_ = _loc5_.aabb;
                           _loc34_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                           _loc16_ = ZPP_AABBTree.tmpaabb;
                           _loc35_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                           §§push(Number(_loc35_ - _loc34_ + _loc32_));
                        }
                        _loc33_ = §§pop();
                        _loc16_ = ZPP_AABBTree.tmpaabb;
                        _loc30_ = _loc6_.aabb;
                        _loc16_.minx = _loc15_.minx < _loc30_.minx?_loc15_.minx:_loc30_.minx;
                        _loc16_.miny = _loc15_.miny < _loc30_.miny?_loc15_.miny:_loc30_.miny;
                        _loc16_.maxx = _loc15_.maxx > _loc30_.maxx?_loc15_.maxx:_loc30_.maxx;
                        _loc16_.maxy = _loc15_.maxy > _loc30_.maxy?_loc15_.maxy:_loc30_.maxy;
                        if(_loc6_.child1 == null)
                        {
                           _loc16_ = ZPP_AABBTree.tmpaabb;
                           §§push(Number((_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2 + _loc32_));
                        }
                        else
                        {
                           _loc16_ = _loc6_.aabb;
                           _loc35_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                           _loc16_ = ZPP_AABBTree.tmpaabb;
                           _loc36_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                           §§push(Number(_loc36_ - _loc35_ + _loc32_));
                        }
                        _loc34_ = §§pop();
                        if(!(_loc31_ < _loc33_ && _loc31_ < _loc34_))
                        {
                           _loc4_ = _loc33_ < _loc34_?_loc5_:_loc6_;
                           continue;
                        }
                        break;
                     }
                     _loc5_ = _loc4_;
                     _loc6_ = _loc5_.parent;
                     if(ZPP_AABBNode.zpp_pool == null)
                     {
                        _loc7_ = new ZPP_AABBNode();
                     }
                     else
                     {
                        _loc7_ = ZPP_AABBNode.zpp_pool;
                        ZPP_AABBNode.zpp_pool = _loc7_.next;
                        _loc7_.next = null;
                     }
                     if(ZPP_AABB.zpp_pool == null)
                     {
                        _loc7_.aabb = new ZPP_AABB();
                     }
                     else
                     {
                        _loc7_.aabb = ZPP_AABB.zpp_pool;
                        ZPP_AABB.zpp_pool = _loc7_.aabb.next;
                        _loc7_.aabb.next = null;
                     }
                     null;
                     _loc7_.moved = false;
                     _loc7_.synced = false;
                     _loc7_.first_sync = false;
                     _loc7_.parent = _loc6_;
                     _loc16_ = _loc7_.aabb;
                     _loc30_ = _loc5_.aabb;
                     _loc16_.minx = _loc15_.minx < _loc30_.minx?_loc15_.minx:_loc30_.minx;
                     _loc16_.miny = _loc15_.miny < _loc30_.miny?_loc15_.miny:_loc30_.miny;
                     _loc16_.maxx = _loc15_.maxx > _loc30_.maxx?_loc15_.maxx:_loc30_.maxx;
                     _loc16_.maxy = _loc15_.maxy > _loc30_.maxy?_loc15_.maxy:_loc30_.maxy;
                     _loc7_.height = _loc5_.height + 1;
                     if(_loc6_ != null)
                     {
                        if(_loc6_.child1 == _loc5_)
                        {
                           _loc6_.child1 = _loc7_;
                        }
                        else
                        {
                           _loc6_.child2 = _loc7_;
                        }
                        _loc7_.child1 = _loc5_;
                        _loc7_.child2 = _loc1_;
                        _loc5_.parent = _loc7_;
                        _loc1_.parent = _loc7_;
                     }
                     else
                     {
                        _loc7_.child1 = _loc5_;
                        _loc7_.child2 = _loc1_;
                        _loc5_.parent = _loc7_;
                        _loc1_.parent = _loc7_;
                        _loc3_.root = _loc7_;
                     }
                     _loc4_ = _loc1_.parent;
                     while(_loc4_ != null)
                     {
                        if(_loc4_.child1 == null || _loc4_.height < 2)
                        {
                           §§push(_loc4_);
                        }
                        else
                        {
                           _loc10_ = _loc4_.child1;
                           _loc11_ = _loc4_.child2;
                           _loc12_ = _loc11_.height - _loc10_.height;
                           if(_loc12_ > 1)
                           {
                              _loc13_ = _loc11_.child1;
                              _loc14_ = _loc11_.child2;
                              _loc11_.child1 = _loc4_;
                              _loc11_.parent = _loc4_.parent;
                              _loc4_.parent = _loc11_;
                              if(_loc11_.parent != null)
                              {
                                 if(_loc11_.parent.child1 == _loc4_)
                                 {
                                    _loc11_.parent.child1 = _loc11_;
                                 }
                                 else
                                 {
                                    _loc11_.parent.child2 = _loc11_;
                                 }
                              }
                              else
                              {
                                 _loc3_.root = _loc11_;
                              }
                              if(_loc13_.height > _loc14_.height)
                              {
                                 _loc11_.child2 = _loc13_;
                                 _loc4_.child2 = _loc14_;
                                 _loc14_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc10_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc16_ = _loc11_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc17_ = _loc10_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc11_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                              }
                              else
                              {
                                 _loc11_.child2 = _loc14_;
                                 _loc4_.child2 = _loc13_;
                                 _loc13_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc10_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc16_ = _loc11_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc17_ = _loc10_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc11_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                              }
                              §§push(_loc11_);
                           }
                           else if(_loc12_ < -1)
                           {
                              _loc13_ = _loc10_.child1;
                              _loc14_ = _loc10_.child2;
                              _loc10_.child1 = _loc4_;
                              _loc10_.parent = _loc4_.parent;
                              _loc4_.parent = _loc10_;
                              if(_loc10_.parent != null)
                              {
                                 if(_loc10_.parent.child1 == _loc4_)
                                 {
                                    _loc10_.parent.child1 = _loc10_;
                                 }
                                 else
                                 {
                                    _loc10_.parent.child2 = _loc10_;
                                 }
                              }
                              else
                              {
                                 _loc3_.root = _loc10_;
                              }
                              if(_loc13_.height > _loc14_.height)
                              {
                                 _loc10_.child2 = _loc13_;
                                 _loc4_.child1 = _loc14_;
                                 _loc14_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc11_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc16_ = _loc10_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc17_ = _loc11_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc10_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                              }
                              else
                              {
                                 _loc10_.child2 = _loc14_;
                                 _loc4_.child1 = _loc13_;
                                 _loc13_.parent = _loc4_;
                                 _loc16_ = _loc4_.aabb;
                                 _loc30_ = _loc11_.aabb;
                                 _loc37_ = _loc13_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc16_ = _loc10_.aabb;
                                 _loc30_ = _loc4_.aabb;
                                 _loc37_ = _loc14_.aabb;
                                 _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                                 _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                                 _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                                 _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                                 _loc17_ = _loc11_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc4_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                 _loc17_ = _loc4_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc10_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                              }
                              §§push(_loc10_);
                           }
                           else
                           {
                              §§push(_loc4_);
                           }
                        }
                        _loc4_ = §§pop();
                        _loc10_ = _loc4_.child1;
                        _loc11_ = _loc4_.child2;
                        _loc12_ = int(_loc10_.height);
                        _loc17_ = _loc11_.height;
                        _loc4_.height = 1 + (_loc12_ > _loc17_?_loc12_:_loc17_);
                        _loc16_ = _loc4_.aabb;
                        _loc30_ = _loc10_.aabb;
                        _loc37_ = _loc11_.aabb;
                        _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                        _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                        _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                        _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                        _loc4_ = _loc4_.parent;
                     }
                  }
                  _loc1_.synced = false;
                  if(!_loc1_.moved)
                  {
                     _loc1_.moved = true;
                     _loc1_.mnext = moves;
                     moves = _loc1_;
                  }
               }
            }
         }
      }
      
      override public function shapesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter) : ShapeList
      {
         var _loc6_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZNPList_ZPP_AABBNode;
         var _loc9_:* = null as ZPP_AABBNode;
         var _loc10_:* = null as ZPP_AABB;
         var _loc11_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         if(ZPP_Vec2.zpp_pool == null)
         {
            _loc6_ = new ZPP_Vec2();
         }
         else
         {
            _loc6_ = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc6_.next;
            _loc6_.next = null;
         }
         _loc6_.weak = false;
         _loc6_._immutable = false;
         _loc6_.x = param1;
         _loc6_.y = param2;
         var _loc4_:ZPP_Vec2 = _loc6_;
         var _loc7_:ShapeList = new ShapeList();
         if(stree.root != null)
         {
            _loc8_ = new ZNPList_ZPP_AABBNode();
            _loc8_.add(stree.root);
            while(_loc8_.head != null)
            {
               _loc9_ = _loc8_.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc4_.x >= _loc10_.minx && _loc4_.x <= _loc10_.maxx && _loc4_.y >= _loc10_.miny && _loc4_.y <= _loc10_.maxy)
               {
                  if(_loc9_.child1 == null)
                  {
                     if(param3 == null || (_loc11_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc11_.collisionGroup) != 0)
                     {
                        if(_loc9_.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                           if(ZPP_Collide.circleContains(_loc9_.shape.circle,_loc4_))
                           {
                              _loc7_.push(_loc9_.shape.outer);
                           }
                        }
                        else if(ZPP_Collide.polyContains(_loc9_.shape.polygon,_loc4_))
                        {
                           _loc7_.push(_loc9_.shape.outer);
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        _loc8_.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        _loc8_.add(_loc9_.child2);
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            _loc8_ = new ZNPList_ZPP_AABBNode();
            _loc8_.add(dtree.root);
            while(_loc8_.head != null)
            {
               _loc9_ = _loc8_.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc4_.x >= _loc10_.minx && _loc4_.x <= _loc10_.maxx && _loc4_.y >= _loc10_.miny && _loc4_.y <= _loc10_.maxy)
               {
                  if(_loc9_.child1 == null)
                  {
                     if(param3 == null || (_loc11_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc11_.collisionGroup) != 0)
                     {
                        if(_loc9_.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                           if(ZPP_Collide.circleContains(_loc9_.shape.circle,_loc4_))
                           {
                              _loc7_.push(_loc9_.shape.outer);
                           }
                        }
                        else if(ZPP_Collide.polyContains(_loc9_.shape.polygon,_loc4_))
                        {
                           _loc7_.push(_loc9_.shape.outer);
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        _loc8_.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        _loc8_.add(_loc9_.child2);
                     }
                  }
               }
            }
         }
         _loc6_ = _loc4_;
         if(_loc6_.outer != null)
         {
            _loc6_.outer.zpp_inner = null;
            _loc6_.outer = null;
         }
         _loc6_._isimmutable = null;
         _loc6_._validate = null;
         _loc6_._invalidate = null;
         _loc6_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc6_;
         return _loc7_;
      }
      
      override public function shapesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter) : ShapeList
      {
         var _loc6_:* = null as ZNPList_ZPP_AABBNode;
         var _loc7_:* = null as ZPP_AABBNode;
         var _loc8_:* = null as ZPP_AABB;
         var _loc9_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         validateShape(param1);
         var _loc4_:ZPP_AABB = param1.aabb;
         var _loc5_:ShapeList = new ShapeList();
         if(stree.root != null)
         {
            _loc6_ = new ZNPList_ZPP_AABBNode();
            _loc6_.add(stree.root);
            while(_loc6_.head != null)
            {
               _loc7_ = _loc6_.pop_unsafe();
               _loc8_ = _loc7_.aabb;
               if(_loc4_.miny <= _loc8_.maxy && _loc8_.miny <= _loc4_.maxy && _loc4_.minx <= _loc8_.maxx && _loc8_.minx <= _loc4_.maxx)
               {
                  if(_loc7_.child1 == null)
                  {
                     if(param3 == null || (_loc9_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc9_.collisionGroup) != 0)
                     {
                        if(param2)
                        {
                           if(ZPP_Collide.containTest(param1,_loc7_.shape))
                           {
                              _loc5_.push(_loc7_.shape.outer);
                           }
                        }
                        else if(ZPP_Collide.testCollide_safe(_loc7_.shape,param1))
                        {
                           _loc5_.push(_loc7_.shape.outer);
                        }
                     }
                  }
                  else
                  {
                     if(_loc7_.child1 != null)
                     {
                        _loc6_.add(_loc7_.child1);
                     }
                     if(_loc7_.child2 != null)
                     {
                        _loc6_.add(_loc7_.child2);
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            _loc6_ = new ZNPList_ZPP_AABBNode();
            _loc6_.add(dtree.root);
            while(_loc6_.head != null)
            {
               _loc7_ = _loc6_.pop_unsafe();
               _loc8_ = _loc7_.aabb;
               if(_loc4_.miny <= _loc8_.maxy && _loc8_.miny <= _loc4_.maxy && _loc4_.minx <= _loc8_.maxx && _loc8_.minx <= _loc4_.maxx)
               {
                  if(_loc7_.child1 == null)
                  {
                     if(param3 == null || (_loc9_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc9_.collisionGroup) != 0)
                     {
                        if(param2)
                        {
                           if(ZPP_Collide.containTest(param1,_loc7_.shape))
                           {
                              _loc5_.push(_loc7_.shape.outer);
                           }
                        }
                        else if(ZPP_Collide.testCollide_safe(_loc7_.shape,param1))
                        {
                           _loc5_.push(_loc7_.shape.outer);
                        }
                     }
                  }
                  else
                  {
                     if(_loc7_.child1 != null)
                     {
                        _loc6_.add(_loc7_.child1);
                     }
                     if(_loc7_.child2 != null)
                     {
                        _loc6_.add(_loc7_.child2);
                     }
                  }
               }
            }
         }
         return _loc5_;
      }
      
      override public function shapesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter) : ShapeList
      {
         var _loc8_:* = null as ZNPList_ZPP_AABBNode;
         var _loc9_:* = null as ZPP_AABBNode;
         var _loc10_:* = null as ZPP_AABB;
         var _loc11_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         updateCircShape(param1,param2,param3);
         var _loc6_:ZPP_AABB = circShape.zpp_inner.aabb;
         var _loc7_:ShapeList = new ShapeList();
         if(stree.root != null)
         {
            _loc8_ = new ZNPList_ZPP_AABBNode();
            _loc8_.add(stree.root);
            while(_loc8_.head != null)
            {
               _loc9_ = _loc8_.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc6_.miny <= _loc10_.maxy && _loc10_.miny <= _loc6_.maxy && _loc6_.minx <= _loc10_.maxx && _loc10_.minx <= _loc6_.maxx)
               {
                  if(_loc9_.child1 == null)
                  {
                     if(param5 == null || (_loc11_.collisionMask & param5.collisionGroup) != 0 && (param5.collisionMask & _loc11_.collisionGroup) != 0)
                     {
                        if(param4)
                        {
                           if(ZPP_Collide.containTest(circShape.zpp_inner,_loc9_.shape))
                           {
                              _loc7_.push(_loc9_.shape.outer);
                           }
                        }
                        else if(ZPP_Collide.testCollide_safe(_loc9_.shape,circShape.zpp_inner))
                        {
                           _loc7_.push(_loc9_.shape.outer);
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        _loc8_.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        _loc8_.add(_loc9_.child2);
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            _loc8_ = new ZNPList_ZPP_AABBNode();
            _loc8_.add(dtree.root);
            while(_loc8_.head != null)
            {
               _loc9_ = _loc8_.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc6_.miny <= _loc10_.maxy && _loc10_.miny <= _loc6_.maxy && _loc6_.minx <= _loc10_.maxx && _loc10_.minx <= _loc6_.maxx)
               {
                  if(_loc9_.child1 == null)
                  {
                     if(param5 == null || (_loc11_.collisionMask & param5.collisionGroup) != 0 && (param5.collisionMask & _loc11_.collisionGroup) != 0)
                     {
                        if(param4)
                        {
                           if(ZPP_Collide.containTest(circShape.zpp_inner,_loc9_.shape))
                           {
                              _loc7_.push(_loc9_.shape.outer);
                           }
                        }
                        else if(ZPP_Collide.testCollide_safe(_loc9_.shape,circShape.zpp_inner))
                        {
                           _loc7_.push(_loc9_.shape.outer);
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        _loc8_.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        _loc8_.add(_loc9_.child2);
                     }
                  }
               }
            }
         }
         return _loc7_;
      }
      
      override public function shapesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter) : ShapeList
      {
         var _loc7_:* = null as ZNPList_ZPP_AABBNode;
         var _loc8_:* = null as ZPP_AABBNode;
         var _loc9_:* = null as ZPP_AABB;
         var _loc10_:* = null as ZNPList_ZPP_AABBNode;
         var _loc11_:* = null as ZPP_AABBNode;
         var _loc12_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         updateAABBShape(param1);
         var _loc5_:ZPP_AABB = aabbShape.zpp_inner.aabb;
         var _loc6_:ShapeList = new ShapeList();
         if(stree.root != null)
         {
            _loc7_ = new ZNPList_ZPP_AABBNode();
            _loc7_.add(stree.root);
            while(_loc7_.head != null)
            {
               _loc8_ = _loc7_.pop_unsafe();
               _loc9_ = _loc8_.aabb;
               if(_loc9_.minx >= _loc5_.minx && _loc9_.miny >= _loc5_.miny && _loc9_.maxx <= _loc5_.maxx && _loc9_.maxy <= _loc5_.maxy)
               {
                  if(_loc8_.child1 == null)
                  {
                     _loc6_.push(_loc8_.shape.outer);
                  }
                  else
                  {
                     _loc10_ = new ZNPList_ZPP_AABBNode();
                     _loc10_.add(_loc8_);
                     while(_loc10_.head != null)
                     {
                        _loc11_ = _loc10_.pop_unsafe();
                        if(_loc11_.child1 == null)
                        {
                           _loc6_.push(_loc11_.shape.outer);
                        }
                        else
                        {
                           if(_loc11_.child1 != null)
                           {
                              _loc10_.add(_loc11_.child1);
                           }
                           if(_loc11_.child2 != null)
                           {
                              _loc10_.add(_loc11_.child2);
                           }
                        }
                     }
                  }
               }
               else
               {
                  _loc9_ = _loc8_.aabb;
                  if(_loc5_.miny <= _loc9_.maxy && _loc9_.miny <= _loc5_.maxy && _loc5_.minx <= _loc9_.maxx && _loc9_.minx <= _loc5_.maxx)
                  {
                     if(_loc8_.child1 == null)
                     {
                        if(param4 == null || (_loc12_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc12_.collisionGroup) != 0)
                        {
                           if(param2)
                           {
                              if(param3)
                              {
                                 if(ZPP_Collide.containTest(aabbShape.zpp_inner,_loc8_.shape))
                                 {
                                    _loc6_.push(_loc8_.shape.outer);
                                 }
                              }
                              else
                              {
                                 _loc9_ = _loc8_.shape.aabb;
                                 if(_loc9_.minx >= _loc5_.minx && _loc9_.miny >= _loc5_.miny && _loc9_.maxx <= _loc5_.maxx && _loc9_.maxy <= _loc5_.maxy)
                                 {
                                    _loc6_.push(_loc8_.shape.outer);
                                 }
                                 else if(ZPP_Collide.testCollide_safe(_loc8_.shape,aabbShape.zpp_inner))
                                 {
                                    _loc6_.push(_loc8_.shape.outer);
                                 }
                              }
                           }
                           else if(!param3 || _loc9_.minx >= _loc5_.minx && _loc9_.miny >= _loc5_.miny && _loc9_.maxx <= _loc5_.maxx && _loc9_.maxy <= _loc5_.maxy)
                           {
                              _loc6_.push(_loc8_.shape.outer);
                           }
                        }
                     }
                     else
                     {
                        if(_loc8_.child1 != null)
                        {
                           _loc7_.add(_loc8_.child1);
                        }
                        if(_loc8_.child2 != null)
                        {
                           _loc7_.add(_loc8_.child2);
                        }
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            _loc7_ = new ZNPList_ZPP_AABBNode();
            _loc7_.add(dtree.root);
            while(_loc7_.head != null)
            {
               _loc8_ = _loc7_.pop_unsafe();
               _loc9_ = _loc8_.aabb;
               if(_loc9_.minx >= _loc5_.minx && _loc9_.miny >= _loc5_.miny && _loc9_.maxx <= _loc5_.maxx && _loc9_.maxy <= _loc5_.maxy)
               {
                  if(_loc8_.child1 == null)
                  {
                     _loc6_.push(_loc8_.shape.outer);
                  }
                  else
                  {
                     _loc10_ = new ZNPList_ZPP_AABBNode();
                     _loc10_.add(_loc8_);
                     while(_loc10_.head != null)
                     {
                        _loc11_ = _loc10_.pop_unsafe();
                        if(_loc11_.child1 == null)
                        {
                           _loc6_.push(_loc11_.shape.outer);
                        }
                        else
                        {
                           if(_loc11_.child1 != null)
                           {
                              _loc10_.add(_loc11_.child1);
                           }
                           if(_loc11_.child2 != null)
                           {
                              _loc10_.add(_loc11_.child2);
                           }
                        }
                     }
                  }
               }
               else
               {
                  _loc9_ = _loc8_.aabb;
                  if(_loc5_.miny <= _loc9_.maxy && _loc9_.miny <= _loc5_.maxy && _loc5_.minx <= _loc9_.maxx && _loc9_.minx <= _loc5_.maxx)
                  {
                     if(_loc8_.child1 == null)
                     {
                        if(param4 == null || (_loc12_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc12_.collisionGroup) != 0)
                        {
                           if(param2)
                           {
                              if(param3)
                              {
                                 if(ZPP_Collide.containTest(aabbShape.zpp_inner,_loc8_.shape))
                                 {
                                    _loc6_.push(_loc8_.shape.outer);
                                 }
                              }
                              else
                              {
                                 _loc9_ = _loc8_.shape.aabb;
                                 if(_loc9_.minx >= _loc5_.minx && _loc9_.miny >= _loc5_.miny && _loc9_.maxx <= _loc5_.maxx && _loc9_.maxy <= _loc5_.maxy)
                                 {
                                    _loc6_.push(_loc8_.shape.outer);
                                 }
                                 else if(ZPP_Collide.testCollide_safe(_loc8_.shape,aabbShape.zpp_inner))
                                 {
                                    _loc6_.push(_loc8_.shape.outer);
                                 }
                              }
                           }
                           else if(!param3 || _loc9_.minx >= _loc5_.minx && _loc9_.miny >= _loc5_.miny && _loc9_.maxx <= _loc5_.maxx && _loc9_.maxy <= _loc5_.maxy)
                           {
                              _loc6_.push(_loc8_.shape.outer);
                           }
                        }
                     }
                     else
                     {
                        if(_loc8_.child1 != null)
                        {
                           _loc7_.add(_loc8_.child1);
                        }
                        if(_loc8_.child2 != null)
                        {
                           _loc7_.add(_loc8_.child2);
                        }
                     }
                  }
               }
            }
         }
         return _loc6_;
      }
      
      override public function rayMultiCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter) : RayResultList
      {
         var _loc6_:Number = NaN;
         var _loc7_:* = null as ZPP_AABBNode;
         var _loc8_:* = null as ZPP_Shape;
         var _loc9_:* = null as ZPP_InteractionFilter;
         if(openlist == null)
         {
            openlist = new ZNPList_ZPP_AABBNode();
         }
         sync_broadphase();
         param1.validate_dir();
         var _loc4_:* = param1.maxdist >= 1.79e308;
         var _loc5_:RayResultList = new RayResultList();
         if(dtree.root != null)
         {
            if(param1.aabbtest(dtree.root.aabb))
            {
               if(_loc4_)
               {
                  openlist.add(dtree.root);
               }
               else
               {
                  _loc6_ = Number(param1.aabbsect(dtree.root.aabb));
                  if(_loc6_ >= 0 && _loc6_ < param1.maxdist)
                  {
                     openlist.add(dtree.root);
                  }
               }
            }
         }
         if(stree.root != null)
         {
            if(param1.aabbtest(stree.root.aabb))
            {
               if(_loc4_)
               {
                  openlist.add(stree.root);
               }
               else
               {
                  _loc6_ = Number(param1.aabbsect(stree.root.aabb));
                  if(_loc6_ >= 0 && _loc6_ < param1.maxdist)
                  {
                     openlist.add(stree.root);
                  }
               }
            }
         }
         while(openlist.head != null)
         {
            _loc7_ = openlist.pop_unsafe();
            if(_loc7_.child1 == null)
            {
               _loc8_ = _loc7_.shape;
               if(param3 == null || (_loc9_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc9_.collisionGroup) != 0)
               {
                  if(_loc8_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     param1.circlesect2(_loc8_.circle,param2,_loc5_);
                  }
                  else if(param1.aabbtest(_loc8_.aabb))
                  {
                     param1.polysect2(_loc8_.polygon,param2,_loc5_);
                  }
               }
            }
            else
            {
               if(_loc7_.child1 != null)
               {
                  if(param1.aabbtest(_loc7_.child1.aabb))
                  {
                     if(_loc4_)
                     {
                        openlist.add(_loc7_.child1);
                     }
                     else
                     {
                        _loc6_ = Number(param1.aabbsect(_loc7_.child1.aabb));
                        if(_loc6_ >= 0 && _loc6_ < param1.maxdist)
                        {
                           openlist.add(_loc7_.child1);
                        }
                     }
                  }
               }
               if(_loc7_.child2 != null)
               {
                  if(param1.aabbtest(_loc7_.child2.aabb))
                  {
                     if(_loc4_)
                     {
                        openlist.add(_loc7_.child2);
                     }
                     else
                     {
                        _loc6_ = Number(param1.aabbsect(_loc7_.child2.aabb));
                        if(_loc6_ >= 0 && _loc6_ < param1.maxdist)
                        {
                           openlist.add(_loc7_.child2);
                        }
                     }
                  }
               }
            }
         }
         openlist.clear();
         return _loc5_;
      }
      
      override public function rayCast(param1:ZPP_Ray, param2:Boolean, param3:ZPP_InteractionFilter) : RayResult
      {
         var _loc5_:Number = NaN;
         var _loc6_:* = null as ZNPNode_ZPP_AABBNode;
         var _loc7_:* = null as ZNPNode_ZPP_AABBNode;
         var _loc8_:* = null as ZPP_AABBNode;
         var _loc9_:* = null as ZNPList_ZPP_AABBNode;
         var _loc10_:* = null as ZNPNode_ZPP_AABBNode;
         var _loc11_:Boolean = false;
         var _loc13_:* = null as ZPP_Shape;
         var _loc14_:* = null as ZPP_InteractionFilter;
         var _loc15_:* = null as RayResult;
         var _loc16_:* = null as ZPP_AABBNode;
         if(openlist == null)
         {
            openlist = new ZNPList_ZPP_AABBNode();
         }
         sync_broadphase();
         param1.validate_dir();
         var _loc4_:Number = param1.maxdist;
         if(dtree.root != null)
         {
            if(param1.aabbtest(dtree.root.aabb))
            {
               _loc5_ = Number(param1.aabbsect(dtree.root.aabb));
               if(_loc5_ >= 0 && _loc5_ < _loc4_)
               {
                  dtree.root.rayt = _loc5_;
                  _loc6_ = null;
                  _loc7_ = openlist.head;
                  while(_loc7_ != null)
                  {
                     _loc8_ = _loc7_.elt;
                     if(dtree.root.rayt >= _loc8_.rayt)
                     {
                        _loc6_ = _loc7_;
                        _loc7_ = _loc7_.next;
                        continue;
                     }
                     break;
                  }
                  _loc9_ = openlist;
                  if(ZNPNode_ZPP_AABBNode.zpp_pool == null)
                  {
                     _loc10_ = new ZNPNode_ZPP_AABBNode();
                  }
                  else
                  {
                     _loc10_ = ZNPNode_ZPP_AABBNode.zpp_pool;
                     ZNPNode_ZPP_AABBNode.zpp_pool = _loc10_.next;
                     _loc10_.next = null;
                  }
                  null;
                  _loc10_.elt = dtree.root;
                  _loc7_ = _loc10_;
                  if(_loc6_ == null)
                  {
                     _loc7_.next = _loc9_.head;
                     _loc9_.head = _loc7_;
                  }
                  else
                  {
                     _loc7_.next = _loc6_.next;
                     _loc6_.next = _loc7_;
                  }
                  _loc11_ = true;
                  _loc9_.modified = _loc11_;
                  _loc9_.pushmod = _loc11_;
                  _loc9_.length = _loc9_.length + 1;
                  _loc7_;
               }
            }
         }
         if(stree.root != null)
         {
            if(param1.aabbtest(stree.root.aabb))
            {
               _loc5_ = Number(param1.aabbsect(stree.root.aabb));
               if(_loc5_ >= 0 && _loc5_ < _loc4_)
               {
                  stree.root.rayt = _loc5_;
                  _loc6_ = null;
                  _loc7_ = openlist.head;
                  while(_loc7_ != null)
                  {
                     _loc8_ = _loc7_.elt;
                     if(stree.root.rayt >= _loc8_.rayt)
                     {
                        _loc6_ = _loc7_;
                        _loc7_ = _loc7_.next;
                        continue;
                     }
                     break;
                  }
                  _loc9_ = openlist;
                  if(ZNPNode_ZPP_AABBNode.zpp_pool == null)
                  {
                     _loc10_ = new ZNPNode_ZPP_AABBNode();
                  }
                  else
                  {
                     _loc10_ = ZNPNode_ZPP_AABBNode.zpp_pool;
                     ZNPNode_ZPP_AABBNode.zpp_pool = _loc10_.next;
                     _loc10_.next = null;
                  }
                  null;
                  _loc10_.elt = stree.root;
                  _loc7_ = _loc10_;
                  if(_loc6_ == null)
                  {
                     _loc7_.next = _loc9_.head;
                     _loc9_.head = _loc7_;
                  }
                  else
                  {
                     _loc7_.next = _loc6_.next;
                     _loc6_.next = _loc7_;
                  }
                  _loc11_ = true;
                  _loc9_.modified = _loc11_;
                  _loc9_.pushmod = _loc11_;
                  _loc9_.length = _loc9_.length + 1;
                  _loc7_;
               }
            }
         }
         var _loc12_:RayResult = null;
         while(openlist.head != null)
         {
            _loc8_ = openlist.pop_unsafe();
            if(_loc8_.rayt < _loc4_)
            {
               if(_loc8_.child1 == null)
               {
                  _loc13_ = _loc8_.shape;
                  if(param3 == null || (_loc14_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc14_.collisionGroup) != 0)
                  {
                     _loc15_ = _loc13_.type == ZPP_Flags.id_ShapeType_CIRCLE?param1.circlesect(_loc13_.circle,param2,_loc4_):!!param1.aabbtest(_loc13_.aabb)?param1.polysect(_loc13_.polygon,param2,_loc4_):null;
                     if(_loc15_ != null)
                     {
                        _loc4_ = _loc15_.distance;
                        _loc12_ = _loc15_;
                     }
                  }
               }
               else
               {
                  if(_loc8_.child1 != null)
                  {
                     if(param1.aabbtest(_loc8_.child1.aabb))
                     {
                        _loc5_ = Number(param1.aabbsect(_loc8_.child1.aabb));
                        if(_loc5_ >= 0 && _loc5_ < _loc4_)
                        {
                           _loc8_.child1.rayt = _loc5_;
                           _loc6_ = null;
                           _loc7_ = openlist.head;
                           while(_loc7_ != null)
                           {
                              _loc16_ = _loc7_.elt;
                              if(_loc8_.child1.rayt >= _loc16_.rayt)
                              {
                                 _loc6_ = _loc7_;
                                 _loc7_ = _loc7_.next;
                                 continue;
                              }
                              break;
                           }
                           _loc9_ = openlist;
                           if(ZNPNode_ZPP_AABBNode.zpp_pool == null)
                           {
                              _loc10_ = new ZNPNode_ZPP_AABBNode();
                           }
                           else
                           {
                              _loc10_ = ZNPNode_ZPP_AABBNode.zpp_pool;
                              ZNPNode_ZPP_AABBNode.zpp_pool = _loc10_.next;
                              _loc10_.next = null;
                           }
                           null;
                           _loc10_.elt = _loc8_.child1;
                           _loc7_ = _loc10_;
                           if(_loc6_ == null)
                           {
                              _loc7_.next = _loc9_.head;
                              _loc9_.head = _loc7_;
                           }
                           else
                           {
                              _loc7_.next = _loc6_.next;
                              _loc6_.next = _loc7_;
                           }
                           _loc11_ = true;
                           _loc9_.modified = _loc11_;
                           _loc9_.pushmod = _loc11_;
                           _loc9_.length = _loc9_.length + 1;
                           _loc7_;
                        }
                     }
                  }
                  if(_loc8_.child2 != null)
                  {
                     if(param1.aabbtest(_loc8_.child2.aabb))
                     {
                        _loc5_ = Number(param1.aabbsect(_loc8_.child2.aabb));
                        if(_loc5_ >= 0 && _loc5_ < _loc4_)
                        {
                           _loc8_.child2.rayt = _loc5_;
                           _loc6_ = null;
                           _loc7_ = openlist.head;
                           while(_loc7_ != null)
                           {
                              _loc16_ = _loc7_.elt;
                              if(_loc8_.child2.rayt >= _loc16_.rayt)
                              {
                                 _loc6_ = _loc7_;
                                 _loc7_ = _loc7_.next;
                                 continue;
                              }
                              break;
                           }
                           _loc9_ = openlist;
                           if(ZNPNode_ZPP_AABBNode.zpp_pool == null)
                           {
                              _loc10_ = new ZNPNode_ZPP_AABBNode();
                           }
                           else
                           {
                              _loc10_ = ZNPNode_ZPP_AABBNode.zpp_pool;
                              ZNPNode_ZPP_AABBNode.zpp_pool = _loc10_.next;
                              _loc10_.next = null;
                           }
                           null;
                           _loc10_.elt = _loc8_.child2;
                           _loc7_ = _loc10_;
                           if(_loc6_ == null)
                           {
                              _loc7_.next = _loc9_.head;
                              _loc9_.head = _loc7_;
                           }
                           else
                           {
                              _loc7_.next = _loc6_.next;
                              _loc6_.next = _loc7_;
                           }
                           _loc11_ = true;
                           _loc9_.modified = _loc11_;
                           _loc9_.pushmod = _loc11_;
                           _loc9_.length = _loc9_.length + 1;
                           _loc7_;
                        }
                     }
                  }
               }
               continue;
            }
            break;
         }
         openlist.clear();
         return _loc12_;
      }
      
      override public function clear() : void
      {
         var _loc1_:* = null as ZPP_AABBNode;
         var _loc2_:* = null as ZPP_AABBPair;
         var _loc3_:* = null as ZNPList_ZPP_AABBPair;
         var _loc4_:* = null as ZPP_AABBPair;
         var _loc5_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc6_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc7_:Boolean = false;
         var _loc8_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc9_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc10_:* = null as ZNPNode_ZPP_AABBPair;
         while(syncs != null)
         {
            _loc1_ = syncs.snext;
            syncs.snext = null;
            if(syncs.first_sync)
            {
               syncs.shape.node = null;
               syncs.shape.removedFromSpace();
               syncs.shape = null;
            }
            syncs = _loc1_;
         }
         while(moves != null)
         {
            _loc1_ = moves.mnext;
            moves.mnext = null;
            if(moves.first_sync)
            {
               moves.shape.node = null;
               moves.shape.removedFromSpace();
               moves.shape = null;
            }
            moves = _loc1_;
         }
         while(pairs != null)
         {
            _loc2_ = pairs.next;
            if(pairs.arb != null)
            {
               pairs.arb.pair = null;
            }
            pairs.arb = null;
            _loc3_ = pairs.n1.shape.pairs;
            _loc4_ = pairs;
            _loc5_ = null;
            _loc6_ = _loc3_.head;
            _loc7_ = false;
            while(_loc6_ != null)
            {
               if(_loc6_.elt == _loc4_)
               {
                  if(_loc5_ == null)
                  {
                     _loc8_ = _loc3_.head;
                     _loc9_ = _loc8_.next;
                     _loc3_.head = _loc9_;
                     if(_loc3_.head == null)
                     {
                        _loc3_.pushmod = true;
                     }
                  }
                  else
                  {
                     _loc8_ = _loc5_.next;
                     _loc9_ = _loc8_.next;
                     _loc5_.next = _loc9_;
                     if(_loc9_ == null)
                     {
                        _loc3_.pushmod = true;
                     }
                  }
                  _loc10_ = _loc8_;
                  _loc10_.elt = null;
                  _loc10_.next = ZNPNode_ZPP_AABBPair.zpp_pool;
                  ZNPNode_ZPP_AABBPair.zpp_pool = _loc10_;
                  _loc3_.modified = true;
                  _loc3_.length = _loc3_.length - 1;
                  _loc3_.pushmod = true;
                  _loc9_;
                  _loc7_ = true;
                  break;
               }
               _loc5_ = _loc6_;
               _loc6_ = _loc6_.next;
            }
            _loc7_;
            _loc3_ = pairs.n2.shape.pairs;
            _loc4_ = pairs;
            _loc5_ = null;
            _loc6_ = _loc3_.head;
            _loc7_ = false;
            while(_loc6_ != null)
            {
               if(_loc6_.elt == _loc4_)
               {
                  if(_loc5_ == null)
                  {
                     _loc8_ = _loc3_.head;
                     _loc9_ = _loc8_.next;
                     _loc3_.head = _loc9_;
                     if(_loc3_.head == null)
                     {
                        _loc3_.pushmod = true;
                     }
                  }
                  else
                  {
                     _loc8_ = _loc5_.next;
                     _loc9_ = _loc8_.next;
                     _loc5_.next = _loc9_;
                     if(_loc9_ == null)
                     {
                        _loc3_.pushmod = true;
                     }
                  }
                  _loc10_ = _loc8_;
                  _loc10_.elt = null;
                  _loc10_.next = ZNPNode_ZPP_AABBPair.zpp_pool;
                  ZNPNode_ZPP_AABBPair.zpp_pool = _loc10_;
                  _loc3_.modified = true;
                  _loc3_.length = _loc3_.length - 1;
                  _loc3_.pushmod = true;
                  _loc9_;
                  _loc7_ = true;
                  break;
               }
               _loc5_ = _loc6_;
               _loc6_ = _loc6_.next;
            }
            _loc7_;
            _loc4_ = pairs;
            _loc1_ = null;
            _loc4_.n2 = _loc1_;
            _loc4_.n1 = _loc1_;
            _loc4_.sleeping = false;
            _loc4_.next = ZPP_AABBPair.zpp_pool;
            ZPP_AABBPair.zpp_pool = _loc4_;
            pairs = _loc2_;
         }
         dtree.clear();
         stree.clear();
      }
      
      override public function broadphase() : void
      {
         var _loc2_:* = null as ZPP_Shape;
         var _loc3_:* = null as ZPP_AABBTree;
         var _loc4_:* = null as ZPP_AABBNode;
         var _loc5_:* = null as ZPP_AABBNode;
         var _loc6_:* = null as ZPP_AABBNode;
         var _loc7_:* = null as ZPP_AABBNode;
         var _loc8_:* = null as ZPP_AABB;
         var _loc9_:* = null as Vec2;
         var _loc10_:* = null as ZPP_AABBNode;
         var _loc11_:* = null as ZPP_AABBNode;
         var _loc12_:* = 0;
         var _loc13_:* = null as ZPP_AABBNode;
         var _loc14_:* = null as ZPP_AABBNode;
         var _loc15_:* = null as ZPP_AABB;
         var _loc16_:* = null as ZPP_AABB;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc19_:* = null as ZPP_Circle;
         var _loc20_:* = null as ZPP_Polygon;
         var _loc21_:Number = NaN;
         var _loc22_:* = null as ZPP_Vec2;
         var _loc23_:* = null as ZPP_Vec2;
         var _loc24_:* = null as ZPP_Vec2;
         var _loc25_:* = null as ZPP_Vec2;
         var _loc26_:Number = NaN;
         var _loc27_:* = null as ZPP_Vec2;
         var _loc28_:* = null as ZPP_Body;
         var _loc29_:Boolean = false;
         var _loc30_:* = null as ZPP_AABB;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:* = null as ZPP_AABB;
         var _loc38_:* = null as ZPP_Shape;
         var _loc39_:* = null as ZPP_Shape;
         var _loc40_:* = null as ZPP_AABBPair;
         var _loc41_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc42_:* = null as ZPP_AABBPair;
         var _loc43_:* = null as ZNPList_ZPP_AABBPair;
         var _loc44_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc45_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc46_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc47_:* = null as ZNPNode_ZPP_AABBPair;
         var _loc48_:* = null as ZPP_AABBPair;
         var _loc49_:* = null as ZPP_AABBPair;
         var _loc50_:* = null as ZPP_Body;
         var _loc51_:* = null as ZPP_Arbiter;
         var _loc1_:ZPP_AABBNode = syncs;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.shape;
            if(!_loc1_.first_sync)
            {
               _loc3_ = !!_loc1_.dyn?dtree:stree;
               if(_loc1_ == _loc3_.root)
               {
                  _loc3_.root = null;
                  null;
               }
               else
               {
                  _loc4_ = _loc1_.parent;
                  _loc5_ = _loc4_.parent;
                  _loc6_ = _loc4_.child1 == _loc1_?_loc4_.child2:_loc4_.child1;
                  if(_loc5_ != null)
                  {
                     if(_loc5_.child1 == _loc4_)
                     {
                        _loc5_.child1 = _loc6_;
                     }
                     else
                     {
                        _loc5_.child2 = _loc6_;
                     }
                     _loc6_.parent = _loc5_;
                     _loc7_ = _loc4_;
                     _loc7_.height = -1;
                     _loc8_ = _loc7_.aabb;
                     if(_loc8_.outer != null)
                     {
                        _loc8_.outer.zpp_inner = null;
                        _loc8_.outer = null;
                     }
                     _loc9_ = null;
                     _loc8_.wrap_max = _loc9_;
                     _loc8_.wrap_min = _loc9_;
                     _loc8_._invalidate = null;
                     _loc8_._validate = null;
                     _loc8_.next = ZPP_AABB.zpp_pool;
                     ZPP_AABB.zpp_pool = _loc8_;
                     _loc10_ = null;
                     _loc7_.parent = _loc10_;
                     _loc10_ = _loc10_;
                     _loc7_.child2 = _loc10_;
                     _loc7_.child1 = _loc10_;
                     _loc7_.next = null;
                     _loc7_.snext = null;
                     _loc7_.mnext = null;
                     _loc7_.next = ZPP_AABBNode.zpp_pool;
                     ZPP_AABBNode.zpp_pool = _loc7_;
                     _loc7_ = _loc5_;
                     while(_loc7_ != null)
                     {
                        if(_loc7_.child1 == null || _loc7_.height < 2)
                        {
                           §§push(_loc7_);
                        }
                        else
                        {
                           _loc10_ = _loc7_.child1;
                           _loc11_ = _loc7_.child2;
                           _loc12_ = _loc11_.height - _loc10_.height;
                           if(_loc12_ > 1)
                           {
                              _loc13_ = _loc11_.child1;
                              _loc14_ = _loc11_.child2;
                              _loc11_.child1 = _loc7_;
                              _loc11_.parent = _loc7_.parent;
                              _loc7_.parent = _loc11_;
                              if(_loc11_.parent != null)
                              {
                                 if(_loc11_.parent.child1 == _loc7_)
                                 {
                                    _loc11_.parent.child1 = _loc11_;
                                 }
                                 else
                                 {
                                    _loc11_.parent.child2 = _loc11_;
                                 }
                              }
                              else
                              {
                                 _loc3_.root = _loc11_;
                              }
                              if(_loc13_.height > _loc14_.height)
                              {
                                 _loc11_.child2 = _loc13_;
                                 _loc7_.child2 = _loc14_;
                                 _loc14_.parent = _loc7_;
                                 _loc8_ = _loc7_.aabb;
                                 _loc15_ = _loc10_.aabb;
                                 _loc16_ = _loc14_.aabb;
                                 _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                 _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                 _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                 _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                 _loc8_ = _loc11_.aabb;
                                 _loc15_ = _loc7_.aabb;
                                 _loc16_ = _loc13_.aabb;
                                 _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                 _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                 _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                 _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                 _loc17_ = _loc10_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc7_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                 _loc17_ = _loc7_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc11_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                              }
                              else
                              {
                                 _loc11_.child2 = _loc14_;
                                 _loc7_.child2 = _loc13_;
                                 _loc13_.parent = _loc7_;
                                 _loc8_ = _loc7_.aabb;
                                 _loc15_ = _loc10_.aabb;
                                 _loc16_ = _loc13_.aabb;
                                 _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                 _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                 _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                 _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                 _loc8_ = _loc11_.aabb;
                                 _loc15_ = _loc7_.aabb;
                                 _loc16_ = _loc14_.aabb;
                                 _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                 _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                 _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                 _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                 _loc17_ = _loc10_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc7_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                 _loc17_ = _loc7_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc11_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                              }
                              §§push(_loc11_);
                           }
                           else if(_loc12_ < -1)
                           {
                              _loc13_ = _loc10_.child1;
                              _loc14_ = _loc10_.child2;
                              _loc10_.child1 = _loc7_;
                              _loc10_.parent = _loc7_.parent;
                              _loc7_.parent = _loc10_;
                              if(_loc10_.parent != null)
                              {
                                 if(_loc10_.parent.child1 == _loc7_)
                                 {
                                    _loc10_.parent.child1 = _loc10_;
                                 }
                                 else
                                 {
                                    _loc10_.parent.child2 = _loc10_;
                                 }
                              }
                              else
                              {
                                 _loc3_.root = _loc10_;
                              }
                              if(_loc13_.height > _loc14_.height)
                              {
                                 _loc10_.child2 = _loc13_;
                                 _loc7_.child1 = _loc14_;
                                 _loc14_.parent = _loc7_;
                                 _loc8_ = _loc7_.aabb;
                                 _loc15_ = _loc11_.aabb;
                                 _loc16_ = _loc14_.aabb;
                                 _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                 _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                 _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                 _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                 _loc8_ = _loc10_.aabb;
                                 _loc15_ = _loc7_.aabb;
                                 _loc16_ = _loc13_.aabb;
                                 _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                 _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                 _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                 _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                 _loc17_ = _loc11_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc7_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                 _loc17_ = _loc7_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc10_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                              }
                              else
                              {
                                 _loc10_.child2 = _loc14_;
                                 _loc7_.child1 = _loc13_;
                                 _loc13_.parent = _loc7_;
                                 _loc8_ = _loc7_.aabb;
                                 _loc15_ = _loc11_.aabb;
                                 _loc16_ = _loc13_.aabb;
                                 _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                 _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                 _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                 _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                 _loc8_ = _loc10_.aabb;
                                 _loc15_ = _loc7_.aabb;
                                 _loc16_ = _loc14_.aabb;
                                 _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                                 _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                                 _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                                 _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                                 _loc17_ = _loc11_.height;
                                 _loc18_ = _loc13_.height;
                                 _loc7_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                                 _loc17_ = _loc7_.height;
                                 _loc18_ = _loc14_.height;
                                 _loc10_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                              }
                              §§push(_loc10_);
                           }
                           else
                           {
                              §§push(_loc7_);
                           }
                        }
                        _loc7_ = §§pop();
                        _loc10_ = _loc7_.child1;
                        _loc11_ = _loc7_.child2;
                        _loc8_ = _loc7_.aabb;
                        _loc15_ = _loc10_.aabb;
                        _loc16_ = _loc11_.aabb;
                        _loc8_.minx = _loc15_.minx < _loc16_.minx?_loc15_.minx:_loc16_.minx;
                        _loc8_.miny = _loc15_.miny < _loc16_.miny?_loc15_.miny:_loc16_.miny;
                        _loc8_.maxx = _loc15_.maxx > _loc16_.maxx?_loc15_.maxx:_loc16_.maxx;
                        _loc8_.maxy = _loc15_.maxy > _loc16_.maxy?_loc15_.maxy:_loc16_.maxy;
                        _loc12_ = int(_loc10_.height);
                        _loc17_ = _loc11_.height;
                        _loc7_.height = 1 + (_loc12_ > _loc17_?_loc12_:_loc17_);
                        _loc7_ = _loc7_.parent;
                     }
                  }
                  else
                  {
                     _loc3_.root = _loc6_;
                     _loc6_.parent = null;
                     _loc7_ = _loc4_;
                     _loc7_.height = -1;
                     _loc8_ = _loc7_.aabb;
                     if(_loc8_.outer != null)
                     {
                        _loc8_.outer.zpp_inner = null;
                        _loc8_.outer = null;
                     }
                     _loc9_ = null;
                     _loc8_.wrap_max = _loc9_;
                     _loc8_.wrap_min = _loc9_;
                     _loc8_._invalidate = null;
                     _loc8_._validate = null;
                     _loc8_.next = ZPP_AABB.zpp_pool;
                     ZPP_AABB.zpp_pool = _loc8_;
                     _loc10_ = null;
                     _loc7_.parent = _loc10_;
                     _loc10_ = _loc10_;
                     _loc7_.child2 = _loc10_;
                     _loc7_.child1 = _loc10_;
                     _loc7_.next = null;
                     _loc7_.snext = null;
                     _loc7_.mnext = null;
                     _loc7_.next = ZPP_AABBNode.zpp_pool;
                     ZPP_AABBNode.zpp_pool = _loc7_;
                  }
               }
            }
            else
            {
               _loc1_.first_sync = false;
            }
            _loc8_ = _loc1_.aabb;
            if(_loc2_.zip_aabb)
            {
               if(_loc2_.body != null)
               {
                  _loc2_.zip_aabb = false;
                  if(_loc2_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                  {
                     _loc19_ = _loc2_.circle;
                     if(_loc19_.zip_worldCOM)
                     {
                        if(_loc19_.body != null)
                        {
                           _loc19_.zip_worldCOM = false;
                           if(_loc19_.zip_localCOM)
                           {
                              _loc19_.zip_localCOM = false;
                              if(_loc19_.type == ZPP_Flags.id_ShapeType_POLYGON)
                              {
                                 _loc20_ = _loc19_.polygon;
                                 if(_loc20_.lverts.next.next == null)
                                 {
                                    _loc20_.localCOMx = _loc20_.lverts.next.x;
                                    _loc20_.localCOMy = _loc20_.lverts.next.y;
                                    null;
                                 }
                                 else if(_loc20_.lverts.next.next.next == null)
                                 {
                                    _loc20_.localCOMx = _loc20_.lverts.next.x;
                                    _loc20_.localCOMy = _loc20_.lverts.next.y;
                                    _loc21_ = 1;
                                    _loc20_.localCOMx = Number(_loc20_.localCOMx + _loc20_.lverts.next.next.x * _loc21_);
                                    _loc20_.localCOMy = Number(_loc20_.localCOMy + _loc20_.lverts.next.next.y * _loc21_);
                                    _loc21_ = 0.5;
                                    _loc20_.localCOMx = _loc20_.localCOMx * _loc21_;
                                    _loc20_.localCOMy = _loc20_.localCOMy * _loc21_;
                                 }
                                 else
                                 {
                                    _loc20_.localCOMx = 0;
                                    _loc20_.localCOMy = 0;
                                    _loc21_ = 0;
                                    _loc22_ = _loc20_.lverts.next;
                                    _loc23_ = _loc22_;
                                    _loc22_ = _loc22_.next;
                                    _loc24_ = _loc22_;
                                    _loc22_ = _loc22_.next;
                                    while(_loc22_ != null)
                                    {
                                       _loc25_ = _loc22_;
                                       _loc21_ = Number(_loc21_ + _loc24_.x * (_loc25_.y - _loc23_.y));
                                       _loc26_ = _loc25_.y * _loc24_.x - _loc25_.x * _loc24_.y;
                                       _loc20_.localCOMx = Number(_loc20_.localCOMx + (_loc24_.x + _loc25_.x) * _loc26_);
                                       _loc20_.localCOMy = Number(_loc20_.localCOMy + (_loc24_.y + _loc25_.y) * _loc26_);
                                       _loc23_ = _loc24_;
                                       _loc24_ = _loc25_;
                                       _loc22_ = _loc22_.next;
                                    }
                                    _loc22_ = _loc20_.lverts.next;
                                    _loc25_ = _loc22_;
                                    _loc21_ = Number(_loc21_ + _loc24_.x * (_loc25_.y - _loc23_.y));
                                    _loc26_ = _loc25_.y * _loc24_.x - _loc25_.x * _loc24_.y;
                                    _loc20_.localCOMx = Number(_loc20_.localCOMx + (_loc24_.x + _loc25_.x) * _loc26_);
                                    _loc20_.localCOMy = Number(_loc20_.localCOMy + (_loc24_.y + _loc25_.y) * _loc26_);
                                    _loc23_ = _loc24_;
                                    _loc24_ = _loc25_;
                                    _loc22_ = _loc22_.next;
                                    _loc27_ = _loc22_;
                                    _loc21_ = Number(_loc21_ + _loc24_.x * (_loc27_.y - _loc23_.y));
                                    _loc26_ = _loc27_.y * _loc24_.x - _loc27_.x * _loc24_.y;
                                    _loc20_.localCOMx = Number(_loc20_.localCOMx + (_loc24_.x + _loc27_.x) * _loc26_);
                                    _loc20_.localCOMy = Number(_loc20_.localCOMy + (_loc24_.y + _loc27_.y) * _loc26_);
                                    _loc21_ = 1 / (3 * _loc21_);
                                    _loc26_ = _loc21_;
                                    _loc20_.localCOMx = _loc20_.localCOMx * _loc26_;
                                    _loc20_.localCOMy = _loc20_.localCOMy * _loc26_;
                                 }
                              }
                              if(_loc19_.wrap_localCOM != null)
                              {
                                 _loc19_.wrap_localCOM.zpp_inner.x = _loc19_.localCOMx;
                                 _loc19_.wrap_localCOM.zpp_inner.y = _loc19_.localCOMy;
                              }
                           }
                           _loc28_ = _loc19_.body;
                           if(_loc28_.zip_axis)
                           {
                              _loc28_.zip_axis = false;
                              _loc28_.axisx = Number(Math.sin(_loc28_.rot));
                              _loc28_.axisy = Number(Math.cos(_loc28_.rot));
                              null;
                           }
                           _loc19_.worldCOMx = Number(_loc19_.body.posx + (_loc19_.body.axisy * _loc19_.localCOMx - _loc19_.body.axisx * _loc19_.localCOMy));
                           _loc19_.worldCOMy = Number(_loc19_.body.posy + (Number(_loc19_.localCOMx * _loc19_.body.axisx + _loc19_.localCOMy * _loc19_.body.axisy)));
                           if(_loc19_.wrap_worldCOM != null)
                           {
                              _loc19_.wrap_worldCOM.zpp_inner.x = _loc19_.worldCOMx;
                              _loc19_.wrap_worldCOM.zpp_inner.y = _loc19_.worldCOMy;
                           }
                        }
                     }
                     _loc21_ = _loc19_.radius;
                     _loc26_ = _loc19_.radius;
                     _loc19_.aabb.minx = _loc19_.worldCOMx - _loc21_;
                     _loc19_.aabb.miny = _loc19_.worldCOMy - _loc26_;
                     _loc19_.aabb.maxx = Number(_loc19_.worldCOMx + _loc21_);
                     _loc19_.aabb.maxy = Number(_loc19_.worldCOMy + _loc26_);
                  }
                  else
                  {
                     _loc20_ = _loc2_.polygon;
                     if(_loc20_.zip_gverts)
                     {
                        if(_loc20_.body != null)
                        {
                           _loc20_.zip_gverts = false;
                           _loc20_.validate_lverts();
                           _loc28_ = _loc20_.body;
                           if(_loc28_.zip_axis)
                           {
                              _loc28_.zip_axis = false;
                              _loc28_.axisx = Number(Math.sin(_loc28_.rot));
                              _loc28_.axisy = Number(Math.cos(_loc28_.rot));
                              null;
                           }
                           _loc22_ = _loc20_.lverts.next;
                           _loc23_ = _loc20_.gverts.next;
                           while(_loc23_ != null)
                           {
                              _loc24_ = _loc23_;
                              _loc25_ = _loc22_;
                              _loc22_ = _loc22_.next;
                              _loc24_.x = Number(_loc20_.body.posx + (_loc20_.body.axisy * _loc25_.x - _loc20_.body.axisx * _loc25_.y));
                              _loc24_.y = Number(_loc20_.body.posy + (Number(_loc25_.x * _loc20_.body.axisx + _loc25_.y * _loc20_.body.axisy)));
                              _loc23_ = _loc23_.next;
                           }
                        }
                     }
                     _loc22_ = _loc20_.gverts.next;
                     _loc20_.aabb.minx = _loc22_.x;
                     _loc20_.aabb.miny = _loc22_.y;
                     _loc20_.aabb.maxx = _loc22_.x;
                     _loc20_.aabb.maxy = _loc22_.y;
                     _loc23_ = _loc20_.gverts.next.next;
                     while(_loc23_ != null)
                     {
                        _loc24_ = _loc23_;
                        if(_loc24_.x < _loc20_.aabb.minx)
                        {
                           _loc20_.aabb.minx = _loc24_.x;
                        }
                        if(_loc24_.x > _loc20_.aabb.maxx)
                        {
                           _loc20_.aabb.maxx = _loc24_.x;
                        }
                        if(_loc24_.y < _loc20_.aabb.miny)
                        {
                           _loc20_.aabb.miny = _loc24_.y;
                        }
                        if(_loc24_.y > _loc20_.aabb.maxy)
                        {
                           _loc20_.aabb.maxy = _loc24_.y;
                        }
                        _loc23_ = _loc23_.next;
                     }
                  }
               }
            }
            _loc15_ = _loc2_.aabb;
            _loc8_.minx = _loc15_.minx - 3;
            _loc8_.miny = _loc15_.miny - 3;
            _loc8_.maxx = Number(_loc15_.maxx + 3);
            _loc8_.maxy = Number(_loc15_.maxy + 3);
            _loc29_ = _loc2_.body.type == ZPP_Flags.id_BodyType_STATIC?false:!_loc2_.body.component.sleeping;
            _loc1_.dyn = _loc29_;
            _loc3_ = !!_loc29_?dtree:stree;
            if(_loc3_.root == null)
            {
               _loc3_.root = _loc1_;
               _loc3_.root.parent = null;
            }
            else
            {
               _loc15_ = _loc1_.aabb;
               _loc4_ = _loc3_.root;
               while(_loc4_.child1 != null)
               {
                  _loc5_ = _loc4_.child1;
                  _loc6_ = _loc4_.child2;
                  _loc16_ = _loc4_.aabb;
                  _loc21_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                  _loc16_ = ZPP_AABBTree.tmpaabb;
                  _loc30_ = _loc4_.aabb;
                  _loc16_.minx = _loc30_.minx < _loc15_.minx?_loc30_.minx:_loc15_.minx;
                  _loc16_.miny = _loc30_.miny < _loc15_.miny?_loc30_.miny:_loc15_.miny;
                  _loc16_.maxx = _loc30_.maxx > _loc15_.maxx?_loc30_.maxx:_loc15_.maxx;
                  _loc16_.maxy = _loc30_.maxy > _loc15_.maxy?_loc30_.maxy:_loc15_.maxy;
                  _loc16_ = ZPP_AABBTree.tmpaabb;
                  _loc26_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                  _loc31_ = 2 * _loc26_;
                  _loc32_ = 2 * (_loc26_ - _loc21_);
                  _loc16_ = ZPP_AABBTree.tmpaabb;
                  _loc30_ = _loc5_.aabb;
                  _loc16_.minx = _loc15_.minx < _loc30_.minx?_loc15_.minx:_loc30_.minx;
                  _loc16_.miny = _loc15_.miny < _loc30_.miny?_loc15_.miny:_loc30_.miny;
                  _loc16_.maxx = _loc15_.maxx > _loc30_.maxx?_loc15_.maxx:_loc30_.maxx;
                  _loc16_.maxy = _loc15_.maxy > _loc30_.maxy?_loc15_.maxy:_loc30_.maxy;
                  if(_loc5_.child1 == null)
                  {
                     _loc16_ = ZPP_AABBTree.tmpaabb;
                     §§push(Number((_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2 + _loc32_));
                  }
                  else
                  {
                     _loc16_ = _loc5_.aabb;
                     _loc34_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                     _loc16_ = ZPP_AABBTree.tmpaabb;
                     _loc35_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                     §§push(Number(_loc35_ - _loc34_ + _loc32_));
                  }
                  _loc33_ = §§pop();
                  _loc16_ = ZPP_AABBTree.tmpaabb;
                  _loc30_ = _loc6_.aabb;
                  _loc16_.minx = _loc15_.minx < _loc30_.minx?_loc15_.minx:_loc30_.minx;
                  _loc16_.miny = _loc15_.miny < _loc30_.miny?_loc15_.miny:_loc30_.miny;
                  _loc16_.maxx = _loc15_.maxx > _loc30_.maxx?_loc15_.maxx:_loc30_.maxx;
                  _loc16_.maxy = _loc15_.maxy > _loc30_.maxy?_loc15_.maxy:_loc30_.maxy;
                  if(_loc6_.child1 == null)
                  {
                     _loc16_ = ZPP_AABBTree.tmpaabb;
                     §§push(Number((_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2 + _loc32_));
                  }
                  else
                  {
                     _loc16_ = _loc6_.aabb;
                     _loc35_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                     _loc16_ = ZPP_AABBTree.tmpaabb;
                     _loc36_ = (_loc16_.maxx - _loc16_.minx + (_loc16_.maxy - _loc16_.miny)) * 2;
                     §§push(Number(_loc36_ - _loc35_ + _loc32_));
                  }
                  _loc34_ = §§pop();
                  if(!(_loc31_ < _loc33_ && _loc31_ < _loc34_))
                  {
                     _loc4_ = _loc33_ < _loc34_?_loc5_:_loc6_;
                     continue;
                  }
                  break;
               }
               _loc5_ = _loc4_;
               _loc6_ = _loc5_.parent;
               if(ZPP_AABBNode.zpp_pool == null)
               {
                  _loc7_ = new ZPP_AABBNode();
               }
               else
               {
                  _loc7_ = ZPP_AABBNode.zpp_pool;
                  ZPP_AABBNode.zpp_pool = _loc7_.next;
                  _loc7_.next = null;
               }
               if(ZPP_AABB.zpp_pool == null)
               {
                  _loc7_.aabb = new ZPP_AABB();
               }
               else
               {
                  _loc7_.aabb = ZPP_AABB.zpp_pool;
                  ZPP_AABB.zpp_pool = _loc7_.aabb.next;
                  _loc7_.aabb.next = null;
               }
               null;
               _loc7_.moved = false;
               _loc7_.synced = false;
               _loc7_.first_sync = false;
               _loc7_.parent = _loc6_;
               _loc16_ = _loc7_.aabb;
               _loc30_ = _loc5_.aabb;
               _loc16_.minx = _loc15_.minx < _loc30_.minx?_loc15_.minx:_loc30_.minx;
               _loc16_.miny = _loc15_.miny < _loc30_.miny?_loc15_.miny:_loc30_.miny;
               _loc16_.maxx = _loc15_.maxx > _loc30_.maxx?_loc15_.maxx:_loc30_.maxx;
               _loc16_.maxy = _loc15_.maxy > _loc30_.maxy?_loc15_.maxy:_loc30_.maxy;
               _loc7_.height = _loc5_.height + 1;
               if(_loc6_ != null)
               {
                  if(_loc6_.child1 == _loc5_)
                  {
                     _loc6_.child1 = _loc7_;
                  }
                  else
                  {
                     _loc6_.child2 = _loc7_;
                  }
                  _loc7_.child1 = _loc5_;
                  _loc7_.child2 = _loc1_;
                  _loc5_.parent = _loc7_;
                  _loc1_.parent = _loc7_;
               }
               else
               {
                  _loc7_.child1 = _loc5_;
                  _loc7_.child2 = _loc1_;
                  _loc5_.parent = _loc7_;
                  _loc1_.parent = _loc7_;
                  _loc3_.root = _loc7_;
               }
               _loc4_ = _loc1_.parent;
               while(_loc4_ != null)
               {
                  if(_loc4_.child1 == null || _loc4_.height < 2)
                  {
                     §§push(_loc4_);
                  }
                  else
                  {
                     _loc10_ = _loc4_.child1;
                     _loc11_ = _loc4_.child2;
                     _loc12_ = _loc11_.height - _loc10_.height;
                     if(_loc12_ > 1)
                     {
                        _loc13_ = _loc11_.child1;
                        _loc14_ = _loc11_.child2;
                        _loc11_.child1 = _loc4_;
                        _loc11_.parent = _loc4_.parent;
                        _loc4_.parent = _loc11_;
                        if(_loc11_.parent != null)
                        {
                           if(_loc11_.parent.child1 == _loc4_)
                           {
                              _loc11_.parent.child1 = _loc11_;
                           }
                           else
                           {
                              _loc11_.parent.child2 = _loc11_;
                           }
                        }
                        else
                        {
                           _loc3_.root = _loc11_;
                        }
                        if(_loc13_.height > _loc14_.height)
                        {
                           _loc11_.child2 = _loc13_;
                           _loc4_.child2 = _loc14_;
                           _loc14_.parent = _loc4_;
                           _loc16_ = _loc4_.aabb;
                           _loc30_ = _loc10_.aabb;
                           _loc37_ = _loc14_.aabb;
                           _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                           _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                           _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                           _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                           _loc16_ = _loc11_.aabb;
                           _loc30_ = _loc4_.aabb;
                           _loc37_ = _loc13_.aabb;
                           _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                           _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                           _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                           _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                           _loc17_ = _loc10_.height;
                           _loc18_ = _loc14_.height;
                           _loc4_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                           _loc17_ = _loc4_.height;
                           _loc18_ = _loc13_.height;
                           _loc11_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                        }
                        else
                        {
                           _loc11_.child2 = _loc14_;
                           _loc4_.child2 = _loc13_;
                           _loc13_.parent = _loc4_;
                           _loc16_ = _loc4_.aabb;
                           _loc30_ = _loc10_.aabb;
                           _loc37_ = _loc13_.aabb;
                           _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                           _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                           _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                           _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                           _loc16_ = _loc11_.aabb;
                           _loc30_ = _loc4_.aabb;
                           _loc37_ = _loc14_.aabb;
                           _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                           _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                           _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                           _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                           _loc17_ = _loc10_.height;
                           _loc18_ = _loc13_.height;
                           _loc4_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                           _loc17_ = _loc4_.height;
                           _loc18_ = _loc14_.height;
                           _loc11_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                        }
                        §§push(_loc11_);
                     }
                     else if(_loc12_ < -1)
                     {
                        _loc13_ = _loc10_.child1;
                        _loc14_ = _loc10_.child2;
                        _loc10_.child1 = _loc4_;
                        _loc10_.parent = _loc4_.parent;
                        _loc4_.parent = _loc10_;
                        if(_loc10_.parent != null)
                        {
                           if(_loc10_.parent.child1 == _loc4_)
                           {
                              _loc10_.parent.child1 = _loc10_;
                           }
                           else
                           {
                              _loc10_.parent.child2 = _loc10_;
                           }
                        }
                        else
                        {
                           _loc3_.root = _loc10_;
                        }
                        if(_loc13_.height > _loc14_.height)
                        {
                           _loc10_.child2 = _loc13_;
                           _loc4_.child1 = _loc14_;
                           _loc14_.parent = _loc4_;
                           _loc16_ = _loc4_.aabb;
                           _loc30_ = _loc11_.aabb;
                           _loc37_ = _loc14_.aabb;
                           _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                           _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                           _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                           _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                           _loc16_ = _loc10_.aabb;
                           _loc30_ = _loc4_.aabb;
                           _loc37_ = _loc13_.aabb;
                           _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                           _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                           _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                           _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                           _loc17_ = _loc11_.height;
                           _loc18_ = _loc14_.height;
                           _loc4_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                           _loc17_ = _loc4_.height;
                           _loc18_ = _loc13_.height;
                           _loc10_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                        }
                        else
                        {
                           _loc10_.child2 = _loc14_;
                           _loc4_.child1 = _loc13_;
                           _loc13_.parent = _loc4_;
                           _loc16_ = _loc4_.aabb;
                           _loc30_ = _loc11_.aabb;
                           _loc37_ = _loc13_.aabb;
                           _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                           _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                           _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                           _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                           _loc16_ = _loc10_.aabb;
                           _loc30_ = _loc4_.aabb;
                           _loc37_ = _loc14_.aabb;
                           _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                           _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                           _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                           _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                           _loc17_ = _loc11_.height;
                           _loc18_ = _loc13_.height;
                           _loc4_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                           _loc17_ = _loc4_.height;
                           _loc18_ = _loc14_.height;
                           _loc10_.height = 1 + (_loc17_ > _loc18_?_loc17_:_loc18_);
                        }
                        §§push(_loc10_);
                     }
                     else
                     {
                        §§push(_loc4_);
                     }
                  }
                  _loc4_ = §§pop();
                  _loc10_ = _loc4_.child1;
                  _loc11_ = _loc4_.child2;
                  _loc12_ = int(_loc10_.height);
                  _loc17_ = _loc11_.height;
                  _loc4_.height = 1 + (_loc12_ > _loc17_?_loc12_:_loc17_);
                  _loc16_ = _loc4_.aabb;
                  _loc30_ = _loc10_.aabb;
                  _loc37_ = _loc11_.aabb;
                  _loc16_.minx = _loc30_.minx < _loc37_.minx?_loc30_.minx:_loc37_.minx;
                  _loc16_.miny = _loc30_.miny < _loc37_.miny?_loc30_.miny:_loc37_.miny;
                  _loc16_.maxx = _loc30_.maxx > _loc37_.maxx?_loc30_.maxx:_loc37_.maxx;
                  _loc16_.maxy = _loc30_.maxy > _loc37_.maxy?_loc30_.maxy:_loc37_.maxy;
                  _loc4_ = _loc4_.parent;
               }
            }
            _loc1_.synced = false;
            _loc1_ = _loc1_.snext;
         }
         while(syncs != null)
         {
            _loc5_ = syncs;
            syncs = _loc5_.snext;
            _loc5_.snext = null;
            _loc4_ = _loc5_;
            if(!_loc4_.moved)
            {
               _loc4_.moved = false;
               _loc2_ = _loc4_.shape;
               _loc28_ = _loc2_.body;
               if(!_loc28_.component.sleeping)
               {
                  _loc8_ = _loc4_.aabb;
                  _loc5_ = null;
                  if(dtree.root != null)
                  {
                     dtree.root.next = _loc5_;
                     _loc5_ = dtree.root;
                  }
                  while(_loc5_ != null)
                  {
                     _loc7_ = _loc5_;
                     _loc5_ = _loc7_.next;
                     _loc7_.next = null;
                     _loc6_ = _loc7_;
                     if(_loc6_ != _loc4_)
                     {
                        if(_loc6_.child1 == null)
                        {
                           _loc38_ = _loc6_.shape;
                           if(_loc38_.body != _loc2_.body)
                           {
                              _loc15_ = _loc6_.aabb;
                              if(_loc15_.miny <= _loc8_.maxy && _loc8_.miny <= _loc15_.maxy && _loc15_.minx <= _loc8_.maxx && _loc8_.minx <= _loc15_.maxx)
                              {
                                 if(_loc2_.id < _loc38_.id)
                                 {
                                    _loc12_ = int(_loc2_.id);
                                    _loc17_ = _loc38_.id;
                                 }
                                 else
                                 {
                                    _loc12_ = int(_loc38_.id);
                                    _loc17_ = _loc2_.id;
                                 }
                                 _loc39_ = _loc2_.pairs.length < _loc38_.pairs.length?_loc2_:_loc38_;
                                 _loc40_ = null;
                                 _loc41_ = _loc39_.pairs.head;
                                 while(_loc41_ != null)
                                 {
                                    _loc42_ = _loc41_.elt;
                                    if(_loc42_.id == _loc12_ && _loc42_.di == _loc17_)
                                    {
                                       _loc40_ = _loc42_;
                                       break;
                                    }
                                    _loc41_ = _loc41_.next;
                                 }
                                 if(_loc40_ != null)
                                 {
                                    if(_loc40_.sleeping)
                                    {
                                       _loc40_.sleeping = false;
                                       _loc40_.next = pairs;
                                       pairs = _loc40_;
                                       _loc40_.first = true;
                                    }
                                 }
                                 else
                                 {
                                    if(ZPP_AABBPair.zpp_pool == null)
                                    {
                                       _loc40_ = new ZPP_AABBPair();
                                    }
                                    else
                                    {
                                       _loc40_ = ZPP_AABBPair.zpp_pool;
                                       ZPP_AABBPair.zpp_pool = _loc40_.next;
                                       _loc40_.next = null;
                                    }
                                    null;
                                    _loc40_.n1 = _loc4_;
                                    _loc40_.n2 = _loc6_;
                                    _loc40_.id = _loc12_;
                                    _loc40_.di = _loc17_;
                                    _loc40_.next = pairs;
                                    pairs = _loc40_;
                                    _loc40_.first = true;
                                    _loc43_ = _loc2_.pairs;
                                    if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                    {
                                       _loc44_ = new ZNPNode_ZPP_AABBPair();
                                    }
                                    else
                                    {
                                       _loc44_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                       ZNPNode_ZPP_AABBPair.zpp_pool = _loc44_.next;
                                       _loc44_.next = null;
                                    }
                                    null;
                                    _loc44_.elt = _loc40_;
                                    _loc41_ = _loc44_;
                                    _loc41_.next = _loc43_.head;
                                    _loc43_.head = _loc41_;
                                    _loc43_.modified = true;
                                    _loc43_.length = _loc43_.length + 1;
                                    _loc40_;
                                    _loc43_ = _loc38_.pairs;
                                    if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                    {
                                       _loc44_ = new ZNPNode_ZPP_AABBPair();
                                    }
                                    else
                                    {
                                       _loc44_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                       ZNPNode_ZPP_AABBPair.zpp_pool = _loc44_.next;
                                       _loc44_.next = null;
                                    }
                                    null;
                                    _loc44_.elt = _loc40_;
                                    _loc41_ = _loc44_;
                                    _loc41_.next = _loc43_.head;
                                    _loc43_.head = _loc41_;
                                    _loc43_.modified = true;
                                    _loc43_.length = _loc43_.length + 1;
                                    _loc40_;
                                 }
                              }
                           }
                        }
                        else
                        {
                           _loc15_ = _loc6_.aabb;
                           if(_loc15_.miny <= _loc8_.maxy && _loc8_.miny <= _loc15_.maxy && _loc15_.minx <= _loc8_.maxx && _loc8_.minx <= _loc15_.maxx)
                           {
                              if(_loc6_.child1 != null)
                              {
                                 _loc6_.child1.next = _loc5_;
                                 _loc5_ = _loc6_.child1;
                              }
                              if(_loc6_.child2 != null)
                              {
                                 _loc6_.child2.next = _loc5_;
                                 _loc5_ = _loc6_.child2;
                              }
                           }
                        }
                     }
                  }
                  if(_loc28_.type != ZPP_Flags.id_BodyType_STATIC)
                  {
                     if(stree.root != null)
                     {
                        stree.root.next = _loc5_;
                        _loc5_ = stree.root;
                     }
                     while(_loc5_ != null)
                     {
                        _loc7_ = _loc5_;
                        _loc5_ = _loc7_.next;
                        _loc7_.next = null;
                        _loc6_ = _loc7_;
                        if(_loc6_ != _loc4_)
                        {
                           if(_loc6_.child1 == null)
                           {
                              _loc38_ = _loc6_.shape;
                              if(_loc38_.body != _loc2_.body)
                              {
                                 _loc15_ = _loc6_.aabb;
                                 if(_loc15_.miny <= _loc8_.maxy && _loc8_.miny <= _loc15_.maxy && _loc15_.minx <= _loc8_.maxx && _loc8_.minx <= _loc15_.maxx)
                                 {
                                    if(_loc2_.id < _loc38_.id)
                                    {
                                       _loc12_ = int(_loc2_.id);
                                       _loc17_ = _loc38_.id;
                                    }
                                    else
                                    {
                                       _loc12_ = int(_loc38_.id);
                                       _loc17_ = _loc2_.id;
                                    }
                                    _loc39_ = _loc2_.pairs.length < _loc38_.pairs.length?_loc2_:_loc38_;
                                    _loc40_ = null;
                                    _loc41_ = _loc39_.pairs.head;
                                    while(_loc41_ != null)
                                    {
                                       _loc42_ = _loc41_.elt;
                                       if(_loc42_.id == _loc12_ && _loc42_.di == _loc17_)
                                       {
                                          _loc40_ = _loc42_;
                                          break;
                                       }
                                       _loc41_ = _loc41_.next;
                                    }
                                    if(_loc40_ != null)
                                    {
                                       if(_loc40_.sleeping)
                                       {
                                          _loc40_.sleeping = false;
                                          _loc40_.next = pairs;
                                          pairs = _loc40_;
                                          _loc40_.first = true;
                                       }
                                    }
                                    else
                                    {
                                       if(ZPP_AABBPair.zpp_pool == null)
                                       {
                                          _loc40_ = new ZPP_AABBPair();
                                       }
                                       else
                                       {
                                          _loc40_ = ZPP_AABBPair.zpp_pool;
                                          ZPP_AABBPair.zpp_pool = _loc40_.next;
                                          _loc40_.next = null;
                                       }
                                       null;
                                       _loc40_.n1 = _loc4_;
                                       _loc40_.n2 = _loc6_;
                                       _loc40_.id = _loc12_;
                                       _loc40_.di = _loc17_;
                                       _loc40_.next = pairs;
                                       pairs = _loc40_;
                                       _loc40_.first = true;
                                       _loc43_ = _loc2_.pairs;
                                       if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                       {
                                          _loc44_ = new ZNPNode_ZPP_AABBPair();
                                       }
                                       else
                                       {
                                          _loc44_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                          ZNPNode_ZPP_AABBPair.zpp_pool = _loc44_.next;
                                          _loc44_.next = null;
                                       }
                                       null;
                                       _loc44_.elt = _loc40_;
                                       _loc41_ = _loc44_;
                                       _loc41_.next = _loc43_.head;
                                       _loc43_.head = _loc41_;
                                       _loc43_.modified = true;
                                       _loc43_.length = _loc43_.length + 1;
                                       _loc40_;
                                       _loc43_ = _loc38_.pairs;
                                       if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                       {
                                          _loc44_ = new ZNPNode_ZPP_AABBPair();
                                       }
                                       else
                                       {
                                          _loc44_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                          ZNPNode_ZPP_AABBPair.zpp_pool = _loc44_.next;
                                          _loc44_.next = null;
                                       }
                                       null;
                                       _loc44_.elt = _loc40_;
                                       _loc41_ = _loc44_;
                                       _loc41_.next = _loc43_.head;
                                       _loc43_.head = _loc41_;
                                       _loc43_.modified = true;
                                       _loc43_.length = _loc43_.length + 1;
                                       _loc40_;
                                    }
                                 }
                              }
                           }
                           else
                           {
                              _loc15_ = _loc6_.aabb;
                              if(_loc15_.miny <= _loc8_.maxy && _loc8_.miny <= _loc15_.maxy && _loc15_.minx <= _loc8_.maxx && _loc8_.minx <= _loc15_.maxx)
                              {
                                 if(_loc6_.child1 != null)
                                 {
                                    _loc6_.child1.next = _loc5_;
                                    _loc5_ = _loc6_.child1;
                                 }
                                 if(_loc6_.child2 != null)
                                 {
                                    _loc6_.child2.next = _loc5_;
                                    _loc5_ = _loc6_.child2;
                                 }
                              }
                           }
                        }
                     }
                     continue;
                  }
                  continue;
               }
               continue;
            }
         }
         while(moves != null)
         {
            _loc5_ = moves;
            moves = _loc5_.mnext;
            _loc5_.mnext = null;
            _loc4_ = _loc5_;
            _loc4_.moved = false;
            _loc2_ = _loc4_.shape;
            _loc28_ = _loc2_.body;
            if(!_loc28_.component.sleeping)
            {
               _loc8_ = _loc4_.aabb;
               _loc5_ = null;
               if(dtree.root != null)
               {
                  dtree.root.next = _loc5_;
                  _loc5_ = dtree.root;
               }
               while(_loc5_ != null)
               {
                  _loc7_ = _loc5_;
                  _loc5_ = _loc7_.next;
                  _loc7_.next = null;
                  _loc6_ = _loc7_;
                  if(_loc6_ != _loc4_)
                  {
                     if(_loc6_.child1 == null)
                     {
                        _loc38_ = _loc6_.shape;
                        if(_loc38_.body != _loc2_.body)
                        {
                           _loc15_ = _loc6_.aabb;
                           if(_loc15_.miny <= _loc8_.maxy && _loc8_.miny <= _loc15_.maxy && _loc15_.minx <= _loc8_.maxx && _loc8_.minx <= _loc15_.maxx)
                           {
                              if(_loc2_.id < _loc38_.id)
                              {
                                 _loc12_ = int(_loc2_.id);
                                 _loc17_ = _loc38_.id;
                              }
                              else
                              {
                                 _loc12_ = int(_loc38_.id);
                                 _loc17_ = _loc2_.id;
                              }
                              _loc39_ = _loc2_.pairs.length < _loc38_.pairs.length?_loc2_:_loc38_;
                              _loc40_ = null;
                              _loc41_ = _loc39_.pairs.head;
                              while(_loc41_ != null)
                              {
                                 _loc42_ = _loc41_.elt;
                                 if(_loc42_.id == _loc12_ && _loc42_.di == _loc17_)
                                 {
                                    _loc40_ = _loc42_;
                                    break;
                                 }
                                 _loc41_ = _loc41_.next;
                              }
                              if(_loc40_ != null)
                              {
                                 if(_loc40_.sleeping)
                                 {
                                    _loc40_.sleeping = false;
                                    _loc40_.next = pairs;
                                    pairs = _loc40_;
                                    _loc40_.first = true;
                                 }
                              }
                              else
                              {
                                 if(ZPP_AABBPair.zpp_pool == null)
                                 {
                                    _loc40_ = new ZPP_AABBPair();
                                 }
                                 else
                                 {
                                    _loc40_ = ZPP_AABBPair.zpp_pool;
                                    ZPP_AABBPair.zpp_pool = _loc40_.next;
                                    _loc40_.next = null;
                                 }
                                 null;
                                 _loc40_.n1 = _loc4_;
                                 _loc40_.n2 = _loc6_;
                                 _loc40_.id = _loc12_;
                                 _loc40_.di = _loc17_;
                                 _loc40_.next = pairs;
                                 pairs = _loc40_;
                                 _loc40_.first = true;
                                 _loc43_ = _loc2_.pairs;
                                 if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                 {
                                    _loc44_ = new ZNPNode_ZPP_AABBPair();
                                 }
                                 else
                                 {
                                    _loc44_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                    ZNPNode_ZPP_AABBPair.zpp_pool = _loc44_.next;
                                    _loc44_.next = null;
                                 }
                                 null;
                                 _loc44_.elt = _loc40_;
                                 _loc41_ = _loc44_;
                                 _loc41_.next = _loc43_.head;
                                 _loc43_.head = _loc41_;
                                 _loc43_.modified = true;
                                 _loc43_.length = _loc43_.length + 1;
                                 _loc40_;
                                 _loc43_ = _loc38_.pairs;
                                 if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                 {
                                    _loc44_ = new ZNPNode_ZPP_AABBPair();
                                 }
                                 else
                                 {
                                    _loc44_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                    ZNPNode_ZPP_AABBPair.zpp_pool = _loc44_.next;
                                    _loc44_.next = null;
                                 }
                                 null;
                                 _loc44_.elt = _loc40_;
                                 _loc41_ = _loc44_;
                                 _loc41_.next = _loc43_.head;
                                 _loc43_.head = _loc41_;
                                 _loc43_.modified = true;
                                 _loc43_.length = _loc43_.length + 1;
                                 _loc40_;
                              }
                           }
                        }
                     }
                     else
                     {
                        _loc15_ = _loc6_.aabb;
                        if(_loc15_.miny <= _loc8_.maxy && _loc8_.miny <= _loc15_.maxy && _loc15_.minx <= _loc8_.maxx && _loc8_.minx <= _loc15_.maxx)
                        {
                           if(_loc6_.child1 != null)
                           {
                              _loc6_.child1.next = _loc5_;
                              _loc5_ = _loc6_.child1;
                           }
                           if(_loc6_.child2 != null)
                           {
                              _loc6_.child2.next = _loc5_;
                              _loc5_ = _loc6_.child2;
                           }
                        }
                     }
                  }
               }
               if(_loc28_.type != ZPP_Flags.id_BodyType_STATIC)
               {
                  if(stree.root != null)
                  {
                     stree.root.next = _loc5_;
                     _loc5_ = stree.root;
                  }
                  while(_loc5_ != null)
                  {
                     _loc7_ = _loc5_;
                     _loc5_ = _loc7_.next;
                     _loc7_.next = null;
                     _loc6_ = _loc7_;
                     if(_loc6_ != _loc4_)
                     {
                        if(_loc6_.child1 == null)
                        {
                           _loc38_ = _loc6_.shape;
                           if(_loc38_.body != _loc2_.body)
                           {
                              _loc15_ = _loc6_.aabb;
                              if(_loc15_.miny <= _loc8_.maxy && _loc8_.miny <= _loc15_.maxy && _loc15_.minx <= _loc8_.maxx && _loc8_.minx <= _loc15_.maxx)
                              {
                                 if(_loc2_.id < _loc38_.id)
                                 {
                                    _loc12_ = int(_loc2_.id);
                                    _loc17_ = _loc38_.id;
                                 }
                                 else
                                 {
                                    _loc12_ = int(_loc38_.id);
                                    _loc17_ = _loc2_.id;
                                 }
                                 _loc39_ = _loc2_.pairs.length < _loc38_.pairs.length?_loc2_:_loc38_;
                                 _loc40_ = null;
                                 _loc41_ = _loc39_.pairs.head;
                                 while(_loc41_ != null)
                                 {
                                    _loc42_ = _loc41_.elt;
                                    if(_loc42_.id == _loc12_ && _loc42_.di == _loc17_)
                                    {
                                       _loc40_ = _loc42_;
                                       break;
                                    }
                                    _loc41_ = _loc41_.next;
                                 }
                                 if(_loc40_ != null)
                                 {
                                    if(_loc40_.sleeping)
                                    {
                                       _loc40_.sleeping = false;
                                       _loc40_.next = pairs;
                                       pairs = _loc40_;
                                       _loc40_.first = true;
                                    }
                                 }
                                 else
                                 {
                                    if(ZPP_AABBPair.zpp_pool == null)
                                    {
                                       _loc40_ = new ZPP_AABBPair();
                                    }
                                    else
                                    {
                                       _loc40_ = ZPP_AABBPair.zpp_pool;
                                       ZPP_AABBPair.zpp_pool = _loc40_.next;
                                       _loc40_.next = null;
                                    }
                                    null;
                                    _loc40_.n1 = _loc4_;
                                    _loc40_.n2 = _loc6_;
                                    _loc40_.id = _loc12_;
                                    _loc40_.di = _loc17_;
                                    _loc40_.next = pairs;
                                    pairs = _loc40_;
                                    _loc40_.first = true;
                                    _loc43_ = _loc2_.pairs;
                                    if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                    {
                                       _loc44_ = new ZNPNode_ZPP_AABBPair();
                                    }
                                    else
                                    {
                                       _loc44_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                       ZNPNode_ZPP_AABBPair.zpp_pool = _loc44_.next;
                                       _loc44_.next = null;
                                    }
                                    null;
                                    _loc44_.elt = _loc40_;
                                    _loc41_ = _loc44_;
                                    _loc41_.next = _loc43_.head;
                                    _loc43_.head = _loc41_;
                                    _loc43_.modified = true;
                                    _loc43_.length = _loc43_.length + 1;
                                    _loc40_;
                                    _loc43_ = _loc38_.pairs;
                                    if(ZNPNode_ZPP_AABBPair.zpp_pool == null)
                                    {
                                       _loc44_ = new ZNPNode_ZPP_AABBPair();
                                    }
                                    else
                                    {
                                       _loc44_ = ZNPNode_ZPP_AABBPair.zpp_pool;
                                       ZNPNode_ZPP_AABBPair.zpp_pool = _loc44_.next;
                                       _loc44_.next = null;
                                    }
                                    null;
                                    _loc44_.elt = _loc40_;
                                    _loc41_ = _loc44_;
                                    _loc41_.next = _loc43_.head;
                                    _loc43_.head = _loc41_;
                                    _loc43_.modified = true;
                                    _loc43_.length = _loc43_.length + 1;
                                    _loc40_;
                                 }
                              }
                           }
                        }
                        else
                        {
                           _loc15_ = _loc6_.aabb;
                           if(_loc15_.miny <= _loc8_.maxy && _loc8_.miny <= _loc15_.maxy && _loc15_.minx <= _loc8_.maxx && _loc8_.minx <= _loc15_.maxx)
                           {
                              if(_loc6_.child1 != null)
                              {
                                 _loc6_.child1.next = _loc5_;
                                 _loc5_ = _loc6_.child1;
                              }
                              if(_loc6_.child2 != null)
                              {
                                 _loc6_.child2.next = _loc5_;
                                 _loc5_ = _loc6_.child2;
                              }
                           }
                        }
                     }
                  }
                  continue;
               }
               continue;
            }
         }
         _loc40_ = null;
         _loc42_ = pairs;
         while(_loc42_ != null)
         {
            if(!_loc42_.first && !(_loc15_.miny <= _loc8_.maxy && _loc8_.miny <= _loc15_.maxy && _loc15_.minx <= _loc8_.maxx && _loc8_.minx <= _loc15_.maxx))
            {
               if(_loc40_ == null)
               {
                  pairs = _loc42_.next;
               }
               else
               {
                  _loc40_.next = _loc42_.next;
               }
               _loc43_ = _loc42_.n1.shape.pairs;
               _loc41_ = null;
               _loc44_ = _loc43_.head;
               _loc29_ = false;
               while(_loc44_ != null)
               {
                  if(_loc44_.elt == _loc42_)
                  {
                     if(_loc41_ == null)
                     {
                        _loc45_ = _loc43_.head;
                        _loc46_ = _loc45_.next;
                        _loc43_.head = _loc46_;
                        if(_loc43_.head == null)
                        {
                           _loc43_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc45_ = _loc41_.next;
                        _loc46_ = _loc45_.next;
                        _loc41_.next = _loc46_;
                        if(_loc46_ == null)
                        {
                           _loc43_.pushmod = true;
                        }
                     }
                     _loc47_ = _loc45_;
                     _loc47_.elt = null;
                     _loc47_.next = ZNPNode_ZPP_AABBPair.zpp_pool;
                     ZNPNode_ZPP_AABBPair.zpp_pool = _loc47_;
                     _loc43_.modified = true;
                     _loc43_.length = _loc43_.length - 1;
                     _loc43_.pushmod = true;
                     _loc46_;
                     _loc29_ = true;
                     break;
                  }
                  _loc41_ = _loc44_;
                  _loc44_ = _loc44_.next;
               }
               _loc29_;
               _loc43_ = _loc42_.n2.shape.pairs;
               _loc41_ = null;
               _loc44_ = _loc43_.head;
               _loc29_ = false;
               while(_loc44_ != null)
               {
                  if(_loc44_.elt == _loc42_)
                  {
                     if(_loc41_ == null)
                     {
                        _loc45_ = _loc43_.head;
                        _loc46_ = _loc45_.next;
                        _loc43_.head = _loc46_;
                        if(_loc43_.head == null)
                        {
                           _loc43_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc45_ = _loc41_.next;
                        _loc46_ = _loc45_.next;
                        _loc41_.next = _loc46_;
                        if(_loc46_ == null)
                        {
                           _loc43_.pushmod = true;
                        }
                     }
                     _loc47_ = _loc45_;
                     _loc47_.elt = null;
                     _loc47_.next = ZNPNode_ZPP_AABBPair.zpp_pool;
                     ZNPNode_ZPP_AABBPair.zpp_pool = _loc47_;
                     _loc43_.modified = true;
                     _loc43_.length = _loc43_.length - 1;
                     _loc43_.pushmod = true;
                     _loc46_;
                     _loc29_ = true;
                     break;
                  }
                  _loc41_ = _loc44_;
                  _loc44_ = _loc44_.next;
               }
               _loc29_;
               _loc48_ = _loc42_.next;
               if(_loc42_.arb != null)
               {
                  _loc42_.arb.pair = null;
               }
               _loc42_.arb = null;
               _loc49_ = _loc42_;
               _loc4_ = null;
               _loc49_.n2 = _loc4_;
               _loc49_.n1 = _loc4_;
               _loc49_.sleeping = false;
               _loc49_.next = ZPP_AABBPair.zpp_pool;
               ZPP_AABBPair.zpp_pool = _loc49_;
               _loc42_ = _loc48_;
            }
            else
            {
               _loc2_ = _loc42_.n1.shape;
               _loc28_ = _loc2_.body;
               _loc38_ = _loc42_.n2.shape;
               _loc50_ = _loc38_.body;
               if((_loc28_.component.sleeping || _loc28_.type == ZPP_Flags.id_BodyType_STATIC) && (_loc50_.component.sleeping || _loc50_.type == ZPP_Flags.id_BodyType_STATIC))
               {
                  _loc42_.sleeping = true;
                  if(_loc40_ == null)
                  {
                     pairs = _loc42_.next;
                  }
                  else
                  {
                     _loc40_.next = _loc42_.next;
                  }
                  _loc42_ = _loc42_.next;
               }
               else
               {
                  _loc42_.first = false;
                  _loc8_ = _loc2_.aabb;
                  _loc15_ = _loc38_.aabb;
                  if(_loc15_.miny <= _loc8_.maxy && _loc8_.miny <= _loc15_.maxy && _loc15_.minx <= _loc8_.maxx && _loc8_.minx <= _loc15_.maxx)
                  {
                     _loc51_ = _loc42_.arb;
                     _loc42_.arb = space.narrowPhase(_loc2_,_loc38_,_loc28_.type != ZPP_Flags.id_BodyType_DYNAMIC || _loc50_.type != ZPP_Flags.id_BodyType_DYNAMIC,_loc42_.arb);
                     if(_loc42_.arb == null)
                     {
                        if(_loc51_ != null)
                        {
                           _loc51_.pair = null;
                        }
                     }
                     else
                     {
                        _loc42_.arb.pair = _loc42_;
                     }
                  }
                  _loc40_ = _loc42_;
                  _loc42_ = _loc42_.next;
               }
            }
         }
      }
      
      override public function bodiesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter) : BodyList
      {
         var _loc6_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZNPList_ZPP_AABBNode;
         var _loc9_:* = null as ZPP_AABBNode;
         var _loc10_:* = null as ZPP_AABB;
         var _loc11_:* = null as Body;
         var _loc12_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         if(ZPP_Vec2.zpp_pool == null)
         {
            _loc6_ = new ZPP_Vec2();
         }
         else
         {
            _loc6_ = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc6_.next;
            _loc6_.next = null;
         }
         _loc6_.weak = false;
         _loc6_._immutable = false;
         _loc6_.x = param1;
         _loc6_.y = param2;
         var _loc4_:ZPP_Vec2 = _loc6_;
         var _loc7_:BodyList = new BodyList();
         if(stree.root != null)
         {
            _loc8_ = new ZNPList_ZPP_AABBNode();
            _loc8_.add(stree.root);
            while(_loc8_.head != null)
            {
               _loc9_ = _loc8_.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc4_.x >= _loc10_.minx && _loc4_.x <= _loc10_.maxx && _loc4_.y >= _loc10_.miny && _loc4_.y <= _loc10_.maxy)
               {
                  if(_loc9_.child1 == null)
                  {
                     _loc11_ = _loc9_.shape.body.outer;
                     if(!_loc7_.has(_loc11_))
                     {
                        if(param3 == null || (_loc12_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc12_.collisionGroup) != 0)
                        {
                           if(_loc9_.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                           {
                              if(ZPP_Collide.circleContains(_loc9_.shape.circle,_loc4_))
                              {
                                 _loc7_.push(_loc11_);
                              }
                           }
                           else if(ZPP_Collide.polyContains(_loc9_.shape.polygon,_loc4_))
                           {
                              _loc7_.push(_loc11_);
                           }
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        _loc8_.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        _loc8_.add(_loc9_.child2);
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            _loc8_ = new ZNPList_ZPP_AABBNode();
            _loc8_.add(dtree.root);
            while(_loc8_.head != null)
            {
               _loc9_ = _loc8_.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc4_.x >= _loc10_.minx && _loc4_.x <= _loc10_.maxx && _loc4_.y >= _loc10_.miny && _loc4_.y <= _loc10_.maxy)
               {
                  if(_loc9_.child1 == null)
                  {
                     _loc11_ = _loc9_.shape.body.outer;
                     if(!_loc7_.has(_loc11_))
                     {
                        if(param3 == null || (_loc12_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc12_.collisionGroup) != 0)
                        {
                           if(_loc9_.shape.type == ZPP_Flags.id_ShapeType_CIRCLE)
                           {
                              if(ZPP_Collide.circleContains(_loc9_.shape.circle,_loc4_))
                              {
                                 _loc7_.push(_loc11_);
                              }
                           }
                           else if(ZPP_Collide.polyContains(_loc9_.shape.polygon,_loc4_))
                           {
                              _loc7_.push(_loc11_);
                           }
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        _loc8_.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        _loc8_.add(_loc9_.child2);
                     }
                  }
               }
            }
         }
         _loc6_ = _loc4_;
         if(_loc6_.outer != null)
         {
            _loc6_.outer.zpp_inner = null;
            _loc6_.outer = null;
         }
         _loc6_._isimmutable = null;
         _loc6_._validate = null;
         _loc6_._invalidate = null;
         _loc6_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc6_;
         return _loc7_;
      }
      
      override public function bodiesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter) : BodyList
      {
         var _loc6_:* = null as ZNPList_ZPP_AABBNode;
         var _loc7_:* = null as ZPP_AABBNode;
         var _loc8_:* = null as ZPP_AABB;
         var _loc9_:* = null as Body;
         var _loc10_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         validateShape(param1);
         var _loc4_:ZPP_AABB = param1.aabb;
         var _loc5_:BodyList = new BodyList();
         if(stree.root != null)
         {
            _loc6_ = new ZNPList_ZPP_AABBNode();
            _loc6_.add(stree.root);
            while(_loc6_.head != null)
            {
               _loc7_ = _loc6_.pop_unsafe();
               _loc8_ = _loc7_.aabb;
               if(_loc4_.miny <= _loc8_.maxy && _loc8_.miny <= _loc4_.maxy && _loc4_.minx <= _loc8_.maxx && _loc8_.minx <= _loc4_.maxx)
               {
                  if(_loc7_.child1 == null)
                  {
                     _loc9_ = _loc7_.shape.body.outer;
                     if(!_loc5_.has(_loc9_))
                     {
                        if(param3 == null || (_loc10_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc10_.collisionGroup) != 0)
                        {
                           if(param2)
                           {
                              if(ZPP_Collide.containTest(param1,_loc7_.shape))
                              {
                                 _loc5_.push(_loc9_);
                              }
                           }
                           else if(ZPP_Collide.testCollide_safe(_loc7_.shape,param1))
                           {
                              _loc5_.push(_loc9_);
                           }
                        }
                     }
                     else if(param2)
                     {
                        if((param3 == null || (_loc10_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc10_.collisionGroup) != 0) && !ZPP_Collide.containTest(param1,_loc7_.shape))
                        {
                           _loc5_.remove(_loc9_);
                        }
                     }
                  }
                  else
                  {
                     if(_loc7_.child1 != null)
                     {
                        _loc6_.add(_loc7_.child1);
                     }
                     if(_loc7_.child2 != null)
                     {
                        _loc6_.add(_loc7_.child2);
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            _loc6_ = new ZNPList_ZPP_AABBNode();
            _loc6_.add(dtree.root);
            while(_loc6_.head != null)
            {
               _loc7_ = _loc6_.pop_unsafe();
               _loc8_ = _loc7_.aabb;
               if(_loc4_.miny <= _loc8_.maxy && _loc8_.miny <= _loc4_.maxy && _loc4_.minx <= _loc8_.maxx && _loc8_.minx <= _loc4_.maxx)
               {
                  if(_loc7_.child1 == null)
                  {
                     _loc9_ = _loc7_.shape.body.outer;
                     if(!_loc5_.has(_loc9_))
                     {
                        if(param3 == null || (_loc10_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc10_.collisionGroup) != 0)
                        {
                           if(param2)
                           {
                              if(ZPP_Collide.containTest(param1,_loc7_.shape))
                              {
                                 _loc5_.push(_loc9_);
                              }
                           }
                           else if(ZPP_Collide.testCollide_safe(_loc7_.shape,param1))
                           {
                              _loc5_.push(_loc9_);
                           }
                        }
                     }
                     else if(param2)
                     {
                        if((param3 == null || (_loc10_.collisionMask & param3.collisionGroup) != 0 && (param3.collisionMask & _loc10_.collisionGroup) != 0) && !ZPP_Collide.containTest(param1,_loc7_.shape))
                        {
                           _loc5_.remove(_loc9_);
                        }
                     }
                  }
                  else
                  {
                     if(_loc7_.child1 != null)
                     {
                        _loc6_.add(_loc7_.child1);
                     }
                     if(_loc7_.child2 != null)
                     {
                        _loc6_.add(_loc7_.child2);
                     }
                  }
               }
            }
         }
         return _loc5_;
      }
      
      override public function bodiesInCircle(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:ZPP_InteractionFilter) : BodyList
      {
         var _loc8_:* = null as ZNPList_ZPP_AABBNode;
         var _loc9_:* = null as ZPP_AABBNode;
         var _loc10_:* = null as ZPP_AABB;
         var _loc11_:* = null as Body;
         var _loc12_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         updateCircShape(param1,param2,param3);
         var _loc6_:ZPP_AABB = circShape.zpp_inner.aabb;
         var _loc7_:BodyList = new BodyList();
         if(stree.root != null)
         {
            _loc8_ = new ZNPList_ZPP_AABBNode();
            _loc8_.add(stree.root);
            while(_loc8_.head != null)
            {
               _loc9_ = _loc8_.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc6_.miny <= _loc10_.maxy && _loc10_.miny <= _loc6_.maxy && _loc6_.minx <= _loc10_.maxx && _loc10_.minx <= _loc6_.maxx)
               {
                  if(_loc9_.child1 == null)
                  {
                     _loc11_ = _loc9_.shape.body.outer;
                     if(!_loc7_.has(_loc11_))
                     {
                        if(param5 == null || (_loc12_.collisionMask & param5.collisionGroup) != 0 && (param5.collisionMask & _loc12_.collisionGroup) != 0)
                        {
                           if(param4)
                           {
                              if(ZPP_Collide.containTest(circShape.zpp_inner,_loc9_.shape))
                              {
                                 _loc7_.push(_loc11_);
                              }
                           }
                           else if(ZPP_Collide.testCollide_safe(_loc9_.shape,circShape.zpp_inner))
                           {
                              _loc7_.push(_loc11_);
                           }
                        }
                     }
                     else if(param4)
                     {
                        if((param5 == null || (_loc12_.collisionMask & param5.collisionGroup) != 0 && (param5.collisionMask & _loc12_.collisionGroup) != 0) && !ZPP_Collide.containTest(circShape.zpp_inner,_loc9_.shape))
                        {
                           _loc7_.remove(_loc11_);
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        _loc8_.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        _loc8_.add(_loc9_.child2);
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            _loc8_ = new ZNPList_ZPP_AABBNode();
            _loc8_.add(dtree.root);
            while(_loc8_.head != null)
            {
               _loc9_ = _loc8_.pop_unsafe();
               _loc10_ = _loc9_.aabb;
               if(_loc6_.miny <= _loc10_.maxy && _loc10_.miny <= _loc6_.maxy && _loc6_.minx <= _loc10_.maxx && _loc10_.minx <= _loc6_.maxx)
               {
                  if(_loc9_.child1 == null)
                  {
                     _loc11_ = _loc9_.shape.body.outer;
                     if(!_loc7_.has(_loc11_))
                     {
                        if(param5 == null || (_loc12_.collisionMask & param5.collisionGroup) != 0 && (param5.collisionMask & _loc12_.collisionGroup) != 0)
                        {
                           if(param4)
                           {
                              if(ZPP_Collide.containTest(circShape.zpp_inner,_loc9_.shape))
                              {
                                 _loc7_.push(_loc11_);
                              }
                           }
                           else if(ZPP_Collide.testCollide_safe(_loc9_.shape,circShape.zpp_inner))
                           {
                              _loc7_.push(_loc11_);
                           }
                        }
                     }
                     else if(param4)
                     {
                        if((param5 == null || (_loc12_.collisionMask & param5.collisionGroup) != 0 && (param5.collisionMask & _loc12_.collisionGroup) != 0) && !ZPP_Collide.containTest(circShape.zpp_inner,_loc9_.shape))
                        {
                           _loc7_.remove(_loc11_);
                        }
                     }
                  }
                  else
                  {
                     if(_loc9_.child1 != null)
                     {
                        _loc8_.add(_loc9_.child1);
                     }
                     if(_loc9_.child2 != null)
                     {
                        _loc8_.add(_loc9_.child2);
                     }
                  }
               }
            }
         }
         return _loc7_;
      }
      
      override public function bodiesInAABB(param1:ZPP_AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter) : BodyList
      {
         var _loc7_:* = null as ZNPList_ZPP_AABBNode;
         var _loc8_:* = null as ZPP_AABBNode;
         var _loc9_:* = null as ZPP_AABB;
         var _loc10_:* = null as Body;
         var _loc11_:* = null as ZNPList_ZPP_AABBNode;
         var _loc12_:* = null as ZPP_AABBNode;
         var _loc13_:* = null as ZPP_InteractionFilter;
         sync_broadphase();
         updateAABBShape(param1);
         var _loc5_:ZPP_AABB = aabbShape.zpp_inner.aabb;
         var _loc6_:BodyList = new BodyList();
         if(stree.root != null)
         {
            _loc7_ = new ZNPList_ZPP_AABBNode();
            _loc7_.add(stree.root);
            while(_loc7_.head != null)
            {
               _loc8_ = _loc7_.pop_unsafe();
               _loc9_ = _loc8_.aabb;
               if(_loc9_.minx >= _loc5_.minx && _loc9_.miny >= _loc5_.miny && _loc9_.maxx <= _loc5_.maxx && _loc9_.maxy <= _loc5_.maxy)
               {
                  if(_loc8_.child1 == null)
                  {
                     _loc10_ = _loc8_.shape.body.outer;
                     if(!_loc6_.has(_loc10_))
                     {
                        _loc6_.push(_loc10_);
                     }
                  }
                  else
                  {
                     _loc11_ = new ZNPList_ZPP_AABBNode();
                     _loc11_.add(_loc8_);
                     while(_loc11_.head != null)
                     {
                        _loc12_ = _loc11_.pop_unsafe();
                        if(_loc12_.child1 == null)
                        {
                           _loc10_ = _loc12_.shape.body.outer;
                           if(!_loc6_.has(_loc10_))
                           {
                              _loc6_.push(_loc10_);
                           }
                        }
                        else
                        {
                           if(_loc12_.child1 != null)
                           {
                              _loc11_.add(_loc12_.child1);
                           }
                           if(_loc12_.child2 != null)
                           {
                              _loc11_.add(_loc12_.child2);
                           }
                        }
                     }
                  }
               }
               else
               {
                  _loc9_ = _loc8_.aabb;
                  if(_loc5_.miny <= _loc9_.maxy && _loc9_.miny <= _loc5_.maxy && _loc5_.minx <= _loc9_.maxx && _loc9_.minx <= _loc5_.maxx)
                  {
                     if(_loc8_.child1 == null)
                     {
                        _loc10_ = _loc8_.shape.body.outer;
                        if(!_loc6_.has(_loc10_))
                        {
                           if(param4 == null || (_loc13_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc13_.collisionGroup) != 0)
                           {
                              if(param2)
                              {
                                 if(param3)
                                 {
                                    if(ZPP_Collide.containTest(aabbShape.zpp_inner,_loc8_.shape))
                                    {
                                       _loc6_.push(_loc10_);
                                    }
                                 }
                                 else
                                 {
                                    _loc9_ = _loc8_.shape.aabb;
                                    if(_loc9_.minx >= _loc5_.minx && _loc9_.miny >= _loc5_.miny && _loc9_.maxx <= _loc5_.maxx && _loc9_.maxy <= _loc5_.maxy)
                                    {
                                       _loc6_.push(_loc10_);
                                    }
                                    else if(ZPP_Collide.testCollide_safe(_loc8_.shape,aabbShape.zpp_inner))
                                    {
                                       _loc6_.push(_loc10_);
                                    }
                                 }
                              }
                              else if(!param3 || _loc9_.minx >= _loc5_.minx && _loc9_.miny >= _loc5_.miny && _loc9_.maxx <= _loc5_.maxx && _loc9_.maxy <= _loc5_.maxy)
                              {
                                 _loc6_.push(_loc10_);
                              }
                           }
                        }
                        else if(param3)
                        {
                           if(param4 == null || (_loc13_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc13_.collisionGroup) != 0)
                           {
                              if(param2)
                              {
                                 if(!ZPP_Collide.containTest(aabbShape.zpp_inner,_loc8_.shape))
                                 {
                                    _loc6_.remove(_loc10_);
                                 }
                              }
                              else
                              {
                                 _loc9_ = _loc8_.shape.aabb;
                                 if(!(_loc9_.minx >= _loc5_.minx && _loc9_.miny >= _loc5_.miny && _loc9_.maxx <= _loc5_.maxx && _loc9_.maxy <= _loc5_.maxy))
                                 {
                                    _loc6_.remove(_loc10_);
                                 }
                              }
                           }
                        }
                     }
                     else
                     {
                        if(_loc8_.child1 != null)
                        {
                           _loc7_.add(_loc8_.child1);
                        }
                        if(_loc8_.child2 != null)
                        {
                           _loc7_.add(_loc8_.child2);
                        }
                     }
                  }
               }
            }
         }
         if(dtree.root != null)
         {
            _loc7_ = new ZNPList_ZPP_AABBNode();
            _loc7_.add(dtree.root);
            while(_loc7_.head != null)
            {
               _loc8_ = _loc7_.pop_unsafe();
               _loc9_ = _loc8_.aabb;
               if(_loc9_.minx >= _loc5_.minx && _loc9_.miny >= _loc5_.miny && _loc9_.maxx <= _loc5_.maxx && _loc9_.maxy <= _loc5_.maxy)
               {
                  if(_loc8_.child1 == null)
                  {
                     _loc10_ = _loc8_.shape.body.outer;
                     if(!_loc6_.has(_loc10_))
                     {
                        _loc6_.push(_loc10_);
                     }
                  }
                  else
                  {
                     _loc11_ = new ZNPList_ZPP_AABBNode();
                     _loc11_.add(_loc8_);
                     while(_loc11_.head != null)
                     {
                        _loc12_ = _loc11_.pop_unsafe();
                        if(_loc12_.child1 == null)
                        {
                           _loc10_ = _loc12_.shape.body.outer;
                           if(!_loc6_.has(_loc10_))
                           {
                              _loc6_.push(_loc10_);
                           }
                        }
                        else
                        {
                           if(_loc12_.child1 != null)
                           {
                              _loc11_.add(_loc12_.child1);
                           }
                           if(_loc12_.child2 != null)
                           {
                              _loc11_.add(_loc12_.child2);
                           }
                        }
                     }
                  }
               }
               else
               {
                  _loc9_ = _loc8_.aabb;
                  if(_loc5_.miny <= _loc9_.maxy && _loc9_.miny <= _loc5_.maxy && _loc5_.minx <= _loc9_.maxx && _loc9_.minx <= _loc5_.maxx)
                  {
                     if(_loc8_.child1 == null)
                     {
                        _loc10_ = _loc8_.shape.body.outer;
                        if(!_loc6_.has(_loc10_))
                        {
                           if(param4 == null || (_loc13_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc13_.collisionGroup) != 0)
                           {
                              if(param2)
                              {
                                 if(param3)
                                 {
                                    if(ZPP_Collide.containTest(aabbShape.zpp_inner,_loc8_.shape))
                                    {
                                       _loc6_.push(_loc10_);
                                    }
                                 }
                                 else
                                 {
                                    _loc9_ = _loc8_.shape.aabb;
                                    if(_loc9_.minx >= _loc5_.minx && _loc9_.miny >= _loc5_.miny && _loc9_.maxx <= _loc5_.maxx && _loc9_.maxy <= _loc5_.maxy)
                                    {
                                       _loc6_.push(_loc10_);
                                    }
                                    else if(ZPP_Collide.testCollide_safe(_loc8_.shape,aabbShape.zpp_inner))
                                    {
                                       _loc6_.push(_loc10_);
                                    }
                                 }
                              }
                              else if(!param3 || _loc9_.minx >= _loc5_.minx && _loc9_.miny >= _loc5_.miny && _loc9_.maxx <= _loc5_.maxx && _loc9_.maxy <= _loc5_.maxy)
                              {
                                 _loc6_.push(_loc10_);
                              }
                           }
                        }
                        else if(param3)
                        {
                           if(param4 == null || (_loc13_.collisionMask & param4.collisionGroup) != 0 && (param4.collisionMask & _loc13_.collisionGroup) != 0)
                           {
                              if(param2)
                              {
                                 if(!ZPP_Collide.containTest(aabbShape.zpp_inner,_loc8_.shape))
                                 {
                                    _loc6_.remove(_loc10_);
                                 }
                              }
                              else
                              {
                                 _loc9_ = _loc8_.shape.aabb;
                                 if(!(_loc9_.minx >= _loc5_.minx && _loc9_.miny >= _loc5_.miny && _loc9_.maxx <= _loc5_.maxx && _loc9_.maxy <= _loc5_.maxy))
                                 {
                                    _loc6_.remove(_loc10_);
                                 }
                              }
                           }
                        }
                     }
                     else
                     {
                        if(_loc8_.child1 != null)
                        {
                           _loc7_.add(_loc8_.child1);
                        }
                        if(_loc8_.child2 != null)
                        {
                           _loc7_.add(_loc8_.child2);
                        }
                     }
                  }
               }
            }
         }
         return _loc6_;
      }
      
      public function __remove(param1:ZPP_Shape) : void
      {
         var _loc3_:* = null as ZPP_AABBNode;
         var _loc4_:* = null as ZPP_AABBNode;
         var _loc7_:* = null as ZPP_AABBPair;
         var _loc8_:* = null as ZPP_AABBPair;
         var _loc2_:ZPP_AABBNode = param1.node;
         if(!_loc2_.first_sync)
         {
            if(_loc2_.dyn)
            {
               dtree.removeLeaf(_loc2_);
            }
            else
            {
               stree.removeLeaf(_loc2_);
            }
         }
         param1.node = null;
         if(_loc2_.synced)
         {
            _loc3_ = null;
            _loc4_ = syncs;
            while(_loc4_ != null)
            {
               if(_loc4_ != _loc2_)
               {
                  _loc3_ = _loc4_;
                  _loc4_ = _loc4_.snext;
                  continue;
               }
               break;
            }
            if(_loc3_ == null)
            {
               syncs = _loc4_.snext;
            }
            else
            {
               _loc3_.snext = _loc4_.snext;
            }
            _loc4_.snext = null;
            _loc2_.synced = false;
         }
         if(_loc2_.moved)
         {
            _loc3_ = null;
            _loc4_ = moves;
            while(_loc4_ != null)
            {
               if(_loc4_ != _loc2_)
               {
                  _loc3_ = _loc4_;
                  _loc4_ = _loc4_.mnext;
                  continue;
               }
               break;
            }
            if(_loc3_ == null)
            {
               moves = _loc4_.mnext;
            }
            else
            {
               _loc3_.mnext = _loc4_.mnext;
            }
            _loc4_.mnext = null;
            _loc2_.moved = false;
         }
         var _loc5_:* = null;
         var _loc6_:ZPP_AABBPair = pairs;
         while(_loc6_ != null)
         {
            _loc7_ = _loc6_.next;
            if(_loc6_.n1 == _loc2_ || _loc6_.n2 == _loc2_)
            {
               if(_loc5_ == null)
               {
                  pairs = _loc7_;
               }
               else
               {
                  _loc5_.next = _loc7_;
               }
               if(_loc6_.arb != null)
               {
                  _loc6_.arb.pair = null;
               }
               _loc6_.arb = null;
               _loc6_.n1.shape.pairs.remove(_loc6_);
               _loc6_.n2.shape.pairs.remove(_loc6_);
               _loc8_ = _loc6_;
               _loc3_ = null;
               _loc8_.n2 = _loc3_;
               _loc8_.n1 = _loc3_;
               _loc8_.sleeping = false;
               _loc8_.next = ZPP_AABBPair.zpp_pool;
               ZPP_AABBPair.zpp_pool = _loc8_;
               _loc6_ = _loc7_;
            }
            else
            {
               _loc5_ = _loc6_;
               _loc6_ = _loc7_;
            }
         }
         while(param1.pairs.head != null)
         {
            _loc7_ = param1.pairs.pop_unsafe();
            if(_loc7_.n1 == _loc2_)
            {
               _loc7_.n2.shape.pairs.remove(_loc7_);
            }
            else
            {
               _loc7_.n1.shape.pairs.remove(_loc7_);
            }
            if(_loc7_.arb != null)
            {
               _loc7_.arb.pair = null;
            }
            _loc7_.arb = null;
            _loc8_ = _loc7_;
            _loc3_ = null;
            _loc8_.n2 = _loc3_;
            _loc8_.n1 = _loc3_;
            _loc8_.sleeping = false;
            _loc8_.next = ZPP_AABBPair.zpp_pool;
            ZPP_AABBPair.zpp_pool = _loc8_;
         }
         _loc3_ = _loc2_;
         _loc3_.height = -1;
         var _loc9_:ZPP_AABB = _loc3_.aabb;
         if(_loc9_.outer != null)
         {
            _loc9_.outer.zpp_inner = null;
            _loc9_.outer = null;
         }
         _loc9_.wrap_max = null;
         _loc9_.wrap_min = null;
         _loc9_._invalidate = null;
         _loc9_._validate = null;
         _loc9_.next = ZPP_AABB.zpp_pool;
         ZPP_AABB.zpp_pool = _loc9_;
         _loc4_ = null;
         _loc3_.parent = _loc4_;
         _loc4_ = _loc4_;
         _loc3_.child2 = _loc4_;
         _loc3_.child1 = _loc4_;
         _loc3_.next = null;
         _loc3_.snext = null;
         _loc3_.mnext = null;
         _loc3_.next = ZPP_AABBNode.zpp_pool;
         ZPP_AABBNode.zpp_pool = _loc3_;
      }
      
      public function __insert(param1:ZPP_Shape) : void
      {
         var _loc2_:* = null as ZPP_AABBNode;
         if(ZPP_AABBNode.zpp_pool == null)
         {
            _loc2_ = new ZPP_AABBNode();
         }
         else
         {
            _loc2_ = ZPP_AABBNode.zpp_pool;
            ZPP_AABBNode.zpp_pool = _loc2_.next;
            _loc2_.next = null;
         }
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc2_.aabb = new ZPP_AABB();
         }
         else
         {
            _loc2_.aabb = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc2_.aabb.next;
            _loc2_.aabb.next = null;
         }
         null;
         _loc2_.moved = false;
         _loc2_.synced = false;
         _loc2_.first_sync = false;
         _loc2_.shape = param1;
         param1.node = _loc2_;
         _loc2_.synced = true;
         _loc2_.first_sync = true;
         _loc2_.snext = syncs;
         syncs = _loc2_;
      }
   }
}
