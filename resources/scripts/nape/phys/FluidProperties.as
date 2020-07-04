package nape.phys
{
   import flash.Boot;
   import nape.geom.Vec2;
   import nape.shape.ShapeList;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_FluidProperties;
   import zpp_nape.util.ZPP_ShapeList;
   
   public class FluidProperties
   {
       
      
      public var zpp_inner:ZPP_FluidProperties;
      
      public function FluidProperties(param1:Number = 1, param2:Number = 1)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         if(ZPP_FluidProperties.zpp_pool == null)
         {
            zpp_inner = new ZPP_FluidProperties();
         }
         else
         {
            zpp_inner = ZPP_FluidProperties.zpp_pool;
            ZPP_FluidProperties.zpp_pool = zpp_inner.next;
            zpp_inner.next = null;
         }
         null;
         zpp_inner.outer = this;
         if(param1 != zpp_inner.density * 1000)
         {
            zpp_inner.density = param1 / 1000;
            zpp_inner.invalidate();
         }
         zpp_inner.density * 1000;
         if(param2 != zpp_inner.viscosity)
         {
            zpp_inner.viscosity = param2 / 1;
            zpp_inner.invalidate();
         }
         zpp_inner.viscosity;
      }
      
      public function toString() : String
      {
         return "{ density: " + zpp_inner.density * 1000 + " viscosity: " + zpp_inner.viscosity + " }";
      }
      
      public function set viscosity(param1:Number) : Number
      {
         if(param1 != zpp_inner.viscosity)
         {
            zpp_inner.viscosity = param1 / 1;
            zpp_inner.invalidate();
         }
         return zpp_inner.viscosity;
      }
      
      public function set gravity(param1:Vec2) : Vec2
      {
         var _loc2_:* = null as Vec2;
         var _loc3_:* = null as Vec2;
         var _loc4_:Number = NaN;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:Number = NaN;
         if(param1 == null)
         {
            if(zpp_inner.wrap_gravity != null)
            {
               zpp_inner.wrap_gravity.zpp_inner._inuse = false;
               zpp_inner.wrap_gravity.dispose();
               zpp_inner.wrap_gravity = null;
            }
         }
         else
         {
            if(zpp_inner.wrap_gravity == null)
            {
               zpp_inner.getgravity();
            }
            _loc2_ = zpp_inner.wrap_gravity;
            _loc5_ = param1.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc4_ = param1.zpp_inner.x;
            _loc5_ = param1.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc6_ = param1.zpp_inner.y;
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
            _loc3_ = _loc2_;
            if(param1.zpp_inner.weak)
            {
               param1.dispose();
            }
            _loc3_;
         }
         return zpp_inner.wrap_gravity;
      }
      
      public function set density(param1:Number) : Number
      {
         if(param1 != zpp_inner.density * 1000)
         {
            zpp_inner.density = param1 / 1000;
            zpp_inner.invalidate();
         }
         return zpp_inner.density * 1000;
      }
      
      public function get viscosity() : Number
      {
         return zpp_inner.viscosity;
      }
      
      public function get userData() : *
      {
         if(zpp_inner.userData == null)
         {
            zpp_inner.userData = {};
         }
         return zpp_inner.userData;
      }
      
      public function get shapes() : ShapeList
      {
         if(zpp_inner.wrap_shapes == null)
         {
            zpp_inner.wrap_shapes = ZPP_ShapeList.get(zpp_inner.shapes,true);
         }
         return zpp_inner.wrap_shapes;
      }
      
      public function get gravity() : Vec2
      {
         return zpp_inner.wrap_gravity;
      }
      
      public function get density() : Number
      {
         return zpp_inner.density * 1000;
      }
      
      public function copy() : FluidProperties
      {
         var _loc1_:FluidProperties = new FluidProperties(zpp_inner.density * 1000,zpp_inner.viscosity);
         _loc1_.zpp_inner.userData = zpp_inner.userData;
         return _loc1_;
      }
   }
}
