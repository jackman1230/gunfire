package nape.geom
{
   import flash.Boot;
   import flash.geom.Matrix;
   import zpp_nape.geom.ZPP_Mat23;
   import zpp_nape.geom.ZPP_Vec2;
   
   public class Mat23
   {
       
      
      public var zpp_inner:ZPP_Mat23;
      
      public function Mat23(param1:Number = 1.0, param2:Number = 0.0, param3:Number = 0.0, param4:Number = 1.0, param5:Number = 0.0, param6:Number = 0.0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = ZPP_Mat23.get();
         zpp_inner.outer = this;
         zpp_inner.a = param1;
         var _loc7_:ZPP_Mat23 = zpp_inner;
         if(_loc7_._invalidate != null)
         {
            _loc7_._invalidate();
         }
         zpp_inner.a;
         zpp_inner.b = param2;
         _loc7_ = zpp_inner;
         if(_loc7_._invalidate != null)
         {
            _loc7_._invalidate();
         }
         zpp_inner.b;
         zpp_inner.tx = param5;
         _loc7_ = zpp_inner;
         if(_loc7_._invalidate != null)
         {
            _loc7_._invalidate();
         }
         zpp_inner.tx;
         zpp_inner.c = param3;
         _loc7_ = zpp_inner;
         if(_loc7_._invalidate != null)
         {
            _loc7_._invalidate();
         }
         zpp_inner.c;
         zpp_inner.d = param4;
         _loc7_ = zpp_inner;
         if(_loc7_._invalidate != null)
         {
            _loc7_._invalidate();
         }
         zpp_inner.d;
         zpp_inner.ty = param6;
         _loc7_ = zpp_inner;
         if(_loc7_._invalidate != null)
         {
            _loc7_._invalidate();
         }
         zpp_inner.ty;
      }
      
      public static function fromMatrix(param1:Matrix) : Mat23
      {
         return new Mat23(param1.a,param1.c,param1.b,param1.d,param1.tx,param1.ty);
      }
      
      public static function rotation(param1:Number) : Mat23
      {
         var _loc2_:Number = Number(Math.cos(param1));
         var _loc3_:Number = Number(Math.sin(param1));
         return new Mat23(_loc2_,-_loc3_,_loc3_,_loc2_,0,0);
      }
      
      public static function translation(param1:Number, param2:Number) : Mat23
      {
         return new Mat23(1,0,0,1,param1,param2);
      }
      
      public static function scale(param1:Number, param2:Number) : Mat23
      {
         return new Mat23(param1,0,0,param2,0,0);
      }
      
      public function transpose() : Mat23
      {
         return new Mat23(zpp_inner.a,zpp_inner.c,zpp_inner.b,zpp_inner.d,zpp_inner.tx,zpp_inner.ty);
      }
      
      public function transform(param1:Vec2, param2:Boolean = false, param3:Boolean = false) : Vec2
      {
         var _loc4_:* = null as Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         if(param2)
         {
            _loc5_ = param1.zpp_inner;
            §§push(Vec2);
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc5_ = param1.zpp_inner;
            §§push(param1.zpp_inner.x * zpp_inner.a);
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc5_ = param1.zpp_inner;
            §§push(Number(§§pop() + param1.zpp_inner.y * zpp_inner.b));
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc5_ = param1.zpp_inner;
            §§push(param1.zpp_inner.x * zpp_inner.c);
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc4_ = §§pop().get(§§pop(),Number(§§pop() + param1.zpp_inner.y * zpp_inner.d),param3);
         }
         else
         {
            _loc5_ = param1.zpp_inner;
            §§push(Vec2);
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc5_ = param1.zpp_inner;
            §§push(param1.zpp_inner.x * zpp_inner.a);
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc5_ = param1.zpp_inner;
            §§push(Number(Number(§§pop() + param1.zpp_inner.y * zpp_inner.b) + zpp_inner.tx));
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc5_ = param1.zpp_inner;
            §§push(param1.zpp_inner.x * zpp_inner.c);
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc4_ = §§pop().get(§§pop(),Number(Number(§§pop() + param1.zpp_inner.y * zpp_inner.d) + zpp_inner.ty),param3);
         }
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc4_;
      }
      
      public function toString() : String
      {
         return "{ a: " + zpp_inner.a + " b: " + zpp_inner.b + " c: " + zpp_inner.c + " d: " + zpp_inner.d + " tx: " + zpp_inner.tx + " ty: " + zpp_inner.ty + " }";
      }
      
      public function toMatrix() : Matrix
      {
         return new Matrix(zpp_inner.a,zpp_inner.c,zpp_inner.b,zpp_inner.d,zpp_inner.tx,zpp_inner.ty);
      }
      
      public function singular() : Boolean
      {
         var _loc1_:Number = zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c;
         return _loc1_ * _loc1_ < 1.0e-8;
      }
      
      public function set ty(param1:Number) : Number
      {
         zpp_inner.ty = param1;
         var _loc2_:ZPP_Mat23 = zpp_inner;
         if(_loc2_._invalidate != null)
         {
            _loc2_._invalidate();
         }
         return zpp_inner.ty;
      }
      
      public function set tx(param1:Number) : Number
      {
         zpp_inner.tx = param1;
         var _loc2_:ZPP_Mat23 = zpp_inner;
         if(_loc2_._invalidate != null)
         {
            _loc2_._invalidate();
         }
         return zpp_inner.tx;
      }
      
      public function set d(param1:Number) : Number
      {
         zpp_inner.d = param1;
         var _loc2_:ZPP_Mat23 = zpp_inner;
         if(_loc2_._invalidate != null)
         {
            _loc2_._invalidate();
         }
         return zpp_inner.d;
      }
      
      public function set c(param1:Number) : Number
      {
         zpp_inner.c = param1;
         var _loc2_:ZPP_Mat23 = zpp_inner;
         if(_loc2_._invalidate != null)
         {
            _loc2_._invalidate();
         }
         return zpp_inner.c;
      }
      
      public function set b(param1:Number) : Number
      {
         zpp_inner.b = param1;
         var _loc2_:ZPP_Mat23 = zpp_inner;
         if(_loc2_._invalidate != null)
         {
            _loc2_._invalidate();
         }
         return zpp_inner.b;
      }
      
      public function set a(param1:Number) : Number
      {
         zpp_inner.a = param1;
         var _loc2_:ZPP_Mat23 = zpp_inner;
         if(_loc2_._invalidate != null)
         {
            _loc2_._invalidate();
         }
         return zpp_inner.a;
      }
      
      public function setAs(param1:Number = 1.0, param2:Number = 0.0, param3:Number = 0.0, param4:Number = 1.0, param5:Number = 0.0, param6:Number = 0.0) : void
      {
         zpp_inner.setas(param1,param2,param3,param4,param5,param6);
         var _loc7_:ZPP_Mat23 = zpp_inner;
         if(_loc7_._invalidate != null)
         {
            _loc7_._invalidate();
         }
      }
      
      public function set(param1:Mat23) : void
      {
         var _loc2_:ZPP_Mat23 = param1.zpp_inner;
         zpp_inner.setas(_loc2_.a,_loc2_.b,_loc2_.c,_loc2_.d,_loc2_.tx,_loc2_.ty);
         _loc2_ = zpp_inner;
         if(_loc2_._invalidate != null)
         {
            _loc2_._invalidate();
         }
      }
      
      public function reset() : void
      {
         setAs();
      }
      
      public function orthogonalise() : Mat23
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:int = 0;
         var _loc4_:* = null as Mat23;
         var _loc5_:* = null as ZPP_Mat23;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         if(!orthogonal())
         {
            _loc1_ = Number(Math.sqrt(Number(zpp_inner.a * zpp_inner.a + zpp_inner.c * zpp_inner.c)));
            _loc2_ = Number(Math.sqrt(Number(zpp_inner.b * zpp_inner.b + zpp_inner.d * zpp_inner.d)));
            _loc3_ = 1;
            _loc1_ = _loc3_ / _loc1_;
            _loc2_ = _loc3_ / _loc2_;
            _loc4_ = this;
            _loc4_.zpp_inner.a = _loc4_.zpp_inner.a * _loc1_;
            _loc5_ = _loc4_.zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            _loc4_.zpp_inner.a;
            _loc4_ = this;
            _loc4_.zpp_inner.c = _loc4_.zpp_inner.c * _loc1_;
            _loc5_ = _loc4_.zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            _loc4_.zpp_inner.c;
            _loc4_ = this;
            _loc4_.zpp_inner.b = _loc4_.zpp_inner.b * _loc2_;
            _loc5_ = _loc4_.zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            _loc4_.zpp_inner.b;
            _loc4_ = this;
            _loc4_.zpp_inner.d = _loc4_.zpp_inner.d * _loc2_;
            _loc5_ = _loc4_.zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            _loc4_.zpp_inner.d;
            _loc6_ = Number(zpp_inner.a * zpp_inner.b + zpp_inner.c * zpp_inner.d);
            _loc7_ = 0.25 * Math.PI - 0.5 * Math.acos(_loc6_ / (_loc3_ * _loc3_));
            if(zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c > 0)
            {
               _loc7_ = -_loc7_;
            }
            _loc8_ = Number(Math.sin(_loc7_));
            _loc9_ = Number(Math.cos(_loc7_));
            _loc10_ = zpp_inner.a * _loc9_ - zpp_inner.c * _loc8_;
            _loc11_ = Number(zpp_inner.b * _loc9_ + zpp_inner.d * _loc8_);
            zpp_inner.c = Number(zpp_inner.c * _loc9_ + zpp_inner.a * _loc8_);
            _loc5_ = zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            zpp_inner.c;
            zpp_inner.a = _loc10_;
            _loc5_ = zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            zpp_inner.a;
            zpp_inner.d = zpp_inner.d * _loc9_ - zpp_inner.b * _loc8_;
            _loc5_ = zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            zpp_inner.d;
            zpp_inner.b = _loc11_;
            _loc5_ = zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            zpp_inner.b;
            _loc5_ = zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
         }
         return this;
      }
      
      public function orthogonal() : Boolean
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc1_:Number = Number(zpp_inner.a * zpp_inner.b + zpp_inner.c * zpp_inner.d);
         if(_loc1_ * _loc1_ < 1.0e-8)
         {
            _loc2_ = Number(zpp_inner.a * zpp_inner.a + zpp_inner.b * zpp_inner.b) - 1;
            _loc3_ = Number(zpp_inner.c * zpp_inner.c + zpp_inner.d * zpp_inner.d) - 1;
            return _loc2_ * _loc2_ < 1.0e-8 && _loc3_ * _loc3_ < 1.0e-8;
         }
         return false;
      }
      
      public function inverseTransform(param1:Vec2, param2:Boolean = false, param3:Boolean = false) : Vec2
      {
         var _loc5_:* = null as Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc4_:Number = 1 / (zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c);
         if(param2)
         {
            _loc6_ = param1.zpp_inner;
            §§push(Vec2);
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc6_ = param1.zpp_inner;
            §§push(param1.zpp_inner.x * zpp_inner.d);
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc6_ = param1.zpp_inner;
            §§push((§§pop() - param1.zpp_inner.y * zpp_inner.b) * _loc4_);
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc6_ = param1.zpp_inner;
            §§push(param1.zpp_inner.y * zpp_inner.a);
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc5_ = §§pop().get(§§pop(),(§§pop() - param1.zpp_inner.x * zpp_inner.c) * _loc4_,param3);
         }
         else
         {
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc7_ = param1.zpp_inner.x - zpp_inner.tx;
            _loc6_ = param1.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            _loc8_ = param1.zpp_inner.y - zpp_inner.ty;
            _loc5_ = Vec2.get((_loc7_ * zpp_inner.d - _loc8_ * zpp_inner.b) * _loc4_,(_loc8_ * zpp_inner.a - _loc7_ * zpp_inner.c) * _loc4_,param3);
         }
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc5_;
      }
      
      public function inverse() : Mat23
      {
         var _loc1_:Number = 1 / (zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c);
         return new Mat23(zpp_inner.d * _loc1_,-zpp_inner.b * _loc1_,-zpp_inner.c * _loc1_,zpp_inner.a * _loc1_,(zpp_inner.b * zpp_inner.ty - zpp_inner.d * zpp_inner.tx) * _loc1_,(zpp_inner.c * zpp_inner.tx - zpp_inner.a * zpp_inner.ty) * _loc1_);
      }
      
      public function get ty() : Number
      {
         return zpp_inner.ty;
      }
      
      public function get tx() : Number
      {
         return zpp_inner.tx;
      }
      
      public function get determinant() : Number
      {
         return zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c;
      }
      
      public function get d() : Number
      {
         return zpp_inner.d;
      }
      
      public function get c() : Number
      {
         return zpp_inner.c;
      }
      
      public function get b() : Number
      {
         return zpp_inner.b;
      }
      
      public function get a() : Number
      {
         return zpp_inner.a;
      }
      
      public function equiorthogonalise() : Mat23
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:* = null as Mat23;
         var _loc5_:* = null as ZPP_Mat23;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         if(!equiorthogonal())
         {
            _loc1_ = Number(Math.sqrt(Number(zpp_inner.a * zpp_inner.a + zpp_inner.c * zpp_inner.c)));
            _loc2_ = Number(Math.sqrt(Number(zpp_inner.b * zpp_inner.b + zpp_inner.d * zpp_inner.d)));
            _loc3_ = (_loc1_ + _loc2_) / 2;
            _loc1_ = _loc3_ / _loc1_;
            _loc2_ = _loc3_ / _loc2_;
            _loc4_ = this;
            _loc4_.zpp_inner.a = _loc4_.zpp_inner.a * _loc1_;
            _loc5_ = _loc4_.zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            _loc4_.zpp_inner.a;
            _loc4_ = this;
            _loc4_.zpp_inner.c = _loc4_.zpp_inner.c * _loc1_;
            _loc5_ = _loc4_.zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            _loc4_.zpp_inner.c;
            _loc4_ = this;
            _loc4_.zpp_inner.b = _loc4_.zpp_inner.b * _loc2_;
            _loc5_ = _loc4_.zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            _loc4_.zpp_inner.b;
            _loc4_ = this;
            _loc4_.zpp_inner.d = _loc4_.zpp_inner.d * _loc2_;
            _loc5_ = _loc4_.zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            _loc4_.zpp_inner.d;
            _loc6_ = Number(zpp_inner.a * zpp_inner.b + zpp_inner.c * zpp_inner.d);
            _loc7_ = 0.25 * Math.PI - 0.5 * Math.acos(_loc6_ / (_loc3_ * _loc3_));
            if(zpp_inner.a * zpp_inner.d - zpp_inner.b * zpp_inner.c > 0)
            {
               _loc7_ = -_loc7_;
            }
            _loc8_ = Number(Math.sin(_loc7_));
            _loc9_ = Number(Math.cos(_loc7_));
            _loc10_ = zpp_inner.a * _loc9_ - zpp_inner.c * _loc8_;
            _loc11_ = Number(zpp_inner.b * _loc9_ + zpp_inner.d * _loc8_);
            zpp_inner.c = Number(zpp_inner.c * _loc9_ + zpp_inner.a * _loc8_);
            _loc5_ = zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            zpp_inner.c;
            zpp_inner.a = _loc10_;
            _loc5_ = zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            zpp_inner.a;
            zpp_inner.d = zpp_inner.d * _loc9_ - zpp_inner.b * _loc8_;
            _loc5_ = zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            zpp_inner.d;
            zpp_inner.b = _loc11_;
            _loc5_ = zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
            zpp_inner.b;
            _loc5_ = zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate();
            }
         }
         return this;
      }
      
      public function equiorthogonal() : Boolean
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         if(singular())
         {
            return false;
         }
         _loc1_ = Number(zpp_inner.a * zpp_inner.b + zpp_inner.c * zpp_inner.d);
         if(_loc1_ * _loc1_ < 1.0e-8)
         {
            _loc2_ = zpp_inner.a * zpp_inner.a + zpp_inner.b * zpp_inner.b - zpp_inner.c * zpp_inner.c - zpp_inner.d * zpp_inner.d;
            return _loc2_ * _loc2_ < 1.0e-8;
         }
         return false;
      }
      
      public function copy() : Mat23
      {
         return new Mat23(zpp_inner.a,zpp_inner.b,zpp_inner.c,zpp_inner.d,zpp_inner.tx,zpp_inner.ty);
      }
      
      public function concat(param1:Mat23) : Mat23
      {
         return new Mat23(Number(param1.zpp_inner.a * zpp_inner.a + param1.zpp_inner.b * zpp_inner.c),Number(param1.zpp_inner.a * zpp_inner.b + param1.zpp_inner.b * zpp_inner.d),Number(param1.zpp_inner.c * zpp_inner.a + param1.zpp_inner.d * zpp_inner.c),Number(param1.zpp_inner.c * zpp_inner.b + param1.zpp_inner.d * zpp_inner.d),Number(Number(param1.zpp_inner.a * zpp_inner.tx + param1.zpp_inner.b * zpp_inner.ty) + param1.zpp_inner.tx),Number(Number(param1.zpp_inner.c * zpp_inner.tx + param1.zpp_inner.d * zpp_inner.ty) + param1.zpp_inner.ty));
      }
   }
}
