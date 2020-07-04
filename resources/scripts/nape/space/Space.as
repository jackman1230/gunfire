package nape.space
{
   import flash.Boot;
   import nape.callbacks.InteractionType;
   import nape.callbacks.ListenerList;
   import nape.constraint.Constraint;
   import nape.constraint.ConstraintList;
   import nape.dynamics.ArbiterList;
   import nape.dynamics.InteractionFilter;
   import nape.geom.AABB;
   import nape.geom.Ray;
   import nape.geom.RayResult;
   import nape.geom.RayResultList;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyList;
   import nape.phys.Compound;
   import nape.phys.CompoundList;
   import nape.shape.Shape;
   import nape.shape.ShapeList;
   import zpp_nape.constraint.ZPP_Constraint;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.dynamics.ZPP_InteractionGroup;
   import zpp_nape.dynamics.ZPP_SpaceArbiterList;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_Compound;
   import zpp_nape.phys.ZPP_Interactor;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZNPNode_ZPP_Constraint;
   import zpp_nape.util.ZPP_Flags;
   
   public class Space
   {
       
      
      public var zpp_inner:ZPP_Space;
      
      public function Space(param1:Vec2 = undefined, param2:Broadphase = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = new ZPP_Space(param1 == null?null:param1.zpp_inner,param2);
         zpp_inner.outer = this;
         if(param1 != null)
         {
            if(param1.zpp_inner.weak)
            {
               param1.dispose();
            }
         }
      }
      
      public function visitConstraints(param1:Function) : void
      {
         var _loc3_:* = null as Constraint;
         var _loc4_:* = null as Compound;
         var _loc2_:* = zpp_inner.wrap_constraints.iterator();
         while(_loc2_.hasNext())
         {
            _loc3_ = _loc2_.next();
            param1(_loc3_);
         }
         _loc2_ = zpp_inner.wrap_compounds.iterator();
         while(_loc2_.hasNext())
         {
            _loc4_ = _loc2_.next();
            _loc4_.visitConstraints(param1);
         }
      }
      
      public function visitCompounds(param1:Function) : void
      {
         var _loc3_:* = null as Compound;
         var _loc2_:* = zpp_inner.wrap_compounds.iterator();
         while(_loc2_.hasNext())
         {
            _loc3_ = _loc2_.next();
            param1(_loc3_);
            _loc3_.visitCompounds(param1);
         }
      }
      
      public function visitBodies(param1:Function) : void
      {
         var _loc3_:* = null as Body;
         var _loc4_:* = null as Compound;
         var _loc2_:* = zpp_inner.wrap_bodies.iterator();
         while(_loc2_.hasNext())
         {
            _loc3_ = _loc2_.next();
            param1(_loc3_);
         }
         _loc2_ = zpp_inner.wrap_compounds.iterator();
         while(_loc2_.hasNext())
         {
            _loc4_ = _loc2_.next();
            _loc4_.visitBodies(param1);
         }
      }
      
      public function step(param1:Number, param2:int = 10, param3:int = 10) : void
      {
         zpp_inner.step(param1,param2,param3);
      }
      
      public function shapesUnderPoint(param1:Vec2, param2:InteractionFilter = undefined) : ShapeList
      {
         var _loc4_:ZPP_Vec2 = param1.zpp_inner;
         §§push(zpp_inner);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc4_ = param1.zpp_inner;
         §§push(param1.zpp_inner.x);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc3_:ShapeList = §§pop().shapesUnderPoint(§§pop(),param1.zpp_inner.y,param2 == null?null:param2.zpp_inner);
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc3_;
      }
      
      public function shapesInShape(param1:Shape, param2:Boolean = false, param3:InteractionFilter = undefined) : ShapeList
      {
         return zpp_inner.shapesInShape(param1.zpp_inner,param2,param3 == null?null:param3.zpp_inner);
      }
      
      public function shapesInCircle(param1:Vec2, param2:Number, param3:Boolean = false, param4:InteractionFilter = undefined) : ShapeList
      {
         var _loc5_:ShapeList = zpp_inner.shapesInCircle(param1,param2,param3,param4 == null?null:param4.zpp_inner);
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc5_;
      }
      
      public function shapesInBody(param1:Body, param2:InteractionFilter = undefined) : ShapeList
      {
         var _loc5_:* = null as Shape;
         var _loc6_:* = null as ShapeList;
         var _loc3_:ShapeList = null;
         var _loc4_:* = param1.zpp_inner.wrap_shapes.iterator();
         while(_loc4_.hasNext())
         {
            _loc5_ = _loc4_.next();
            _loc6_ = shapesInShape(_loc5_,false,param2);
            if(_loc3_ == null)
            {
               _loc3_ = _loc6_;
            }
            else
            {
               _loc3_.merge(_loc6_);
            }
         }
         return _loc3_ == null?new ShapeList():_loc3_;
      }
      
      public function shapesInAABB(param1:AABB, param2:Boolean = false, param3:Boolean = true, param4:InteractionFilter = undefined) : ShapeList
      {
         return zpp_inner.shapesInAABB(param1,param3,param2,param4 == null?null:param4.zpp_inner);
      }
      
      public function set worldLinearDrag(param1:Number) : Number
      {
         var _loc2_:Number = param1;
         zpp_inner.global_lin_drag = _loc2_;
         return zpp_inner.global_lin_drag;
      }
      
      public function set worldAngularDrag(param1:Number) : Number
      {
         var _loc2_:Number = param1;
         zpp_inner.global_ang_drag = _loc2_;
         return zpp_inner.global_ang_drag;
      }
      
      public function set sortContacts(param1:Boolean) : Boolean
      {
         zpp_inner.sortcontacts = param1;
         return zpp_inner.sortcontacts;
      }
      
      public function set gravity(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         if(zpp_inner.wrap_gravity == null)
         {
            zpp_inner.getgravity();
         }
         var _loc2_:Vec2 = zpp_inner.wrap_gravity;
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
         if(zpp_inner.wrap_gravity == null)
         {
            zpp_inner.getgravity();
         }
         return zpp_inner.wrap_gravity;
      }
      
      public function rayMultiCast(param1:Ray, param2:Boolean = false, param3:InteractionFilter = undefined) : RayResultList
      {
         return zpp_inner.rayMultiCast(param1,param2,param3);
      }
      
      public function rayCast(param1:Ray, param2:Boolean = false, param3:InteractionFilter = undefined) : RayResult
      {
         return zpp_inner.rayCast(param1,param2,param3);
      }
      
      public function interactionType(param1:Shape, param2:Shape) : InteractionType
      {
         var _loc9_:* = null as ZPP_Constraint;
         var _loc10_:* = null as ZPP_InteractionGroup;
         var _loc11_:* = null as ZPP_Interactor;
         var _loc12_:* = null as ZPP_InteractionGroup;
         var _loc13_:Boolean = false;
         var _loc14_:* = null as ZPP_InteractionFilter;
         var _loc15_:* = null as ZPP_InteractionFilter;
         if(!!(param1.zpp_inner.body != null?param1.zpp_inner.body.outer:null).isStatic() && (param2.zpp_inner.body != null?param2.zpp_inner.body.outer:null).isStatic())
         {
            return null;
         }
         if((param1.zpp_inner.body != null?param1.zpp_inner.body.outer:null) == (param2.zpp_inner.body != null?param2.zpp_inner.body.outer:null))
         {
            return null;
         }
         var _loc3_:ZPP_Shape = param1.zpp_inner;
         var _loc4_:ZPP_Shape = param2.zpp_inner;
         var _loc5_:ZPP_Body = _loc3_.body;
         var _loc6_:ZPP_Body = _loc4_.body;
         var _loc7_:Boolean = false;
         var _loc8_:ZNPNode_ZPP_Constraint = _loc5_.constraints.head;
         while(_loc8_ != null)
         {
            _loc9_ = _loc8_.elt;
            if(!!_loc9_.ignore && _loc9_.pair_exists(_loc5_.id,_loc6_.id))
            {
               _loc7_ = true;
               break;
            }
            _loc8_ = _loc8_.next;
         }
         if((_loc3_.fluidEnabled || _loc4_.fluidEnabled) && ((_loc14_.fluidMask & _loc15_.fluidGroup) != 0 && (_loc15_.fluidMask & _loc14_.fluidGroup) != 0) && !(!!_loc3_.fluidEnabled && _loc5_.type == ZPP_Flags.id_BodyType_DYNAMIC && !_loc4_.fluidEnabled && _loc6_.type != ZPP_Flags.id_BodyType_DYNAMIC || !!_loc4_.fluidEnabled && _loc6_.type == ZPP_Flags.id_BodyType_DYNAMIC && !_loc3_.fluidEnabled && _loc5_.type != ZPP_Flags.id_BodyType_DYNAMIC || !!_loc3_.fluidEnabled && _loc5_.type != ZPP_Flags.id_BodyType_DYNAMIC && _loc6_.type != ZPP_Flags.id_BodyType_DYNAMIC || !!_loc4_.fluidEnabled && _loc6_.type != ZPP_Flags.id_BodyType_DYNAMIC && _loc5_.type != ZPP_Flags.id_BodyType_DYNAMIC))
         {
            §§push(0);
         }
         else
         {
            _loc14_ = _loc3_.filter;
            _loc15_ = _loc4_.filter;
            if((_loc14_.collisionMask & _loc15_.collisionGroup) != 0 && (_loc15_.collisionMask & _loc14_.collisionGroup) != 0 && !(_loc5_.imass == 0 && _loc6_.imass == 0 && _loc5_.iinertia == 0 && _loc6_.iinertia == 0))
            {
               §§push(1);
            }
            else
            {
               _loc14_ = _loc3_.filter;
               _loc15_ = _loc4_.filter;
               §§push((_loc14_.sensorMask & _loc15_.sensorGroup) != 0 && (_loc15_.sensorMask & _loc14_.sensorGroup) != 0?2:-1);
            }
         }
         switch(§§pop())
         {
            case 0:
               if(ZPP_Flags.InteractionType_FLUID == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.InteractionType_FLUID = new InteractionType();
                  ZPP_Flags.§internal§ = false;
               }
               §§push(ZPP_Flags.InteractionType_FLUID);
               break;
            case 1:
               if(ZPP_Flags.InteractionType_COLLISION == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.InteractionType_COLLISION = new InteractionType();
                  ZPP_Flags.§internal§ = false;
               }
               §§push(ZPP_Flags.InteractionType_COLLISION);
               break;
            case 2:
               if(ZPP_Flags.InteractionType_SENSOR == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                  ZPP_Flags.§internal§ = false;
               }
               §§push(ZPP_Flags.InteractionType_SENSOR);
         }
         return §§pop();
      }
      
      public function get worldLinearDrag() : Number
      {
         return zpp_inner.global_lin_drag;
      }
      
      public function get worldAngularDrag() : Number
      {
         return zpp_inner.global_ang_drag;
      }
      
      public function get world() : Body
      {
         return zpp_inner.__static;
      }
      
      public function get userData() : *
      {
         if(zpp_inner.userData == null)
         {
            zpp_inner.userData = {};
         }
         return zpp_inner.userData;
      }
      
      public function get timeStamp() : int
      {
         return zpp_inner.stamp;
      }
      
      public function get sortContacts() : Boolean
      {
         return zpp_inner.sortcontacts;
      }
      
      public function get liveConstraints() : ConstraintList
      {
         return zpp_inner.wrap_livecon;
      }
      
      public function get liveBodies() : BodyList
      {
         return zpp_inner.wrap_live;
      }
      
      public function get listeners() : ListenerList
      {
         return zpp_inner.wrap_listeners;
      }
      
      public function get id() : int
      {
         return zpp_inner.id;
      }
      
      public function get gravity() : Vec2
      {
         if(zpp_inner.wrap_gravity == null)
         {
            zpp_inner.getgravity();
         }
         return zpp_inner.wrap_gravity;
      }
      
      public function get elapsedTime() : Number
      {
         return zpp_inner.time;
      }
      
      public function get constraints() : ConstraintList
      {
         return zpp_inner.wrap_constraints;
      }
      
      public function get compounds() : CompoundList
      {
         return zpp_inner.wrap_compounds;
      }
      
      public function get broadphase() : Broadphase
      {
         if(zpp_inner.bphase.is_sweep)
         {
            if(ZPP_Flags.Broadphase_SWEEP_AND_PRUNE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.Broadphase_SWEEP_AND_PRUNE = new Broadphase();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.Broadphase_SWEEP_AND_PRUNE);
         }
         else
         {
            if(ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE = new Broadphase();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE);
         }
         return §§pop();
      }
      
      public function get bodies() : BodyList
      {
         return zpp_inner.wrap_bodies;
      }
      
      public function get arbiters() : ArbiterList
      {
         var _loc1_:* = null as ZPP_SpaceArbiterList;
         if(zpp_inner.wrap_arbiters == null)
         {
            _loc1_ = new ZPP_SpaceArbiterList();
            _loc1_.space = zpp_inner;
            zpp_inner.wrap_arbiters = _loc1_;
         }
         return zpp_inner.wrap_arbiters;
      }
      
      public function clear() : void
      {
         zpp_inner.clear();
      }
      
      public function bodiesUnderPoint(param1:Vec2, param2:InteractionFilter = undefined) : BodyList
      {
         var _loc4_:ZPP_Vec2 = param1.zpp_inner;
         §§push(zpp_inner);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc4_ = param1.zpp_inner;
         §§push(param1.zpp_inner.x);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc3_:BodyList = §§pop().bodiesUnderPoint(§§pop(),param1.zpp_inner.y,param2 == null?null:param2.zpp_inner);
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc3_;
      }
      
      public function bodiesInShape(param1:Shape, param2:Boolean = false, param3:InteractionFilter = undefined) : BodyList
      {
         return zpp_inner.bodiesInShape(param1.zpp_inner,param2,param3 == null?null:param3.zpp_inner);
      }
      
      public function bodiesInCircle(param1:Vec2, param2:Number, param3:Boolean = false, param4:InteractionFilter = undefined) : BodyList
      {
         var _loc5_:BodyList = zpp_inner.bodiesInCircle(param1,param2,param3,param4 == null?null:param4.zpp_inner);
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc5_;
      }
      
      public function bodiesInBody(param1:Body, param2:InteractionFilter = undefined) : BodyList
      {
         var _loc5_:* = null as Shape;
         var _loc6_:* = null as BodyList;
         var _loc3_:BodyList = null;
         var _loc4_:* = param1.zpp_inner.wrap_shapes.iterator();
         while(_loc4_.hasNext())
         {
            _loc5_ = _loc4_.next();
            _loc6_ = bodiesInShape(_loc5_,false,param2);
            if(_loc3_ == null)
            {
               _loc3_ = _loc6_;
            }
            else
            {
               _loc3_.merge(_loc6_);
            }
         }
         return _loc3_ == null?new BodyList():_loc3_;
      }
      
      public function bodiesInAABB(param1:AABB, param2:Boolean = false, param3:Boolean = true, param4:InteractionFilter = undefined) : BodyList
      {
         return zpp_inner.bodiesInAABB(param1,param3,param2,param4 == null?null:param4.zpp_inner);
      }
   }
}
