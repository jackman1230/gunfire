package zpp_nape.shape
{
   import flash.Boot;
   import nape.geom.Mat23;
   import nape.geom.Vec2;
   import nape.shape.Circle;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_Circle extends ZPP_Shape
   {
       
      
      public var radius:Number;
      
      public var outer_zn:Circle;
      
      public function ZPP_Circle()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(ZPP_Flags.id_ShapeType_CIRCLE);
         circle = this;
         zip_localCOM = false;
      }
      
      public function setupLocalCOM() : void
      {
         wrap_localCOM = Vec2.get(localCOMx,localCOMy);
         wrap_localCOM.zpp_inner._inuse = true;
         wrap_localCOM.zpp_inner._validate = localCOM_validate;
         wrap_localCOM.zpp_inner._invalidate = localCOM_invalidate;
      }
      
      public function localCOM_validate() : void
      {
         wrap_localCOM.zpp_inner.x = localCOMx;
         wrap_localCOM.zpp_inner.y = localCOMy;
      }
      
      public function localCOM_invalidate(param1:ZPP_Vec2) : void
      {
         localCOMx = param1.x;
         localCOMy = param1.y;
         invalidate_localCOM();
         if(body != null)
         {
            body.wake();
         }
      }
      
      public function invalidate_radius() : void
      {
         invalidate_area_inertia();
         invalidate_angDrag();
         invalidate_aabb();
         if(body != null)
         {
            body.wake();
         }
      }
      
      public function __validate_area_inertia() : void
      {
         var _loc1_:Number = radius * radius;
         area = _loc1_ * Math.PI;
         inertia = Number(_loc1_ * 0.5 + (Number(localCOMx * localCOMx + localCOMy * localCOMy)));
      }
      
      public function __validate_angDrag() : void
      {
         var _loc1_:Number = Number(localCOMx * localCOMx + localCOMy * localCOMy);
         var _loc2_:Number = radius * radius;
         var _loc3_:Number = material.dynamicFriction * 2.5;
         angDrag = Number((_loc1_ + 2 * _loc2_) * _loc3_ + 75 * _loc1_);
         angDrag = angDrag / (2 * (_loc1_ + 0.5 * _loc2_));
      }
      
      public function __translate(param1:Number, param2:Number) : void
      {
         localCOMx = Number(localCOMx + param1 * 1);
         localCOMy = Number(localCOMy + param2 * 1);
         invalidate_localCOM();
      }
      
      public function __transform(param1:Mat23) : void
      {
         var _loc2_:Number = param1.zpp_inner.a * param1.zpp_inner.d - param1.zpp_inner.b * param1.zpp_inner.c;
         if(_loc2_ < 0)
         {
            _loc2_ = -_loc2_;
         }
         radius = radius * Math.sqrt(_loc2_);
         var _loc3_:Number = Number(Number(param1.zpp_inner.a * localCOMx + param1.zpp_inner.b * localCOMy) + param1.zpp_inner.tx);
         localCOMy = Number(Number(param1.zpp_inner.c * localCOMx + param1.zpp_inner.d * localCOMy) + param1.zpp_inner.ty);
         localCOMx = _loc3_;
         invalidate_radius();
         invalidate_localCOM();
      }
      
      public function __scale(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = ((param1 < 0?-param1:param1) + (param2 < 0?-param2:param2)) / 2;
         radius = radius * (_loc3_ < 0?-_loc3_:_loc3_);
         invalidate_radius();
         if(Number(localCOMx * localCOMx + localCOMy * localCOMy) > 0)
         {
            localCOMx = localCOMx * param1;
            localCOMy = localCOMy * param2;
            invalidate_localCOM();
         }
      }
      
      public function __rotate(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(Number(localCOMx * localCOMx + localCOMy * localCOMy) > 0)
         {
            _loc3_ = param2 * localCOMx - param1 * localCOMy;
            _loc4_ = Number(localCOMx * param1 + localCOMy * param2);
            localCOMx = _loc3_;
            localCOMy = _loc4_;
            invalidate_localCOM();
         }
      }
      
      public function __copy() : ZPP_Circle
      {
         var _loc1_:ZPP_Circle = new Circle(radius).zpp_inner_zn;
         _loc1_.localCOMx = localCOMx;
         _loc1_.localCOMy = localCOMy;
         _loc1_.zip_localCOM = false;
         return _loc1_;
      }
      
      public function __clear() : void
      {
      }
   }
}
