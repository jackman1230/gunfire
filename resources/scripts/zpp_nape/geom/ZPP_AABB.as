package zpp_nape.geom
{
   import nape.geom.AABB;
   import nape.geom.Vec2;
   
   public class ZPP_AABB
   {
      
      public static var zpp_pool:ZPP_AABB;
       
      
      public var wrap_min:Vec2;
      
      public var wrap_max:Vec2;
      
      public var outer:AABB;
      
      public var next:ZPP_AABB;
      
      public var miny:Number;
      
      public var minx:Number;
      
      public var maxy:Number;
      
      public var maxx:Number;
      
      public var _validate:Object;
      
      public var _invalidate:Object;
      
      public var _immutable:Boolean;
      
      public function ZPP_AABB()
      {
      }
      
      public static function get(param1:Number, param2:Number, param3:Number, param4:Number) : ZPP_AABB
      {
         var _loc5_:* = null as ZPP_AABB;
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc5_ = new ZPP_AABB();
         }
         else
         {
            _loc5_ = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc5_.next;
            _loc5_.next = null;
         }
         null;
         _loc5_.minx = param1;
         _loc5_.miny = param2;
         _loc5_.maxx = param3;
         _loc5_.maxy = param4;
         return _loc5_;
      }
      
      public function wrapper() : AABB
      {
         var _loc1_:* = null as ZPP_AABB;
         var _loc2_:* = null as Vec2;
         if(outer == null)
         {
            outer = new AABB();
            _loc1_ = outer.zpp_inner;
            if(_loc1_.outer != null)
            {
               _loc1_.outer.zpp_inner = null;
               _loc1_.outer = null;
            }
            _loc2_ = null;
            _loc1_.wrap_max = _loc2_;
            _loc1_.wrap_min = _loc2_;
            _loc1_._invalidate = null;
            _loc1_._validate = null;
            _loc1_.next = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc1_;
            outer.zpp_inner = this;
         }
         return outer;
      }
      
      public function toString() : String
      {
         return "{ x: " + minx + " y: " + miny + " w: " + (maxx - minx) + " h: " + (maxy - miny) + " }";
      }
      
      public function mod_min(param1:ZPP_Vec2) : void
      {
         if(param1.x != minx || param1.y != miny)
         {
            minx = param1.x;
            miny = param1.y;
            if(_invalidate != null)
            {
               _invalidate(this);
            }
         }
      }
      
      public function mod_max(param1:ZPP_Vec2) : void
      {
         if(param1.x != maxx || param1.y != maxy)
         {
            maxx = param1.x;
            maxy = param1.y;
            if(_invalidate != null)
            {
               _invalidate(this);
            }
         }
      }
      
      public function getmin() : Vec2
      {
         if(wrap_min == null)
         {
            wrap_min = Vec2.get(minx,miny);
            wrap_min.zpp_inner._inuse = true;
            if(_immutable)
            {
               wrap_min.zpp_inner._immutable = true;
            }
            else
            {
               wrap_min.zpp_inner._invalidate = mod_min;
            }
            wrap_min.zpp_inner._validate = dom_min;
         }
         return wrap_min;
      }
      
      public function getmax() : Vec2
      {
         if(wrap_max == null)
         {
            wrap_max = Vec2.get(maxx,maxy);
            wrap_max.zpp_inner._inuse = true;
            if(_immutable)
            {
               wrap_max.zpp_inner._immutable = true;
            }
            else
            {
               wrap_max.zpp_inner._invalidate = mod_max;
            }
            wrap_max.zpp_inner._validate = dom_max;
         }
         return wrap_max;
      }
      
      public function dom_min() : void
      {
         if(_validate != null)
         {
            _validate();
         }
         wrap_min.zpp_inner.x = minx;
         wrap_min.zpp_inner.y = miny;
      }
      
      public function dom_max() : void
      {
         if(_validate != null)
         {
            _validate();
         }
         wrap_max.zpp_inner.x = maxx;
         wrap_max.zpp_inner.y = maxy;
      }
   }
}
