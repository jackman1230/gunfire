package nape.geom
{
   import flash.Boot;
   import flash.geom.Rectangle;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Vec2;
   
   public class AABB
   {
       
      
      public var zpp_inner:ZPP_AABB;
      
      public function AABB(param1:Number = 0, param2:Number = 0, param3:Number = 0, param4:Number = 0)
      {
         var _loc5_:* = null as ZPP_AABB;
         if(Boot.skip_constructor)
         {
            return;
         }
         §§push();
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
         _loc5_.maxx = Number(param1 + param3);
         _loc5_.maxy = Number(param2 + param4);
         §§pop().zpp_inner = _loc5_;
         zpp_inner.outer = this;
      }
      
      public static function fromRect(param1:Rectangle) : AABB
      {
         return new AABB(param1.x,param1.y,param1.width,param1.height);
      }
      
      public function toString() : String
      {
         var _loc1_:ZPP_AABB = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.toString();
      }
      
      public function set y(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_AABB;
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(zpp_inner.miny != param1)
         {
            zpp_inner.maxy = Number(zpp_inner.maxy + (param1 - zpp_inner.miny));
            zpp_inner.miny = param1;
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return zpp_inner.miny;
      }
      
      public function set x(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_AABB;
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(zpp_inner.minx != param1)
         {
            zpp_inner.maxx = Number(zpp_inner.maxx + (param1 - zpp_inner.minx));
            zpp_inner.minx = param1;
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return zpp_inner.minx;
      }
      
      public function set width(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_AABB;
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc2_ = zpp_inner;
         if(_loc2_.maxx - _loc2_.minx != param1)
         {
            _loc2_ = zpp_inner;
            §§push(zpp_inner);
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            §§pop().maxx = Number(zpp_inner.minx + param1);
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc2_ = zpp_inner;
         return _loc2_.maxx - _loc2_.minx;
      }
      
      public function set min(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc2_:Vec2 = zpp_inner.getmin();
         _loc5_ = param1.zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         var _loc4_:Number = param1.zpp_inner.x;
         _loc5_ = param1.zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         var _loc6_:Number = param1.zpp_inner.y;
         _loc5_ = _loc2_.zpp_inner;
         §§push(false);
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         if(_loc2_.zpp_inner.x == _loc4_)
         {
            §§pop();
            _loc5_ = _loc2_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§push(_loc2_.zpp_inner.y == _loc6_);
         }
         if(!§§pop())
         {
            _loc2_.zpp_inner.x = _loc4_;
            _loc2_.zpp_inner.y = _loc6_;
            _loc5_ = _loc2_.zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate(_loc5_);
            }
         }
         var _loc3_:Vec2 = _loc2_;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         _loc3_;
         return zpp_inner.getmin();
      }
      
      public function set max(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc2_:Vec2 = zpp_inner.getmax();
         _loc5_ = param1.zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         var _loc4_:Number = param1.zpp_inner.x;
         _loc5_ = param1.zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         var _loc6_:Number = param1.zpp_inner.y;
         _loc5_ = _loc2_.zpp_inner;
         §§push(false);
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         if(_loc2_.zpp_inner.x == _loc4_)
         {
            §§pop();
            _loc5_ = _loc2_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§push(_loc2_.zpp_inner.y == _loc6_);
         }
         if(!§§pop())
         {
            _loc2_.zpp_inner.x = _loc4_;
            _loc2_.zpp_inner.y = _loc6_;
            _loc5_ = _loc2_.zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate(_loc5_);
            }
         }
         var _loc3_:Vec2 = _loc2_;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         _loc3_;
         return zpp_inner.getmax();
      }
      
      public function set height(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_AABB;
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc2_ = zpp_inner;
         if(_loc2_.maxy - _loc2_.miny != param1)
         {
            _loc2_ = zpp_inner;
            §§push(zpp_inner);
            if(_loc2_._validate != null)
            {
               _loc2_._validate();
            }
            §§pop().maxy = Number(zpp_inner.miny + param1);
            _loc2_ = zpp_inner;
            if(_loc2_._invalidate != null)
            {
               _loc2_._invalidate(_loc2_);
            }
         }
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc2_ = zpp_inner;
         return _loc2_.maxy - _loc2_.miny;
      }
      
      public function get y() : Number
      {
         var _loc1_:ZPP_AABB = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.miny;
      }
      
      public function get x() : Number
      {
         var _loc1_:ZPP_AABB = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.minx;
      }
      
      public function get width() : Number
      {
         var _loc1_:ZPP_AABB = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         return _loc1_.maxx - _loc1_.minx;
      }
      
      public function get min() : Vec2
      {
         return zpp_inner.getmin();
      }
      
      public function get max() : Vec2
      {
         return zpp_inner.getmax();
      }
      
      public function get height() : Number
      {
         var _loc1_:ZPP_AABB = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         return _loc1_.maxy - _loc1_.miny;
      }
      
      public function copy() : AABB
      {
         var _loc2_:* = null as ZPP_AABB;
         var _loc1_:ZPP_AABB = zpp_inner;
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc2_ = new ZPP_AABB();
         }
         else
         {
            _loc2_ = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc2_.next;
            _loc2_.next = null;
         }
         null;
         _loc2_.minx = _loc1_.minx;
         _loc2_.miny = _loc1_.miny;
         _loc2_.maxx = _loc1_.maxx;
         _loc2_.maxy = _loc1_.maxy;
         return _loc2_.wrapper();
      }
   }
}
