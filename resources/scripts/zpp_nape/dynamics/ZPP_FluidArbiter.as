package zpp_nape.dynamics
{
   import flash.Boot;
   import nape.dynamics.FluidArbiter;
   import nape.geom.Vec2;
   import zpp_nape.geom.ZPP_Vec2;
   
   public class ZPP_FluidArbiter extends ZPP_Arbiter
   {
      
      public static var zpp_pool:ZPP_FluidArbiter;
       
      
      public var wrap_position:Vec2;
      
      public var wMass:Number;
      
      public var vMassc:Number;
      
      public var vMassb:Number;
      
      public var vMassa:Number;
      
      public var r2y:Number;
      
      public var r2x:Number;
      
      public var r1y:Number;
      
      public var r1x:Number;
      
      public var pre_dt:Number;
      
      public var pdampy:Number;
      
      public var pdampx:Number;
      
      public var padamp:Number;
      
      public var overlap:Number;
      
      public var outer_zn:FluidArbiter;
      
      public var ny:Number;
      
      public var nx:Number;
      
      public var nodrag:Boolean;
      
      public var next:ZPP_FluidArbiter;
      
      public var mutable:Boolean;
      
      public var lgamma:Number;
      
      public var dampy:Number;
      
      public var dampx:Number;
      
      public var centroidy:Number;
      
      public var centroidx:Number;
      
      public var buoyy:Number;
      
      public var buoyx:Number;
      
      public var agamma:Number;
      
      public var adamp:Number;
      
      public function ZPP_FluidArbiter()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         type = ZPP_Arbiter.FLUID;
         fluidarb = this;
         buoyx = 0;
         buoyy = 0;
         pre_dt = -1;
      }
      
      public function position_validate() : void
      {
         wrap_position.zpp_inner.x = centroidx;
         wrap_position.zpp_inner.y = centroidy;
      }
      
      public function position_invalidate(param1:ZPP_Vec2) : void
      {
         centroidx = param1.x;
         centroidy = param1.y;
      }
      
      public function getposition() : void
      {
         wrap_position = Vec2.get();
         wrap_position.zpp_inner._inuse = true;
         wrap_position.zpp_inner._immutable = !mutable;
         wrap_position.zpp_inner._validate = position_validate;
         wrap_position.zpp_inner._invalidate = position_invalidate;
      }
   }
}
