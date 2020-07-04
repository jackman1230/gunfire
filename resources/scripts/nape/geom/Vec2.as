package nape.geom
{
   import flash.Boot;
   import flash.geom.Point;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.util.ZPP_PubPool;
   
   public class Vec2
   {
       
      
      public var zpp_pool:Vec2;
      
      public var zpp_inner:ZPP_Vec2;
      
      public function Vec2(param1:Number = 0, param2:Number = 0)
      {
         var _loc4_:* = null as ZPP_Vec2;
         if(Boot.skip_constructor)
         {
            return;
         }
         §§push();
         if(ZPP_Vec2.zpp_pool == null)
         {
            _loc4_ = new ZPP_Vec2();
         }
         else
         {
            _loc4_ = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc4_.next;
            _loc4_.next = null;
         }
         _loc4_.weak = false;
         _loc4_._immutable = false;
         _loc4_.x = param1;
         _loc4_.y = param2;
         §§pop().zpp_inner = _loc4_;
         zpp_inner.outer = this;
      }
      
      public static function weak(param1:Number = 0, param2:Number = 0) : Vec2
      {
         return Vec2.get(param1,param2,true);
      }
      
      public static function get(param1:Number = 0, param2:Number = 0, param3:Boolean = false) : Vec2
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZPP_Vec2;
         if(ZPP_PubPool.poolVec2 == null)
         {
            _loc4_ = new Vec2();
         }
         else
         {
            _loc4_ = ZPP_PubPool.poolVec2;
            ZPP_PubPool.poolVec2 = _loc4_.zpp_pool;
            _loc4_.zpp_pool = null;
         }
         if(_loc4_.zpp_inner == null)
         {
            _loc5_ = false;
            §§push(_loc4_);
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
            _loc6_._immutable = _loc5_;
            _loc6_.x = param1;
            _loc6_.y = param2;
            §§pop().zpp_inner = _loc6_;
            _loc4_.zpp_inner.outer = _loc4_;
         }
         else
         {
            _loc6_ = _loc4_.zpp_inner;
            §§push(false);
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            if(_loc4_.zpp_inner.x == param1)
            {
               §§pop();
               _loc6_ = _loc4_.zpp_inner;
               if(_loc6_._validate != null)
               {
                  _loc6_._validate();
               }
               §§push(_loc4_.zpp_inner.y == param2);
            }
            if(!§§pop())
            {
               _loc4_.zpp_inner.x = param1;
               _loc4_.zpp_inner.y = param2;
               _loc6_ = _loc4_.zpp_inner;
               if(_loc6_._invalidate != null)
               {
                  _loc6_._invalidate(_loc6_);
               }
            }
            _loc4_;
         }
         _loc4_.zpp_inner.weak = param3;
         return _loc4_;
      }
      
      public static function fromPoint(param1:Point, param2:Boolean = false) : Vec2
      {
         return Vec2.get(param1.x,param1.y,param2);
      }
      
      public static function fromPolar(param1:Number, param2:Number, param3:Boolean = false) : Vec2
      {
         return Vec2.get(param1 * Math.cos(param2),param1 * Math.sin(param2),param3);
      }
      
      public function toString() : String
      {
         var _loc1_:ZPP_Vec2 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.toString();
      }
      
      public function subeq(param1:Vec2) : Vec2
      {
         var _loc4_:* = null as ZPP_Vec2;
         _loc4_ = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner.x);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc3_:Number = §§pop() - param1.zpp_inner.x;
         _loc4_ = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner.y);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc5_:Number = §§pop() - param1.zpp_inner.y;
         _loc4_ = zpp_inner;
         §§push(false);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         if(zpp_inner.x == _loc3_)
         {
            §§pop();
            _loc4_ = zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            §§push(zpp_inner.y == _loc5_);
         }
         if(!§§pop())
         {
            zpp_inner.x = _loc3_;
            zpp_inner.y = _loc5_;
            _loc4_ = zpp_inner;
            if(_loc4_._invalidate != null)
            {
               _loc4_._invalidate(_loc4_);
            }
         }
         var _loc2_:Vec2 = this;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc2_;
      }
      
      public function sub(param1:Vec2, param2:Boolean = false) : Vec2
      {
         var _loc4_:ZPP_Vec2 = zpp_inner;
         §§push(Vec2);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner.x);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc4_ = zpp_inner;
         §§push(§§pop() - param1.zpp_inner.x);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner.y);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc3_:Vec2 = §§pop().get(§§pop(),§§pop() - param1.zpp_inner.y,param2);
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc3_;
      }
      
      public function setxy(param1:Number, param2:Number) : Vec2
      {
         var _loc3_:* = null as ZPP_Vec2;
         _loc3_ = zpp_inner;
         §§push(false);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(zpp_inner.x == param1)
         {
            §§pop();
            _loc3_ = zpp_inner;
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            §§push(zpp_inner.y == param2);
         }
         if(!§§pop())
         {
            zpp_inner.x = param1;
            zpp_inner.y = param2;
            _loc3_ = zpp_inner;
            if(_loc3_._invalidate != null)
            {
               _loc3_._invalidate(_loc3_);
            }
         }
         return this;
      }
      
      public function set y(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_Vec2;
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(zpp_inner.y != param1)
         {
            zpp_inner.y = param1;
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
         return zpp_inner.y;
      }
      
      public function set x(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_Vec2;
         _loc2_ = zpp_inner;
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         if(zpp_inner.x != param1)
         {
            zpp_inner.x = param1;
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
         return zpp_inner.x;
      }
      
      public function set length(param1:Number) : Number
      {
         var _loc3_:* = null as ZPP_Vec2;
         _loc3_ = zpp_inner;
         §§push(param1);
         §§push(Math);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         §§push(zpp_inner.x);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         §§push(§§pop() * zpp_inner.x);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         §§push(zpp_inner.y);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc2_:Number = §§pop() / §§pop().sqrt(Number(§§pop() + §§pop() * zpp_inner.y));
         var _loc4_:Vec2 = this;
         _loc3_ = _loc4_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc5_:Number = _loc4_.zpp_inner.x * _loc2_;
         _loc3_ = _loc4_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(_loc4_.zpp_inner.x != _loc5_)
         {
            _loc4_.zpp_inner.x = _loc5_;
            _loc3_ = _loc4_.zpp_inner;
            if(_loc3_._invalidate != null)
            {
               _loc3_._invalidate(_loc3_);
            }
         }
         _loc3_ = _loc4_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc4_.zpp_inner.x;
         _loc4_ = this;
         _loc3_ = _loc4_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc5_ = _loc4_.zpp_inner.y * _loc2_;
         _loc3_ = _loc4_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(_loc4_.zpp_inner.y != _loc5_)
         {
            _loc4_.zpp_inner.y = _loc5_;
            _loc3_ = _loc4_.zpp_inner;
            if(_loc3_._invalidate != null)
            {
               _loc3_._invalidate(_loc3_);
            }
         }
         _loc3_ = _loc4_.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc4_.zpp_inner.y;
         _loc3_ = zpp_inner;
         if(_loc3_._invalidate != null)
         {
            _loc3_._invalidate(_loc3_);
         }
         _loc3_ = zpp_inner;
         §§push(Math);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         §§push(zpp_inner.x);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         §§push(§§pop() * zpp_inner.x);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         §§push(zpp_inner.y);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         return Number(§§pop().sqrt(Number(§§pop() + §§pop() * zpp_inner.y)));
      }
      
      public function set angle(param1:Number) : Number
      {
         var _loc3_:* = null as ZPP_Vec2;
         _loc3_ = zpp_inner;
         §§push(Math);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         §§push(zpp_inner.x);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         §§push(§§pop() * zpp_inner.x);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         §§push(zpp_inner.y);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc2_:Number = Number(§§pop().sqrt(Number(§§pop() + §§pop() * zpp_inner.y)));
         var _loc4_:Number = _loc2_ * Math.cos(param1);
         var _loc5_:Number = _loc2_ * Math.sin(param1);
         _loc3_ = zpp_inner;
         §§push(false);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(zpp_inner.x == _loc4_)
         {
            §§pop();
            _loc3_ = zpp_inner;
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            §§push(zpp_inner.y == _loc5_);
         }
         if(!§§pop())
         {
            zpp_inner.x = _loc4_;
            zpp_inner.y = _loc5_;
            _loc3_ = zpp_inner;
            if(_loc3_._invalidate != null)
            {
               _loc3_._invalidate(_loc3_);
            }
         }
         this;
         _loc3_ = zpp_inner;
         §§push(false);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         §§push(zpp_inner.x);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(§§pop() == zpp_inner.y)
         {
            §§pop();
            _loc3_ = zpp_inner;
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            §§push(zpp_inner.x == 0);
         }
         if(§§pop())
         {
            §§push(0);
         }
         else
         {
            _loc3_ = zpp_inner;
            §§push(Math);
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            _loc3_ = zpp_inner;
            §§push(zpp_inner.y);
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            §§push(Number(§§pop().atan2(§§pop(),zpp_inner.x)));
         }
         return §§pop();
      }
      
      public function set(param1:Vec2) : Vec2
      {
         var _loc4_:* = null as ZPP_Vec2;
         _loc4_ = param1.zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc3_:Number = param1.zpp_inner.x;
         _loc4_ = param1.zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc5_:Number = param1.zpp_inner.y;
         _loc4_ = zpp_inner;
         §§push(false);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         if(zpp_inner.x == _loc3_)
         {
            §§pop();
            _loc4_ = zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            §§push(zpp_inner.y == _loc5_);
         }
         if(!§§pop())
         {
            zpp_inner.x = _loc3_;
            zpp_inner.y = _loc5_;
            _loc4_ = zpp_inner;
            if(_loc4_._invalidate != null)
            {
               _loc4_._invalidate(_loc4_);
            }
         }
         var _loc2_:Vec2 = this;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc2_;
      }
      
      public function rotate(param1:Number) : Vec2
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:* = null as ZPP_Vec2;
         if(param1 % (Math.PI * 2) != 0)
         {
            _loc2_ = Number(Math.sin(param1));
            _loc3_ = Number(Math.cos(param1));
            _loc4_ = _loc3_ * zpp_inner.x - _loc2_ * zpp_inner.y;
            zpp_inner.y = Number(zpp_inner.x * _loc2_ + zpp_inner.y * _loc3_);
            zpp_inner.x = _loc4_;
            _loc5_ = zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate(_loc5_);
            }
         }
         return this;
      }
      
      public function perp(param1:Boolean = false) : Vec2
      {
         var _loc2_:ZPP_Vec2 = zpp_inner;
         §§push(Vec2);
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc2_ = zpp_inner;
         §§push(-zpp_inner.y);
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return §§pop().get(§§pop(),zpp_inner.x,param1);
      }
      
      public function muleq(param1:Number) : Vec2
      {
         var _loc3_:* = null as ZPP_Vec2;
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc2_:Number = zpp_inner.x * param1;
         _loc3_ = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc4_:Number = zpp_inner.y * param1;
         _loc3_ = zpp_inner;
         §§push(false);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         if(zpp_inner.x == _loc2_)
         {
            §§pop();
            _loc3_ = zpp_inner;
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            §§push(zpp_inner.y == _loc4_);
         }
         if(!§§pop())
         {
            zpp_inner.x = _loc2_;
            zpp_inner.y = _loc4_;
            _loc3_ = zpp_inner;
            if(_loc3_._invalidate != null)
            {
               _loc3_._invalidate(_loc3_);
            }
         }
         return this;
      }
      
      public function mul(param1:Number, param2:Boolean = false) : Vec2
      {
         var _loc3_:ZPP_Vec2 = zpp_inner;
         §§push(Vec2);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         §§push(zpp_inner.x * param1);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         return §§pop().get(§§pop(),zpp_inner.y * param1,param2);
      }
      
      public function lsq() : Number
      {
         var _loc1_:ZPP_Vec2 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         §§push(zpp_inner.x);
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         §§push(§§pop() * zpp_inner.x);
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         §§push(zpp_inner.y);
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return Number(§§pop() + §§pop() * zpp_inner.y);
      }
      
      public function get y() : Number
      {
         var _loc1_:ZPP_Vec2 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.y;
      }
      
      public function get x() : Number
      {
         var _loc1_:ZPP_Vec2 = zpp_inner;
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return zpp_inner.x;
      }
      
      public function get length() : Number
      {
         var _loc1_:ZPP_Vec2 = zpp_inner;
         §§push(Math);
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         §§push(zpp_inner.x);
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         §§push(§§pop() * zpp_inner.x);
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         §§push(zpp_inner.y);
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return Number(§§pop().sqrt(Number(§§pop() + §§pop() * zpp_inner.y)));
      }
      
      public function get angle() : Number
      {
         var _loc1_:* = null as ZPP_Vec2;
         _loc1_ = zpp_inner;
         §§push(false);
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         §§push(zpp_inner.x);
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         if(§§pop() == zpp_inner.y)
         {
            §§pop();
            _loc1_ = zpp_inner;
            if(_loc1_._validate != null)
            {
               _loc1_._validate();
            }
            §§push(zpp_inner.x == 0);
         }
         if(§§pop())
         {
            return 0;
         }
         _loc1_ = zpp_inner;
         §§push(Math);
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         _loc1_ = zpp_inner;
         §§push(zpp_inner.y);
         if(_loc1_._validate != null)
         {
            _loc1_._validate();
         }
         return Number(§§pop().atan2(§§pop(),zpp_inner.x));
      }
      
      public function dot(param1:Vec2) : Number
      {
         var _loc3_:ZPP_Vec2 = zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = param1.zpp_inner;
         §§push(zpp_inner.x);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         §§push(§§pop() * param1.zpp_inner.x);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = param1.zpp_inner;
         §§push(zpp_inner.y);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc2_:Number = Number(§§pop() + §§pop() * param1.zpp_inner.y);
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc2_;
      }
      
      public function dispose() : void
      {
         var _loc1_:ZPP_Vec2 = zpp_inner;
         zpp_inner.outer = null;
         zpp_inner = null;
         var _loc2_:Vec2 = this;
         _loc2_.zpp_pool = ZPP_PubPool.poolVec2;
         ZPP_PubPool.poolVec2 = _loc2_;
         var _loc3_:ZPP_Vec2 = _loc1_;
         if(_loc3_.outer != null)
         {
            _loc3_.outer.zpp_inner = null;
            _loc3_.outer = null;
         }
         _loc3_._isimmutable = null;
         _loc3_._validate = null;
         _loc3_._invalidate = null;
         _loc3_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc3_;
      }
      
      public function cross(param1:Vec2) : Number
      {
         var _loc3_:ZPP_Vec2 = param1.zpp_inner;
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         §§push(param1.zpp_inner.y);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = param1.zpp_inner;
         §§push(§§pop() * zpp_inner.x);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = zpp_inner;
         §§push(param1.zpp_inner.x);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc2_:Number = §§pop() - §§pop() * zpp_inner.y;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc2_;
      }
      
      public function copy(param1:Boolean = false) : Vec2
      {
         var _loc2_:ZPP_Vec2 = zpp_inner;
         §§push(Vec2);
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         _loc2_ = zpp_inner;
         §§push(zpp_inner.x);
         if(_loc2_._validate != null)
         {
            _loc2_._validate();
         }
         return §§pop().get(§§pop(),zpp_inner.y,param1);
      }
      
      public function addeq(param1:Vec2) : Vec2
      {
         var _loc4_:* = null as ZPP_Vec2;
         _loc4_ = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner.x);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc3_:Number = Number(§§pop() + param1.zpp_inner.x);
         _loc4_ = zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner.y);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc5_:Number = Number(§§pop() + param1.zpp_inner.y);
         _loc4_ = zpp_inner;
         §§push(false);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         if(zpp_inner.x == _loc3_)
         {
            §§pop();
            _loc4_ = zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            §§push(zpp_inner.y == _loc5_);
         }
         if(!§§pop())
         {
            zpp_inner.x = _loc3_;
            zpp_inner.y = _loc5_;
            _loc4_ = zpp_inner;
            if(_loc4_._invalidate != null)
            {
               _loc4_._invalidate(_loc4_);
            }
         }
         var _loc2_:Vec2 = this;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc2_;
      }
      
      public function add(param1:Vec2, param2:Boolean = false) : Vec2
      {
         var _loc4_:ZPP_Vec2 = zpp_inner;
         §§push(Vec2);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner.x);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc4_ = zpp_inner;
         §§push(Number(§§pop() + param1.zpp_inner.x));
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner.y);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc3_:Vec2 = §§pop().get(§§pop(),Number(§§pop() + param1.zpp_inner.y),param2);
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc3_;
      }
   }
}
