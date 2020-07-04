package zpp_nape.geom
{
   import flash.Boot;
   import nape.geom.RayResult;
   import nape.geom.RayResultList;
   import nape.geom.Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.shape.ZPP_Edge;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.util.ZNPList_RayResult;
   import zpp_nape.util.ZNPNode_RayResult;
   import zpp_nape.util.ZNPNode_ZPP_Edge;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_Ray
   {
       
      
      public var zip_dir:Boolean;
      
      public var userData;
      
      public var originy:Number;
      
      public var originx:Number;
      
      public var origin:Vec2;
      
      public var normaly:Number;
      
      public var normalx:Number;
      
      public var maxdist:Number;
      
      public var idiry:Number;
      
      public var idirx:Number;
      
      public var diry:Number;
      
      public var dirx:Number;
      
      public var direction:Vec2;
      
      public var absnormaly:Number;
      
      public var absnormalx:Number;
      
      public function ZPP_Ray()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         origin = Vec2.get();
         origin.zpp_inner._invalidate = origin_invalidate;
         direction = Vec2.get();
         direction.zpp_inner._invalidate = direction_invalidate;
         originx = 0;
         originy = 0;
         dirx = 0;
         diry = 0;
         zip_dir = false;
      }
      
      public function validate_dir() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(zip_dir)
         {
            zip_dir = false;
            _loc1_ = Number(dirx * dirx + diry * diry);
            _loc2_ = 1 / Math.sqrt(_loc1_);
            _loc3_ = _loc2_;
            dirx = dirx * _loc3_;
            diry = diry * _loc3_;
            idirx = 1 / dirx;
            idiry = 1 / diry;
            normalx = -diry;
            normaly = dirx;
            _loc1_ = normalx;
            absnormalx = _loc1_ < 0?-_loc1_:_loc1_;
            _loc1_ = normaly;
            absnormaly = _loc1_ < 0?-_loc1_:_loc1_;
         }
      }
      
      public function rayAABB() : ZPP_AABB
      {
         var _loc5_:Number = NaN;
         var _loc7_:* = null as ZPP_AABB;
         var _loc1_:Number = originx;
         var _loc2_:Number = _loc1_;
         var _loc3_:Number = originy;
         var _loc4_:Number = _loc3_;
         if(maxdist >= 1.79e308)
         {
            if(dirx > 0)
            {
               _loc2_ = 1.79e308;
            }
            else if(dirx < 0)
            {
               _loc2_ = -1.79e308;
            }
            if(diry > 0)
            {
               _loc4_ = 1.79e308;
            }
            else if(diry < 0)
            {
               _loc4_ = -1.79e308;
            }
         }
         else
         {
            _loc2_ = Number(_loc2_ + maxdist * dirx);
            _loc4_ = Number(_loc4_ + maxdist * diry);
         }
         if(_loc2_ < _loc1_)
         {
            _loc5_ = _loc1_;
            _loc1_ = _loc2_;
            _loc2_ = _loc5_;
         }
         if(_loc4_ < _loc3_)
         {
            _loc5_ = _loc3_;
            _loc3_ = _loc4_;
            _loc4_ = _loc5_;
         }
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc7_ = new ZPP_AABB();
         }
         else
         {
            _loc7_ = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc7_.next;
            _loc7_.next = null;
         }
         null;
         _loc7_.minx = _loc1_;
         _loc7_.miny = _loc3_;
         _loc7_.maxx = _loc2_;
         _loc7_.maxy = _loc4_;
         var _loc6_:ZPP_AABB = _loc7_;
         return _loc6_;
      }
      
      public function polysect2(param1:ZPP_Polygon, param2:Boolean, param3:RayResultList) : void
      {
         var _loc9_:* = false;
         var _loc13_:* = null as ZPP_Vec2;
         var _loc14_:* = null as ZPP_Edge;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:* = null as RayResult;
         var _loc23_:* = null as ZNPNode_RayResult;
         var _loc24_:* = null as ZNPNode_RayResult;
         var _loc25_:* = null as RayResult;
         var _loc26_:* = null as ZNPList_RayResult;
         var _loc27_:* = null as ZNPNode_RayResult;
         var _loc28_:Boolean = false;
         var _loc4_:Number = 1.79e308;
         var _loc5_:Number = -1;
         var _loc6_:ZPP_Edge = null;
         var _loc7_:ZPP_Edge = null;
         var _loc8_:ZNPNode_ZPP_Edge = param1.edges.head;
         _loc9_ = true;
         var _loc10_:ZPP_Vec2 = param1.gverts.next;
         var _loc11_:ZPP_Vec2 = _loc10_;
         var _loc12_:ZPP_Vec2 = _loc10_.next;
         while(_loc12_ != null)
         {
            _loc13_ = _loc12_;
            _loc14_ = _loc8_.elt;
            if(param2 || Number(_loc14_.gnormx * dirx + _loc14_.gnormy * diry) < 0)
            {
               _loc15_ = _loc13_.x - _loc11_.x;
               _loc16_ = _loc13_.y - _loc11_.y;
               _loc17_ = _loc11_.x - originx;
               _loc18_ = _loc11_.y - originy;
               _loc19_ = _loc16_ * dirx - _loc15_ * diry;
               if(_loc19_ * _loc19_ > 1.0e-8)
               {
                  _loc19_ = 1 / _loc19_;
                  _loc20_ = (_loc16_ * _loc17_ - _loc15_ * _loc18_) * _loc19_;
                  if(_loc20_ > 0 && _loc20_ <= maxdist && (_loc20_ < _loc4_ || _loc20_ > _loc5_))
                  {
                     _loc21_ = (diry * _loc17_ - dirx * _loc18_) * _loc19_;
                     if(_loc21_ > -1.0e-8 && _loc21_ < 1.00000001)
                     {
                        if(_loc20_ < _loc4_)
                        {
                           _loc4_ = _loc20_;
                           _loc6_ = _loc8_.elt;
                        }
                        if(_loc20_ > _loc5_)
                        {
                           _loc5_ = _loc20_;
                           _loc7_ = _loc8_.elt;
                        }
                     }
                  }
               }
            }
            _loc8_ = _loc8_.next;
            _loc10_ = _loc12_;
            _loc11_ = _loc13_;
            _loc12_ = _loc12_.next;
         }
         if(_loc9_)
         {
            _loc12_ = param1.gverts.next;
            _loc13_ = _loc12_;
            _loc14_ = _loc8_.elt;
            if(param2 || Number(_loc14_.gnormx * dirx + _loc14_.gnormy * diry) < 0)
            {
               _loc15_ = _loc13_.x - _loc11_.x;
               _loc16_ = _loc13_.y - _loc11_.y;
               _loc17_ = _loc11_.x - originx;
               _loc18_ = _loc11_.y - originy;
               _loc19_ = _loc16_ * dirx - _loc15_ * diry;
               if(_loc19_ * _loc19_ > 1.0e-8)
               {
                  _loc19_ = 1 / _loc19_;
                  _loc20_ = (_loc16_ * _loc17_ - _loc15_ * _loc18_) * _loc19_;
                  if(_loc20_ > 0 && _loc20_ <= maxdist && (_loc20_ < _loc4_ || _loc20_ > _loc5_))
                  {
                     _loc21_ = (diry * _loc17_ - dirx * _loc18_) * _loc19_;
                     if(_loc21_ > -1.0e-8 && _loc21_ < 1.00000001)
                     {
                        if(_loc20_ < _loc4_)
                        {
                           _loc4_ = _loc20_;
                           _loc6_ = _loc8_.elt;
                        }
                        if(_loc20_ > _loc5_)
                        {
                           _loc5_ = _loc20_;
                           _loc7_ = _loc8_.elt;
                        }
                     }
                  }
               }
            }
            _loc8_ = _loc8_.next;
         }
         if(_loc6_ != null)
         {
            _loc15_ = _loc6_.gnormx;
            _loc16_ = _loc6_.gnormy;
            _loc9_ = Number(_loc15_ * dirx + _loc16_ * diry) > 0;
            if(_loc9_)
            {
               _loc15_ = -_loc15_;
               _loc16_ = -_loc16_;
            }
            _loc22_ = new RayResult(Vec2.get(_loc15_,_loc16_),_loc4_,_loc9_,param1.outer);
            _loc23_ = null;
            _loc24_ = param3.zpp_inner.inner.head;
            while(_loc24_ != null)
            {
               _loc25_ = _loc24_.elt;
               if(_loc22_.distance >= _loc25_.distance)
               {
                  _loc23_ = _loc24_;
                  _loc24_ = _loc24_.next;
                  continue;
               }
               break;
            }
            _loc26_ = param3.zpp_inner.inner;
            if(ZNPNode_RayResult.zpp_pool == null)
            {
               _loc27_ = new ZNPNode_RayResult();
            }
            else
            {
               _loc27_ = ZNPNode_RayResult.zpp_pool;
               ZNPNode_RayResult.zpp_pool = _loc27_.next;
               _loc27_.next = null;
            }
            null;
            _loc27_.elt = _loc22_;
            _loc24_ = _loc27_;
            if(_loc23_ == null)
            {
               _loc24_.next = _loc26_.head;
               _loc26_.head = _loc24_;
            }
            else
            {
               _loc24_.next = _loc23_.next;
               _loc23_.next = _loc24_;
            }
            _loc28_ = true;
            _loc26_.modified = _loc28_;
            _loc26_.pushmod = _loc28_;
            _loc26_.length = _loc26_.length + 1;
            _loc24_;
         }
         if(_loc7_ != null && _loc6_ != _loc7_)
         {
            _loc15_ = _loc7_.gnormx;
            _loc16_ = _loc7_.gnormy;
            _loc9_ = Number(_loc15_ * dirx + _loc16_ * diry) > 0;
            if(_loc9_)
            {
               _loc15_ = -_loc15_;
               _loc16_ = -_loc16_;
            }
            _loc22_ = new RayResult(Vec2.get(_loc15_,_loc16_),_loc5_,_loc9_,param1.outer);
            _loc23_ = null;
            _loc24_ = param3.zpp_inner.inner.head;
            while(_loc24_ != null)
            {
               _loc25_ = _loc24_.elt;
               if(_loc22_.distance >= _loc25_.distance)
               {
                  _loc23_ = _loc24_;
                  _loc24_ = _loc24_.next;
                  continue;
               }
               break;
            }
            _loc26_ = param3.zpp_inner.inner;
            if(ZNPNode_RayResult.zpp_pool == null)
            {
               _loc27_ = new ZNPNode_RayResult();
            }
            else
            {
               _loc27_ = ZNPNode_RayResult.zpp_pool;
               ZNPNode_RayResult.zpp_pool = _loc27_.next;
               _loc27_.next = null;
            }
            null;
            _loc27_.elt = _loc22_;
            _loc24_ = _loc27_;
            if(_loc23_ == null)
            {
               _loc24_.next = _loc26_.head;
               _loc26_.head = _loc24_;
            }
            else
            {
               _loc24_.next = _loc23_.next;
               _loc23_.next = _loc24_;
            }
            _loc28_ = true;
            _loc26_.modified = _loc28_;
            _loc26_.pushmod = _loc28_;
            _loc26_.length = _loc26_.length + 1;
            _loc24_;
         }
      }
      
      public function polysect(param1:ZPP_Polygon, param2:Boolean, param3:Number) : RayResult
      {
         var _loc7_:* = false;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZPP_Edge;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:* = null as RayResult;
         var _loc4_:Number = param3;
         var _loc5_:ZPP_Edge = null;
         var _loc6_:ZNPNode_ZPP_Edge = param1.edges.head;
         _loc7_ = true;
         var _loc8_:ZPP_Vec2 = param1.gverts.next;
         var _loc9_:ZPP_Vec2 = _loc8_;
         var _loc10_:ZPP_Vec2 = _loc8_.next;
         while(_loc10_ != null)
         {
            _loc11_ = _loc10_;
            _loc12_ = _loc6_.elt;
            if(param2 || Number(_loc12_.gnormx * dirx + _loc12_.gnormy * diry) < 0)
            {
               _loc13_ = _loc11_.x - _loc9_.x;
               _loc14_ = _loc11_.y - _loc9_.y;
               _loc15_ = _loc9_.x - originx;
               _loc16_ = _loc9_.y - originy;
               _loc17_ = _loc14_ * dirx - _loc13_ * diry;
               if(_loc17_ * _loc17_ > 1.0e-8)
               {
                  _loc17_ = 1 / _loc17_;
                  _loc18_ = (_loc14_ * _loc15_ - _loc13_ * _loc16_) * _loc17_;
                  if(_loc18_ > 0 && _loc18_ < _loc4_ && _loc18_ <= maxdist)
                  {
                     _loc19_ = (diry * _loc15_ - dirx * _loc16_) * _loc17_;
                     if(_loc19_ > -1.0e-8 && _loc19_ < 1.00000001)
                     {
                        _loc4_ = _loc18_;
                        _loc5_ = _loc6_.elt;
                     }
                  }
               }
            }
            _loc6_ = _loc6_.next;
            _loc8_ = _loc10_;
            _loc9_ = _loc11_;
            _loc10_ = _loc10_.next;
         }
         if(_loc7_)
         {
            _loc10_ = param1.gverts.next;
            _loc11_ = _loc10_;
            _loc12_ = _loc6_.elt;
            if(param2 || Number(_loc12_.gnormx * dirx + _loc12_.gnormy * diry) < 0)
            {
               _loc13_ = _loc11_.x - _loc9_.x;
               _loc14_ = _loc11_.y - _loc9_.y;
               _loc15_ = _loc9_.x - originx;
               _loc16_ = _loc9_.y - originy;
               _loc17_ = _loc14_ * dirx - _loc13_ * diry;
               if(_loc17_ * _loc17_ > 1.0e-8)
               {
                  _loc17_ = 1 / _loc17_;
                  _loc18_ = (_loc14_ * _loc15_ - _loc13_ * _loc16_) * _loc17_;
                  if(_loc18_ > 0 && _loc18_ < _loc4_ && _loc18_ <= maxdist)
                  {
                     _loc19_ = (diry * _loc15_ - dirx * _loc16_) * _loc17_;
                     if(_loc19_ > -1.0e-8 && _loc19_ < 1.00000001)
                     {
                        _loc4_ = _loc18_;
                        _loc5_ = _loc6_.elt;
                     }
                  }
               }
            }
            _loc6_ = _loc6_.next;
         }
         if(_loc5_ != null)
         {
            _loc13_ = _loc5_.gnormx;
            _loc14_ = _loc5_.gnormy;
            _loc7_ = Number(_loc13_ * dirx + _loc14_ * diry) > 0;
            if(_loc7_)
            {
               _loc13_ = -_loc13_;
               _loc14_ = -_loc14_;
            }
            _loc20_ = new RayResult(Vec2.get(_loc13_,_loc14_),_loc4_,_loc7_,param1.outer);
            return _loc20_;
         }
         return null;
      }
      
      public function origin_invalidate(param1:ZPP_Vec2) : void
      {
         originx = param1.x;
         originy = param1.y;
      }
      
      public function direction_invalidate(param1:ZPP_Vec2) : void
      {
         dirx = param1.x;
         diry = param1.y;
         zip_dir = true;
      }
      
      public function circlesect2(param1:ZPP_Circle, param2:Boolean, param3:RayResultList) : void
      {
         var _loc4_:* = null as ZPP_Polygon;
         var _loc5_:Number = NaN;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZPP_Body;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:* = null as RayResult;
         var _loc24_:* = null as ZNPNode_RayResult;
         var _loc25_:* = null as ZNPNode_RayResult;
         var _loc26_:* = null as RayResult;
         var _loc27_:* = null as ZNPList_RayResult;
         var _loc28_:* = null as ZNPNode_RayResult;
         var _loc29_:Boolean = false;
         var _loc30_:Number = NaN;
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
                     _loc4_ = param1.polygon;
                     if(_loc4_.lverts.next.next == null)
                     {
                        _loc4_.localCOMx = _loc4_.lverts.next.x;
                        _loc4_.localCOMy = _loc4_.lverts.next.y;
                        null;
                     }
                     else if(_loc4_.lverts.next.next.next == null)
                     {
                        _loc4_.localCOMx = _loc4_.lverts.next.x;
                        _loc4_.localCOMy = _loc4_.lverts.next.y;
                        _loc5_ = 1;
                        _loc4_.localCOMx = Number(_loc4_.localCOMx + _loc4_.lverts.next.next.x * _loc5_);
                        _loc4_.localCOMy = Number(_loc4_.localCOMy + _loc4_.lverts.next.next.y * _loc5_);
                        _loc5_ = 0.5;
                        _loc4_.localCOMx = _loc4_.localCOMx * _loc5_;
                        _loc4_.localCOMy = _loc4_.localCOMy * _loc5_;
                     }
                     else
                     {
                        _loc4_.localCOMx = 0;
                        _loc4_.localCOMy = 0;
                        _loc5_ = 0;
                        _loc6_ = _loc4_.lverts.next;
                        _loc7_ = _loc6_;
                        _loc6_ = _loc6_.next;
                        _loc8_ = _loc6_;
                        _loc6_ = _loc6_.next;
                        while(_loc6_ != null)
                        {
                           _loc9_ = _loc6_;
                           _loc5_ = Number(_loc5_ + _loc8_.x * (_loc9_.y - _loc7_.y));
                           _loc10_ = _loc9_.y * _loc8_.x - _loc9_.x * _loc8_.y;
                           _loc4_.localCOMx = Number(_loc4_.localCOMx + (_loc8_.x + _loc9_.x) * _loc10_);
                           _loc4_.localCOMy = Number(_loc4_.localCOMy + (_loc8_.y + _loc9_.y) * _loc10_);
                           _loc7_ = _loc8_;
                           _loc8_ = _loc9_;
                           _loc6_ = _loc6_.next;
                        }
                        _loc6_ = _loc4_.lverts.next;
                        _loc9_ = _loc6_;
                        _loc5_ = Number(_loc5_ + _loc8_.x * (_loc9_.y - _loc7_.y));
                        _loc10_ = _loc9_.y * _loc8_.x - _loc9_.x * _loc8_.y;
                        _loc4_.localCOMx = Number(_loc4_.localCOMx + (_loc8_.x + _loc9_.x) * _loc10_);
                        _loc4_.localCOMy = Number(_loc4_.localCOMy + (_loc8_.y + _loc9_.y) * _loc10_);
                        _loc7_ = _loc8_;
                        _loc8_ = _loc9_;
                        _loc6_ = _loc6_.next;
                        _loc11_ = _loc6_;
                        _loc5_ = Number(_loc5_ + _loc8_.x * (_loc11_.y - _loc7_.y));
                        _loc10_ = _loc11_.y * _loc8_.x - _loc11_.x * _loc8_.y;
                        _loc4_.localCOMx = Number(_loc4_.localCOMx + (_loc8_.x + _loc11_.x) * _loc10_);
                        _loc4_.localCOMy = Number(_loc4_.localCOMy + (_loc8_.y + _loc11_.y) * _loc10_);
                        _loc5_ = 1 / (3 * _loc5_);
                        _loc10_ = _loc5_;
                        _loc4_.localCOMx = _loc4_.localCOMx * _loc10_;
                        _loc4_.localCOMy = _loc4_.localCOMy * _loc10_;
                     }
                  }
                  if(param1.wrap_localCOM != null)
                  {
                     param1.wrap_localCOM.zpp_inner.x = param1.localCOMx;
                     param1.wrap_localCOM.zpp_inner.y = param1.localCOMy;
                  }
               }
               _loc12_ = param1.body;
               if(_loc12_.zip_axis)
               {
                  _loc12_.zip_axis = false;
                  _loc12_.axisx = Number(Math.sin(_loc12_.rot));
                  _loc12_.axisy = Number(Math.cos(_loc12_.rot));
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
         _loc5_ = originx - param1.worldCOMx;
         _loc10_ = originy - param1.worldCOMy;
         var _loc13_:Number = Number(dirx * dirx + diry * diry);
         var _loc14_:Number = 2 * (_loc5_ * dirx + _loc10_ * diry);
         var _loc15_:Number = _loc5_ * _loc5_ + _loc10_ * _loc10_ - param1.radius * param1.radius;
         var _loc16_:Number = _loc14_ * _loc14_ - 4 * _loc13_ * _loc15_;
         if(_loc16_ == 0)
         {
            _loc17_ = -_loc14_ / 2 * _loc13_;
            if((!param2 || _loc15_ > 0) && _loc17_ > 0 && _loc17_ <= maxdist)
            {
               _loc18_ = originx;
               _loc19_ = originy;
               _loc20_ = _loc17_;
               _loc18_ = Number(_loc18_ + dirx * _loc20_);
               _loc19_ = Number(_loc19_ + diry * _loc20_);
               _loc20_ = 1;
               _loc18_ = _loc18_ - param1.worldCOMx * _loc20_;
               _loc19_ = _loc19_ - param1.worldCOMy * _loc20_;
               _loc20_ = Number(_loc18_ * _loc18_ + _loc19_ * _loc19_);
               _loc21_ = 1 / Math.sqrt(_loc20_);
               _loc22_ = _loc21_;
               _loc18_ = _loc18_ * _loc22_;
               _loc19_ = _loc19_ * _loc22_;
               if(_loc15_ <= 0)
               {
                  _loc18_ = -_loc18_;
                  _loc19_ = -_loc19_;
               }
               _loc23_ = new RayResult(Vec2.get(_loc18_,_loc19_),_loc17_,_loc15_ <= 0,param1.outer);
               _loc24_ = null;
               _loc25_ = param3.zpp_inner.inner.head;
               while(_loc25_ != null)
               {
                  _loc26_ = _loc25_.elt;
                  if(_loc23_.distance >= _loc26_.distance)
                  {
                     _loc24_ = _loc25_;
                     _loc25_ = _loc25_.next;
                     continue;
                  }
                  break;
               }
               _loc27_ = param3.zpp_inner.inner;
               if(ZNPNode_RayResult.zpp_pool == null)
               {
                  _loc28_ = new ZNPNode_RayResult();
               }
               else
               {
                  _loc28_ = ZNPNode_RayResult.zpp_pool;
                  ZNPNode_RayResult.zpp_pool = _loc28_.next;
                  _loc28_.next = null;
               }
               null;
               _loc28_.elt = _loc23_;
               _loc25_ = _loc28_;
               if(_loc24_ == null)
               {
                  _loc25_.next = _loc27_.head;
                  _loc27_.head = _loc25_;
               }
               else
               {
                  _loc25_.next = _loc24_.next;
                  _loc24_.next = _loc25_;
               }
               _loc29_ = true;
               _loc27_.modified = _loc29_;
               _loc27_.pushmod = _loc29_;
               _loc27_.length = _loc27_.length + 1;
               _loc25_;
            }
         }
         else
         {
            _loc16_ = Number(Math.sqrt(_loc16_));
            _loc13_ = 1 / (2 * _loc13_);
            _loc17_ = (-_loc14_ - _loc16_) * _loc13_;
            _loc18_ = (-_loc14_ + _loc16_) * _loc13_;
            if(_loc17_ > 0 && _loc17_ <= maxdist)
            {
               _loc19_ = originx;
               _loc20_ = originy;
               _loc21_ = _loc17_;
               _loc19_ = Number(_loc19_ + dirx * _loc21_);
               _loc20_ = Number(_loc20_ + diry * _loc21_);
               _loc21_ = 1;
               _loc19_ = _loc19_ - param1.worldCOMx * _loc21_;
               _loc20_ = _loc20_ - param1.worldCOMy * _loc21_;
               _loc21_ = Number(_loc19_ * _loc19_ + _loc20_ * _loc20_);
               _loc22_ = 1 / Math.sqrt(_loc21_);
               _loc30_ = _loc22_;
               _loc19_ = _loc19_ * _loc30_;
               _loc20_ = _loc20_ * _loc30_;
               _loc23_ = new RayResult(Vec2.get(_loc19_,_loc20_),_loc17_,false,param1.outer);
               _loc24_ = null;
               _loc25_ = param3.zpp_inner.inner.head;
               while(_loc25_ != null)
               {
                  _loc26_ = _loc25_.elt;
                  if(_loc23_.distance >= _loc26_.distance)
                  {
                     _loc24_ = _loc25_;
                     _loc25_ = _loc25_.next;
                     continue;
                  }
                  break;
               }
               _loc27_ = param3.zpp_inner.inner;
               if(ZNPNode_RayResult.zpp_pool == null)
               {
                  _loc28_ = new ZNPNode_RayResult();
               }
               else
               {
                  _loc28_ = ZNPNode_RayResult.zpp_pool;
                  ZNPNode_RayResult.zpp_pool = _loc28_.next;
                  _loc28_.next = null;
               }
               null;
               _loc28_.elt = _loc23_;
               _loc25_ = _loc28_;
               if(_loc24_ == null)
               {
                  _loc25_.next = _loc27_.head;
                  _loc27_.head = _loc25_;
               }
               else
               {
                  _loc25_.next = _loc24_.next;
                  _loc24_.next = _loc25_;
               }
               _loc29_ = true;
               _loc27_.modified = _loc29_;
               _loc27_.pushmod = _loc29_;
               _loc27_.length = _loc27_.length + 1;
               _loc25_;
            }
            if(_loc18_ > 0 && _loc18_ <= maxdist && param2)
            {
               _loc19_ = originx;
               _loc20_ = originy;
               _loc21_ = _loc18_;
               _loc19_ = Number(_loc19_ + dirx * _loc21_);
               _loc20_ = Number(_loc20_ + diry * _loc21_);
               _loc21_ = 1;
               _loc19_ = _loc19_ - param1.worldCOMx * _loc21_;
               _loc20_ = _loc20_ - param1.worldCOMy * _loc21_;
               _loc21_ = Number(_loc19_ * _loc19_ + _loc20_ * _loc20_);
               _loc22_ = 1 / Math.sqrt(_loc21_);
               _loc30_ = _loc22_;
               _loc19_ = _loc19_ * _loc30_;
               _loc20_ = _loc20_ * _loc30_;
               _loc19_ = -_loc19_;
               _loc20_ = -_loc20_;
               _loc23_ = new RayResult(Vec2.get(_loc19_,_loc20_),_loc18_,true,param1.outer);
               _loc24_ = null;
               _loc25_ = param3.zpp_inner.inner.head;
               while(_loc25_ != null)
               {
                  _loc26_ = _loc25_.elt;
                  if(_loc23_.distance >= _loc26_.distance)
                  {
                     _loc24_ = _loc25_;
                     _loc25_ = _loc25_.next;
                     continue;
                  }
                  break;
               }
               _loc27_ = param3.zpp_inner.inner;
               if(ZNPNode_RayResult.zpp_pool == null)
               {
                  _loc28_ = new ZNPNode_RayResult();
               }
               else
               {
                  _loc28_ = ZNPNode_RayResult.zpp_pool;
                  ZNPNode_RayResult.zpp_pool = _loc28_.next;
                  _loc28_.next = null;
               }
               null;
               _loc28_.elt = _loc23_;
               _loc25_ = _loc28_;
               if(_loc24_ == null)
               {
                  _loc25_.next = _loc27_.head;
                  _loc27_.head = _loc25_;
               }
               else
               {
                  _loc25_.next = _loc24_.next;
                  _loc24_.next = _loc25_;
               }
               _loc29_ = true;
               _loc27_.modified = _loc29_;
               _loc27_.pushmod = _loc29_;
               _loc27_.length = _loc27_.length + 1;
               _loc25_;
            }
         }
      }
      
      public function circlesect(param1:ZPP_Circle, param2:Boolean, param3:Number) : RayResult
      {
         var _loc4_:* = null as ZPP_Polygon;
         var _loc5_:Number = NaN;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZPP_Body;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:* = null as RayResult;
         var _loc24_:Number = NaN;
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
                     _loc4_ = param1.polygon;
                     if(_loc4_.lverts.next.next == null)
                     {
                        _loc4_.localCOMx = _loc4_.lverts.next.x;
                        _loc4_.localCOMy = _loc4_.lverts.next.y;
                        null;
                     }
                     else if(_loc4_.lverts.next.next.next == null)
                     {
                        _loc4_.localCOMx = _loc4_.lverts.next.x;
                        _loc4_.localCOMy = _loc4_.lverts.next.y;
                        _loc5_ = 1;
                        _loc4_.localCOMx = Number(_loc4_.localCOMx + _loc4_.lverts.next.next.x * _loc5_);
                        _loc4_.localCOMy = Number(_loc4_.localCOMy + _loc4_.lverts.next.next.y * _loc5_);
                        _loc5_ = 0.5;
                        _loc4_.localCOMx = _loc4_.localCOMx * _loc5_;
                        _loc4_.localCOMy = _loc4_.localCOMy * _loc5_;
                     }
                     else
                     {
                        _loc4_.localCOMx = 0;
                        _loc4_.localCOMy = 0;
                        _loc5_ = 0;
                        _loc6_ = _loc4_.lverts.next;
                        _loc7_ = _loc6_;
                        _loc6_ = _loc6_.next;
                        _loc8_ = _loc6_;
                        _loc6_ = _loc6_.next;
                        while(_loc6_ != null)
                        {
                           _loc9_ = _loc6_;
                           _loc5_ = Number(_loc5_ + _loc8_.x * (_loc9_.y - _loc7_.y));
                           _loc10_ = _loc9_.y * _loc8_.x - _loc9_.x * _loc8_.y;
                           _loc4_.localCOMx = Number(_loc4_.localCOMx + (_loc8_.x + _loc9_.x) * _loc10_);
                           _loc4_.localCOMy = Number(_loc4_.localCOMy + (_loc8_.y + _loc9_.y) * _loc10_);
                           _loc7_ = _loc8_;
                           _loc8_ = _loc9_;
                           _loc6_ = _loc6_.next;
                        }
                        _loc6_ = _loc4_.lverts.next;
                        _loc9_ = _loc6_;
                        _loc5_ = Number(_loc5_ + _loc8_.x * (_loc9_.y - _loc7_.y));
                        _loc10_ = _loc9_.y * _loc8_.x - _loc9_.x * _loc8_.y;
                        _loc4_.localCOMx = Number(_loc4_.localCOMx + (_loc8_.x + _loc9_.x) * _loc10_);
                        _loc4_.localCOMy = Number(_loc4_.localCOMy + (_loc8_.y + _loc9_.y) * _loc10_);
                        _loc7_ = _loc8_;
                        _loc8_ = _loc9_;
                        _loc6_ = _loc6_.next;
                        _loc11_ = _loc6_;
                        _loc5_ = Number(_loc5_ + _loc8_.x * (_loc11_.y - _loc7_.y));
                        _loc10_ = _loc11_.y * _loc8_.x - _loc11_.x * _loc8_.y;
                        _loc4_.localCOMx = Number(_loc4_.localCOMx + (_loc8_.x + _loc11_.x) * _loc10_);
                        _loc4_.localCOMy = Number(_loc4_.localCOMy + (_loc8_.y + _loc11_.y) * _loc10_);
                        _loc5_ = 1 / (3 * _loc5_);
                        _loc10_ = _loc5_;
                        _loc4_.localCOMx = _loc4_.localCOMx * _loc10_;
                        _loc4_.localCOMy = _loc4_.localCOMy * _loc10_;
                     }
                  }
                  if(param1.wrap_localCOM != null)
                  {
                     param1.wrap_localCOM.zpp_inner.x = param1.localCOMx;
                     param1.wrap_localCOM.zpp_inner.y = param1.localCOMy;
                  }
               }
               _loc12_ = param1.body;
               if(_loc12_.zip_axis)
               {
                  _loc12_.zip_axis = false;
                  _loc12_.axisx = Number(Math.sin(_loc12_.rot));
                  _loc12_.axisy = Number(Math.cos(_loc12_.rot));
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
         _loc5_ = originx - param1.worldCOMx;
         _loc10_ = originy - param1.worldCOMy;
         var _loc13_:Number = Number(dirx * dirx + diry * diry);
         var _loc14_:Number = 2 * (_loc5_ * dirx + _loc10_ * diry);
         var _loc15_:Number = _loc5_ * _loc5_ + _loc10_ * _loc10_ - param1.radius * param1.radius;
         var _loc16_:Number = _loc14_ * _loc14_ - 4 * _loc13_ * _loc15_;
         if(_loc16_ == 0)
         {
            _loc17_ = -_loc14_ / 2 * _loc13_;
            if((!param2 || _loc15_ > 0) && _loc17_ > 0 && _loc17_ < param3 && _loc17_ <= maxdist)
            {
               _loc18_ = originx;
               _loc19_ = originy;
               _loc20_ = _loc17_;
               _loc18_ = Number(_loc18_ + dirx * _loc20_);
               _loc19_ = Number(_loc19_ + diry * _loc20_);
               _loc20_ = 1;
               _loc18_ = _loc18_ - param1.worldCOMx * _loc20_;
               _loc19_ = _loc19_ - param1.worldCOMy * _loc20_;
               _loc20_ = Number(_loc18_ * _loc18_ + _loc19_ * _loc19_);
               _loc21_ = 1 / Math.sqrt(_loc20_);
               _loc22_ = _loc21_;
               _loc18_ = _loc18_ * _loc22_;
               _loc19_ = _loc19_ * _loc22_;
               if(_loc15_ <= 0)
               {
                  _loc18_ = -_loc18_;
                  _loc19_ = -_loc19_;
               }
               _loc23_ = new RayResult(Vec2.get(_loc18_,_loc19_),_loc17_,_loc15_ <= 0,param1.outer);
               return _loc23_;
            }
            return null;
         }
         _loc16_ = Number(Math.sqrt(_loc16_));
         _loc13_ = 1 / (2 * _loc13_);
         _loc17_ = (-_loc14_ - _loc16_) * _loc13_;
         _loc18_ = (-_loc14_ + _loc16_) * _loc13_;
         if(_loc17_ > 0)
         {
            if(_loc17_ < param3 && _loc17_ <= maxdist)
            {
               _loc19_ = originx;
               _loc20_ = originy;
               _loc21_ = _loc17_;
               _loc19_ = Number(_loc19_ + dirx * _loc21_);
               _loc20_ = Number(_loc20_ + diry * _loc21_);
               _loc21_ = 1;
               _loc19_ = _loc19_ - param1.worldCOMx * _loc21_;
               _loc20_ = _loc20_ - param1.worldCOMy * _loc21_;
               _loc21_ = Number(_loc19_ * _loc19_ + _loc20_ * _loc20_);
               _loc22_ = 1 / Math.sqrt(_loc21_);
               _loc24_ = _loc22_;
               _loc19_ = _loc19_ * _loc24_;
               _loc20_ = _loc20_ * _loc24_;
               _loc23_ = new RayResult(Vec2.get(_loc19_,_loc20_),_loc17_,false,param1.outer);
               return _loc23_;
            }
            return null;
         }
         if(_loc18_ > 0 && param2)
         {
            if(_loc18_ < param3 && _loc18_ <= maxdist)
            {
               _loc19_ = originx;
               _loc20_ = originy;
               _loc21_ = _loc18_;
               _loc19_ = Number(_loc19_ + dirx * _loc21_);
               _loc20_ = Number(_loc20_ + diry * _loc21_);
               _loc21_ = 1;
               _loc19_ = _loc19_ - param1.worldCOMx * _loc21_;
               _loc20_ = _loc20_ - param1.worldCOMy * _loc21_;
               _loc21_ = Number(_loc19_ * _loc19_ + _loc20_ * _loc20_);
               _loc22_ = 1 / Math.sqrt(_loc21_);
               _loc24_ = _loc22_;
               _loc19_ = _loc19_ * _loc24_;
               _loc20_ = _loc20_ * _loc24_;
               _loc19_ = -_loc19_;
               _loc20_ = -_loc20_;
               _loc23_ = new RayResult(Vec2.get(_loc19_,_loc20_),_loc18_,true,param1.outer);
               return _loc23_;
            }
            return null;
         }
         return null;
      }
      
      public function aabbtest(param1:ZPP_AABB) : Boolean
      {
         var _loc2_:Number = Number(normalx * (originx - 0.5 * (param1.minx + param1.maxx)) + normaly * (originy - 0.5 * (param1.miny + param1.maxy)));
         var _loc3_:Number = Number(absnormalx * 0.5 * (param1.maxx - param1.minx) + absnormaly * 0.5 * (param1.maxy - param1.miny));
         var _loc4_:Number = _loc2_;
         return (_loc4_ < 0?-_loc4_:_loc4_) < _loc3_;
      }
      
      public function aabbsect(param1:ZPP_AABB) : Number
      {
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:Boolean = originx >= param1.minx && originx <= param1.maxx;
         var _loc3_:Boolean = originy >= param1.miny && originy <= param1.maxy;
         if(!!_loc2_ && _loc3_)
         {
            return 0;
         }
         _loc4_ = -1;
         while(!(dirx >= 0 && originx >= param1.maxx))
         {
            if(!(dirx <= 0 && originx <= param1.minx))
            {
               if(!(diry >= 0 && originy >= param1.maxy))
               {
                  if(!(diry <= 0 && originy <= param1.miny))
                  {
                     if(dirx > 0)
                     {
                        _loc5_ = (param1.minx - originx) * idirx;
                        if(_loc5_ >= 0 && _loc5_ <= maxdist)
                        {
                           _loc6_ = Number(originy + _loc5_ * diry);
                           if(_loc6_ >= param1.miny && _loc6_ <= param1.maxy)
                           {
                              _loc4_ = _loc5_;
                              break;
                           }
                        }
                     }
                     else if(dirx < 0)
                     {
                        _loc5_ = (param1.maxx - originx) * idirx;
                        if(_loc5_ >= 0 && _loc5_ <= maxdist)
                        {
                           _loc6_ = Number(originy + _loc5_ * diry);
                           if(_loc6_ >= param1.miny && _loc6_ <= param1.maxy)
                           {
                              _loc4_ = _loc5_;
                              break;
                           }
                        }
                     }
                     if(diry > 0)
                     {
                        _loc5_ = (param1.miny - originy) * idiry;
                        if(_loc5_ >= 0 && _loc5_ <= maxdist)
                        {
                           _loc6_ = Number(originx + _loc5_ * dirx);
                           if(_loc6_ >= param1.minx && _loc6_ <= param1.maxx)
                           {
                              _loc4_ = _loc5_;
                              break;
                           }
                        }
                     }
                     else if(diry < 0)
                     {
                        _loc5_ = (param1.maxy - originy) * idiry;
                        if(_loc5_ >= 0 && _loc5_ <= maxdist)
                        {
                           _loc6_ = Number(originx + _loc5_ * dirx);
                           if(_loc6_ >= param1.minx && _loc6_ <= param1.maxx)
                           {
                              _loc4_ = _loc5_;
                              break;
                           }
                        }
                     }
                     continue;
                  }
                  break;
               }
               break;
            }
            break;
         }
         return _loc4_;
      }
   }
}
