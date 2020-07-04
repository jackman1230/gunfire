package nape.phys
{
   import flash.Boot;
   import flash.display.DisplayObject;
   import nape.callbacks.InteractionType;
   import nape.constraint.Constraint;
   import nape.constraint.ConstraintList;
   import nape.dynamics.Arbiter;
   import nape.dynamics.ArbiterList;
   import nape.dynamics.CollisionArbiter;
   import nape.dynamics.FluidArbiter;
   import nape.dynamics.InteractionFilter;
   import nape.dynamics.InteractionGroup;
   import nape.geom.AABB;
   import nape.geom.Mat23;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.shape.Shape;
   import nape.shape.ShapeList;
   import nape.space.Space;
   import zpp_nape.callbacks.ZPP_CbType;
   import zpp_nape.constraint.ZPP_Constraint;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.dynamics.ZPP_InteractionGroup;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.geom.ZPP_Vec3;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_Compound;
   import zpp_nape.phys.ZPP_FluidProperties;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZNPList_ZPP_Arbiter;
   import zpp_nape.util.ZNPNode_ZPP_Constraint;
   import zpp_nape.util.ZNPNode_ZPP_Shape;
   import zpp_nape.util.ZPP_ArbiterList;
   import zpp_nape.util.ZPP_ConstraintList;
   import zpp_nape.util.ZPP_Flags;
   
   public class Body extends Interactor
   {
       
      
      public var zpp_inner:ZPP_Body;
      
      public var graphicAngleOffset:Number;
      
      public function Body(param1:BodyType = undefined, param2:Vec2 = undefined)
      {
         var _loc3_:* = null as ZPP_Vec2;
         var _loc5_:int = 0;
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         zpp_inner = new ZPP_Body();
         zpp_inner.outer = this;
         zpp_inner.outer_i = this;
         zpp_inner_i = zpp_inner;
         if(param2 != null)
         {
            _loc3_ = param2.zpp_inner;
            §§push(zpp_inner);
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            §§pop().posx = param2.zpp_inner.x;
            _loc3_ = param2.zpp_inner;
            §§push(zpp_inner);
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            §§pop().posy = param2.zpp_inner.y;
         }
         else
         {
            zpp_inner.posx = 0;
            zpp_inner.posy = 0;
         }
         if(param1 == null)
         {
            if(ZPP_Flags.BodyType_DYNAMIC == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.BodyType_DYNAMIC = new BodyType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.BodyType_DYNAMIC);
         }
         else
         {
            §§push(param1);
         }
         var _loc4_:BodyType = §§pop();
         zpp_inner.immutable_midstep("Body::type");
         §§push(null);
         if(ZPP_Flags.BodyType_STATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_STATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_STATIC);
         if(ZPP_Flags.BodyType_DYNAMIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_DYNAMIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_DYNAMIC);
         if(ZPP_Flags.BodyType_KINEMATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_KINEMATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         if(null[zpp_inner.type] != _loc4_)
         {
            §§push(_loc4_);
            if(ZPP_Flags.BodyType_DYNAMIC == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.BodyType_DYNAMIC = new BodyType();
               ZPP_Flags.§internal§ = false;
            }
            if(§§pop() == ZPP_Flags.BodyType_DYNAMIC)
            {
               §§push(ZPP_Flags.id_BodyType_DYNAMIC);
            }
            else
            {
               §§push(_loc4_);
               if(ZPP_Flags.BodyType_KINEMATIC == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.BodyType_KINEMATIC = new BodyType();
                  ZPP_Flags.§internal§ = false;
               }
               §§push(§§pop() == ZPP_Flags.BodyType_KINEMATIC?ZPP_Flags.id_BodyType_KINEMATIC:ZPP_Flags.id_BodyType_STATIC);
            }
            _loc5_ = §§pop();
            if(_loc5_ == ZPP_Flags.id_BodyType_STATIC && zpp_inner.space != null)
            {
               zpp_inner.velx = 0;
               zpp_inner.vely = 0;
               zpp_inner.angvel = 0;
            }
            zpp_inner.invalidate_type();
            if(zpp_inner.space != null)
            {
               zpp_inner.space.transmitType(zpp_inner,_loc5_);
            }
            else
            {
               zpp_inner.type = _loc5_;
            }
         }
         §§push(null);
         if(ZPP_Flags.BodyType_STATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_STATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_STATIC);
         if(ZPP_Flags.BodyType_DYNAMIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_DYNAMIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_DYNAMIC);
         if(ZPP_Flags.BodyType_KINEMATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_KINEMATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         null[zpp_inner.type];
         if(param2 != null)
         {
            if(param2.zpp_inner.weak)
            {
               param2.dispose();
            }
         }
         graphicAngleOffset = 0;
         zpp_inner_i.insert_cbtype(ZPP_CbType.ANY_BODY.zpp_inner);
      }
      
      public function worldToRelative(param1:Vec2, param2:Boolean = false) : Vec2
      {
         var _loc4_:ZPP_Vec2 = param1.zpp_inner;
         §§push(Vec2);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc4_ = param1.zpp_inner;
         §§push(param1.zpp_inner.x - zpp_inner.posx);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc3_:Vec2 = §§pop().get(§§pop(),param1.zpp_inner.y - zpp_inner.posy,param2);
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc3_;
      }
      
      public function worldToLocal(param1:Vec2, param2:Boolean = false) : Vec2
      {
         return relativeToLocal(worldToRelative(param1,true),param2);
      }
      
      public function translateShapes(param1:Vec2) : void
      {
         var _loc4_:* = null as ZPP_Shape;
         zpp_inner.immutable_midstep("Body::translateShapes()");
         var _loc2_:Boolean = param1.zpp_inner.weak;
         param1.zpp_inner.weak = false;
         var _loc3_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
            _loc4_.outer.translate(param1);
            _loc3_ = _loc3_.next;
         }
         param1.zpp_inner.weak = _loc2_;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
      }
      
      public function transformShapes(param1:Mat23) : void
      {
         var _loc3_:* = null as ZPP_Shape;
         zpp_inner.immutable_midstep("Body::transformShapes()");
         var _loc2_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc3_.outer.transform(param1);
            _loc2_ = _loc2_.next;
         }
      }
      
      public function totalImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
      {
         var _loc8_:* = null as Arbiter;
         var _loc9_:* = null as ZPP_Arbiter;
         var _loc10_:* = null as Vec3;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:* = null as ZPP_Vec3;
         var _loc15_:* = null as ZPP_Constraint;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc7_:* = zpp_inner.wrap_arbiters.iterator();
         while(_loc7_.hasNext())
         {
            _loc8_ = _loc7_.next();
            _loc9_ = _loc8_.zpp_inner;
            if(_loc9_.type != ZPP_Arbiter.SENSOR)
            {
               if(!(param1 != null && _loc9_.b2 != param1.zpp_inner && _loc9_.b1 != param1.zpp_inner))
               {
                  _loc10_ = _loc9_.wrapper().totalImpulse(this,param2);
                  _loc11_ = 1;
                  _loc12_ = _loc11_;
                  _loc13_ = _loc10_.zpp_inner;
                  §§push(_loc3_);
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc3_ = Number(§§pop() + _loc10_.zpp_inner.x * _loc12_);
                  _loc13_ = _loc10_.zpp_inner;
                  §§push(_loc4_);
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc4_ = Number(§§pop() + _loc10_.zpp_inner.y * _loc12_);
                  _loc13_ = _loc10_.zpp_inner;
                  §§push(_loc5_);
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc5_ = Number(§§pop() + _loc10_.zpp_inner.z * _loc11_);
                  _loc10_.dispose();
               }
            }
         }
         var _loc14_:ZNPNode_ZPP_Constraint = zpp_inner.constraints.head;
         while(_loc14_ != null)
         {
            _loc15_ = _loc14_.elt;
            if(_loc15_.active)
            {
               _loc10_ = _loc15_.outer.bodyImpulse(this);
               _loc11_ = 1;
               _loc12_ = _loc11_;
               _loc13_ = _loc10_.zpp_inner;
               §§push(_loc3_);
               if(_loc13_._validate != null)
               {
                  _loc13_._validate();
               }
               _loc3_ = Number(§§pop() + _loc10_.zpp_inner.x * _loc12_);
               _loc13_ = _loc10_.zpp_inner;
               §§push(_loc4_);
               if(_loc13_._validate != null)
               {
                  _loc13_._validate();
               }
               _loc4_ = Number(§§pop() + _loc10_.zpp_inner.y * _loc12_);
               _loc13_ = _loc10_.zpp_inner;
               §§push(_loc5_);
               if(_loc13_._validate != null)
               {
                  _loc13_._validate();
               }
               _loc5_ = Number(§§pop() + _loc10_.zpp_inner.z * _loc11_);
               _loc10_.dispose();
            }
            _loc14_ = _loc14_.next;
         }
         return Vec3.get(_loc3_,_loc4_,_loc5_);
      }
      
      public function totalFluidImpulse(param1:Body = undefined) : Vec3
      {
         var _loc7_:* = null as Arbiter;
         var _loc8_:* = null as ZPP_Arbiter;
         var _loc9_:* = null as Vec3;
         var _loc10_:* = null as Arbiter;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:* = null as ZPP_Vec3;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc6_:* = zpp_inner.wrap_arbiters.iterator();
         while(_loc6_.hasNext())
         {
            _loc7_ = _loc6_.next();
            _loc8_ = _loc7_.zpp_inner;
            if(_loc8_.type == ZPP_Arbiter.FLUID)
            {
               if(!(param1 != null && _loc8_.b2 != param1.zpp_inner && _loc8_.b1 != param1.zpp_inner))
               {
                  _loc10_ = _loc8_.wrapper();
                  _loc9_ = (!!_loc10_.isFluidArbiter()?_loc10_.zpp_inner.fluidarb.outer_zn:null).totalImpulse(this);
                  _loc11_ = 1;
                  _loc12_ = _loc11_;
                  _loc13_ = _loc9_.zpp_inner;
                  §§push(_loc2_);
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc2_ = Number(§§pop() + _loc9_.zpp_inner.x * _loc12_);
                  _loc13_ = _loc9_.zpp_inner;
                  §§push(_loc3_);
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc3_ = Number(§§pop() + _loc9_.zpp_inner.y * _loc12_);
                  _loc13_ = _loc9_.zpp_inner;
                  §§push(_loc4_);
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc4_ = Number(§§pop() + _loc9_.zpp_inner.z * _loc11_);
                  _loc9_.dispose();
               }
            }
         }
         return Vec3.get(_loc2_,_loc3_,_loc4_);
      }
      
      public function totalContactsImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
      {
         var _loc8_:* = null as Arbiter;
         var _loc9_:* = null as ZPP_Arbiter;
         var _loc10_:* = null as Vec3;
         var _loc11_:* = null as Arbiter;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:* = null as ZPP_Vec3;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc7_:* = zpp_inner.wrap_arbiters.iterator();
         while(_loc7_.hasNext())
         {
            _loc8_ = _loc7_.next();
            _loc9_ = _loc8_.zpp_inner;
            if(_loc9_.type == ZPP_Arbiter.COL)
            {
               if(!(param1 != null && _loc9_.b2 != param1.zpp_inner && _loc9_.b1 != param1.zpp_inner))
               {
                  _loc11_ = _loc9_.wrapper();
                  _loc10_ = (!!_loc11_.isCollisionArbiter()?_loc11_.zpp_inner.colarb.outer_zn:null).totalImpulse(this,param2);
                  _loc12_ = 1;
                  _loc13_ = _loc12_;
                  _loc14_ = _loc10_.zpp_inner;
                  §§push(_loc3_);
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc3_ = Number(§§pop() + _loc10_.zpp_inner.x * _loc13_);
                  _loc14_ = _loc10_.zpp_inner;
                  §§push(_loc4_);
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc4_ = Number(§§pop() + _loc10_.zpp_inner.y * _loc13_);
                  _loc14_ = _loc10_.zpp_inner;
                  §§push(_loc5_);
                  if(_loc14_._validate != null)
                  {
                     _loc14_._validate();
                  }
                  _loc5_ = Number(§§pop() + _loc10_.zpp_inner.z * _loc12_);
                  _loc10_.dispose();
               }
            }
         }
         return Vec3.get(_loc3_,_loc4_,_loc5_);
      }
      
      override public function toString() : String
      {
         return (!!zpp_inner.world?"(space::world":"(" + (!!isDynamic()?"dynamic":!!isStatic()?"static":"kinematic")) + ")#" + zpp_inner_i.id;
      }
      
      public function tangentImpulse(param1:Body = undefined, param2:Boolean = false, param3:Boolean = false) : Vec2
      {
         var _loc9_:* = null as Arbiter;
         var _loc10_:* = null as ZPP_Arbiter;
         var _loc11_:* = null as Vec3;
         var _loc12_:* = null as Arbiter;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:* = null as ZPP_Vec3;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc8_:* = zpp_inner.wrap_arbiters.iterator();
         while(_loc8_.hasNext())
         {
            _loc9_ = _loc8_.next();
            _loc10_ = _loc9_.zpp_inner;
            if(_loc10_.type == ZPP_Arbiter.COL)
            {
               if(!(param1 != null && _loc10_.b2 != param1.zpp_inner && _loc10_.b1 != param1.zpp_inner))
               {
                  _loc12_ = _loc10_.wrapper();
                  _loc11_ = (!!_loc12_.isCollisionArbiter()?_loc12_.zpp_inner.colarb.outer_zn:null).tangentImpulse(this,param2);
                  _loc13_ = 1;
                  _loc14_ = _loc13_;
                  _loc15_ = _loc11_.zpp_inner;
                  §§push(_loc4_);
                  if(_loc15_._validate != null)
                  {
                     _loc15_._validate();
                  }
                  _loc4_ = Number(§§pop() + _loc11_.zpp_inner.x * _loc14_);
                  _loc15_ = _loc11_.zpp_inner;
                  §§push(_loc5_);
                  if(_loc15_._validate != null)
                  {
                     _loc15_._validate();
                  }
                  _loc5_ = Number(§§pop() + _loc11_.zpp_inner.y * _loc14_);
                  _loc15_ = _loc11_.zpp_inner;
                  §§push(_loc6_);
                  if(_loc15_._validate != null)
                  {
                     _loc15_._validate();
                  }
                  _loc6_ = Number(§§pop() + _loc11_.zpp_inner.z * _loc13_);
                  _loc11_.dispose();
               }
            }
         }
         return Vec2.get(_loc4_,_loc5_,param3);
      }
      
      public function set velocity(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         if(zpp_inner.wrap_vel == null)
         {
            zpp_inner.setupVelocity();
         }
         var _loc2_:Vec2 = zpp_inner.wrap_vel;
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
         if(zpp_inner.wrap_vel == null)
         {
            zpp_inner.setupVelocity();
         }
         return zpp_inner.wrap_vel;
      }
      
      public function set type(param1:BodyType) : BodyType
      {
         var _loc2_:int = 0;
         zpp_inner.immutable_midstep("Body::type");
         §§push(null);
         if(ZPP_Flags.BodyType_STATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_STATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_STATIC);
         if(ZPP_Flags.BodyType_DYNAMIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_DYNAMIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_DYNAMIC);
         if(ZPP_Flags.BodyType_KINEMATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_KINEMATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         if(null[zpp_inner.type] != param1)
         {
            §§push(param1);
            if(ZPP_Flags.BodyType_DYNAMIC == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.BodyType_DYNAMIC = new BodyType();
               ZPP_Flags.§internal§ = false;
            }
            if(§§pop() == ZPP_Flags.BodyType_DYNAMIC)
            {
               §§push(ZPP_Flags.id_BodyType_DYNAMIC);
            }
            else
            {
               §§push(param1);
               if(ZPP_Flags.BodyType_KINEMATIC == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.BodyType_KINEMATIC = new BodyType();
                  ZPP_Flags.§internal§ = false;
               }
               §§push(§§pop() == ZPP_Flags.BodyType_KINEMATIC?ZPP_Flags.id_BodyType_KINEMATIC:ZPP_Flags.id_BodyType_STATIC);
            }
            _loc2_ = §§pop();
            if(_loc2_ == ZPP_Flags.id_BodyType_STATIC && zpp_inner.space != null)
            {
               zpp_inner.velx = 0;
               zpp_inner.vely = 0;
               zpp_inner.angvel = 0;
            }
            zpp_inner.invalidate_type();
            if(zpp_inner.space != null)
            {
               zpp_inner.space.transmitType(zpp_inner,_loc2_);
            }
            else
            {
               zpp_inner.type = _loc2_;
            }
         }
         §§push(null);
         if(ZPP_Flags.BodyType_STATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_STATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_STATIC);
         if(ZPP_Flags.BodyType_DYNAMIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_DYNAMIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_DYNAMIC);
         if(ZPP_Flags.BodyType_KINEMATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_KINEMATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.type];
      }
      
      public function set torque(param1:Number) : Number
      {
         if(zpp_inner.torque != param1)
         {
            zpp_inner.torque = param1;
            zpp_inner.invalidate_wake();
         }
         return zpp_inner.torque;
      }
      
      public function set surfaceVel(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         if(zpp_inner.wrap_svel == null)
         {
            zpp_inner.setupsvel();
         }
         var _loc2_:Vec2 = zpp_inner.wrap_svel;
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
         if(zpp_inner.wrap_svel == null)
         {
            zpp_inner.setupsvel();
         }
         return zpp_inner.wrap_svel;
      }
      
      public function set space(param1:Space) : Space
      {
         zpp_inner.immutable_midstep("Body::space");
         if((zpp_inner.space == null?null:zpp_inner.space.outer) != param1)
         {
            if(param1 != null)
            {
               param1.zpp_inner.wrap_bodies.add(this);
            }
         }
         return zpp_inner.space == null?null:zpp_inner.space.outer;
      }
      
      public function set rotation(param1:Number) : Number
      {
         var _loc2_:* = null as ZPP_Body;
         var _loc3_:Boolean = false;
         var _loc4_:* = null as ZNPNode_ZPP_Shape;
         var _loc5_:* = null as ZPP_Shape;
         zpp_inner.immutable_midstep("Body::rotation");
         if(zpp_inner.rot != param1)
         {
            zpp_inner.rot = param1;
            _loc2_ = zpp_inner;
            _loc3_ = false;
            _loc2_.zip_axis = true;
            _loc4_ = _loc2_.shapes.head;
            while(_loc4_ != null)
            {
               _loc5_ = _loc4_.elt;
               if(_loc5_.type == ZPP_Flags.id_ShapeType_POLYGON)
               {
                  _loc5_.polygon.invalidate_gverts();
                  _loc5_.polygon.invalidate_gaxi();
               }
               _loc5_.invalidate_worldCOM();
               _loc4_ = _loc4_.next;
            }
            _loc2_.invalidate_worldCOM();
            if(!_loc3_)
            {
               _loc2_.validate_graphic();
            }
            zpp_inner.wake();
         }
         return zpp_inner.rot;
      }
      
      public function set position(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         if(zpp_inner.wrap_pos == null)
         {
            zpp_inner.setupPosition();
         }
         var _loc2_:Vec2 = zpp_inner.wrap_pos;
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
         if(zpp_inner.wrap_pos == null)
         {
            zpp_inner.setupPosition();
         }
         return zpp_inner.wrap_pos;
      }
      
      public function set massMode(param1:MassMode) : MassMode
      {
         zpp_inner.immutable_midstep("Body::massMode");
         §§push(zpp_inner);
         §§push(param1);
         if(ZPP_Flags.MassMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.MassMode_DEFAULT = new MassMode();
            ZPP_Flags.§internal§ = false;
         }
         §§pop().massMode = §§pop() == ZPP_Flags.MassMode_DEFAULT?ZPP_Flags.id_MassMode_DEFAULT:ZPP_Flags.id_MassMode_FIXED;
         zpp_inner.invalidate_mass();
         if(ZPP_Flags.MassMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.MassMode_DEFAULT = new MassMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.MassMode_DEFAULT);
         if(ZPP_Flags.MassMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.MassMode_FIXED = new MassMode();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.massMode];
      }
      
      public function set mass(param1:Number) : Number
      {
         zpp_inner.immutable_midstep("Body::mass");
         zpp_inner.massMode = ZPP_Flags.id_MassMode_FIXED;
         zpp_inner.cmass = param1;
         zpp_inner.invalidate_mass();
         zpp_inner.validate_mass();
         return zpp_inner.cmass;
      }
      
      public function set kinematicVel(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         if(zpp_inner.wrap_kinvel == null)
         {
            zpp_inner.setupkinvel();
         }
         var _loc2_:Vec2 = zpp_inner.wrap_kinvel;
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
         if(zpp_inner.wrap_kinvel == null)
         {
            zpp_inner.setupkinvel();
         }
         return zpp_inner.wrap_kinvel;
      }
      
      public function set kinAngVel(param1:Number) : Number
      {
         if(zpp_inner.kinangvel != param1)
         {
            zpp_inner.kinangvel = param1;
            zpp_inner.invalidate_wake();
         }
         return zpp_inner.kinangvel;
      }
      
      public function set inertiaMode(param1:InertiaMode) : InertiaMode
      {
         zpp_inner.immutable_midstep("Body::inertiaMode");
         §§push(zpp_inner);
         §§push(param1);
         if(ZPP_Flags.InertiaMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InertiaMode_FIXED = new InertiaMode();
            ZPP_Flags.§internal§ = false;
         }
         §§pop().inertiaMode = §§pop() == ZPP_Flags.InertiaMode_FIXED?ZPP_Flags.id_InertiaMode_FIXED:ZPP_Flags.id_InertiaMode_DEFAULT;
         zpp_inner.invalidate_inertia();
         if(ZPP_Flags.InertiaMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InertiaMode_DEFAULT = new InertiaMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.InertiaMode_DEFAULT);
         if(ZPP_Flags.InertiaMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InertiaMode_FIXED = new InertiaMode();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.inertiaMode];
      }
      
      public function set inertia(param1:Number) : Number
      {
         zpp_inner.immutable_midstep("Body::inertia");
         zpp_inner.inertiaMode = ZPP_Flags.id_InertiaMode_FIXED;
         zpp_inner.cinertia = param1;
         zpp_inner.invalidate_inertia();
         zpp_inner.validate_inertia();
         return zpp_inner.cinertia;
      }
      
      public function set gravMassScale(param1:Number) : Number
      {
         zpp_inner.immutable_midstep("Body::gravMassScale");
         zpp_inner.gravMassMode = ZPP_Flags.id_GravMassMode_SCALED;
         zpp_inner.gravMassScale = param1;
         zpp_inner.invalidate_gravMassScale();
         zpp_inner.validate_gravMassScale();
         return zpp_inner.gravMassScale;
      }
      
      public function set gravMassMode(param1:GravMassMode) : GravMassMode
      {
         zpp_inner.immutable_midstep("Body::gravMassMode");
         §§push(zpp_inner);
         §§push(param1);
         if(ZPP_Flags.GravMassMode_SCALED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.GravMassMode_SCALED = new GravMassMode();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.GravMassMode_SCALED)
         {
            §§push(ZPP_Flags.id_GravMassMode_SCALED);
         }
         else
         {
            §§push(param1);
            if(ZPP_Flags.GravMassMode_DEFAULT == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.GravMassMode_DEFAULT = new GravMassMode();
               ZPP_Flags.§internal§ = false;
            }
            §§push(§§pop() == ZPP_Flags.GravMassMode_DEFAULT?ZPP_Flags.id_GravMassMode_DEFAULT:ZPP_Flags.id_GravMassMode_FIXED);
         }
         §§pop().gravMassMode = §§pop();
         zpp_inner.invalidate_gravMass();
         if(ZPP_Flags.GravMassMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.GravMassMode_DEFAULT = new GravMassMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.GravMassMode_DEFAULT);
         if(ZPP_Flags.GravMassMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.GravMassMode_FIXED = new GravMassMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.GravMassMode_FIXED);
         if(ZPP_Flags.GravMassMode_SCALED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.GravMassMode_SCALED = new GravMassMode();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.massMode];
      }
      
      public function set gravMass(param1:Number) : Number
      {
         zpp_inner.immutable_midstep("Body::gravMass");
         zpp_inner.gravMassMode = ZPP_Flags.id_GravMassMode_FIXED;
         zpp_inner.gravMass = param1;
         zpp_inner.invalidate_gravMass();
         zpp_inner.validate_gravMass();
         return zpp_inner.gravMass;
      }
      
      public function set graphicUpdate(param1:Function) : Function
      {
         zpp_inner.graphicUpdate = param1;
         if(param1 != null)
         {
            zpp_inner.validate_graphic();
         }
         return zpp_inner.graphicUpdate;
      }
      
      public function set graphicOffset(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc2_:Vec2 = zpp_inner.graphicOffset;
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
         return zpp_inner.graphicOffset;
      }
      
      public function set graphic(param1:*) : *
      {
         if(param1 != zpp_inner.graphic)
         {
            if(param1 == null)
            {
               zpp_inner.graphic = null;
            }
            else
            {
               zpp_inner.graphic = param1;
               zpp_inner.flashgraphic = Boolean(Std.§is§(param1,DisplayObject));
               zpp_inner.validate_graphic();
            }
         }
         return zpp_inner.graphic;
      }
      
      public function set force(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         if(zpp_inner.wrap_force == null)
         {
            zpp_inner.setupForce();
         }
         var _loc2_:Vec2 = zpp_inner.wrap_force;
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
         if(zpp_inner.wrap_force == null)
         {
            zpp_inner.setupForce();
         }
         return zpp_inner.wrap_force;
      }
      
      public function set compound(param1:Compound) : Compound
      {
         if((zpp_inner.compound == null?null:zpp_inner.compound.outer) != param1)
         {
            if(param1 != null)
            {
               param1.zpp_inner.wrap_bodies.add(this);
            }
         }
         return zpp_inner.compound == null?null:zpp_inner.compound.outer;
      }
      
      public function set angularVel(param1:Number) : Number
      {
         if(zpp_inner.angvel != param1)
         {
            zpp_inner.angvel = param1;
            zpp_inner.invalidate_wake();
         }
         return zpp_inner.angvel;
      }
      
      public function set allowRotation(param1:Boolean) : Boolean
      {
         zpp_inner.immutable_midstep("Body::" + Std.string(param1));
         if(!zpp_inner.norotate != param1)
         {
            zpp_inner.norotate = !param1;
            zpp_inner.invalidate_inertia();
         }
         return !zpp_inner.norotate;
      }
      
      public function set allowMovement(param1:Boolean) : Boolean
      {
         zpp_inner.immutable_midstep("Body::" + Std.string(param1));
         if(!zpp_inner.nomove != param1)
         {
            zpp_inner.nomove = !param1;
            zpp_inner.invalidate_mass();
         }
         return !zpp_inner.nomove;
      }
      
      public function setShapeMaterials(param1:Material) : void
      {
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:* = null as Shape;
         zpp_inner.immutable_midstep("Body::setShapeMaterials()");
         var _loc2_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc4_ = _loc3_.outer;
            _loc4_.zpp_inner.immutable_midstep("Shape::material");
            _loc4_.zpp_inner.setMaterial(param1.zpp_inner);
            _loc4_.zpp_inner.material.wrapper();
            _loc2_ = _loc2_.next;
         }
      }
      
      public function setShapeFluidProperties(param1:FluidProperties) : void
      {
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:* = null as Shape;
         zpp_inner.immutable_midstep("Body::setShapeFluidProperties()");
         var _loc2_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc4_ = _loc3_.outer;
            _loc4_.zpp_inner.setFluid(param1.zpp_inner);
            _loc4_.zpp_inner.immutable_midstep("Shape::fluidProperties");
            if(_loc4_.zpp_inner.fluidProperties == null)
            {
               _loc4_.zpp_inner.setFluid(new FluidProperties().zpp_inner);
            }
            _loc4_.zpp_inner.fluidProperties.wrapper();
            _loc2_ = _loc2_.next;
         }
      }
      
      public function setShapeFilters(param1:InteractionFilter) : void
      {
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:* = null as Shape;
         zpp_inner.immutable_midstep("Body::setShapeFilters()");
         var _loc2_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc4_ = _loc3_.outer;
            _loc4_.zpp_inner.immutable_midstep("Shape::filter");
            _loc4_.zpp_inner.setFilter(param1.zpp_inner);
            _loc4_.zpp_inner.filter.wrapper();
            _loc2_ = _loc2_.next;
         }
      }
      
      public function scaleShapes(param1:Number, param2:Number) : void
      {
         var _loc4_:* = null as ZPP_Shape;
         zpp_inner.immutable_midstep("Body::scaleShapes()");
         var _loc3_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
            _loc4_.outer.scale(param1,param2);
            _loc3_ = _loc3_.next;
         }
      }
      
      public function rotateShapes(param1:Number) : void
      {
         var _loc3_:* = null as ZPP_Shape;
         zpp_inner.immutable_midstep("Body::rotateShapes()");
         var _loc2_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc3_.outer.rotate(param1);
            _loc2_ = _loc2_.next;
         }
      }
      
      public function rotate(param1:Vec2, param2:Number) : void
      {
         var _loc9_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZPP_Body;
         var _loc13_:Boolean = false;
         var _loc14_:* = null as ZNPNode_ZPP_Shape;
         var _loc15_:* = null as ZPP_Shape;
         var _loc3_:Boolean = param1.zpp_inner.weak;
         param1.zpp_inner.weak = false;
         if(zpp_inner.wrap_pos == null)
         {
            zpp_inner.setupPosition();
         }
         var _loc4_:Vec2 = zpp_inner.wrap_pos.sub(param1);
         _loc4_.rotate(param2);
         var _loc5_:Vec2 = param1.add(_loc4_,true);
         if(zpp_inner.wrap_pos == null)
         {
            zpp_inner.setupPosition();
         }
         var _loc6_:Vec2 = zpp_inner.wrap_pos;
         _loc9_ = _loc5_.zpp_inner;
         if(_loc9_._validate != null)
         {
            _loc9_._validate();
         }
         var _loc8_:Number = _loc5_.zpp_inner.x;
         _loc9_ = _loc5_.zpp_inner;
         if(_loc9_._validate != null)
         {
            _loc9_._validate();
         }
         var _loc10_:Number = _loc5_.zpp_inner.y;
         _loc9_ = _loc6_.zpp_inner;
         §§push(false);
         if(_loc9_._validate != null)
         {
            _loc9_._validate();
         }
         if(_loc6_.zpp_inner.x == _loc8_)
         {
            §§pop();
            _loc9_ = _loc6_.zpp_inner;
            if(_loc9_._validate != null)
            {
               _loc9_._validate();
            }
            §§push(_loc6_.zpp_inner.y == _loc10_);
         }
         if(!§§pop())
         {
            _loc6_.zpp_inner.x = _loc8_;
            _loc6_.zpp_inner.y = _loc10_;
            _loc9_ = _loc6_.zpp_inner;
            if(_loc9_._invalidate != null)
            {
               _loc9_._invalidate(_loc9_);
            }
         }
         var _loc7_:Vec2 = _loc6_;
         if(_loc5_.zpp_inner.weak)
         {
            _loc5_.dispose();
         }
         _loc7_;
         if(zpp_inner.wrap_pos == null)
         {
            zpp_inner.setupPosition();
         }
         zpp_inner.wrap_pos;
         _loc4_.dispose();
         var _loc11_:Body = this;
         _loc8_ = Number(_loc11_.zpp_inner.rot + param2);
         _loc11_.zpp_inner.immutable_midstep("Body::rotation");
         if(_loc11_.zpp_inner.rot != _loc8_)
         {
            _loc11_.zpp_inner.rot = _loc8_;
            _loc12_ = _loc11_.zpp_inner;
            _loc13_ = false;
            _loc12_.zip_axis = true;
            _loc14_ = _loc12_.shapes.head;
            while(_loc14_ != null)
            {
               _loc15_ = _loc14_.elt;
               if(_loc15_.type == ZPP_Flags.id_ShapeType_POLYGON)
               {
                  _loc15_.polygon.invalidate_gverts();
                  _loc15_.polygon.invalidate_gaxi();
               }
               _loc15_.invalidate_worldCOM();
               _loc14_ = _loc14_.next;
            }
            _loc12_.invalidate_worldCOM();
            if(!_loc13_)
            {
               _loc12_.validate_graphic();
            }
            _loc11_.zpp_inner.wake();
         }
         _loc11_.zpp_inner.rot;
         param1.zpp_inner.weak = _loc3_;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
      }
      
      public function rollingImpulse(param1:Body = undefined, param2:Boolean = false) : Number
      {
         var _loc6_:* = null as Arbiter;
         var _loc7_:* = null as ZPP_Arbiter;
         var _loc8_:* = null as Arbiter;
         var _loc3_:Number = 0;
         var _loc4_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc5_:* = zpp_inner.wrap_arbiters.iterator();
         while(_loc5_.hasNext())
         {
            _loc6_ = _loc5_.next();
            _loc7_ = _loc6_.zpp_inner;
            if(_loc7_.type == ZPP_Arbiter.COL)
            {
               if(!(param1 != null && _loc7_.b2 != param1.zpp_inner && _loc7_.b1 != param1.zpp_inner))
               {
                  _loc8_ = _loc7_.wrapper();
                  _loc3_ = Number(_loc3_ + Number((!!_loc8_.isCollisionArbiter()?_loc8_.zpp_inner.colarb.outer_zn:null).rollingImpulse(this,param2)));
               }
            }
         }
         return _loc3_;
      }
      
      public function relativeToWorld(param1:Vec2, param2:Boolean = false) : Vec2
      {
         var _loc4_:ZPP_Vec2 = param1.zpp_inner;
         §§push(Vec2);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc4_ = param1.zpp_inner;
         §§push(Number(param1.zpp_inner.x + zpp_inner.posx));
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc3_:Vec2 = §§pop().get(§§pop(),Number(param1.zpp_inner.y + zpp_inner.posy),param2);
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc3_;
      }
      
      public function relativeToLocal(param1:Vec2, param2:Boolean = false) : Vec2
      {
         var _loc3_:ZPP_Body = zpp_inner;
         if(_loc3_.zip_axis)
         {
            _loc3_.zip_axis = false;
            _loc3_.axisx = Number(Math.sin(_loc3_.rot));
            _loc3_.axisy = Number(Math.cos(_loc3_.rot));
            null;
         }
         var _loc6_:ZPP_Vec2 = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc6_ = param1.zpp_inner;
         §§push(param1.zpp_inner.x * zpp_inner.axisy);
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc4_:Number = Number(§§pop() + param1.zpp_inner.y * zpp_inner.axisx);
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc6_ = param1.zpp_inner;
         §§push(param1.zpp_inner.y * zpp_inner.axisy);
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc5_:Number = §§pop() - param1.zpp_inner.x * zpp_inner.axisx;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return Vec2.get(_loc4_,_loc5_,param2);
      }
      
      public function normalImpulse(param1:Body = undefined, param2:Boolean = false, param3:Boolean = false) : Vec2
      {
         var _loc9_:* = null as Arbiter;
         var _loc10_:* = null as ZPP_Arbiter;
         var _loc11_:* = null as Vec3;
         var _loc12_:* = null as Arbiter;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:* = null as ZPP_Vec3;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:Number = 0;
         var _loc7_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc8_:* = zpp_inner.wrap_arbiters.iterator();
         while(_loc8_.hasNext())
         {
            _loc9_ = _loc8_.next();
            _loc10_ = _loc9_.zpp_inner;
            if(_loc10_.type == ZPP_Arbiter.COL)
            {
               if(!(param1 != null && _loc10_.b2 != param1.zpp_inner && _loc10_.b1 != param1.zpp_inner))
               {
                  _loc12_ = _loc10_.wrapper();
                  _loc11_ = (!!_loc12_.isCollisionArbiter()?_loc12_.zpp_inner.colarb.outer_zn:null).normalImpulse(this,param2);
                  _loc13_ = 1;
                  _loc14_ = _loc13_;
                  _loc15_ = _loc11_.zpp_inner;
                  §§push(_loc4_);
                  if(_loc15_._validate != null)
                  {
                     _loc15_._validate();
                  }
                  _loc4_ = Number(§§pop() + _loc11_.zpp_inner.x * _loc14_);
                  _loc15_ = _loc11_.zpp_inner;
                  §§push(_loc5_);
                  if(_loc15_._validate != null)
                  {
                     _loc15_._validate();
                  }
                  _loc5_ = Number(§§pop() + _loc11_.zpp_inner.y * _loc14_);
                  _loc15_ = _loc11_.zpp_inner;
                  §§push(_loc6_);
                  if(_loc15_._validate != null)
                  {
                     _loc15_._validate();
                  }
                  _loc6_ = Number(§§pop() + _loc11_.zpp_inner.z * _loc13_);
                  _loc11_.dispose();
               }
            }
         }
         return Vec2.get(_loc4_,_loc5_,false);
      }
      
      public function localToWorld(param1:Vec2, param2:Boolean = false) : Vec2
      {
         return relativeToWorld(localToRelative(param1,true),param2);
      }
      
      public function localToRelative(param1:Vec2, param2:Boolean = false) : Vec2
      {
         var _loc3_:ZPP_Body = zpp_inner;
         if(_loc3_.zip_axis)
         {
            _loc3_.zip_axis = false;
            _loc3_.axisx = Number(Math.sin(_loc3_.rot));
            _loc3_.axisy = Number(Math.cos(_loc3_.rot));
            null;
         }
         var _loc6_:ZPP_Vec2 = param1.zpp_inner;
         §§push(zpp_inner.axisy);
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc6_ = param1.zpp_inner;
         §§push(§§pop() * param1.zpp_inner.x);
         §§push(zpp_inner.axisx);
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc4_:Number = §§pop() - §§pop() * param1.zpp_inner.y;
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc6_ = param1.zpp_inner;
         §§push(param1.zpp_inner.x * zpp_inner.axisx);
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc5_:Number = Number(§§pop() + param1.zpp_inner.y * zpp_inner.axisy);
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return Vec2.get(_loc4_,_loc5_,param2);
      }
      
      public function isStatic() : Boolean
      {
         return zpp_inner.type == ZPP_Flags.id_BodyType_STATIC;
      }
      
      public function isKinematic() : Boolean
      {
         return zpp_inner.type == ZPP_Flags.id_BodyType_KINEMATIC;
      }
      
      public function isDynamic() : Boolean
      {
         return zpp_inner.type == ZPP_Flags.id_BodyType_DYNAMIC;
      }
      
      public function interactingBodies(param1:InteractionType = undefined, param2:int = -1) : BodyList
      {
         if(param1 == null)
         {
            §§push(ZPP_Arbiter.COL | ZPP_Arbiter.SENSOR | ZPP_Arbiter.FLUID);
         }
         else
         {
            §§push(param1);
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            if(§§pop() == ZPP_Flags.InteractionType_COLLISION)
            {
               §§push(ZPP_Arbiter.COL);
            }
            else
            {
               §§push(param1);
               if(ZPP_Flags.InteractionType_SENSOR == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                  ZPP_Flags.§internal§ = false;
               }
               §§push(§§pop() == ZPP_Flags.InteractionType_SENSOR?ZPP_Arbiter.SENSOR:ZPP_Arbiter.FLUID);
            }
         }
         var _loc3_:int = §§pop();
         return zpp_inner.interactingBodies(_loc3_,param2);
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
      
      public function get velocity() : Vec2
      {
         if(zpp_inner.wrap_vel == null)
         {
            zpp_inner.setupVelocity();
         }
         return zpp_inner.wrap_vel;
      }
      
      public function get type() : BodyType
      {
         §§push(null);
         if(ZPP_Flags.BodyType_STATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_STATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_STATIC);
         if(ZPP_Flags.BodyType_DYNAMIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_DYNAMIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.BodyType_DYNAMIC);
         if(ZPP_Flags.BodyType_KINEMATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_KINEMATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.type];
      }
      
      public function get torque() : Number
      {
         return zpp_inner.torque;
      }
      
      public function get surfaceVel() : Vec2
      {
         if(zpp_inner.wrap_svel == null)
         {
            zpp_inner.setupsvel();
         }
         return zpp_inner.wrap_svel;
      }
      
      public function get space() : Space
      {
         return zpp_inner.space == null?null:zpp_inner.space.outer;
      }
      
      public function get shapes() : ShapeList
      {
         return zpp_inner.wrap_shapes;
      }
      
      public function get rotation() : Number
      {
         return zpp_inner.rot;
      }
      
      public function get position() : Vec2
      {
         if(zpp_inner.wrap_pos == null)
         {
            zpp_inner.setupPosition();
         }
         return zpp_inner.wrap_pos;
      }
      
      public function get massMode() : MassMode
      {
         if(ZPP_Flags.MassMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.MassMode_DEFAULT = new MassMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.MassMode_DEFAULT);
         if(ZPP_Flags.MassMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.MassMode_FIXED = new MassMode();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.massMode];
      }
      
      public function get mass() : Number
      {
         zpp_inner.validate_mass();
         return zpp_inner.cmass;
      }
      
      public function get localCOM() : Vec2
      {
         if(zpp_inner.wrap_localCOM == null)
         {
            zpp_inner.wrap_localCOM = Vec2.get(zpp_inner.localCOMx,zpp_inner.localCOMy);
            zpp_inner.wrap_localCOM.zpp_inner._inuse = true;
            zpp_inner.wrap_localCOM.zpp_inner._immutable = true;
            zpp_inner.wrap_localCOM.zpp_inner._validate = zpp_inner.getlocalCOM;
         }
         return zpp_inner.wrap_localCOM;
      }
      
      public function get kinematicVel() : Vec2
      {
         if(zpp_inner.wrap_kinvel == null)
         {
            zpp_inner.setupkinvel();
         }
         return zpp_inner.wrap_kinvel;
      }
      
      public function get kinAngVel() : Number
      {
         return zpp_inner.kinangvel;
      }
      
      public function get isSleeping() : Boolean
      {
         return zpp_inner.component.sleeping;
      }
      
      public function get inertiaMode() : InertiaMode
      {
         if(ZPP_Flags.InertiaMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InertiaMode_DEFAULT = new InertiaMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.InertiaMode_DEFAULT);
         if(ZPP_Flags.InertiaMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InertiaMode_FIXED = new InertiaMode();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.inertiaMode];
      }
      
      public function get inertia() : Number
      {
         zpp_inner.validate_inertia();
         return zpp_inner.cinertia;
      }
      
      public function get gravMassScale() : Number
      {
         zpp_inner.validate_gravMassScale();
         return zpp_inner.gravMassScale;
      }
      
      public function get gravMassMode() : GravMassMode
      {
         if(ZPP_Flags.GravMassMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.GravMassMode_DEFAULT = new GravMassMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.GravMassMode_DEFAULT);
         if(ZPP_Flags.GravMassMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.GravMassMode_FIXED = new GravMassMode();
            ZPP_Flags.§internal§ = false;
         }
         §§push(ZPP_Flags.GravMassMode_FIXED);
         if(ZPP_Flags.GravMassMode_SCALED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.GravMassMode_SCALED = new GravMassMode();
            ZPP_Flags.§internal§ = false;
         }
         return null[zpp_inner.massMode];
      }
      
      public function get gravMass() : Number
      {
         zpp_inner.validate_gravMass();
         return zpp_inner.gravMass;
      }
      
      public function get graphicUpdate() : Function
      {
         return zpp_inner.graphicUpdate;
      }
      
      public function get graphicOffset() : Vec2
      {
         return zpp_inner.graphicOffset;
      }
      
      public function get graphic() : *
      {
         return zpp_inner.graphic;
      }
      
      public function get force() : Vec2
      {
         if(zpp_inner.wrap_force == null)
         {
            zpp_inner.setupForce();
         }
         return zpp_inner.wrap_force;
      }
      
      public function get constraints() : ConstraintList
      {
         if(zpp_inner.wrap_constraints == null)
         {
            zpp_inner.wrap_constraints = ZPP_ConstraintList.get(zpp_inner.constraints,true);
         }
         return zpp_inner.wrap_constraints;
      }
      
      public function get constraintVelocity() : Vec3
      {
         if(zpp_inner.wrapcvel == null)
         {
            zpp_inner.setup_cvel();
         }
         return zpp_inner.wrapcvel;
      }
      
      public function get constraintMass() : Number
      {
         if(!zpp_inner.world)
         {
            zpp_inner.validate_mass();
         }
         return zpp_inner.smass;
      }
      
      public function get constraintInertia() : Number
      {
         if(!zpp_inner.world)
         {
            zpp_inner.validate_inertia();
         }
         return zpp_inner.sinertia;
      }
      
      public function get compound() : Compound
      {
         return zpp_inner.compound == null?null:zpp_inner.compound.outer;
      }
      
      public function get bounds() : AABB
      {
         return zpp_inner.aabb.wrapper();
      }
      
      public function get arbiters() : ArbiterList
      {
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         return zpp_inner.wrap_arbiters;
      }
      
      public function get angularVel() : Number
      {
         return zpp_inner.angvel;
      }
      
      public function get allowRotation() : Boolean
      {
         return !zpp_inner.norotate;
      }
      
      public function get allowMovement() : Boolean
      {
         return !zpp_inner.nomove;
      }
      
      public function dragImpulse(param1:Body = undefined) : Vec3
      {
         var _loc7_:* = null as Arbiter;
         var _loc8_:* = null as ZPP_Arbiter;
         var _loc9_:* = null as Vec3;
         var _loc10_:* = null as Arbiter;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:* = null as ZPP_Vec3;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc6_:* = zpp_inner.wrap_arbiters.iterator();
         while(_loc6_.hasNext())
         {
            _loc7_ = _loc6_.next();
            _loc8_ = _loc7_.zpp_inner;
            if(_loc8_.type == ZPP_Arbiter.FLUID)
            {
               if(!(param1 != null && _loc8_.b2 != param1.zpp_inner && _loc8_.b1 != param1.zpp_inner))
               {
                  _loc10_ = _loc8_.wrapper();
                  _loc9_ = (!!_loc10_.isFluidArbiter()?_loc10_.zpp_inner.fluidarb.outer_zn:null).dragImpulse(this);
                  _loc11_ = 1;
                  _loc12_ = _loc11_;
                  _loc13_ = _loc9_.zpp_inner;
                  §§push(_loc2_);
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc2_ = Number(§§pop() + _loc9_.zpp_inner.x * _loc12_);
                  _loc13_ = _loc9_.zpp_inner;
                  §§push(_loc3_);
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc3_ = Number(§§pop() + _loc9_.zpp_inner.y * _loc12_);
                  _loc13_ = _loc9_.zpp_inner;
                  §§push(_loc4_);
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc4_ = Number(§§pop() + _loc9_.zpp_inner.z * _loc11_);
                  _loc9_.dispose();
               }
            }
         }
         return Vec3.get(_loc2_,_loc3_,_loc4_);
      }
      
      public function crushFactor() : Number
      {
         var _loc4_:* = null as Arbiter;
         var _loc5_:* = null as Vec3;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as Constraint;
         var _loc1_:Number = 0;
         var _loc2_:Vec2 = Vec2.get();
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc3_:* = zpp_inner.wrap_arbiters.iterator();
         while(_loc3_.hasNext())
         {
            _loc4_ = _loc3_.next();
            _loc5_ = _loc4_.totalImpulse(this);
            _loc6_ = _loc5_.xy();
            _loc2_.addeq(_loc6_);
            _loc7_ = _loc6_.zpp_inner;
            §§push(_loc1_);
            §§push(Math);
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc7_ = _loc6_.zpp_inner;
            §§push(_loc6_.zpp_inner.x);
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc7_ = _loc6_.zpp_inner;
            §§push(§§pop() * _loc6_.zpp_inner.x);
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc7_ = _loc6_.zpp_inner;
            §§push(_loc6_.zpp_inner.y);
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc1_ = Number(§§pop() + Number(§§pop().sqrt(Number(§§pop() + §§pop() * _loc6_.zpp_inner.y))));
            _loc6_.dispose();
            _loc5_.dispose();
         }
         if(zpp_inner.wrap_constraints == null)
         {
            zpp_inner.wrap_constraints = ZPP_ConstraintList.get(zpp_inner.constraints,true);
         }
         _loc3_ = zpp_inner.wrap_constraints.iterator();
         while(_loc3_.hasNext())
         {
            _loc8_ = _loc3_.next();
            _loc5_ = _loc8_.bodyImpulse(this);
            _loc6_ = _loc5_.xy();
            _loc2_.addeq(_loc6_);
            _loc7_ = _loc6_.zpp_inner;
            §§push(_loc1_);
            §§push(Math);
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc7_ = _loc6_.zpp_inner;
            §§push(_loc6_.zpp_inner.x);
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc7_ = _loc6_.zpp_inner;
            §§push(§§pop() * _loc6_.zpp_inner.x);
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc7_ = _loc6_.zpp_inner;
            §§push(_loc6_.zpp_inner.y);
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc1_ = Number(§§pop() + Number(§§pop().sqrt(Number(§§pop() + §§pop() * _loc6_.zpp_inner.y))));
            _loc6_.dispose();
            _loc5_.dispose();
         }
         _loc7_ = _loc2_.zpp_inner;
         §§push(_loc1_);
         §§push(Math);
         if(_loc7_._validate != null)
         {
            _loc7_._validate();
         }
         _loc7_ = _loc2_.zpp_inner;
         §§push(_loc2_.zpp_inner.x);
         if(_loc7_._validate != null)
         {
            _loc7_._validate();
         }
         _loc7_ = _loc2_.zpp_inner;
         §§push(§§pop() * _loc2_.zpp_inner.x);
         if(_loc7_._validate != null)
         {
            _loc7_._validate();
         }
         _loc7_ = _loc2_.zpp_inner;
         §§push(_loc2_.zpp_inner.y);
         if(_loc7_._validate != null)
         {
            _loc7_._validate();
         }
         var _loc9_:Number = (§§pop() - §§pop().sqrt(Number(§§pop() + §§pop() * _loc2_.zpp_inner.y))) * (zpp_inner.space == null?null:zpp_inner.space.outer).zpp_inner.pre_dt;
         _loc2_.dispose();
         return _loc9_;
      }
      
      public function copy() : Body
      {
         var _loc1_:Body = zpp_inner.copy();
         _loc1_.zpp_inner.userData = zpp_inner.userData;
         return _loc1_;
      }
      
      public function contains(param1:Vec2) : Boolean
      {
         var _loc4_:* = null as ZPP_Shape;
         var _loc2_:Boolean = false;
         var _loc3_:ZNPNode_ZPP_Shape = zpp_inner.shapes.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
            if(_loc4_.outer.contains(param1))
            {
               _loc2_ = true;
               break;
            }
            _loc3_ = _loc3_.next;
         }
         return _loc2_;
      }
      
      public function constraintsImpulse() : Vec3
      {
         var _loc5_:* = null as ZPP_Constraint;
         var _loc6_:* = null as Vec3;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null as ZPP_Vec3;
         var _loc1_:Number = 0;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:ZNPNode_ZPP_Constraint = zpp_inner.constraints.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            _loc6_ = _loc5_.outer.bodyImpulse(this);
            _loc7_ = 1;
            _loc8_ = _loc7_;
            _loc9_ = _loc6_.zpp_inner;
            §§push(_loc1_);
            if(_loc9_._validate != null)
            {
               _loc9_._validate();
            }
            _loc1_ = Number(§§pop() + _loc6_.zpp_inner.x * _loc8_);
            _loc9_ = _loc6_.zpp_inner;
            §§push(_loc2_);
            if(_loc9_._validate != null)
            {
               _loc9_._validate();
            }
            _loc2_ = Number(§§pop() + _loc6_.zpp_inner.y * _loc8_);
            _loc9_ = _loc6_.zpp_inner;
            §§push(_loc3_);
            if(_loc9_._validate != null)
            {
               _loc9_._validate();
            }
            _loc3_ = Number(§§pop() + _loc6_.zpp_inner.z * _loc7_);
            _loc6_.dispose();
            _loc4_ = _loc4_.next;
         }
         return Vec3.get(_loc1_,_loc2_,_loc3_);
      }
      
      public function connectedBodies(param1:int = -1) : BodyList
      {
         return zpp_inner.connectedBodies(param1);
      }
      
      public function clear() : void
      {
         zpp_inner.immutable_midstep("Body::clear()");
         zpp_inner.clear();
         zpp_inner.userData = null;
         zpp_inner_i.immutable_midstep("Interactor::group");
         zpp_inner_i.setGroup(null);
         if(zpp_inner_i.group == null)
         {
            null;
         }
         else
         {
            zpp_inner_i.group.outer;
         }
         if(zpp_inner.compound == null)
         {
            null;
         }
         else
         {
            zpp_inner.compound.outer;
         }
      }
      
      public function buoyancyImpulse(param1:Body = undefined) : Vec3
      {
         var _loc7_:* = null as Arbiter;
         var _loc8_:* = null as ZPP_Arbiter;
         var _loc9_:* = null as Vec3;
         var _loc10_:* = null as Arbiter;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:* = null as ZPP_Vec3;
         var _loc2_:Number = 0;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:ZNPList_ZPP_Arbiter = zpp_inner.arbiters;
         if(zpp_inner.wrap_arbiters == null)
         {
            zpp_inner.wrap_arbiters = ZPP_ArbiterList.get(zpp_inner.arbiters,true);
         }
         var _loc6_:* = zpp_inner.wrap_arbiters.iterator();
         while(_loc6_.hasNext())
         {
            _loc7_ = _loc6_.next();
            _loc8_ = _loc7_.zpp_inner;
            if(_loc8_.type == ZPP_Arbiter.FLUID)
            {
               if(!(param1 != null && _loc8_.b2 != param1.zpp_inner && _loc8_.b1 != param1.zpp_inner))
               {
                  _loc10_ = _loc8_.wrapper();
                  _loc9_ = (!!_loc10_.isFluidArbiter()?_loc10_.zpp_inner.fluidarb.outer_zn:null).buoyancyImpulse(this);
                  _loc11_ = 1;
                  _loc12_ = _loc11_;
                  _loc13_ = _loc9_.zpp_inner;
                  §§push(_loc2_);
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc2_ = Number(§§pop() + _loc9_.zpp_inner.x * _loc12_);
                  _loc13_ = _loc9_.zpp_inner;
                  §§push(_loc3_);
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc3_ = Number(§§pop() + _loc9_.zpp_inner.y * _loc12_);
                  _loc13_ = _loc9_.zpp_inner;
                  §§push(_loc4_);
                  if(_loc13_._validate != null)
                  {
                     _loc13_._validate();
                  }
                  _loc4_ = Number(§§pop() + _loc9_.zpp_inner.z * _loc11_);
                  _loc9_.dispose();
               }
            }
         }
         return Vec3.get(_loc2_,_loc3_,_loc4_);
      }
      
      public function applyWorldImpulse(param1:Vec2, param2:Vec2 = undefined) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:Number = NaN;
         zpp_inner.validate_mass();
         _loc3_ = zpp_inner.imass;
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner);
         §§push(zpp_inner.velx);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().velx = Number(§§pop() + param1.zpp_inner.x * _loc3_);
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner);
         §§push(zpp_inner.vely);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().vely = Number(§§pop() + param1.zpp_inner.y * _loc3_);
         if(param2 != null)
         {
            _loc4_ = param2.zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc3_ = param2.zpp_inner.x - zpp_inner.posx;
            _loc4_ = param2.zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc5_ = param2.zpp_inner.y - zpp_inner.posy;
            zpp_inner.validate_inertia();
            _loc4_ = param1.zpp_inner;
            §§push(zpp_inner);
            §§push(zpp_inner.angvel);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param1.zpp_inner;
            §§push(param1.zpp_inner.y * _loc3_);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            §§pop().angvel = Number(§§pop() + (§§pop() - param1.zpp_inner.x * _loc5_) * zpp_inner.iinertia);
            if(param2.zpp_inner.weak)
            {
               param2.dispose();
            }
         }
         if(isDynamic())
         {
            zpp_inner.invalidate_wake();
         }
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
      }
      
      public function applyWorldForce(param1:Vec2, param2:Vec2 = undefined) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:Number = NaN;
         _loc3_ = 1;
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner);
         §§push(zpp_inner.forcex);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().forcex = Number(§§pop() + param1.zpp_inner.x * _loc3_);
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner);
         §§push(zpp_inner.forcey);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().forcey = Number(§§pop() + param1.zpp_inner.y * _loc3_);
         if(param2 != null)
         {
            _loc4_ = param2.zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc3_ = param2.zpp_inner.x - zpp_inner.posx;
            _loc4_ = param2.zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc5_ = param2.zpp_inner.y - zpp_inner.posy;
            _loc4_ = param1.zpp_inner;
            §§push(zpp_inner);
            §§push(zpp_inner.torque);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param1.zpp_inner;
            §§push(param1.zpp_inner.y * _loc3_);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            §§pop().torque = Number(§§pop() + (§§pop() - param1.zpp_inner.x * _loc5_));
            if(param2.zpp_inner.weak)
            {
               param2.dispose();
            }
         }
         if(isDynamic())
         {
            zpp_inner.invalidate_wake();
         }
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
      }
      
      public function applyRelativeImpulse(param1:Vec2, param2:Vec2 = undefined) : void
      {
         var _loc4_:* = null as ZPP_Vec2;
         zpp_inner.validate_mass();
         var _loc3_:Number = zpp_inner.imass;
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner);
         §§push(zpp_inner.velx);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().velx = Number(§§pop() + param1.zpp_inner.x * _loc3_);
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner);
         §§push(zpp_inner.vely);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().vely = Number(§§pop() + param1.zpp_inner.y * _loc3_);
         if(param2 != null)
         {
            zpp_inner.validate_inertia();
            _loc4_ = param1.zpp_inner;
            §§push(zpp_inner);
            §§push(zpp_inner.angvel);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param2.zpp_inner;
            §§push(param1.zpp_inner.y);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param1.zpp_inner;
            §§push(§§pop() * param2.zpp_inner.x);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param2.zpp_inner;
            §§push(param1.zpp_inner.x);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            §§pop().angvel = Number(§§pop() + (§§pop() - §§pop() * param2.zpp_inner.y) * zpp_inner.iinertia);
            if(param2.zpp_inner.weak)
            {
               param2.dispose();
            }
         }
         if(isDynamic())
         {
            zpp_inner.invalidate_wake();
         }
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
      }
      
      public function applyRelativeForce(param1:Vec2, param2:Vec2 = undefined) : void
      {
         var _loc4_:* = null as ZPP_Vec2;
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner);
         §§push(zpp_inner.forcex);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().forcex = Number(§§pop() + param1.zpp_inner.x * 1);
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner);
         §§push(zpp_inner.forcey);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().forcey = Number(§§pop() + param1.zpp_inner.y * 1);
         if(param2 != null)
         {
            _loc4_ = param1.zpp_inner;
            §§push(zpp_inner);
            §§push(zpp_inner.torque);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param2.zpp_inner;
            §§push(param1.zpp_inner.y);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param1.zpp_inner;
            §§push(§§pop() * param2.zpp_inner.x);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param2.zpp_inner;
            §§push(param1.zpp_inner.x);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            §§pop().torque = Number(§§pop() + (§§pop() - §§pop() * param2.zpp_inner.y));
            if(param2.zpp_inner.weak)
            {
               param2.dispose();
            }
         }
         if(isDynamic())
         {
            zpp_inner.invalidate_wake();
         }
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
      }
      
      public function applyLocalImpulse(param1:Vec2, param2:Vec2 = undefined) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Body;
         var _loc6_:Number = NaN;
         zpp_inner.validate_mass();
         _loc3_ = zpp_inner.imass;
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner);
         §§push(zpp_inner.velx);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().velx = Number(§§pop() + param1.zpp_inner.x * _loc3_);
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner);
         §§push(zpp_inner.vely);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().vely = Number(§§pop() + param1.zpp_inner.y * _loc3_);
         if(param2 != null)
         {
            _loc5_ = zpp_inner;
            if(_loc5_.zip_axis)
            {
               _loc5_.zip_axis = false;
               _loc5_.axisx = Number(Math.sin(_loc5_.rot));
               _loc5_.axisy = Number(Math.cos(_loc5_.rot));
               null;
            }
            _loc4_ = param2.zpp_inner;
            §§push(zpp_inner.axisy);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param2.zpp_inner;
            §§push(§§pop() * param2.zpp_inner.x);
            §§push(zpp_inner.axisx);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc3_ = §§pop() - §§pop() * param2.zpp_inner.y;
            _loc4_ = param2.zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param2.zpp_inner;
            §§push(param2.zpp_inner.x * zpp_inner.axisx);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc6_ = Number(§§pop() + param2.zpp_inner.y * zpp_inner.axisy);
            zpp_inner.validate_inertia();
            _loc4_ = param1.zpp_inner;
            §§push(zpp_inner);
            §§push(zpp_inner.angvel);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param1.zpp_inner;
            §§push(param1.zpp_inner.y * _loc3_);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            §§pop().angvel = Number(§§pop() + (§§pop() - param1.zpp_inner.x * _loc6_) * zpp_inner.iinertia);
            if(param2.zpp_inner.weak)
            {
               param2.dispose();
            }
         }
         if(isDynamic())
         {
            zpp_inner.invalidate_wake();
         }
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
      }
      
      public function applyLocalForce(param1:Vec2, param2:Vec2 = undefined) : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Body;
         var _loc6_:Number = NaN;
         _loc3_ = 1;
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner);
         §§push(zpp_inner.forcex);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().forcex = Number(§§pop() + param1.zpp_inner.x * _loc3_);
         _loc4_ = param1.zpp_inner;
         §§push(zpp_inner);
         §§push(zpp_inner.forcey);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         §§pop().forcey = Number(§§pop() + param1.zpp_inner.y * _loc3_);
         if(param2 != null)
         {
            _loc5_ = zpp_inner;
            if(_loc5_.zip_axis)
            {
               _loc5_.zip_axis = false;
               _loc5_.axisx = Number(Math.sin(_loc5_.rot));
               _loc5_.axisy = Number(Math.cos(_loc5_.rot));
               null;
            }
            _loc4_ = param2.zpp_inner;
            §§push(zpp_inner.axisy);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param2.zpp_inner;
            §§push(§§pop() * param2.zpp_inner.x);
            §§push(zpp_inner.axisx);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc3_ = §§pop() - §§pop() * param2.zpp_inner.y;
            _loc4_ = param2.zpp_inner;
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param2.zpp_inner;
            §§push(param2.zpp_inner.x * zpp_inner.axisx);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc6_ = Number(§§pop() + param2.zpp_inner.y * zpp_inner.axisy);
            _loc4_ = param1.zpp_inner;
            §§push(zpp_inner);
            §§push(zpp_inner.torque);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            _loc4_ = param1.zpp_inner;
            §§push(param1.zpp_inner.y * _loc3_);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            §§pop().torque = Number(§§pop() + (§§pop() - param1.zpp_inner.x * _loc6_));
            if(param2.zpp_inner.weak)
            {
               param2.dispose();
            }
         }
         if(isDynamic())
         {
            zpp_inner.invalidate_wake();
         }
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
      }
      
      public function align() : void
      {
         var _loc3_:Number = NaN;
         var _loc4_:* = null as ZPP_Vec2;
         zpp_inner.immutable_midstep("Body::align()");
         zpp_inner.validate_localCOM();
         var _loc1_:Vec2 = Vec2.get(-zpp_inner.localCOMx,-zpp_inner.localCOMy);
         translateShapes(_loc1_);
         var _loc2_:Vec2 = localToRelative(_loc1_);
         if(zpp_inner.wrap_pos == null)
         {
            zpp_inner.setupPosition();
         }
         zpp_inner.wrap_pos.subeq(_loc2_);
         if(zpp_inner.pre_posx < 1.79e308)
         {
            _loc3_ = 1;
            _loc4_ = _loc2_.zpp_inner;
            §§push(zpp_inner);
            §§push(zpp_inner.pre_posx);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            §§pop().pre_posx = §§pop() - _loc2_.zpp_inner.x * _loc3_;
            _loc4_ = _loc2_.zpp_inner;
            §§push(zpp_inner);
            §§push(zpp_inner.pre_posy);
            if(_loc4_._validate != null)
            {
               _loc4_._validate();
            }
            §§pop().pre_posy = §§pop() - _loc2_.zpp_inner.y * _loc3_;
         }
         _loc1_.dispose();
         _loc2_.dispose();
      }
   }
}
