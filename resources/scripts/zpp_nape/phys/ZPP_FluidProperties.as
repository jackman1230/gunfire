package zpp_nape.phys
{
   import flash.Boot;
   import nape.geom.Vec2;
   import nape.phys.FluidProperties;
   import nape.shape.ShapeList;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZNPList_ZPP_Shape;
   import zpp_nape.util.ZNPNode_ZPP_Shape;
   
   public class ZPP_FluidProperties
   {
      
      public static var zpp_pool:ZPP_FluidProperties;
       
      
      public var wrap_shapes:ShapeList;
      
      public var wrap_gravity:Vec2;
      
      public var viscosity:Number;
      
      public var userData;
      
      public var shapes:ZNPList_ZPP_Shape;
      
      public var outer:FluidProperties;
      
      public var next:ZPP_FluidProperties;
      
      public var gravityy:Number;
      
      public var gravityx:Number;
      
      public var density:Number;
      
      public function ZPP_FluidProperties()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         shapes = new ZNPList_ZPP_Shape();
         viscosity = Number(1);
         density = 1;
         wrap_gravity = null;
         gravityx = 0;
         gravityy = 0;
      }
      
      public function wrapper() : FluidProperties
      {
         var _loc1_:* = null as ZPP_FluidProperties;
         if(outer == null)
         {
            outer = new FluidProperties();
            _loc1_ = outer.zpp_inner;
            _loc1_.outer = null;
            _loc1_.next = ZPP_FluidProperties.zpp_pool;
            ZPP_FluidProperties.zpp_pool = _loc1_;
            outer.zpp_inner = this;
         }
         return outer;
      }
      
      public function invalidate() : void
      {
         var _loc2_:* = null as ZPP_Shape;
         var _loc1_:ZNPNode_ZPP_Shape = shapes.head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.elt;
            _loc2_.invalidate_fluidprops();
            _loc1_ = _loc1_.next;
         }
      }
      
      public function gravity_validate() : void
      {
         wrap_gravity.zpp_inner.x = gravityx;
         wrap_gravity.zpp_inner.y = gravityy;
      }
      
      public function gravity_invalidate(param1:ZPP_Vec2) : void
      {
         gravityx = param1.x;
         gravityy = param1.y;
         invalidate();
      }
      
      public function getgravity() : void
      {
         wrap_gravity = Vec2.get(gravityx,gravityy);
         wrap_gravity.zpp_inner._inuse = true;
         wrap_gravity.zpp_inner._invalidate = gravity_invalidate;
         wrap_gravity.zpp_inner._validate = gravity_validate;
      }
      
      public function copy() : ZPP_FluidProperties
      {
         var _loc1_:* = null as ZPP_FluidProperties;
         if(ZPP_FluidProperties.zpp_pool == null)
         {
            _loc1_ = new ZPP_FluidProperties();
         }
         else
         {
            _loc1_ = ZPP_FluidProperties.zpp_pool;
            ZPP_FluidProperties.zpp_pool = _loc1_.next;
            _loc1_.next = null;
         }
         null;
         _loc1_.viscosity = viscosity;
         _loc1_.density = density;
         return _loc1_;
      }
   }
}
