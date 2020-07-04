package nape.shape
{
   import flash.Boot;
   import nape.dynamics.InteractionFilter;
   import nape.geom.AABB;
   import nape.geom.Mat23;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.FluidProperties;
   import nape.phys.Interactor;
   import nape.phys.Material;
   import zpp_nape.geom.ZPP_Collide;
   import zpp_nape.geom.ZPP_Geom;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_FluidProperties;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZPP_Flags;
   
   public class Shape extends Interactor
   {
       
      
      public var zpp_inner:ZPP_Shape;
      
      public function Shape()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
      }
      
      public static function copy(param1:Shape) : Shape
      {
         var _loc2_:Shape = param1.zpp_inner.copy();
         _loc2_.zpp_inner.userData = param1.zpp_inner.userData;
         return _loc2_;
      }
      
      public function translate(param1:Vec2) : void
      {
         var _loc2_:* = null as ZPP_Vec2;
         zpp_inner.immutable_midstep("Shape::translate()");
         if(Number(param1.lsq()) > 0)
         {
            if(isCircle())
            {
               _loc2_ = param1.zpp_inner;
               §§push(zpp_inner.circle);
               if(_loc2_._validate != null)
               {
                  _loc2_._validate();
               }
               _loc2_ = param1.zpp_inner;
               §§push(param1.zpp_inner.x);
               if(_loc2_._validate != null)
               {
                  _loc2_._validate();
               }
               §§pop().__translate(§§pop(),param1.zpp_inner.y);
            }
            else
            {
               _loc2_ = param1.zpp_inner;
               §§push(zpp_inner.polygon);
               if(_loc2_._validate != null)
               {
                  _loc2_._validate();
               }
               _loc2_ = param1.zpp_inner;
               §§push(param1.zpp_inner.x);
               if(_loc2_._validate != null)
               {
                  _loc2_._validate();
               }
               §§pop().__translate(§§pop(),param1.zpp_inner.y);
            }
         }
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
      }
      
      public function transform(param1:Mat23) : void
      {
         zpp_inner.immutable_midstep("Shape::transform()");
         if(isCircle())
         {
            if(param1.equiorthogonal())
            {
               zpp_inner.circle.__transform(param1);
            }
         }
         else
         {
            zpp_inner.polygon.__transform(param1);
         }
      }
      
      override public function toString() : String
      {
         var _loc1_:String = !!isCircle()?"Circle":"Polygon";
         return _loc1_ + "#" + zpp_inner_i.id;
      }
      
      public function set material(param1:Material) : Material
      {
         zpp_inner.immutable_midstep("Shape::material");
         zpp_inner.setMaterial(param1.zpp_inner);
         return zpp_inner.material.wrapper();
      }
      
      public function set localCOM(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         zpp_inner.immutable_midstep("Body::localCOM");
         if(zpp_inner.wrap_localCOM == null)
         {
            if(isCircle())
            {
               zpp_inner.circle.setupLocalCOM();
            }
            else
            {
               zpp_inner.polygon.setupLocalCOM();
            }
         }
         var _loc2_:Vec2 = zpp_inner.wrap_localCOM;
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
         if(zpp_inner.wrap_localCOM == null)
         {
            if(isCircle())
            {
               zpp_inner.circle.setupLocalCOM();
            }
            else
            {
               zpp_inner.polygon.setupLocalCOM();
            }
         }
         return zpp_inner.wrap_localCOM;
      }
      
      public function set fluidProperties(param1:FluidProperties) : FluidProperties
      {
         zpp_inner.setFluid(param1.zpp_inner);
         zpp_inner.immutable_midstep("Shape::fluidProperties");
         if(zpp_inner.fluidProperties == null)
         {
            zpp_inner.setFluid(new FluidProperties().zpp_inner);
         }
         return zpp_inner.fluidProperties.wrapper();
      }
      
      public function set fluidEnabled(param1:Boolean) : Boolean
      {
         zpp_inner.immutable_midstep("Shape::fluidEnabled");
         zpp_inner.fluidEnabled = param1;
         if(!!param1 && zpp_inner.fluidProperties == null)
         {
            zpp_inner.setFluid(new FluidProperties().zpp_inner);
            zpp_inner.immutable_midstep("Shape::fluidProperties");
            if(zpp_inner.fluidProperties == null)
            {
               zpp_inner.setFluid(new FluidProperties().zpp_inner);
            }
            zpp_inner.fluidProperties.wrapper();
         }
         zpp_inner.wake();
         return zpp_inner.fluidEnabled;
      }
      
      public function set filter(param1:InteractionFilter) : InteractionFilter
      {
         zpp_inner.immutable_midstep("Shape::filter");
         zpp_inner.setFilter(param1.zpp_inner);
         return zpp_inner.filter.wrapper();
      }
      
      public function set body(param1:Body) : Body
      {
         zpp_inner.immutable_midstep("Shape::body");
         if((zpp_inner.body != null?zpp_inner.body.outer:null) != param1)
         {
            if(zpp_inner.body != null)
            {
               (zpp_inner.body != null?zpp_inner.body.outer:null).zpp_inner.wrap_shapes.remove(this);
            }
            if(param1 != null)
            {
               param1.zpp_inner.wrap_shapes.add(this);
            }
         }
         return zpp_inner.body != null?zpp_inner.body.outer:null;
      }
      
      public function scale(param1:Number, param2:Number) : void
      {
         var _loc3_:Number = NaN;
         zpp_inner.immutable_midstep("Shape::scale()");
         if(param1 != 0 && param2 != 0)
         {
            if(isCircle())
            {
               _loc3_ = param1 * param1 - param2 * param2;
               if(_loc3_ * _loc3_ < 1.0e-8)
               {
                  zpp_inner.circle.__scale(param1,param2);
               }
            }
            else
            {
               zpp_inner.polygon.__scale(param1,param2);
            }
         }
      }
      
      public function rotate(param1:Number) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         zpp_inner.immutable_midstep("Shape::rotate()");
         var _loc2_:Number = param1 % (2 * Math.PI);
         if(_loc2_ != 0)
         {
            _loc3_ = Number(Math.cos(param1));
            _loc4_ = Number(Math.sin(param1));
            if(isCircle())
            {
               zpp_inner.circle.__rotate(_loc4_,_loc3_);
            }
            else
            {
               zpp_inner.polygon.__rotate(_loc4_,_loc3_);
            }
         }
      }
      
      public function isPolygon() : Boolean
      {
         return zpp_inner.type == ZPP_Flags.id_ShapeType_POLYGON;
      }
      
      public function isCircle() : Boolean
      {
         return zpp_inner.type == ZPP_Flags.id_ShapeType_CIRCLE;
      }
      
      public function get worldCOM() : Vec2
      {
         if(zpp_inner.wrap_worldCOM == null)
         {
            zpp_inner.wrap_worldCOM = Vec2.get(zpp_inner.worldCOMx,zpp_inner.worldCOMy);
            zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
            zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
            zpp_inner.wrap_worldCOM.zpp_inner._validate = zpp_inner.getworldCOM;
         }
         return zpp_inner.wrap_worldCOM;
      }
      
      public function get type() : ShapeType
      {
         if(ZPP_Flags.ShapeType_CIRCLE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ShapeType_CIRCLE = new ShapeType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.ShapeType_CIRCLE);
         if(ZPP_Flags.ShapeType_POLYGON == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ShapeType_POLYGON = new ShapeType();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.type];
      }
      
      public function get material() : Material
      {
         return zpp_inner.material.wrapper();
      }
      
      public function get localCOM() : Vec2
      {
         if(zpp_inner.wrap_localCOM == null)
         {
            if(isCircle())
            {
               zpp_inner.circle.setupLocalCOM();
            }
            else
            {
               zpp_inner.polygon.setupLocalCOM();
            }
         }
         return zpp_inner.wrap_localCOM;
      }
      
      public function get inertia() : Number
      {
         zpp_inner.validate_area_inertia();
         return zpp_inner.inertia;
      }
      
      public function get fluidProperties() : FluidProperties
      {
         zpp_inner.immutable_midstep("Shape::fluidProperties");
         if(zpp_inner.fluidProperties == null)
         {
            zpp_inner.setFluid(new FluidProperties().zpp_inner);
         }
         return zpp_inner.fluidProperties.wrapper();
      }
      
      public function get fluidEnabled() : Boolean
      {
         return zpp_inner.fluidEnabled;
      }
      
      public function get filter() : InteractionFilter
      {
         return zpp_inner.filter.wrapper();
      }
      
      public function get castPolygon() : Polygon
      {
         return !!isPolygon()?zpp_inner.polygon.outer_zn:null;
      }
      
      public function get castCircle() : Circle
      {
         return !!isCircle()?zpp_inner.circle.outer_zn:null;
      }
      
      public function get bounds() : AABB
      {
         return zpp_inner.aabb.wrapper();
      }
      
      public function get body() : Body
      {
         return zpp_inner.body != null?zpp_inner.body.outer:null;
      }
      
      public function get area() : Number
      {
         zpp_inner.validate_area_inertia();
         return zpp_inner.area;
      }
      
      public function get angDrag() : Number
      {
         zpp_inner.validate_angDrag();
         return zpp_inner.angDrag;
      }
      
      public function contains(param1:Vec2) : Boolean
      {
         ZPP_Geom.validateShape(zpp_inner);
         return Boolean(ZPP_Collide.shapeContains(zpp_inner,param1.zpp_inner));
      }
   }
}
