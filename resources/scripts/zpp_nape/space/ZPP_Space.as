package zpp_nape.space
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.callbacks.BodyCallback;
   import nape.callbacks.ConstraintCallback;
   import nape.callbacks.InteractionCallback;
   import nape.callbacks.Listener;
   import nape.callbacks.ListenerList;
   import nape.callbacks.PreCallback;
   import nape.callbacks.PreFlag;
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
   import nape.shape.ShapeList;
   import nape.space.Broadphase;
   import nape.space.Space;
   import zpp_nape.ZPP_ID;
   import zpp_nape.callbacks.ZPP_BodyListener;
   import zpp_nape.callbacks.ZPP_Callback;
   import zpp_nape.callbacks.ZPP_CbSet;
   import zpp_nape.callbacks.ZPP_CbSetPair;
   import zpp_nape.callbacks.ZPP_ConstraintListener;
   import zpp_nape.callbacks.ZPP_InteractionListener;
   import zpp_nape.callbacks.ZPP_Listener;
   import zpp_nape.callbacks.ZPP_OptionType;
   import zpp_nape.constraint.ZPP_Constraint;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.dynamics.ZPP_ColArbiter;
   import zpp_nape.dynamics.ZPP_Contact;
   import zpp_nape.dynamics.ZPP_FluidArbiter;
   import zpp_nape.dynamics.ZPP_IContact;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.dynamics.ZPP_InteractionGroup;
   import zpp_nape.dynamics.ZPP_SensorArbiter;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Collide;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_Compound;
   import zpp_nape.phys.ZPP_Interactor;
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.shape.ZPP_Edge;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZNPList_ZPP_Arbiter;
   import zpp_nape.util.ZNPList_ZPP_Body;
   import zpp_nape.util.ZNPList_ZPP_CallbackSet;
   import zpp_nape.util.ZNPList_ZPP_CbSetPair;
   import zpp_nape.util.ZNPList_ZPP_CbType;
   import zpp_nape.util.ZNPList_ZPP_ColArbiter;
   import zpp_nape.util.ZNPList_ZPP_Component;
   import zpp_nape.util.ZNPList_ZPP_Compound;
   import zpp_nape.util.ZNPList_ZPP_Constraint;
   import zpp_nape.util.ZNPList_ZPP_FluidArbiter;
   import zpp_nape.util.ZNPList_ZPP_InteractionListener;
   import zpp_nape.util.ZNPList_ZPP_Interactor;
   import zpp_nape.util.ZNPList_ZPP_Listener;
   import zpp_nape.util.ZNPList_ZPP_SensorArbiter;
   import zpp_nape.util.ZNPNode_ZPP_Arbiter;
   import zpp_nape.util.ZNPNode_ZPP_Body;
   import zpp_nape.util.ZNPNode_ZPP_BodyListener;
   import zpp_nape.util.ZNPNode_ZPP_CallbackSet;
   import zpp_nape.util.ZNPNode_ZPP_CbSetPair;
   import zpp_nape.util.ZNPNode_ZPP_ColArbiter;
   import zpp_nape.util.ZNPNode_ZPP_Component;
   import zpp_nape.util.ZNPNode_ZPP_Compound;
   import zpp_nape.util.ZNPNode_ZPP_Constraint;
   import zpp_nape.util.ZNPNode_ZPP_ConstraintListener;
   import zpp_nape.util.ZNPNode_ZPP_Edge;
   import zpp_nape.util.ZNPNode_ZPP_FluidArbiter;
   import zpp_nape.util.ZNPNode_ZPP_InteractionListener;
   import zpp_nape.util.ZNPNode_ZPP_Interactor;
   import zpp_nape.util.ZNPNode_ZPP_Listener;
   import zpp_nape.util.ZNPNode_ZPP_SensorArbiter;
   import zpp_nape.util.ZNPNode_ZPP_Shape;
   import zpp_nape.util.ZPP_BodyList;
   import zpp_nape.util.ZPP_CompoundList;
   import zpp_nape.util.ZPP_ConstraintList;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_ListenerList;
   import zpp_nape.util.ZPP_Set_ZPP_CbSet;
   
   public class ZPP_Space
   {
       
      
      public var wrap_livecon:ConstraintList;
      
      public var wrap_live:BodyList;
      
      public var wrap_listeners:ListenerList;
      
      public var wrap_gravity:Vec2;
      
      public var wrap_constraints:ConstraintList;
      
      public var wrap_compounds:CompoundList;
      
      public var wrap_bodies:BodyList;
      
      public var wrap_arbiters:ArbiterList;
      
      public var userData;
      
      public var time:Number;
      
      public var staticsleep:ZNPList_ZPP_Body;
      
      public var stamp:int;
      
      public var sortcontacts:Boolean;
      
      public var s_arbiters:ZNPList_ZPP_SensorArbiter;
      
      public var prelisteners:ZNPList_ZPP_InteractionListener;
      
      public var precb:PreCallback;
      
      public var pre_dt:Number;
      
      public var outer:Space;
      
      public var mrca2:ZNPList_ZPP_Interactor;
      
      public var mrca1:ZNPList_ZPP_Interactor;
      
      public var midstep:Boolean;
      
      public var live_constraints:ZNPList_ZPP_Constraint;
      
      public var live:ZNPList_ZPP_Body;
      
      public var listeners:ZNPList_ZPP_Listener;
      
      public var kinematics:ZNPList_ZPP_Body;
      
      public var islands:ZPP_Island;
      
      public var id:int;
      
      public var gravityy:Number;
      
      public var gravityx:Number;
      
      public var global_lin_drag:Number;
      
      public var global_ang_drag:Number;
      
      public var f_arbiters:ZNPList_ZPP_FluidArbiter;
      
      public var constraints:ZNPList_ZPP_Constraint;
      
      public var compounds:ZNPList_ZPP_Compound;
      
      public var cbsets:ZPP_CbSetManager;
      
      public var callbackset_list:ZPP_CallbackSet;
      
      public var callbacks:ZPP_Callback;
      
      public var c_arbiters_true:ZNPList_ZPP_ColArbiter;
      
      public var c_arbiters_false:ZNPList_ZPP_ColArbiter;
      
      public var bphase:ZPP_Broadphase;
      
      public var bodies:ZNPList_ZPP_Body;
      
      public var __static:Body;
      
      public function ZPP_Space(param1:ZPP_Vec2 = undefined, param2:Broadphase = undefined)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         global_lin_drag = 0.015;
         global_ang_drag = 0.015;
         precb = new PreCallback();
         precb.zpp_inner = new ZPP_Callback();
         id = int(ZPP_ID.Space());
         sortcontacts = true;
         pre_dt = 0;
         if(param2 == null || §§pop() == ZPP_Flags.Broadphase_DYNAMIC_AABB_TREE)
         {
            bphase = new ZPP_DynAABBPhase(this);
         }
         else
         {
            §§push(param2);
            if(ZPP_Flags.Broadphase_SWEEP_AND_PRUNE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.Broadphase_SWEEP_AND_PRUNE = new Broadphase();
               ZPP_Flags.§internal§ = false;
            }
            if(§§pop() == ZPP_Flags.Broadphase_SWEEP_AND_PRUNE)
            {
               bphase = new ZPP_SweepPhase(this);
            }
         }
         time = 0;
         if(param1 != null)
         {
            gravityx = param1.x;
            gravityy = param1.y;
         }
         else
         {
            gravityx = 0;
            gravityy = 0;
         }
         bodies = new ZNPList_ZPP_Body();
         wrap_bodies = ZPP_BodyList.get(bodies);
         wrap_bodies.zpp_inner.adder = bodies_adder;
         wrap_bodies.zpp_inner.subber = bodies_subber;
         compounds = new ZNPList_ZPP_Compound();
         wrap_compounds = ZPP_CompoundList.get(compounds);
         wrap_compounds.zpp_inner.adder = compounds_adder;
         wrap_compounds.zpp_inner.subber = compounds_subber;
         kinematics = new ZNPList_ZPP_Body();
         c_arbiters_true = new ZNPList_ZPP_ColArbiter();
         c_arbiters_false = new ZNPList_ZPP_ColArbiter();
         f_arbiters = new ZNPList_ZPP_FluidArbiter();
         s_arbiters = new ZNPList_ZPP_SensorArbiter();
         islands = new ZPP_Island();
         live = new ZNPList_ZPP_Body();
         wrap_live = ZPP_BodyList.get(live,true);
         staticsleep = new ZNPList_ZPP_Body();
         constraints = new ZNPList_ZPP_Constraint();
         wrap_constraints = ZPP_ConstraintList.get(constraints);
         wrap_constraints.zpp_inner.adder = constraints_adder;
         wrap_constraints.zpp_inner.subber = constraints_subber;
         live_constraints = new ZNPList_ZPP_Constraint();
         wrap_livecon = ZPP_ConstraintList.get(live_constraints,true);
         __static = ZPP_Body.__static();
         __static.zpp_inner.space = this;
         callbacks = new ZPP_Callback();
         midstep = false;
         listeners = new ZNPList_ZPP_Listener();
         wrap_listeners = ZPP_ListenerList.get(listeners);
         wrap_listeners.zpp_inner.adder = listeners_adder;
         wrap_listeners.zpp_inner.subber = listeners_subber;
         callbackset_list = new ZPP_CallbackSet();
         mrca1 = new ZNPList_ZPP_Interactor();
         mrca2 = new ZNPList_ZPP_Interactor();
         prelisteners = new ZNPList_ZPP_InteractionListener();
         cbsets = new ZPP_CbSetManager(this);
      }
      
      public function warmStart() : void
      {
         var _loc2_:* = null as ZPP_FluidArbiter;
         var _loc3_:Number = NaN;
         var _loc6_:* = null as ZPP_ColArbiter;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc10_:* = null as ZPP_Constraint;
         var _loc1_:ZNPNode_ZPP_FluidArbiter = f_arbiters.head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.elt;
            if(!!_loc2_.active && (_loc2_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
            {
               _loc3_ = _loc2_.b1.imass;
               _loc2_.b1.velx = _loc2_.b1.velx - _loc2_.dampx * _loc3_;
               _loc2_.b1.vely = _loc2_.b1.vely - _loc2_.dampy * _loc3_;
               _loc3_ = _loc2_.b2.imass;
               _loc2_.b2.velx = Number(_loc2_.b2.velx + _loc2_.dampx * _loc3_);
               _loc2_.b2.vely = Number(_loc2_.b2.vely + _loc2_.dampy * _loc3_);
               _loc2_.b1.angvel = _loc2_.b1.angvel - _loc2_.b1.iinertia * (_loc2_.dampy * _loc2_.r1x - _loc2_.dampx * _loc2_.r1y);
               _loc2_.b2.angvel = Number(_loc2_.b2.angvel + _loc2_.b2.iinertia * (_loc2_.dampy * _loc2_.r2x - _loc2_.dampx * _loc2_.r2y));
               _loc2_.b1.angvel = _loc2_.b1.angvel - _loc2_.adamp * _loc2_.b1.iinertia;
               _loc2_.b2.angvel = Number(_loc2_.b2.angvel + _loc2_.adamp * _loc2_.b2.iinertia);
               _loc2_.pdampx = _loc2_.dampx;
               _loc2_.pdampy = _loc2_.dampy;
               _loc2_.padamp = _loc2_.adamp;
            }
            _loc1_ = _loc1_.next;
         }
         var _loc4_:ZNPNode_ZPP_ColArbiter = c_arbiters_false.head;
         var _loc5_:Boolean = true;
         if(_loc4_ == null)
         {
            _loc4_ = c_arbiters_true.head;
            _loc5_ = false;
         }
         while(_loc4_ != null)
         {
            _loc6_ = _loc4_.elt;
            if(!!_loc6_.active && (_loc6_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
            {
               _loc3_ = _loc6_.nx * _loc6_.c1.jnAcc - _loc6_.ny * _loc6_.c1.jtAcc;
               _loc7_ = Number(_loc6_.ny * _loc6_.c1.jnAcc + _loc6_.nx * _loc6_.c1.jtAcc);
               _loc8_ = _loc6_.b1.imass;
               _loc6_.b1.velx = _loc6_.b1.velx - _loc3_ * _loc8_;
               _loc6_.b1.vely = _loc6_.b1.vely - _loc7_ * _loc8_;
               _loc6_.b1.angvel = _loc6_.b1.angvel - _loc6_.b1.iinertia * (_loc7_ * _loc6_.c1.r1x - _loc3_ * _loc6_.c1.r1y);
               _loc8_ = _loc6_.b2.imass;
               _loc6_.b2.velx = Number(_loc6_.b2.velx + _loc3_ * _loc8_);
               _loc6_.b2.vely = Number(_loc6_.b2.vely + _loc7_ * _loc8_);
               _loc6_.b2.angvel = Number(_loc6_.b2.angvel + _loc6_.b2.iinertia * (_loc7_ * _loc6_.c1.r2x - _loc3_ * _loc6_.c1.r2y));
               if(_loc6_.hc2)
               {
                  _loc3_ = _loc6_.nx * _loc6_.c2.jnAcc - _loc6_.ny * _loc6_.c2.jtAcc;
                  _loc7_ = Number(_loc6_.ny * _loc6_.c2.jnAcc + _loc6_.nx * _loc6_.c2.jtAcc);
                  _loc8_ = _loc6_.b1.imass;
                  _loc6_.b1.velx = _loc6_.b1.velx - _loc3_ * _loc8_;
                  _loc6_.b1.vely = _loc6_.b1.vely - _loc7_ * _loc8_;
                  _loc6_.b1.angvel = _loc6_.b1.angvel - _loc6_.b1.iinertia * (_loc7_ * _loc6_.c2.r1x - _loc3_ * _loc6_.c2.r1y);
                  _loc8_ = _loc6_.b2.imass;
                  _loc6_.b2.velx = Number(_loc6_.b2.velx + _loc3_ * _loc8_);
                  _loc6_.b2.vely = Number(_loc6_.b2.vely + _loc7_ * _loc8_);
                  _loc6_.b2.angvel = Number(_loc6_.b2.angvel + _loc6_.b2.iinertia * (_loc7_ * _loc6_.c2.r2x - _loc3_ * _loc6_.c2.r2y));
               }
               _loc6_.b2.angvel = Number(_loc6_.b2.angvel + _loc6_.jrAcc * _loc6_.b2.iinertia);
               _loc6_.b1.angvel = _loc6_.b1.angvel - _loc6_.jrAcc * _loc6_.b1.iinertia;
               _loc6_.oc1.pjnAcc = _loc6_.c1.jnAcc;
               _loc6_.oc1.pjtAcc = _loc6_.c1.jtAcc;
               if(_loc6_.hc2)
               {
                  _loc6_.oc2.pjnAcc = _loc6_.c2.jnAcc;
                  _loc6_.oc2.pjtAcc = _loc6_.c2.jtAcc;
               }
               _loc6_.pjrAcc = _loc6_.jrAcc;
            }
            _loc4_ = _loc4_.next;
            if(!!_loc5_ && _loc4_ == null)
            {
               _loc4_ = c_arbiters_true.head;
               _loc5_ = false;
            }
         }
         var _loc9_:ZNPNode_ZPP_Constraint = live_constraints.head;
         while(_loc9_ != null)
         {
            _loc10_ = _loc9_.elt;
            _loc10_.warmStart();
            _loc9_ = _loc9_.next;
         }
      }
      
      public function wake_constraint(param1:ZPP_Constraint, param2:Boolean = false) : Boolean
      {
         var _loc3_:* = null as ZNPList_ZPP_Constraint;
         var _loc4_:* = null as ZNPNode_ZPP_Constraint;
         var _loc5_:* = null as ZNPNode_ZPP_Constraint;
         if(param1.active)
         {
            param1.component.waket = stamp + (!!midstep?0:1);
            if(param1.component.sleeping)
            {
               if(param1.component.island == null)
               {
                  param1.component.sleeping = false;
                  _loc3_ = live_constraints;
                  if(ZNPNode_ZPP_Constraint.zpp_pool == null)
                  {
                     _loc5_ = new ZNPNode_ZPP_Constraint();
                  }
                  else
                  {
                     _loc5_ = ZNPNode_ZPP_Constraint.zpp_pool;
                     ZNPNode_ZPP_Constraint.zpp_pool = _loc5_.next;
                     _loc5_.next = null;
                  }
                  null;
                  _loc5_.elt = param1;
                  _loc4_ = _loc5_;
                  _loc4_.next = _loc3_.head;
                  _loc3_.head = _loc4_;
                  _loc3_.modified = true;
                  _loc3_.length = _loc3_.length + 1;
                  param1;
                  param1.wake_connected();
                  if(!param2)
                  {
                     constraintCbWake(param1);
                  }
               }
               else
               {
                  wakeIsland(param1.component.island);
               }
               return true;
            }
            return false;
         }
         return false;
      }
      
      public function wakeIsland(param1:ZPP_Island) : void
      {
         var _loc2_:* = null as ZPP_Component;
         var _loc3_:* = null as ZPP_Body;
         var _loc4_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc5_:* = null as ZPP_Arbiter;
         var _loc6_:* = null as ZPP_ColArbiter;
         var _loc7_:* = null as ZNPList_ZPP_ColArbiter;
         var _loc8_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc9_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc10_:* = null as ZNPList_ZPP_FluidArbiter;
         var _loc11_:* = null as ZPP_FluidArbiter;
         var _loc12_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc13_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc14_:* = null as ZNPList_ZPP_SensorArbiter;
         var _loc15_:* = null as ZPP_SensorArbiter;
         var _loc16_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc17_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc18_:* = null as ZNPNode_ZPP_Shape;
         var _loc19_:* = null as ZPP_Shape;
         var _loc20_:* = null as ZPP_Constraint;
         var _loc21_:* = null as ZNPList_ZPP_Constraint;
         var _loc22_:* = null as ZNPNode_ZPP_Constraint;
         var _loc23_:* = null as ZNPNode_ZPP_Constraint;
         while(param1.comps.head != null)
         {
            _loc2_ = param1.comps.pop_unsafe();
            _loc2_.waket = stamp + (!!midstep?0:1);
            if(_loc2_.isBody)
            {
               _loc3_ = _loc2_.body;
               live.add(_loc3_);
               _loc4_ = _loc3_.arbiters.head;
               while(_loc4_ != null)
               {
                  _loc5_ = _loc4_.elt;
                  if(_loc5_.sleeping)
                  {
                     _loc5_.sleeping = false;
                     _loc5_.up_stamp = _loc5_.up_stamp + (stamp - _loc5_.sleep_stamp);
                     if(_loc5_.type == ZPP_Arbiter.COL)
                     {
                        _loc6_ = _loc5_.colarb;
                        if(_loc6_.stat)
                        {
                           _loc7_ = c_arbiters_true;
                           if(ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                           {
                              _loc9_ = new ZNPNode_ZPP_ColArbiter();
                           }
                           else
                           {
                              _loc9_ = ZNPNode_ZPP_ColArbiter.zpp_pool;
                              ZNPNode_ZPP_ColArbiter.zpp_pool = _loc9_.next;
                              _loc9_.next = null;
                           }
                           null;
                           _loc9_.elt = _loc6_;
                           _loc8_ = _loc9_;
                           _loc8_.next = _loc7_.head;
                           _loc7_.head = _loc8_;
                           _loc7_.modified = true;
                           _loc7_.length = _loc7_.length + 1;
                           _loc6_;
                        }
                        else
                        {
                           _loc7_ = c_arbiters_false;
                           if(ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                           {
                              _loc9_ = new ZNPNode_ZPP_ColArbiter();
                           }
                           else
                           {
                              _loc9_ = ZNPNode_ZPP_ColArbiter.zpp_pool;
                              ZNPNode_ZPP_ColArbiter.zpp_pool = _loc9_.next;
                              _loc9_.next = null;
                           }
                           null;
                           _loc9_.elt = _loc6_;
                           _loc8_ = _loc9_;
                           _loc8_.next = _loc7_.head;
                           _loc7_.head = _loc8_;
                           _loc7_.modified = true;
                           _loc7_.length = _loc7_.length + 1;
                           _loc6_;
                        }
                     }
                     else if(_loc5_.type == ZPP_Arbiter.FLUID)
                     {
                        _loc10_ = f_arbiters;
                        _loc11_ = _loc5_.fluidarb;
                        if(ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
                        {
                           _loc13_ = new ZNPNode_ZPP_FluidArbiter();
                        }
                        else
                        {
                           _loc13_ = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                           ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc13_.next;
                           _loc13_.next = null;
                        }
                        null;
                        _loc13_.elt = _loc11_;
                        _loc12_ = _loc13_;
                        _loc12_.next = _loc10_.head;
                        _loc10_.head = _loc12_;
                        _loc10_.modified = true;
                        _loc10_.length = _loc10_.length + 1;
                        _loc11_;
                     }
                     else
                     {
                        _loc14_ = s_arbiters;
                        _loc15_ = _loc5_.sensorarb;
                        if(ZNPNode_ZPP_SensorArbiter.zpp_pool == null)
                        {
                           _loc17_ = new ZNPNode_ZPP_SensorArbiter();
                        }
                        else
                        {
                           _loc17_ = ZNPNode_ZPP_SensorArbiter.zpp_pool;
                           ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc17_.next;
                           _loc17_.next = null;
                        }
                        null;
                        _loc17_.elt = _loc15_;
                        _loc16_ = _loc17_;
                        _loc16_.next = _loc14_.head;
                        _loc14_.head = _loc16_;
                        _loc14_.modified = true;
                        _loc14_.length = _loc14_.length + 1;
                        _loc15_;
                     }
                  }
                  _loc4_ = _loc4_.next;
               }
               bodyCbWake(_loc3_);
               _loc2_.sleeping = false;
               _loc2_.island = null;
               _loc2_.parent = _loc2_;
               _loc2_.rank = 0;
               if(!bphase.is_sweep && _loc3_.type != ZPP_Flags.id_BodyType_STATIC)
               {
                  _loc18_ = _loc3_.shapes.head;
                  while(_loc18_ != null)
                  {
                     _loc19_ = _loc18_.elt;
                     if(_loc19_.node != null)
                     {
                        bphase.sync(_loc19_);
                     }
                     _loc18_ = _loc18_.next;
                  }
               }
            }
            else
            {
               _loc20_ = _loc2_.constraint;
               _loc21_ = live_constraints;
               if(ZNPNode_ZPP_Constraint.zpp_pool == null)
               {
                  _loc23_ = new ZNPNode_ZPP_Constraint();
               }
               else
               {
                  _loc23_ = ZNPNode_ZPP_Constraint.zpp_pool;
                  ZNPNode_ZPP_Constraint.zpp_pool = _loc23_.next;
                  _loc23_.next = null;
               }
               null;
               _loc23_.elt = _loc20_;
               _loc22_ = _loc23_;
               _loc22_.next = _loc21_.head;
               _loc21_.head = _loc22_;
               _loc21_.modified = true;
               _loc21_.length = _loc21_.length + 1;
               _loc20_;
               constraintCbWake(_loc20_);
               _loc2_.sleeping = false;
               _loc2_.island = null;
               _loc2_.parent = _loc2_;
               _loc2_.rank = 0;
            }
         }
         var _loc24_:ZPP_Island = param1;
         _loc24_.next = ZPP_Island.zpp_pool;
         ZPP_Island.zpp_pool = _loc24_;
      }
      
      public function wakeCompound(param1:ZPP_Compound) : void
      {
         var _loc3_:* = null as ZPP_Body;
         var _loc4_:* = null as ZPP_Body;
         var _loc6_:* = null as ZPP_Constraint;
         var _loc8_:* = null as ZPP_Compound;
         var _loc2_:ZNPNode_ZPP_Body = param1.bodies.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc4_ = _loc3_;
            if(!_loc4_.world)
            {
               _loc4_.component.waket = stamp + (!!midstep?0:1);
               if(_loc4_.component.sleeping)
               {
                  really_wake(_loc4_,false);
               }
            }
            _loc2_ = _loc2_.next;
         }
         var _loc5_:ZNPNode_ZPP_Constraint = param1.constraints.head;
         while(_loc5_ != null)
         {
            _loc6_ = _loc5_.elt;
            wake_constraint(_loc6_);
            _loc5_ = _loc5_.next;
         }
         var _loc7_:ZNPNode_ZPP_Compound = param1.compounds.head;
         while(_loc7_ != null)
         {
            _loc8_ = _loc7_.elt;
            wakeCompound(_loc8_);
            _loc7_ = _loc7_.next;
         }
      }
      
      public function validation() : void
      {
         var _loc2_:* = null as ZPP_Set_ZPP_CbSet;
         var _loc3_:* = null as ZPP_CbSet;
         var _loc5_:* = null as ZPP_Body;
         var _loc6_:* = null as ZNPNode_ZPP_Shape;
         var _loc7_:* = null as ZPP_Shape;
         var _loc8_:* = null as ZPP_Circle;
         var _loc9_:* = null as ZPP_Polygon;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc13_:* = null as ZPP_Vec2;
         var _loc14_:* = null as ZPP_Vec2;
         var _loc15_:Number = NaN;
         var _loc16_:* = null as ZPP_Vec2;
         var _loc17_:* = null as ZPP_Body;
         var _loc18_:* = null as ZPP_AABB;
         var _loc19_:* = null as ZPP_AABB;
         var _loc20_:* = null as ZNPNode_ZPP_Edge;
         var _loc21_:* = null as ZPP_Edge;
         var _loc22_:* = null as ZNPNode_ZPP_BodyListener;
         var _loc23_:* = null as ZPP_BodyListener;
         var _loc24_:* = null as ZPP_Callback;
         var _loc26_:* = null as ZPP_Constraint;
         var _loc27_:* = null as ZNPNode_ZPP_ConstraintListener;
         var _loc28_:* = null as ZPP_ConstraintListener;
         var _loc1_:ZPP_CbSetManager = cbsets;
         if(!_loc1_.cbsets.empty())
         {
            _loc2_ = _loc1_.cbsets.parent;
            while(_loc2_.prev != null)
            {
               _loc2_ = _loc2_.prev;
            }
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.data;
               _loc3_.validate();
               if(_loc2_.next != null)
               {
                  _loc2_ = _loc2_.next;
                  while(_loc2_.prev != null)
                  {
                     _loc2_ = _loc2_.prev;
                  }
               }
               else
               {
                  while(_loc2_.parent != null && _loc2_ == _loc2_.parent.next)
                  {
                     _loc2_ = _loc2_.parent;
                  }
                  _loc2_ = _loc2_.parent;
               }
            }
         }
         var _loc4_:ZNPNode_ZPP_Body = live.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            _loc5_.validate_mass();
            _loc5_.validate_inertia();
            if(_loc5_.zip_aabb)
            {
               _loc5_.zip_aabb = false;
               _loc5_.aabb.minx = 1.79e308;
               _loc5_.aabb.miny = 1.79e308;
               _loc5_.aabb.maxx = -1.79e308;
               _loc5_.aabb.maxy = -1.79e308;
               _loc6_ = _loc5_.shapes.head;
               while(_loc6_ != null)
               {
                  _loc7_ = _loc6_.elt;
                  if(_loc7_.zip_aabb)
                  {
                     if(_loc7_.body != null)
                     {
                        _loc7_.zip_aabb = false;
                        if(_loc7_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                           _loc8_ = _loc7_.circle;
                           if(_loc8_.zip_worldCOM)
                           {
                              if(_loc8_.body != null)
                              {
                                 _loc8_.zip_worldCOM = false;
                                 if(_loc8_.zip_localCOM)
                                 {
                                    _loc8_.zip_localCOM = false;
                                    if(_loc8_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                    {
                                       _loc9_ = _loc8_.polygon;
                                       if(_loc9_.lverts.next.next == null)
                                       {
                                          _loc9_.localCOMx = _loc9_.lverts.next.x;
                                          _loc9_.localCOMy = _loc9_.lverts.next.y;
                                          null;
                                       }
                                       else if(_loc9_.lverts.next.next.next == null)
                                       {
                                          _loc9_.localCOMx = _loc9_.lverts.next.x;
                                          _loc9_.localCOMy = _loc9_.lverts.next.y;
                                          _loc10_ = 1;
                                          _loc9_.localCOMx = Number(_loc9_.localCOMx + _loc9_.lverts.next.next.x * _loc10_);
                                          _loc9_.localCOMy = Number(_loc9_.localCOMy + _loc9_.lverts.next.next.y * _loc10_);
                                          _loc10_ = 0.5;
                                          _loc9_.localCOMx = _loc9_.localCOMx * _loc10_;
                                          _loc9_.localCOMy = _loc9_.localCOMy * _loc10_;
                                       }
                                       else
                                       {
                                          _loc9_.localCOMx = 0;
                                          _loc9_.localCOMy = 0;
                                          _loc10_ = 0;
                                          _loc11_ = _loc9_.lverts.next;
                                          _loc12_ = _loc11_;
                                          _loc11_ = _loc11_.next;
                                          _loc13_ = _loc11_;
                                          _loc11_ = _loc11_.next;
                                          while(_loc11_ != null)
                                          {
                                             _loc14_ = _loc11_;
                                             _loc10_ = Number(_loc10_ + _loc13_.x * (_loc14_.y - _loc12_.y));
                                             _loc15_ = _loc14_.y * _loc13_.x - _loc14_.x * _loc13_.y;
                                             _loc9_.localCOMx = Number(_loc9_.localCOMx + (_loc13_.x + _loc14_.x) * _loc15_);
                                             _loc9_.localCOMy = Number(_loc9_.localCOMy + (_loc13_.y + _loc14_.y) * _loc15_);
                                             _loc12_ = _loc13_;
                                             _loc13_ = _loc14_;
                                             _loc11_ = _loc11_.next;
                                          }
                                          _loc11_ = _loc9_.lverts.next;
                                          _loc14_ = _loc11_;
                                          _loc10_ = Number(_loc10_ + _loc13_.x * (_loc14_.y - _loc12_.y));
                                          _loc15_ = _loc14_.y * _loc13_.x - _loc14_.x * _loc13_.y;
                                          _loc9_.localCOMx = Number(_loc9_.localCOMx + (_loc13_.x + _loc14_.x) * _loc15_);
                                          _loc9_.localCOMy = Number(_loc9_.localCOMy + (_loc13_.y + _loc14_.y) * _loc15_);
                                          _loc12_ = _loc13_;
                                          _loc13_ = _loc14_;
                                          _loc11_ = _loc11_.next;
                                          _loc16_ = _loc11_;
                                          _loc10_ = Number(_loc10_ + _loc13_.x * (_loc16_.y - _loc12_.y));
                                          _loc15_ = _loc16_.y * _loc13_.x - _loc16_.x * _loc13_.y;
                                          _loc9_.localCOMx = Number(_loc9_.localCOMx + (_loc13_.x + _loc16_.x) * _loc15_);
                                          _loc9_.localCOMy = Number(_loc9_.localCOMy + (_loc13_.y + _loc16_.y) * _loc15_);
                                          _loc10_ = 1 / (3 * _loc10_);
                                          _loc15_ = _loc10_;
                                          _loc9_.localCOMx = _loc9_.localCOMx * _loc15_;
                                          _loc9_.localCOMy = _loc9_.localCOMy * _loc15_;
                                       }
                                    }
                                    if(_loc8_.wrap_localCOM != null)
                                    {
                                       _loc8_.wrap_localCOM.zpp_inner.x = _loc8_.localCOMx;
                                       _loc8_.wrap_localCOM.zpp_inner.y = _loc8_.localCOMy;
                                    }
                                 }
                                 _loc17_ = _loc8_.body;
                                 if(_loc17_.zip_axis)
                                 {
                                    _loc17_.zip_axis = false;
                                    _loc17_.axisx = Number(Math.sin(_loc17_.rot));
                                    _loc17_.axisy = Number(Math.cos(_loc17_.rot));
                                    null;
                                 }
                                 _loc8_.worldCOMx = Number(_loc8_.body.posx + (_loc8_.body.axisy * _loc8_.localCOMx - _loc8_.body.axisx * _loc8_.localCOMy));
                                 _loc8_.worldCOMy = Number(_loc8_.body.posy + (Number(_loc8_.localCOMx * _loc8_.body.axisx + _loc8_.localCOMy * _loc8_.body.axisy)));
                                 if(_loc8_.wrap_worldCOM != null)
                                 {
                                    _loc8_.wrap_worldCOM.zpp_inner.x = _loc8_.worldCOMx;
                                    _loc8_.wrap_worldCOM.zpp_inner.y = _loc8_.worldCOMy;
                                 }
                              }
                           }
                           _loc10_ = _loc8_.radius;
                           _loc15_ = _loc8_.radius;
                           _loc8_.aabb.minx = _loc8_.worldCOMx - _loc10_;
                           _loc8_.aabb.miny = _loc8_.worldCOMy - _loc15_;
                           _loc8_.aabb.maxx = Number(_loc8_.worldCOMx + _loc10_);
                           _loc8_.aabb.maxy = Number(_loc8_.worldCOMy + _loc15_);
                        }
                        else
                        {
                           _loc9_ = _loc7_.polygon;
                           if(_loc9_.zip_gverts)
                           {
                              if(_loc9_.body != null)
                              {
                                 _loc9_.zip_gverts = false;
                                 _loc9_.validate_lverts();
                                 _loc17_ = _loc9_.body;
                                 if(_loc17_.zip_axis)
                                 {
                                    _loc17_.zip_axis = false;
                                    _loc17_.axisx = Number(Math.sin(_loc17_.rot));
                                    _loc17_.axisy = Number(Math.cos(_loc17_.rot));
                                    null;
                                 }
                                 _loc11_ = _loc9_.lverts.next;
                                 _loc12_ = _loc9_.gverts.next;
                                 while(_loc12_ != null)
                                 {
                                    _loc13_ = _loc12_;
                                    _loc14_ = _loc11_;
                                    _loc11_ = _loc11_.next;
                                    _loc13_.x = Number(_loc9_.body.posx + (_loc9_.body.axisy * _loc14_.x - _loc9_.body.axisx * _loc14_.y));
                                    _loc13_.y = Number(_loc9_.body.posy + (Number(_loc14_.x * _loc9_.body.axisx + _loc14_.y * _loc9_.body.axisy)));
                                    _loc12_ = _loc12_.next;
                                 }
                              }
                           }
                           _loc11_ = _loc9_.gverts.next;
                           _loc9_.aabb.minx = _loc11_.x;
                           _loc9_.aabb.miny = _loc11_.y;
                           _loc9_.aabb.maxx = _loc11_.x;
                           _loc9_.aabb.maxy = _loc11_.y;
                           _loc12_ = _loc9_.gverts.next.next;
                           while(_loc12_ != null)
                           {
                              _loc13_ = _loc12_;
                              if(_loc13_.x < _loc9_.aabb.minx)
                              {
                                 _loc9_.aabb.minx = _loc13_.x;
                              }
                              if(_loc13_.x > _loc9_.aabb.maxx)
                              {
                                 _loc9_.aabb.maxx = _loc13_.x;
                              }
                              if(_loc13_.y < _loc9_.aabb.miny)
                              {
                                 _loc9_.aabb.miny = _loc13_.y;
                              }
                              if(_loc13_.y > _loc9_.aabb.maxy)
                              {
                                 _loc9_.aabb.maxy = _loc13_.y;
                              }
                              _loc12_ = _loc12_.next;
                           }
                        }
                     }
                  }
                  _loc18_ = _loc5_.aabb;
                  _loc19_ = _loc7_.aabb;
                  if(_loc19_.minx < _loc18_.minx)
                  {
                     _loc18_.minx = _loc19_.minx;
                  }
                  if(_loc19_.maxx > _loc18_.maxx)
                  {
                     _loc18_.maxx = _loc19_.maxx;
                  }
                  if(_loc19_.miny < _loc18_.miny)
                  {
                     _loc18_.miny = _loc19_.miny;
                  }
                  if(_loc19_.maxy > _loc18_.maxy)
                  {
                     _loc18_.maxy = _loc19_.maxy;
                  }
                  _loc6_ = _loc6_.next;
               }
            }
            _loc5_.validate_gravMass();
            _loc5_.validate_worldCOM();
            if(_loc5_.zip_axis)
            {
               _loc5_.zip_axis = false;
               _loc5_.axisx = Number(Math.sin(_loc5_.rot));
               _loc5_.axisy = Number(Math.cos(_loc5_.rot));
               null;
            }
            _loc6_ = _loc5_.shapes.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_.elt;
               if(_loc7_.type == ZPP_Flags.id_ShapeType_POLYGON)
               {
                  _loc9_ = _loc7_.polygon;
                  if(_loc9_.zip_gaxi)
                  {
                     if(_loc9_.body != null)
                     {
                        _loc9_.zip_gaxi = false;
                        _loc9_.validate_laxi();
                        _loc17_ = _loc9_.body;
                        if(_loc17_.zip_axis)
                        {
                           _loc17_.zip_axis = false;
                           _loc17_.axisx = Number(Math.sin(_loc17_.rot));
                           _loc17_.axisy = Number(Math.cos(_loc17_.rot));
                           null;
                        }
                        _loc20_ = _loc9_.edges.head;
                        _loc11_ = _loc9_.gverts.next;
                        _loc12_ = _loc11_;
                        _loc11_ = _loc11_.next;
                        while(_loc11_ != null)
                        {
                           _loc13_ = _loc11_;
                           _loc21_ = _loc20_.elt;
                           _loc20_ = _loc20_.next;
                           _loc21_.gp0 = _loc12_;
                           _loc21_.gp1 = _loc13_;
                           _loc21_.gnormx = _loc9_.body.axisy * _loc21_.lnormx - _loc9_.body.axisx * _loc21_.lnormy;
                           _loc21_.gnormy = Number(_loc21_.lnormx * _loc9_.body.axisx + _loc21_.lnormy * _loc9_.body.axisy);
                           _loc21_.gprojection = Number(Number(_loc9_.body.posx * _loc21_.gnormx + _loc9_.body.posy * _loc21_.gnormy) + _loc21_.lprojection);
                           if(_loc21_.wrap_gnorm != null)
                           {
                              _loc21_.wrap_gnorm.zpp_inner.x = _loc21_.gnormx;
                              _loc21_.wrap_gnorm.zpp_inner.y = _loc21_.gnormy;
                           }
                           _loc21_.tp0 = _loc21_.gp0.y * _loc21_.gnormx - _loc21_.gp0.x * _loc21_.gnormy;
                           _loc21_.tp1 = _loc21_.gp1.y * _loc21_.gnormx - _loc21_.gp1.x * _loc21_.gnormy;
                           _loc12_ = _loc13_;
                           _loc11_ = _loc11_.next;
                        }
                        _loc13_ = _loc9_.gverts.next;
                        _loc21_ = _loc20_.elt;
                        _loc20_ = _loc20_.next;
                        _loc21_.gp0 = _loc12_;
                        _loc21_.gp1 = _loc13_;
                        _loc21_.gnormx = _loc9_.body.axisy * _loc21_.lnormx - _loc9_.body.axisx * _loc21_.lnormy;
                        _loc21_.gnormy = Number(_loc21_.lnormx * _loc9_.body.axisx + _loc21_.lnormy * _loc9_.body.axisy);
                        _loc21_.gprojection = Number(Number(_loc9_.body.posx * _loc21_.gnormx + _loc9_.body.posy * _loc21_.gnormy) + _loc21_.lprojection);
                        if(_loc21_.wrap_gnorm != null)
                        {
                           _loc21_.wrap_gnorm.zpp_inner.x = _loc21_.gnormx;
                           _loc21_.wrap_gnorm.zpp_inner.y = _loc21_.gnormy;
                        }
                        _loc21_.tp0 = _loc21_.gp0.y * _loc21_.gnormx - _loc21_.gp0.x * _loc21_.gnormy;
                        _loc21_.tp1 = _loc21_.gp1.y * _loc21_.gnormx - _loc21_.gp1.x * _loc21_.gnormy;
                     }
                  }
               }
               _loc6_ = _loc6_.next;
            }
            if(!!_loc5_.component.woken && _loc5_.cbSet != null)
            {
               _loc22_ = _loc5_.cbSet.bodylisteners.head;
               while(_loc22_ != null)
               {
                  _loc23_ = _loc22_.elt;
                  if(_loc23_.event != ZPP_Flags.id_CbEvent_WAKE)
                  {
                     _loc22_ = _loc22_.next;
                  }
                  else
                  {
                     _loc24_ = push_callback(_loc23_);
                     _loc24_.event = ZPP_Flags.id_CbEvent_WAKE;
                     _loc24_.body = _loc5_;
                     _loc22_ = _loc22_.next;
                  }
               }
            }
            _loc5_.component.woken = false;
            if(!bphase.is_sweep)
            {
               _loc6_ = _loc5_.shapes.head;
               while(_loc6_ != null)
               {
                  _loc7_ = _loc6_.elt;
                  bphase.sync(_loc7_);
                  _loc6_ = _loc6_.next;
               }
            }
            _loc4_ = _loc4_.next;
         }
         _loc4_ = kinematics.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            _loc5_.validate_mass();
            _loc5_.validate_inertia();
            if(_loc5_.zip_aabb)
            {
               _loc5_.zip_aabb = false;
               _loc5_.aabb.minx = 1.79e308;
               _loc5_.aabb.miny = 1.79e308;
               _loc5_.aabb.maxx = -1.79e308;
               _loc5_.aabb.maxy = -1.79e308;
               _loc6_ = _loc5_.shapes.head;
               while(_loc6_ != null)
               {
                  _loc7_ = _loc6_.elt;
                  if(_loc7_.zip_aabb)
                  {
                     if(_loc7_.body != null)
                     {
                        _loc7_.zip_aabb = false;
                        if(_loc7_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                           _loc8_ = _loc7_.circle;
                           if(_loc8_.zip_worldCOM)
                           {
                              if(_loc8_.body != null)
                              {
                                 _loc8_.zip_worldCOM = false;
                                 if(_loc8_.zip_localCOM)
                                 {
                                    _loc8_.zip_localCOM = false;
                                    if(_loc8_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                    {
                                       _loc9_ = _loc8_.polygon;
                                       if(_loc9_.lverts.next.next == null)
                                       {
                                          _loc9_.localCOMx = _loc9_.lverts.next.x;
                                          _loc9_.localCOMy = _loc9_.lverts.next.y;
                                          null;
                                       }
                                       else if(_loc9_.lverts.next.next.next == null)
                                       {
                                          _loc9_.localCOMx = _loc9_.lverts.next.x;
                                          _loc9_.localCOMy = _loc9_.lverts.next.y;
                                          _loc10_ = 1;
                                          _loc9_.localCOMx = Number(_loc9_.localCOMx + _loc9_.lverts.next.next.x * _loc10_);
                                          _loc9_.localCOMy = Number(_loc9_.localCOMy + _loc9_.lverts.next.next.y * _loc10_);
                                          _loc10_ = 0.5;
                                          _loc9_.localCOMx = _loc9_.localCOMx * _loc10_;
                                          _loc9_.localCOMy = _loc9_.localCOMy * _loc10_;
                                       }
                                       else
                                       {
                                          _loc9_.localCOMx = 0;
                                          _loc9_.localCOMy = 0;
                                          _loc10_ = 0;
                                          _loc11_ = _loc9_.lverts.next;
                                          _loc12_ = _loc11_;
                                          _loc11_ = _loc11_.next;
                                          _loc13_ = _loc11_;
                                          _loc11_ = _loc11_.next;
                                          while(_loc11_ != null)
                                          {
                                             _loc14_ = _loc11_;
                                             _loc10_ = Number(_loc10_ + _loc13_.x * (_loc14_.y - _loc12_.y));
                                             _loc15_ = _loc14_.y * _loc13_.x - _loc14_.x * _loc13_.y;
                                             _loc9_.localCOMx = Number(_loc9_.localCOMx + (_loc13_.x + _loc14_.x) * _loc15_);
                                             _loc9_.localCOMy = Number(_loc9_.localCOMy + (_loc13_.y + _loc14_.y) * _loc15_);
                                             _loc12_ = _loc13_;
                                             _loc13_ = _loc14_;
                                             _loc11_ = _loc11_.next;
                                          }
                                          _loc11_ = _loc9_.lverts.next;
                                          _loc14_ = _loc11_;
                                          _loc10_ = Number(_loc10_ + _loc13_.x * (_loc14_.y - _loc12_.y));
                                          _loc15_ = _loc14_.y * _loc13_.x - _loc14_.x * _loc13_.y;
                                          _loc9_.localCOMx = Number(_loc9_.localCOMx + (_loc13_.x + _loc14_.x) * _loc15_);
                                          _loc9_.localCOMy = Number(_loc9_.localCOMy + (_loc13_.y + _loc14_.y) * _loc15_);
                                          _loc12_ = _loc13_;
                                          _loc13_ = _loc14_;
                                          _loc11_ = _loc11_.next;
                                          _loc16_ = _loc11_;
                                          _loc10_ = Number(_loc10_ + _loc13_.x * (_loc16_.y - _loc12_.y));
                                          _loc15_ = _loc16_.y * _loc13_.x - _loc16_.x * _loc13_.y;
                                          _loc9_.localCOMx = Number(_loc9_.localCOMx + (_loc13_.x + _loc16_.x) * _loc15_);
                                          _loc9_.localCOMy = Number(_loc9_.localCOMy + (_loc13_.y + _loc16_.y) * _loc15_);
                                          _loc10_ = 1 / (3 * _loc10_);
                                          _loc15_ = _loc10_;
                                          _loc9_.localCOMx = _loc9_.localCOMx * _loc15_;
                                          _loc9_.localCOMy = _loc9_.localCOMy * _loc15_;
                                       }
                                    }
                                    if(_loc8_.wrap_localCOM != null)
                                    {
                                       _loc8_.wrap_localCOM.zpp_inner.x = _loc8_.localCOMx;
                                       _loc8_.wrap_localCOM.zpp_inner.y = _loc8_.localCOMy;
                                    }
                                 }
                                 _loc17_ = _loc8_.body;
                                 if(_loc17_.zip_axis)
                                 {
                                    _loc17_.zip_axis = false;
                                    _loc17_.axisx = Number(Math.sin(_loc17_.rot));
                                    _loc17_.axisy = Number(Math.cos(_loc17_.rot));
                                    null;
                                 }
                                 _loc8_.worldCOMx = Number(_loc8_.body.posx + (_loc8_.body.axisy * _loc8_.localCOMx - _loc8_.body.axisx * _loc8_.localCOMy));
                                 _loc8_.worldCOMy = Number(_loc8_.body.posy + (Number(_loc8_.localCOMx * _loc8_.body.axisx + _loc8_.localCOMy * _loc8_.body.axisy)));
                                 if(_loc8_.wrap_worldCOM != null)
                                 {
                                    _loc8_.wrap_worldCOM.zpp_inner.x = _loc8_.worldCOMx;
                                    _loc8_.wrap_worldCOM.zpp_inner.y = _loc8_.worldCOMy;
                                 }
                              }
                           }
                           _loc10_ = _loc8_.radius;
                           _loc15_ = _loc8_.radius;
                           _loc8_.aabb.minx = _loc8_.worldCOMx - _loc10_;
                           _loc8_.aabb.miny = _loc8_.worldCOMy - _loc15_;
                           _loc8_.aabb.maxx = Number(_loc8_.worldCOMx + _loc10_);
                           _loc8_.aabb.maxy = Number(_loc8_.worldCOMy + _loc15_);
                        }
                        else
                        {
                           _loc9_ = _loc7_.polygon;
                           if(_loc9_.zip_gverts)
                           {
                              if(_loc9_.body != null)
                              {
                                 _loc9_.zip_gverts = false;
                                 _loc9_.validate_lverts();
                                 _loc17_ = _loc9_.body;
                                 if(_loc17_.zip_axis)
                                 {
                                    _loc17_.zip_axis = false;
                                    _loc17_.axisx = Number(Math.sin(_loc17_.rot));
                                    _loc17_.axisy = Number(Math.cos(_loc17_.rot));
                                    null;
                                 }
                                 _loc11_ = _loc9_.lverts.next;
                                 _loc12_ = _loc9_.gverts.next;
                                 while(_loc12_ != null)
                                 {
                                    _loc13_ = _loc12_;
                                    _loc14_ = _loc11_;
                                    _loc11_ = _loc11_.next;
                                    _loc13_.x = Number(_loc9_.body.posx + (_loc9_.body.axisy * _loc14_.x - _loc9_.body.axisx * _loc14_.y));
                                    _loc13_.y = Number(_loc9_.body.posy + (Number(_loc14_.x * _loc9_.body.axisx + _loc14_.y * _loc9_.body.axisy)));
                                    _loc12_ = _loc12_.next;
                                 }
                              }
                           }
                           _loc11_ = _loc9_.gverts.next;
                           _loc9_.aabb.minx = _loc11_.x;
                           _loc9_.aabb.miny = _loc11_.y;
                           _loc9_.aabb.maxx = _loc11_.x;
                           _loc9_.aabb.maxy = _loc11_.y;
                           _loc12_ = _loc9_.gverts.next.next;
                           while(_loc12_ != null)
                           {
                              _loc13_ = _loc12_;
                              if(_loc13_.x < _loc9_.aabb.minx)
                              {
                                 _loc9_.aabb.minx = _loc13_.x;
                              }
                              if(_loc13_.x > _loc9_.aabb.maxx)
                              {
                                 _loc9_.aabb.maxx = _loc13_.x;
                              }
                              if(_loc13_.y < _loc9_.aabb.miny)
                              {
                                 _loc9_.aabb.miny = _loc13_.y;
                              }
                              if(_loc13_.y > _loc9_.aabb.maxy)
                              {
                                 _loc9_.aabb.maxy = _loc13_.y;
                              }
                              _loc12_ = _loc12_.next;
                           }
                        }
                     }
                  }
                  _loc18_ = _loc5_.aabb;
                  _loc19_ = _loc7_.aabb;
                  if(_loc19_.minx < _loc18_.minx)
                  {
                     _loc18_.minx = _loc19_.minx;
                  }
                  if(_loc19_.maxx > _loc18_.maxx)
                  {
                     _loc18_.maxx = _loc19_.maxx;
                  }
                  if(_loc19_.miny < _loc18_.miny)
                  {
                     _loc18_.miny = _loc19_.miny;
                  }
                  if(_loc19_.maxy > _loc18_.maxy)
                  {
                     _loc18_.maxy = _loc19_.maxy;
                  }
                  _loc6_ = _loc6_.next;
               }
            }
            _loc5_.validate_gravMass();
            _loc5_.validate_worldCOM();
            if(_loc5_.zip_axis)
            {
               _loc5_.zip_axis = false;
               _loc5_.axisx = Number(Math.sin(_loc5_.rot));
               _loc5_.axisy = Number(Math.cos(_loc5_.rot));
               null;
            }
            _loc6_ = _loc5_.shapes.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_.elt;
               if(_loc7_.type == ZPP_Flags.id_ShapeType_POLYGON)
               {
                  _loc9_ = _loc7_.polygon;
                  if(_loc9_.zip_gaxi)
                  {
                     if(_loc9_.body != null)
                     {
                        _loc9_.zip_gaxi = false;
                        _loc9_.validate_laxi();
                        _loc17_ = _loc9_.body;
                        if(_loc17_.zip_axis)
                        {
                           _loc17_.zip_axis = false;
                           _loc17_.axisx = Number(Math.sin(_loc17_.rot));
                           _loc17_.axisy = Number(Math.cos(_loc17_.rot));
                           null;
                        }
                        _loc20_ = _loc9_.edges.head;
                        _loc11_ = _loc9_.gverts.next;
                        _loc12_ = _loc11_;
                        _loc11_ = _loc11_.next;
                        while(_loc11_ != null)
                        {
                           _loc13_ = _loc11_;
                           _loc21_ = _loc20_.elt;
                           _loc20_ = _loc20_.next;
                           _loc21_.gp0 = _loc12_;
                           _loc21_.gp1 = _loc13_;
                           _loc21_.gnormx = _loc9_.body.axisy * _loc21_.lnormx - _loc9_.body.axisx * _loc21_.lnormy;
                           _loc21_.gnormy = Number(_loc21_.lnormx * _loc9_.body.axisx + _loc21_.lnormy * _loc9_.body.axisy);
                           _loc21_.gprojection = Number(Number(_loc9_.body.posx * _loc21_.gnormx + _loc9_.body.posy * _loc21_.gnormy) + _loc21_.lprojection);
                           if(_loc21_.wrap_gnorm != null)
                           {
                              _loc21_.wrap_gnorm.zpp_inner.x = _loc21_.gnormx;
                              _loc21_.wrap_gnorm.zpp_inner.y = _loc21_.gnormy;
                           }
                           _loc21_.tp0 = _loc21_.gp0.y * _loc21_.gnormx - _loc21_.gp0.x * _loc21_.gnormy;
                           _loc21_.tp1 = _loc21_.gp1.y * _loc21_.gnormx - _loc21_.gp1.x * _loc21_.gnormy;
                           _loc12_ = _loc13_;
                           _loc11_ = _loc11_.next;
                        }
                        _loc13_ = _loc9_.gverts.next;
                        _loc21_ = _loc20_.elt;
                        _loc20_ = _loc20_.next;
                        _loc21_.gp0 = _loc12_;
                        _loc21_.gp1 = _loc13_;
                        _loc21_.gnormx = _loc9_.body.axisy * _loc21_.lnormx - _loc9_.body.axisx * _loc21_.lnormy;
                        _loc21_.gnormy = Number(_loc21_.lnormx * _loc9_.body.axisx + _loc21_.lnormy * _loc9_.body.axisy);
                        _loc21_.gprojection = Number(Number(_loc9_.body.posx * _loc21_.gnormx + _loc9_.body.posy * _loc21_.gnormy) + _loc21_.lprojection);
                        if(_loc21_.wrap_gnorm != null)
                        {
                           _loc21_.wrap_gnorm.zpp_inner.x = _loc21_.gnormx;
                           _loc21_.wrap_gnorm.zpp_inner.y = _loc21_.gnormy;
                        }
                        _loc21_.tp0 = _loc21_.gp0.y * _loc21_.gnormx - _loc21_.gp0.x * _loc21_.gnormy;
                        _loc21_.tp1 = _loc21_.gp1.y * _loc21_.gnormx - _loc21_.gp1.x * _loc21_.gnormy;
                     }
                  }
               }
               _loc6_ = _loc6_.next;
            }
            if(!bphase.is_sweep)
            {
               _loc6_ = _loc5_.shapes.head;
               while(_loc6_ != null)
               {
                  _loc7_ = _loc6_.elt;
                  bphase.sync(_loc7_);
                  _loc6_ = _loc6_.next;
               }
            }
            _loc4_ = _loc4_.next;
         }
         var _loc25_:ZNPNode_ZPP_Constraint = live_constraints.head;
         while(_loc25_ != null)
         {
            _loc26_ = _loc25_.elt;
            if(_loc26_.active)
            {
               if(!!_loc26_.component.woken && _loc26_.cbSet != null)
               {
                  _loc27_ = _loc26_.cbSet.conlisteners.head;
                  while(_loc27_ != null)
                  {
                     _loc28_ = _loc27_.elt;
                     if(_loc28_.event != ZPP_Flags.id_CbEvent_WAKE)
                     {
                        _loc27_ = _loc27_.next;
                     }
                     else
                     {
                        _loc24_ = push_callback(_loc28_);
                        _loc24_.event = ZPP_Flags.id_CbEvent_WAKE;
                        _loc24_.constraint = _loc26_;
                        _loc27_ = _loc27_.next;
                     }
                  }
               }
               _loc26_.component.woken = false;
            }
            _loc25_ = _loc25_.next;
         }
      }
      
      public function updateVel(param1:Number) : void
      {
         var _loc4_:* = null as ZPP_Body;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc2_:ZNPNode_ZPP_Body = null;
         var _loc3_:ZNPNode_ZPP_Body = live.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
            _loc5_ = _loc4_.gravMass;
            _loc4_.forcex = Number(_loc4_.forcex + gravityx * _loc5_);
            _loc4_.forcey = Number(_loc4_.forcey + gravityy * _loc5_);
            _loc5_ = -global_lin_drag * _loc4_.mass;
            _loc4_.forcex = Number(_loc4_.forcex + _loc4_.velx * _loc5_);
            _loc4_.forcey = Number(_loc4_.forcey + _loc4_.vely * _loc5_);
            if(_loc4_.smass != 0)
            {
               _loc5_ = param1 * _loc4_.imass;
               _loc4_.velx = Number(_loc4_.velx + _loc4_.forcex * _loc5_);
               _loc4_.vely = Number(_loc4_.vely + _loc4_.forcey * _loc5_);
            }
            _loc4_.forcex = 0;
            _loc4_.forcey = 0;
            if(_loc4_.sinertia != 0)
            {
               _loc5_ = _loc4_.worldCOMx - _loc4_.posx;
               _loc6_ = _loc4_.worldCOMy - _loc4_.posy;
               _loc4_.torque = Number(_loc4_.torque + (gravityy * _loc5_ - gravityx * _loc6_) * _loc4_.gravMass);
               _loc4_.torque = _loc4_.torque - _loc4_.angvel * global_ang_drag * _loc4_.inertia;
               _loc4_.angvel = Number(_loc4_.angvel + _loc4_.torque * param1 * _loc4_.iinertia);
            }
            _loc4_.torque = 0;
            _loc2_ = _loc3_;
            _loc3_ = _loc3_.next;
         }
      }
      
      public function updatePos(param1:Number) : void
      {
         var _loc3_:* = null as ZPP_Body;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc2_:ZNPNode_ZPP_Body = live.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc4_ = param1;
            _loc3_.posx = Number(_loc3_.posx + _loc3_.velx * _loc4_);
            _loc3_.posy = Number(_loc3_.posy + _loc3_.vely * _loc4_);
            if(_loc3_.angvel != 0)
            {
               _loc4_ = _loc3_.angvel * param1;
               _loc3_.rot = Number(_loc3_.rot + _loc4_);
               if(_loc4_ * _loc4_ > 0.0001)
               {
                  _loc3_.axisx = Number(Math.sin(_loc3_.rot));
                  _loc3_.axisy = Number(Math.cos(_loc3_.rot));
                  null;
               }
               else
               {
                  _loc5_ = _loc4_ * _loc4_;
                  _loc6_ = 1 - 0.5 * _loc5_;
                  _loc7_ = 1 - _loc5_ * _loc5_ / 8;
                  _loc8_ = (_loc6_ * _loc3_.axisx + _loc4_ * _loc3_.axisy) * _loc7_;
                  _loc3_.axisy = (_loc6_ * _loc3_.axisy - _loc4_ * _loc3_.axisx) * _loc7_;
                  _loc3_.axisx = _loc8_;
               }
            }
            _loc2_ = _loc2_.next;
         }
         _loc2_ = kinematics.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc4_ = param1;
            _loc3_.posx = Number(_loc3_.posx + _loc3_.velx * _loc4_);
            _loc3_.posy = Number(_loc3_.posy + _loc3_.vely * _loc4_);
            if(_loc3_.angvel != 0)
            {
               _loc4_ = _loc3_.angvel * param1;
               _loc3_.rot = Number(_loc3_.rot + _loc4_);
               if(_loc4_ * _loc4_ > 0.0001)
               {
                  _loc3_.axisx = Number(Math.sin(_loc3_.rot));
                  _loc3_.axisy = Number(Math.cos(_loc3_.rot));
                  null;
               }
               else
               {
                  _loc5_ = _loc4_ * _loc4_;
                  _loc6_ = 1 - 0.5 * _loc5_;
                  _loc7_ = 1 - _loc5_ * _loc5_ / 8;
                  _loc8_ = (_loc6_ * _loc3_.axisx + _loc4_ * _loc3_.axisy) * _loc7_;
                  _loc3_.axisy = (_loc6_ * _loc3_.axisy - _loc4_ * _loc3_.axisx) * _loc7_;
                  _loc3_.axisx = _loc8_;
               }
            }
            _loc2_ = _loc2_.next;
         }
      }
      
      public function transmitType(param1:ZPP_Body, param2:int) : void
      {
         var _loc3_:ZPP_Body = param1;
         if(!_loc3_.world)
         {
            _loc3_.component.waket = stamp + (!!midstep?0:1);
            if(_loc3_.component.sleeping)
            {
               really_wake(_loc3_,false);
            }
         }
         if(param1.type == ZPP_Flags.id_BodyType_DYNAMIC)
         {
            live.remove(param1);
         }
         else if(param1.type == ZPP_Flags.id_BodyType_KINEMATIC)
         {
            kinematics.remove(param1);
            staticsleep.remove(param1);
         }
         else if(param1.type == ZPP_Flags.id_BodyType_STATIC)
         {
            staticsleep.remove(param1);
         }
         param1.type = param2;
         if(param1.type == ZPP_Flags.id_BodyType_KINEMATIC)
         {
            kinematics.add(param1);
         }
         if(param1.type == ZPP_Flags.id_BodyType_STATIC)
         {
            static_validation(param1);
         }
         param1.component.sleeping = true;
         _loc3_ = param1;
         if(!_loc3_.world)
         {
            _loc3_.component.waket = stamp + (!!midstep?0:1);
            if(_loc3_.component.sleeping)
            {
               really_wake(_loc3_,true);
            }
         }
      }
      
      public function step(param1:Number, param2:int, param3:int) : void
      {
         var _loc7_:* = null as ZNPList_ZPP_ColArbiter;
         var _loc8_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc9_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc10_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc11_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc12_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc13_:* = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc18_:* = null as ZPP_Body;
         var _loc19_:* = false;
         var _loc20_:* = false;
         var _loc21_:Boolean = false;
         var _loc22_:* = null as ZNPNode_ZPP_Shape;
         var _loc23_:* = null as ZPP_Shape;
         var _loc25_:* = null as ZNPList_ZPP_Body;
         var _loc26_:* = null as ZNPNode_ZPP_Body;
         var _loc27_:* = null as ZNPNode_ZPP_Body;
         var _loc28_:* = null as ZNPNode_ZPP_Body;
         var _loc31_:* = null as ZPP_CallbackSet;
         var _loc32_:* = null as ZPP_CallbackSet;
         var _loc33_:* = null as ZPP_CallbackSet;
         var _loc34_:* = null as ZPP_CallbackSet;
         var _loc35_:* = null as ZPP_Interactor;
         var _loc36_:* = null as ZPP_CbSet;
         var _loc37_:* = null as ZPP_CbSet;
         var _loc38_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc39_:* = null as ZPP_CbSetPair;
         var _loc40_:* = null as ZNPList_ZPP_CbSetPair;
         var _loc41_:* = null as ZNPNode_ZPP_CbSetPair;
         var _loc42_:* = null as ZPP_CbSetPair;
         var _loc43_:* = null as ZPP_InteractionListener;
         var _loc44_:* = null as ZPP_Callback;
         var _loc45_:* = null as ZPP_Interactor;
         var _loc46_:* = null as ZPP_OptionType;
         var _loc47_:* = null as ZNPList_ZPP_CbType;
         var _loc48_:* = null as ZPP_BodyListener;
         var _loc49_:* = null as ZPP_ConstraintListener;
         var _loc50_:* = null as ZPP_Callback;
         var _loc4_:ZPP_Space = this;
         time = Number(time + param1);
         pre_dt = param1;
         midstep = true;
         var _loc5_:* = param2 >> 1;
         var _loc6_:* = param2 - _loc5_;
         stamp = stamp + 1;
         validation();
         bphase.broadphase();
         doForests(param1);
         prestep(param1);
         if(sortcontacts)
         {
            _loc7_ = c_arbiters_false;
            if(_loc7_.head != null && _loc7_.head.next != null)
            {
               _loc8_ = _loc7_.head;
               _loc9_ = null;
               _loc10_ = null;
               _loc11_ = null;
               _loc12_ = null;
               _loc13_ = 1;
               do
               {
                  _loc14_ = 0;
                  _loc10_ = _loc8_;
                  _loc8_ = null;
                  _loc9_ = _loc8_;
                  while(_loc10_ != null)
                  {
                     _loc14_++;
                     _loc11_ = _loc10_;
                     _loc15_ = 0;
                     _loc16_ = _loc13_;
                     while(_loc11_ != null && _loc15_ < _loc13_)
                     {
                        _loc15_++;
                        _loc11_ = _loc11_.next;
                     }
                     while(_loc15_ > 0 || _loc16_ > 0 && _loc11_ != null)
                     {
                        if(_loc15_ == 0)
                        {
                           _loc12_ = _loc11_;
                           _loc11_ = _loc11_.next;
                           _loc16_--;
                        }
                        else if(_loc16_ == 0 || _loc11_ == null)
                        {
                           _loc12_ = _loc10_;
                           _loc10_ = _loc10_.next;
                           _loc15_--;
                        }
                        else
                        {
                           _loc12_ = _loc10_;
                           _loc10_ = _loc10_.next;
                           _loc15_--;
                        }
                        if(_loc9_ != null)
                        {
                           _loc9_.next = _loc12_;
                        }
                        else
                        {
                           _loc8_ = _loc12_;
                        }
                        _loc9_ = _loc12_;
                     }
                     _loc10_ = _loc11_;
                  }
                  _loc9_.next = null;
                  _loc13_ = _loc13_ << 1;
               }
               while(_loc14_ > 1);
               
               _loc7_.head = _loc8_;
               _loc7_.modified = true;
               _loc7_.pushmod = true;
            }
         }
         iterateVel(_loc5_,true);
         updateVel(param1);
         warmStart();
         iterateVel(_loc6_,false);
         var _loc17_:ZNPNode_ZPP_Body = kinematics.head;
         while(_loc17_ != null)
         {
            _loc18_ = _loc17_.elt;
            _loc18_.pre_posx = _loc18_.posx;
            _loc18_.pre_posy = _loc18_.posy;
            _loc18_.pre_rot = _loc18_.rot;
            _loc17_ = _loc17_.next;
         }
         _loc17_ = live.head;
         while(_loc17_ != null)
         {
            _loc18_ = _loc17_.elt;
            _loc18_.pre_posx = _loc18_.posx;
            _loc18_.pre_posy = _loc18_.posy;
            _loc18_.pre_rot = _loc18_.rot;
            _loc17_ = _loc17_.next;
         }
         updatePos(param1);
         iteratePos(param3);
         _loc17_ = kinematics.head;
         while(_loc17_ != null)
         {
            _loc18_ = _loc17_.elt;
            _loc19_ = !(_loc18_.posx == _loc18_.pre_posx && _loc18_.posy == _loc18_.pre_posy);
            _loc20_ = _loc18_.pre_rot != _loc18_.rot;
            if(_loc19_)
            {
               _loc21_ = false;
               _loc22_ = _loc18_.shapes.head;
               while(_loc22_ != null)
               {
                  _loc23_ = _loc22_.elt;
                  if(_loc23_.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc23_.polygon.invalidate_gverts();
                     _loc23_.polygon.invalidate_gaxi();
                  }
                  _loc23_.invalidate_worldCOM();
                  _loc22_ = _loc22_.next;
               }
               _loc18_.invalidate_worldCOM();
               if(!_loc21_)
               {
                  _loc18_.validate_graphic();
               }
            }
            _loc18_.pre_posx = _loc18_.posx;
            _loc18_.pre_posy = _loc18_.posy;
            if(_loc20_)
            {
               _loc18_.zip_axis = true;
               _loc22_ = _loc18_.shapes.head;
               while(_loc22_ != null)
               {
                  _loc23_ = _loc22_.elt;
                  if(_loc23_.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc23_.polygon.invalidate_gverts();
                     _loc23_.polygon.invalidate_gaxi();
                  }
                  _loc23_.invalidate_worldCOM();
                  _loc22_ = _loc22_.next;
               }
               _loc18_.invalidate_worldCOM();
               if(!_loc19_)
               {
                  _loc18_.validate_graphic();
               }
            }
            _loc18_.pre_rot = _loc18_.rot;
            if(_loc20_ || _loc19_)
            {
               _loc18_.validate_graphic();
            }
            _loc17_ = _loc17_.next;
         }
         _loc17_ = live.head;
         while(_loc17_ != null)
         {
            _loc18_ = _loc17_.elt;
            _loc19_ = !(_loc18_.posx == _loc18_.pre_posx && _loc18_.posy == _loc18_.pre_posy);
            _loc20_ = _loc18_.pre_rot != _loc18_.rot;
            if(_loc19_)
            {
               _loc21_ = false;
               _loc22_ = _loc18_.shapes.head;
               while(_loc22_ != null)
               {
                  _loc23_ = _loc22_.elt;
                  if(_loc23_.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc23_.polygon.invalidate_gverts();
                     _loc23_.polygon.invalidate_gaxi();
                  }
                  _loc23_.invalidate_worldCOM();
                  _loc22_ = _loc22_.next;
               }
               _loc18_.invalidate_worldCOM();
               if(!_loc21_)
               {
                  _loc18_.validate_graphic();
               }
            }
            _loc18_.pre_posx = _loc18_.posx;
            _loc18_.pre_posy = _loc18_.posy;
            if(_loc20_)
            {
               _loc18_.zip_axis = true;
               _loc22_ = _loc18_.shapes.head;
               while(_loc22_ != null)
               {
                  _loc23_ = _loc22_.elt;
                  if(_loc23_.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc23_.polygon.invalidate_gverts();
                     _loc23_.polygon.invalidate_gaxi();
                  }
                  _loc23_.invalidate_worldCOM();
                  _loc22_ = _loc22_.next;
               }
               _loc18_.invalidate_worldCOM();
               if(!_loc19_)
               {
                  _loc18_.validate_graphic();
               }
            }
            _loc18_.pre_rot = _loc18_.rot;
            if(_loc20_ || _loc19_)
            {
               _loc18_.validate_graphic();
            }
            _loc17_ = _loc17_.next;
         }
         _loc17_ = null;
         var _loc24_:ZNPNode_ZPP_Body = staticsleep.head;
         while(_loc24_ != null)
         {
            _loc18_ = _loc24_.elt;
            if(_loc18_.type != ZPP_Flags.id_BodyType_KINEMATIC || _loc18_.velx == 0 && _loc18_.vely == 0 && _loc18_.angvel == 0)
            {
               _loc18_.component.sleeping = true;
               _loc25_ = staticsleep;
               if(_loc17_ == null)
               {
                  _loc26_ = _loc25_.head;
                  _loc27_ = _loc26_.next;
                  _loc25_.head = _loc27_;
                  if(_loc25_.head == null)
                  {
                     _loc25_.pushmod = true;
                  }
               }
               else
               {
                  _loc26_ = _loc17_.next;
                  _loc27_ = _loc26_.next;
                  _loc17_.next = _loc27_;
                  if(_loc27_ == null)
                  {
                     _loc25_.pushmod = true;
                  }
               }
               _loc28_ = _loc26_;
               _loc28_.elt = null;
               _loc28_.next = ZNPNode_ZPP_Body.zpp_pool;
               ZNPNode_ZPP_Body.zpp_pool = _loc28_;
               _loc25_.modified = true;
               _loc25_.length = _loc25_.length - 1;
               _loc25_.pushmod = true;
               _loc24_ = _loc27_;
            }
            else
            {
               _loc17_ = _loc24_;
               _loc24_ = _loc24_.next;
            }
         }
         midstep = false;
         var _loc29_:ZPP_CallbackSet = null;
         var _loc30_:ZPP_CallbackSet = callbackset_list.next;
         while(_loc30_ != null)
         {
            _loc31_ = _loc30_;
            if(_loc31_.arbiters.head == null)
            {
               _loc32_ = callbackset_list;
               if(_loc29_ == null)
               {
                  _loc33_ = _loc32_.next;
                  _loc34_ = _loc33_.next;
                  _loc32_.next = _loc34_;
                  if(_loc32_.next == null)
                  {
                     _loc32_.pushmod = true;
                  }
               }
               else
               {
                  _loc33_ = _loc29_.next;
                  _loc34_ = _loc33_.next;
                  _loc29_.next = _loc34_;
                  if(_loc34_ == null)
                  {
                     _loc32_.pushmod = true;
                  }
               }
               _loc33_._inuse = false;
               _loc32_.modified = true;
               _loc32_.length = _loc32_.length - 1;
               _loc32_.pushmod = true;
               _loc30_ = _loc34_;
               _loc32_ = _loc31_;
               _loc35_ = null;
               _loc32_.int2 = _loc35_;
               _loc32_.int1 = _loc35_;
               _loc13_ = -1;
               _loc32_.di = _loc13_;
               _loc32_.id = _loc13_;
               _loc32_.freed = true;
               null;
               _loc32_.next = ZPP_CallbackSet.zpp_pool;
               ZPP_CallbackSet.zpp_pool = _loc32_;
            }
            else
            {
               _loc36_ = _loc31_.int1.cbSet;
               _loc37_ = _loc31_.int2.cbSet;
               _loc13_ = int(ZPP_Flags.id_CbEvent_ONGOING);
               _loc39_ = null;
               _loc40_ = _loc36_.cbpairs.length < _loc37_.cbpairs.length?_loc36_.cbpairs:_loc37_.cbpairs;
               _loc41_ = _loc40_.head;
               while(_loc41_ != null)
               {
                  _loc42_ = _loc41_.elt;
                  if(_loc42_.a == _loc36_ && _loc42_.b == _loc37_ || _loc42_.a == _loc37_ && _loc42_.b == _loc36_)
                  {
                     _loc39_ = _loc42_;
                     break;
                  }
                  _loc41_ = _loc41_.next;
               }
               if(_loc39_ == null)
               {
                  if(ZPP_CbSetPair.zpp_pool == null)
                  {
                     _loc42_ = new ZPP_CbSetPair();
                  }
                  else
                  {
                     _loc42_ = ZPP_CbSetPair.zpp_pool;
                     ZPP_CbSetPair.zpp_pool = _loc42_.next;
                     _loc42_.next = null;
                  }
                  _loc42_.zip_listeners = true;
                  if(ZPP_CbSet.setlt(_loc36_,_loc37_))
                  {
                     _loc42_.a = _loc36_;
                     _loc42_.b = _loc37_;
                  }
                  else
                  {
                     _loc42_.a = _loc37_;
                     _loc42_.b = _loc36_;
                  }
                  _loc39_ = _loc42_;
                  _loc36_.cbpairs.add(_loc39_);
                  if(_loc37_ != _loc36_)
                  {
                     _loc37_.cbpairs.add(_loc39_);
                  }
               }
               if(_loc39_.zip_listeners)
               {
                  _loc39_.zip_listeners = false;
                  _loc39_.__validate();
               }
               _loc38_ = _loc39_.listeners.head;
               while(_loc38_ != null)
               {
                  _loc43_ = _loc38_.elt;
                  if(_loc43_.event == _loc13_)
                  {
                     if(!_loc31_.empty_arb(_loc43_.itype))
                     {
                        _loc44_ = _loc4_.push_callback(_loc43_);
                        _loc44_.event = ZPP_Flags.id_CbEvent_ONGOING;
                        _loc35_ = _loc31_.int1;
                        _loc45_ = _loc31_.int2;
                        _loc46_ = _loc43_.options1;
                        _loc47_ = _loc35_.cbTypes;
                        if(!!_loc46_.nonemptyintersection(_loc47_,_loc46_.includes) && !_loc46_.nonemptyintersection(_loc47_,_loc46_.excludes) && (!!_loc46_.nonemptyintersection(_loc47_,_loc46_.includes) && !_loc46_.nonemptyintersection(_loc47_,_loc46_.excludes)))
                        {
                           _loc44_.int1 = _loc35_;
                           _loc44_.int2 = _loc45_;
                        }
                        else
                        {
                           _loc44_.int1 = _loc45_;
                           _loc44_.int2 = _loc35_;
                        }
                        _loc44_.set = _loc31_;
                     }
                  }
                  _loc38_ = _loc38_.next;
               }
               _loc29_ = _loc30_;
               _loc30_ = _loc30_.next;
            }
         }
         while(!callbacks.empty())
         {
            _loc44_ = callbacks.pop();
            if(_loc44_.listener.type == ZPP_Flags.id_ListenerType_BODY)
            {
               _loc48_ = _loc44_.listener.body;
               _loc48_.handler(_loc44_.wrapper_body());
            }
            else if(_loc44_.listener.type == ZPP_Flags.id_ListenerType_CONSTRAINT)
            {
               _loc49_ = _loc44_.listener.constraint;
               _loc49_.handler(_loc44_.wrapper_con());
            }
            else if(_loc44_.listener.type == ZPP_Flags.id_ListenerType_INTERACTION)
            {
               _loc43_ = _loc44_.listener.interaction;
               _loc43_.handleri(_loc44_.wrapper_int());
            }
            _loc50_ = _loc44_;
            _loc35_ = null;
            _loc50_.int2 = _loc35_;
            _loc50_.int1 = _loc35_;
            _loc50_.body = null;
            _loc50_.constraint = null;
            _loc50_.listener = null;
            if(_loc50_.wrap_arbiters != null)
            {
               _loc50_.wrap_arbiters.zpp_inner.inner = null;
            }
            _loc50_.set = null;
            _loc50_.next = ZPP_Callback.zpp_pool;
            ZPP_Callback.zpp_pool = _loc50_;
         }
      }
      
      public function static_validation(param1:ZPP_Body) : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_Shape;
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:* = null as ZPP_Circle;
         var _loc5_:* = null as ZPP_Polygon;
         var _loc6_:Number = NaN;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:Number = NaN;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc13_:* = null as ZPP_Body;
         var _loc14_:* = null as ZPP_AABB;
         var _loc15_:* = null as ZPP_AABB;
         var _loc16_:* = null as ZNPNode_ZPP_Edge;
         var _loc17_:* = null as ZPP_Edge;
         if(param1.zip_aabb)
         {
            param1.zip_aabb = false;
            param1.aabb.minx = 1.79e308;
            param1.aabb.miny = 1.79e308;
            param1.aabb.maxx = -1.79e308;
            param1.aabb.maxy = -1.79e308;
            _loc2_ = param1.shapes.head;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.elt;
               if(_loc3_.zip_aabb)
               {
                  if(_loc3_.body != null)
                  {
                     _loc3_.zip_aabb = false;
                     if(_loc3_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        _loc4_ = _loc3_.circle;
                        if(_loc4_.zip_worldCOM)
                        {
                           if(_loc4_.body != null)
                           {
                              _loc4_.zip_worldCOM = false;
                              if(_loc4_.zip_localCOM)
                              {
                                 _loc4_.zip_localCOM = false;
                                 if(_loc4_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                 {
                                    _loc5_ = _loc4_.polygon;
                                    if(_loc5_.lverts.next.next == null)
                                    {
                                       _loc5_.localCOMx = _loc5_.lverts.next.x;
                                       _loc5_.localCOMy = _loc5_.lverts.next.y;
                                       null;
                                    }
                                    else if(_loc5_.lverts.next.next.next == null)
                                    {
                                       _loc5_.localCOMx = _loc5_.lverts.next.x;
                                       _loc5_.localCOMy = _loc5_.lverts.next.y;
                                       _loc6_ = 1;
                                       _loc5_.localCOMx = Number(_loc5_.localCOMx + _loc5_.lverts.next.next.x * _loc6_);
                                       _loc5_.localCOMy = Number(_loc5_.localCOMy + _loc5_.lverts.next.next.y * _loc6_);
                                       _loc6_ = 0.5;
                                       _loc5_.localCOMx = _loc5_.localCOMx * _loc6_;
                                       _loc5_.localCOMy = _loc5_.localCOMy * _loc6_;
                                    }
                                    else
                                    {
                                       _loc5_.localCOMx = 0;
                                       _loc5_.localCOMy = 0;
                                       _loc6_ = 0;
                                       _loc7_ = _loc5_.lverts.next;
                                       _loc8_ = _loc7_;
                                       _loc7_ = _loc7_.next;
                                       _loc9_ = _loc7_;
                                       _loc7_ = _loc7_.next;
                                       while(_loc7_ != null)
                                       {
                                          _loc10_ = _loc7_;
                                          _loc6_ = Number(_loc6_ + _loc9_.x * (_loc10_.y - _loc8_.y));
                                          _loc11_ = _loc10_.y * _loc9_.x - _loc10_.x * _loc9_.y;
                                          _loc5_.localCOMx = Number(_loc5_.localCOMx + (_loc9_.x + _loc10_.x) * _loc11_);
                                          _loc5_.localCOMy = Number(_loc5_.localCOMy + (_loc9_.y + _loc10_.y) * _loc11_);
                                          _loc8_ = _loc9_;
                                          _loc9_ = _loc10_;
                                          _loc7_ = _loc7_.next;
                                       }
                                       _loc7_ = _loc5_.lverts.next;
                                       _loc10_ = _loc7_;
                                       _loc6_ = Number(_loc6_ + _loc9_.x * (_loc10_.y - _loc8_.y));
                                       _loc11_ = _loc10_.y * _loc9_.x - _loc10_.x * _loc9_.y;
                                       _loc5_.localCOMx = Number(_loc5_.localCOMx + (_loc9_.x + _loc10_.x) * _loc11_);
                                       _loc5_.localCOMy = Number(_loc5_.localCOMy + (_loc9_.y + _loc10_.y) * _loc11_);
                                       _loc8_ = _loc9_;
                                       _loc9_ = _loc10_;
                                       _loc7_ = _loc7_.next;
                                       _loc12_ = _loc7_;
                                       _loc6_ = Number(_loc6_ + _loc9_.x * (_loc12_.y - _loc8_.y));
                                       _loc11_ = _loc12_.y * _loc9_.x - _loc12_.x * _loc9_.y;
                                       _loc5_.localCOMx = Number(_loc5_.localCOMx + (_loc9_.x + _loc12_.x) * _loc11_);
                                       _loc5_.localCOMy = Number(_loc5_.localCOMy + (_loc9_.y + _loc12_.y) * _loc11_);
                                       _loc6_ = 1 / (3 * _loc6_);
                                       _loc11_ = _loc6_;
                                       _loc5_.localCOMx = _loc5_.localCOMx * _loc11_;
                                       _loc5_.localCOMy = _loc5_.localCOMy * _loc11_;
                                    }
                                 }
                                 if(_loc4_.wrap_localCOM != null)
                                 {
                                    _loc4_.wrap_localCOM.zpp_inner.x = _loc4_.localCOMx;
                                    _loc4_.wrap_localCOM.zpp_inner.y = _loc4_.localCOMy;
                                 }
                              }
                              _loc13_ = _loc4_.body;
                              if(_loc13_.zip_axis)
                              {
                                 _loc13_.zip_axis = false;
                                 _loc13_.axisx = Number(Math.sin(_loc13_.rot));
                                 _loc13_.axisy = Number(Math.cos(_loc13_.rot));
                                 null;
                              }
                              _loc4_.worldCOMx = Number(_loc4_.body.posx + (_loc4_.body.axisy * _loc4_.localCOMx - _loc4_.body.axisx * _loc4_.localCOMy));
                              _loc4_.worldCOMy = Number(_loc4_.body.posy + (Number(_loc4_.localCOMx * _loc4_.body.axisx + _loc4_.localCOMy * _loc4_.body.axisy)));
                              if(_loc4_.wrap_worldCOM != null)
                              {
                                 _loc4_.wrap_worldCOM.zpp_inner.x = _loc4_.worldCOMx;
                                 _loc4_.wrap_worldCOM.zpp_inner.y = _loc4_.worldCOMy;
                              }
                           }
                        }
                        _loc6_ = _loc4_.radius;
                        _loc11_ = _loc4_.radius;
                        _loc4_.aabb.minx = _loc4_.worldCOMx - _loc6_;
                        _loc4_.aabb.miny = _loc4_.worldCOMy - _loc11_;
                        _loc4_.aabb.maxx = Number(_loc4_.worldCOMx + _loc6_);
                        _loc4_.aabb.maxy = Number(_loc4_.worldCOMy + _loc11_);
                     }
                     else
                     {
                        _loc5_ = _loc3_.polygon;
                        if(_loc5_.zip_gverts)
                        {
                           if(_loc5_.body != null)
                           {
                              _loc5_.zip_gverts = false;
                              _loc5_.validate_lverts();
                              _loc13_ = _loc5_.body;
                              if(_loc13_.zip_axis)
                              {
                                 _loc13_.zip_axis = false;
                                 _loc13_.axisx = Number(Math.sin(_loc13_.rot));
                                 _loc13_.axisy = Number(Math.cos(_loc13_.rot));
                                 null;
                              }
                              _loc7_ = _loc5_.lverts.next;
                              _loc8_ = _loc5_.gverts.next;
                              while(_loc8_ != null)
                              {
                                 _loc9_ = _loc8_;
                                 _loc10_ = _loc7_;
                                 _loc7_ = _loc7_.next;
                                 _loc9_.x = Number(_loc5_.body.posx + (_loc5_.body.axisy * _loc10_.x - _loc5_.body.axisx * _loc10_.y));
                                 _loc9_.y = Number(_loc5_.body.posy + (Number(_loc10_.x * _loc5_.body.axisx + _loc10_.y * _loc5_.body.axisy)));
                                 _loc8_ = _loc8_.next;
                              }
                           }
                        }
                        _loc7_ = _loc5_.gverts.next;
                        _loc5_.aabb.minx = _loc7_.x;
                        _loc5_.aabb.miny = _loc7_.y;
                        _loc5_.aabb.maxx = _loc7_.x;
                        _loc5_.aabb.maxy = _loc7_.y;
                        _loc8_ = _loc5_.gverts.next.next;
                        while(_loc8_ != null)
                        {
                           _loc9_ = _loc8_;
                           if(_loc9_.x < _loc5_.aabb.minx)
                           {
                              _loc5_.aabb.minx = _loc9_.x;
                           }
                           if(_loc9_.x > _loc5_.aabb.maxx)
                           {
                              _loc5_.aabb.maxx = _loc9_.x;
                           }
                           if(_loc9_.y < _loc5_.aabb.miny)
                           {
                              _loc5_.aabb.miny = _loc9_.y;
                           }
                           if(_loc9_.y > _loc5_.aabb.maxy)
                           {
                              _loc5_.aabb.maxy = _loc9_.y;
                           }
                           _loc8_ = _loc8_.next;
                        }
                     }
                  }
               }
               _loc14_ = param1.aabb;
               _loc15_ = _loc3_.aabb;
               if(_loc15_.minx < _loc14_.minx)
               {
                  _loc14_.minx = _loc15_.minx;
               }
               if(_loc15_.maxx > _loc14_.maxx)
               {
                  _loc14_.maxx = _loc15_.maxx;
               }
               if(_loc15_.miny < _loc14_.miny)
               {
                  _loc14_.miny = _loc15_.miny;
               }
               if(_loc15_.maxy > _loc14_.maxy)
               {
                  _loc14_.maxy = _loc15_.maxy;
               }
               _loc2_ = _loc2_.next;
            }
         }
         param1.validate_mass();
         param1.validate_inertia();
         _loc2_ = param1.shapes.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            if(_loc3_.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               _loc5_ = _loc3_.polygon;
               if(_loc5_.zip_gaxi)
               {
                  if(_loc5_.body != null)
                  {
                     _loc5_.zip_gaxi = false;
                     _loc5_.validate_laxi();
                     _loc13_ = _loc5_.body;
                     if(_loc13_.zip_axis)
                     {
                        _loc13_.zip_axis = false;
                        _loc13_.axisx = Number(Math.sin(_loc13_.rot));
                        _loc13_.axisy = Number(Math.cos(_loc13_.rot));
                        null;
                     }
                     _loc16_ = _loc5_.edges.head;
                     _loc7_ = _loc5_.gverts.next;
                     _loc8_ = _loc7_;
                     _loc7_ = _loc7_.next;
                     while(_loc7_ != null)
                     {
                        _loc9_ = _loc7_;
                        _loc17_ = _loc16_.elt;
                        _loc16_ = _loc16_.next;
                        _loc17_.gp0 = _loc8_;
                        _loc17_.gp1 = _loc9_;
                        _loc17_.gnormx = _loc5_.body.axisy * _loc17_.lnormx - _loc5_.body.axisx * _loc17_.lnormy;
                        _loc17_.gnormy = Number(_loc17_.lnormx * _loc5_.body.axisx + _loc17_.lnormy * _loc5_.body.axisy);
                        _loc17_.gprojection = Number(Number(_loc5_.body.posx * _loc17_.gnormx + _loc5_.body.posy * _loc17_.gnormy) + _loc17_.lprojection);
                        if(_loc17_.wrap_gnorm != null)
                        {
                           _loc17_.wrap_gnorm.zpp_inner.x = _loc17_.gnormx;
                           _loc17_.wrap_gnorm.zpp_inner.y = _loc17_.gnormy;
                        }
                        _loc17_.tp0 = _loc17_.gp0.y * _loc17_.gnormx - _loc17_.gp0.x * _loc17_.gnormy;
                        _loc17_.tp1 = _loc17_.gp1.y * _loc17_.gnormx - _loc17_.gp1.x * _loc17_.gnormy;
                        _loc8_ = _loc9_;
                        _loc7_ = _loc7_.next;
                     }
                     _loc9_ = _loc5_.gverts.next;
                     _loc17_ = _loc16_.elt;
                     _loc16_ = _loc16_.next;
                     _loc17_.gp0 = _loc8_;
                     _loc17_.gp1 = _loc9_;
                     _loc17_.gnormx = _loc5_.body.axisy * _loc17_.lnormx - _loc5_.body.axisx * _loc17_.lnormy;
                     _loc17_.gnormy = Number(_loc17_.lnormx * _loc5_.body.axisx + _loc17_.lnormy * _loc5_.body.axisy);
                     _loc17_.gprojection = Number(Number(_loc5_.body.posx * _loc17_.gnormx + _loc5_.body.posy * _loc17_.gnormy) + _loc17_.lprojection);
                     if(_loc17_.wrap_gnorm != null)
                     {
                        _loc17_.wrap_gnorm.zpp_inner.x = _loc17_.gnormx;
                        _loc17_.wrap_gnorm.zpp_inner.y = _loc17_.gnormy;
                     }
                     _loc17_.tp0 = _loc17_.gp0.y * _loc17_.gnormx - _loc17_.gp0.x * _loc17_.gnormy;
                     _loc17_.tp1 = _loc17_.gp1.y * _loc17_.gnormx - _loc17_.gp1.x * _loc17_.gnormy;
                  }
               }
            }
            _loc2_ = _loc2_.next;
         }
      }
      
      public function shapesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter) : ShapeList
      {
         return bphase.shapesUnderPoint(param1,param2,param3);
      }
      
      public function shapesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter) : ShapeList
      {
         return bphase.shapesInShape(param1,param2,param3);
      }
      
      public function shapesInCircle(param1:Vec2, param2:Number, param3:Boolean, param4:ZPP_InteractionFilter) : ShapeList
      {
         var _loc5_:ZPP_Vec2 = param1.zpp_inner;
         §§push(bphase);
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         _loc5_ = param1.zpp_inner;
         §§push(param1.zpp_inner.x);
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         return §§pop().shapesInCircle(§§pop(),param1.zpp_inner.y,param2,param3,param4);
      }
      
      public function shapesInAABB(param1:AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter) : ShapeList
      {
         return bphase.shapesInAABB(param1.zpp_inner,param2,param3,param4);
      }
      
      public function removed_shape(param1:ZPP_Shape, param2:Boolean = false) : void
      {
         var _loc7_:* = null as ZPP_Arbiter;
         var _loc8_:Boolean = false;
         var _loc9_:* = null as ZNPNode_ZPP_Interactor;
         var _loc10_:* = null as ZPP_Interactor;
         var _loc11_:* = null as ZNPNode_ZPP_Interactor;
         var _loc12_:* = null as ZPP_Interactor;
         var _loc13_:* = null as ZPP_CbSet;
         var _loc14_:* = null as ZPP_CbSet;
         var _loc15_:* = null as ZPP_CbSetPair;
         var _loc16_:* = null as ZNPList_ZPP_CbSetPair;
         var _loc17_:* = null as ZNPNode_ZPP_CbSetPair;
         var _loc18_:* = null as ZPP_CbSetPair;
         var _loc19_:* = null as ZPP_CallbackSet;
         var _loc20_:int = 0;
         var _loc21_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc22_:* = null as ZPP_InteractionListener;
         var _loc23_:* = null as ZPP_Callback;
         var _loc24_:* = null as ZPP_Interactor;
         var _loc25_:* = null as ZPP_Interactor;
         var _loc26_:* = null as ZPP_OptionType;
         var _loc27_:* = null as ZNPList_ZPP_CbType;
         var _loc28_:* = null as ZPP_Body;
         var _loc29_:* = null as ZNPList_ZPP_Arbiter;
         var _loc30_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc31_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc32_:Boolean = false;
         var _loc33_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc34_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc35_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc3_:ZPP_Space = this;
         var _loc4_:ZPP_Body = param1.body;
         if(!param2)
         {
            _loc4_.wake();
         }
         var _loc5_:ZNPNode_ZPP_Arbiter = null;
         var _loc6_:ZNPNode_ZPP_Arbiter = _loc4_.arbiters.head;
         while(_loc6_ != null)
         {
            _loc7_ = _loc6_.elt;
            _loc8_ = _loc7_.ws1 == param1 || _loc7_.ws2 == param1;
            if(_loc8_)
            {
               if(_loc7_.present != 0)
               {
                  MRCA_chains(_loc7_.ws1,_loc7_.ws2);
                  _loc9_ = mrca1.head;
                  while(_loc9_ != null)
                  {
                     _loc10_ = _loc9_.elt;
                     _loc11_ = mrca2.head;
                     while(_loc11_ != null)
                     {
                        _loc12_ = _loc11_.elt;
                        _loc13_ = _loc10_.cbSet;
                        _loc14_ = _loc12_.cbSet;
                        _loc13_.validate();
                        _loc14_.validate();
                        _loc15_ = null;
                        _loc16_ = _loc13_.cbpairs.length < _loc14_.cbpairs.length?_loc13_.cbpairs:_loc14_.cbpairs;
                        _loc17_ = _loc16_.head;
                        while(_loc17_ != null)
                        {
                           _loc18_ = _loc17_.elt;
                           if(_loc18_.a == _loc13_ && _loc18_.b == _loc14_ || _loc18_.a == _loc14_ && _loc18_.b == _loc13_)
                           {
                              _loc15_ = _loc18_;
                              break;
                           }
                           _loc17_ = _loc17_.next;
                        }
                        if(_loc15_ == null)
                        {
                           if(ZPP_CbSetPair.zpp_pool == null)
                           {
                              _loc18_ = new ZPP_CbSetPair();
                           }
                           else
                           {
                              _loc18_ = ZPP_CbSetPair.zpp_pool;
                              ZPP_CbSetPair.zpp_pool = _loc18_.next;
                              _loc18_.next = null;
                           }
                           _loc18_.zip_listeners = true;
                           if(ZPP_CbSet.setlt(_loc13_,_loc14_))
                           {
                              _loc18_.a = _loc13_;
                              _loc18_.b = _loc14_;
                           }
                           else
                           {
                              _loc18_.a = _loc14_;
                              _loc18_.b = _loc13_;
                           }
                           _loc15_ = _loc18_;
                           _loc13_.cbpairs.add(_loc15_);
                           if(_loc14_ != _loc13_)
                           {
                              _loc14_.cbpairs.add(_loc15_);
                           }
                        }
                        if(_loc15_.zip_listeners)
                        {
                           _loc15_.zip_listeners = false;
                           _loc15_.__validate();
                        }
                        if(_loc15_.listeners.head == null)
                        {
                           _loc11_ = _loc11_.next;
                        }
                        else
                        {
                           _loc19_ = ZPP_Interactor.get(_loc10_,_loc12_);
                           _loc19_.remove_arb(_loc7_);
                           if(!param2)
                           {
                              _loc20_ = ZPP_Flags.id_CbEvent_END;
                              _loc15_ = null;
                              _loc16_ = _loc13_.cbpairs.length < _loc14_.cbpairs.length?_loc13_.cbpairs:_loc14_.cbpairs;
                              _loc17_ = _loc16_.head;
                              while(_loc17_ != null)
                              {
                                 _loc18_ = _loc17_.elt;
                                 if(_loc18_.a == _loc13_ && _loc18_.b == _loc14_ || _loc18_.a == _loc14_ && _loc18_.b == _loc13_)
                                 {
                                    _loc15_ = _loc18_;
                                    break;
                                 }
                                 _loc17_ = _loc17_.next;
                              }
                              if(_loc15_ == null)
                              {
                                 if(ZPP_CbSetPair.zpp_pool == null)
                                 {
                                    _loc18_ = new ZPP_CbSetPair();
                                 }
                                 else
                                 {
                                    _loc18_ = ZPP_CbSetPair.zpp_pool;
                                    ZPP_CbSetPair.zpp_pool = _loc18_.next;
                                    _loc18_.next = null;
                                 }
                                 _loc18_.zip_listeners = true;
                                 if(ZPP_CbSet.setlt(_loc13_,_loc14_))
                                 {
                                    _loc18_.a = _loc13_;
                                    _loc18_.b = _loc14_;
                                 }
                                 else
                                 {
                                    _loc18_.a = _loc14_;
                                    _loc18_.b = _loc13_;
                                 }
                                 _loc15_ = _loc18_;
                                 _loc13_.cbpairs.add(_loc15_);
                                 if(_loc14_ != _loc13_)
                                 {
                                    _loc14_.cbpairs.add(_loc15_);
                                 }
                              }
                              if(_loc15_.zip_listeners)
                              {
                                 _loc15_.zip_listeners = false;
                                 _loc15_.__validate();
                              }
                              _loc21_ = _loc15_.listeners.head;
                              while(_loc21_ != null)
                              {
                                 _loc22_ = _loc21_.elt;
                                 if(_loc22_.event == _loc20_)
                                 {
                                    if((_loc22_.itype & _loc7_.type) != 0 && _loc19_.empty_arb(_loc22_.itype))
                                    {
                                       _loc23_ = _loc3_.push_callback(_loc22_);
                                       _loc23_.event = ZPP_Flags.id_CbEvent_END;
                                       _loc24_ = _loc19_.int1;
                                       _loc25_ = _loc19_.int2;
                                       _loc26_ = _loc22_.options1;
                                       _loc27_ = _loc24_.cbTypes;
                                       if(!!_loc26_.nonemptyintersection(_loc27_,_loc26_.includes) && !_loc26_.nonemptyintersection(_loc27_,_loc26_.excludes) && (!!_loc26_.nonemptyintersection(_loc27_,_loc26_.includes) && !_loc26_.nonemptyintersection(_loc27_,_loc26_.excludes)))
                                       {
                                          _loc23_.int1 = _loc24_;
                                          _loc23_.int2 = _loc25_;
                                       }
                                       else
                                       {
                                          _loc23_.int1 = _loc25_;
                                          _loc23_.int2 = _loc24_;
                                       }
                                       _loc23_.set = _loc19_;
                                    }
                                 }
                                 _loc21_ = _loc21_.next;
                              }
                           }
                           if(_loc19_.arbiters.head == null)
                           {
                              remove_callbackset(_loc19_);
                           }
                           _loc11_ = _loc11_.next;
                        }
                     }
                     _loc9_ = _loc9_.next;
                  }
                  _loc7_.present = _loc7_.present - 1;
               }
               if(_loc7_.b1 != _loc4_ && _loc7_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
               {
                  _loc28_ = _loc7_.b1;
                  if(!_loc28_.world)
                  {
                     _loc28_.component.waket = stamp + (!!midstep?0:1);
                     if(_loc28_.component.sleeping)
                     {
                        really_wake(_loc28_,false);
                     }
                  }
               }
               if(_loc7_.b2 != _loc4_ && _loc7_.b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
               {
                  _loc28_ = _loc7_.b2;
                  if(!_loc28_.world)
                  {
                     _loc28_.component.waket = stamp + (!!midstep?0:1);
                     if(_loc28_.component.sleeping)
                     {
                        really_wake(_loc28_,false);
                     }
                  }
               }
               _loc7_.cleared = true;
               if(_loc4_ == null || _loc7_.b2 == _loc4_)
               {
                  _loc29_ = _loc7_.b1.arbiters;
                  _loc30_ = null;
                  _loc31_ = _loc29_.head;
                  _loc32_ = false;
                  while(_loc31_ != null)
                  {
                     if(_loc31_.elt == _loc7_)
                     {
                        if(_loc30_ == null)
                        {
                           _loc33_ = _loc29_.head;
                           _loc34_ = _loc33_.next;
                           _loc29_.head = _loc34_;
                           if(_loc29_.head == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc33_ = _loc30_.next;
                           _loc34_ = _loc33_.next;
                           _loc30_.next = _loc34_;
                           if(_loc34_ == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        _loc35_ = _loc33_;
                        _loc35_.elt = null;
                        _loc35_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc35_;
                        _loc29_.modified = true;
                        _loc29_.length = _loc29_.length - 1;
                        _loc29_.pushmod = true;
                        _loc34_;
                        _loc32_ = true;
                        break;
                     }
                     _loc30_ = _loc31_;
                     _loc31_ = _loc31_.next;
                  }
                  _loc32_;
               }
               if(_loc4_ == null || _loc7_.b1 == _loc4_)
               {
                  _loc29_ = _loc7_.b2.arbiters;
                  _loc30_ = null;
                  _loc31_ = _loc29_.head;
                  _loc32_ = false;
                  while(_loc31_ != null)
                  {
                     if(_loc31_.elt == _loc7_)
                     {
                        if(_loc30_ == null)
                        {
                           _loc33_ = _loc29_.head;
                           _loc34_ = _loc33_.next;
                           _loc29_.head = _loc34_;
                           if(_loc29_.head == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        else
                        {
                           _loc33_ = _loc30_.next;
                           _loc34_ = _loc33_.next;
                           _loc30_.next = _loc34_;
                           if(_loc34_ == null)
                           {
                              _loc29_.pushmod = true;
                           }
                        }
                        _loc35_ = _loc33_;
                        _loc35_.elt = null;
                        _loc35_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                        ZNPNode_ZPP_Arbiter.zpp_pool = _loc35_;
                        _loc29_.modified = true;
                        _loc29_.length = _loc29_.length - 1;
                        _loc29_.pushmod = true;
                        _loc34_;
                        _loc32_ = true;
                        break;
                     }
                     _loc30_ = _loc31_;
                     _loc31_ = _loc31_.next;
                  }
                  _loc32_;
               }
               if(_loc7_.pair != null)
               {
                  _loc7_.pair.arb = null;
                  _loc7_.pair = null;
               }
               _loc7_.active = false;
               f_arbiters.modified = true;
               _loc6_ = _loc4_.arbiters.erase(_loc5_);
            }
            else
            {
               _loc5_ = _loc6_;
               _loc6_ = _loc6_.next;
            }
         }
         bphase.remove(param1);
         param1.removedFromSpace();
      }
      
      public function remove_callbackset(param1:ZPP_CallbackSet) : void
      {
         var _loc6_:* = null as ZNPNode_ZPP_CallbackSet;
         var _loc7_:* = null as ZNPNode_ZPP_CallbackSet;
         var _loc8_:* = null as ZNPNode_ZPP_CallbackSet;
         param1.lazydel = true;
         var _loc2_:ZNPList_ZPP_CallbackSet = param1.int1.cbsets;
         var _loc3_:ZNPNode_ZPP_CallbackSet = null;
         var _loc4_:ZNPNode_ZPP_CallbackSet = _loc2_.head;
         var _loc5_:Boolean = false;
         while(_loc4_ != null)
         {
            if(_loc4_.elt == param1)
            {
               if(_loc3_ == null)
               {
                  _loc6_ = _loc2_.head;
                  _loc7_ = _loc6_.next;
                  _loc2_.head = _loc7_;
                  if(_loc2_.head == null)
                  {
                     _loc2_.pushmod = true;
                  }
               }
               else
               {
                  _loc6_ = _loc3_.next;
                  _loc7_ = _loc6_.next;
                  _loc3_.next = _loc7_;
                  if(_loc7_ == null)
                  {
                     _loc2_.pushmod = true;
                  }
               }
               _loc8_ = _loc6_;
               _loc8_.elt = null;
               _loc8_.next = ZNPNode_ZPP_CallbackSet.zpp_pool;
               ZNPNode_ZPP_CallbackSet.zpp_pool = _loc8_;
               _loc2_.modified = true;
               _loc2_.length = _loc2_.length - 1;
               _loc2_.pushmod = true;
               _loc7_;
               _loc5_ = true;
               break;
            }
            _loc3_ = _loc4_;
            _loc4_ = _loc4_.next;
         }
         _loc5_;
         _loc2_ = param1.int2.cbsets;
         _loc3_ = null;
         _loc4_ = _loc2_.head;
         _loc5_ = false;
         while(_loc4_ != null)
         {
            if(_loc4_.elt == param1)
            {
               if(_loc3_ == null)
               {
                  _loc6_ = _loc2_.head;
                  _loc7_ = _loc6_.next;
                  _loc2_.head = _loc7_;
                  if(_loc2_.head == null)
                  {
                     _loc2_.pushmod = true;
                  }
               }
               else
               {
                  _loc6_ = _loc3_.next;
                  _loc7_ = _loc6_.next;
                  _loc3_.next = _loc7_;
                  if(_loc7_ == null)
                  {
                     _loc2_.pushmod = true;
                  }
               }
               _loc8_ = _loc6_;
               _loc8_.elt = null;
               _loc8_.next = ZNPNode_ZPP_CallbackSet.zpp_pool;
               ZNPNode_ZPP_CallbackSet.zpp_pool = _loc8_;
               _loc2_.modified = true;
               _loc2_.length = _loc2_.length - 1;
               _loc2_.pushmod = true;
               _loc7_;
               _loc5_ = true;
               break;
            }
            _loc3_ = _loc4_;
            _loc4_ = _loc4_.next;
         }
         _loc5_;
      }
      
      public function remListener(param1:ZPP_Listener) : void
      {
         if(param1.interaction != null)
         {
            null;
         }
         param1.removedFromSpace();
         param1.space = null;
      }
      
      public function remConstraint(param1:ZPP_Constraint) : void
      {
         if(param1.active)
         {
            wake_constraint(param1,true);
            live_constraints.remove(param1);
         }
         param1.removedFromSpace();
         param1.space = null;
      }
      
      public function remCompound(param1:ZPP_Compound) : void
      {
         var _loc3_:* = null as ZPP_Body;
         var _loc5_:* = null as ZPP_Constraint;
         var _loc7_:* = null as ZPP_Compound;
         var _loc2_:ZNPNode_ZPP_Body = param1.bodies.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            remBody(_loc3_);
            _loc2_ = _loc2_.next;
         }
         var _loc4_:ZNPNode_ZPP_Constraint = param1.constraints.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            remConstraint(_loc5_);
            _loc4_ = _loc4_.next;
         }
         var _loc6_:ZNPNode_ZPP_Compound = param1.compounds.head;
         while(_loc6_ != null)
         {
            _loc7_ = _loc6_.elt;
            remCompound(_loc7_);
            _loc6_ = _loc6_.next;
         }
         param1.removedFromSpace();
         param1.space = null;
      }
      
      public function remBody(param1:ZPP_Body, param2:int = -1) : void
      {
         var _loc3_:* = null as ZPP_Body;
         var _loc5_:* = null as ZPP_Shape;
         if(param1.type == ZPP_Flags.id_BodyType_STATIC)
         {
            _loc3_ = param1;
            if(!_loc3_.world)
            {
               _loc3_.component.waket = stamp + (!!midstep?0:1);
               if(_loc3_.component.sleeping)
               {
                  really_wake(_loc3_,true);
               }
            }
            staticsleep.remove(param1);
         }
         else if(param1.type == ZPP_Flags.id_BodyType_DYNAMIC)
         {
            _loc3_ = param1;
            if(!_loc3_.world)
            {
               _loc3_.component.waket = stamp + (!!midstep?0:1);
               if(_loc3_.component.sleeping)
               {
                  really_wake(_loc3_,true);
               }
            }
            live.remove(param1);
         }
         else
         {
            if(param2 != ZPP_Flags.id_BodyType_KINEMATIC)
            {
               kinematics.remove(param1);
            }
            _loc3_ = param1;
            if(!_loc3_.world)
            {
               _loc3_.component.waket = stamp + (!!midstep?0:1);
               if(_loc3_.component.sleeping)
               {
                  really_wake(_loc3_,true);
               }
            }
            staticsleep.remove(param1);
         }
         var _loc4_:ZNPNode_ZPP_Shape = param1.shapes.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            removed_shape(_loc5_,true);
            _loc4_ = _loc4_.next;
         }
         param1.removedFromSpace();
         param1.space = null;
      }
      
      public function really_wake(param1:ZPP_Body, param2:Boolean = false) : void
      {
         var _loc3_:* = null as ZNPList_ZPP_Body;
         var _loc4_:* = null as ZNPNode_ZPP_Body;
         var _loc5_:* = null as ZNPNode_ZPP_Body;
         var _loc6_:* = null as ZNPNode_ZPP_Constraint;
         var _loc7_:* = null as ZPP_Constraint;
         var _loc8_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc9_:* = null as ZPP_Arbiter;
         var _loc10_:* = null as ZPP_ColArbiter;
         var _loc11_:* = null as ZNPList_ZPP_ColArbiter;
         var _loc12_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc13_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc14_:* = null as ZNPList_ZPP_FluidArbiter;
         var _loc15_:* = null as ZPP_FluidArbiter;
         var _loc16_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc17_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc18_:* = null as ZNPList_ZPP_SensorArbiter;
         var _loc19_:* = null as ZPP_SensorArbiter;
         var _loc20_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc21_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc22_:* = null as ZPP_Body;
         var _loc23_:* = null as ZNPNode_ZPP_Shape;
         var _loc24_:* = null as ZPP_Shape;
         if(param1.component.island == null)
         {
            param1.component.sleeping = false;
            if(param1.type == ZPP_Flags.id_BodyType_KINEMATIC || param1.type == ZPP_Flags.id_BodyType_STATIC)
            {
               _loc3_ = staticsleep;
               if(ZNPNode_ZPP_Body.zpp_pool == null)
               {
                  _loc5_ = new ZNPNode_ZPP_Body();
               }
               else
               {
                  _loc5_ = ZNPNode_ZPP_Body.zpp_pool;
                  ZNPNode_ZPP_Body.zpp_pool = _loc5_.next;
                  _loc5_.next = null;
               }
               null;
               _loc5_.elt = param1;
               _loc4_ = _loc5_;
               _loc4_.next = _loc3_.head;
               _loc3_.head = _loc4_;
               _loc3_.modified = true;
               _loc3_.length = _loc3_.length + 1;
               param1;
            }
            else
            {
               _loc3_ = live;
               if(ZNPNode_ZPP_Body.zpp_pool == null)
               {
                  _loc5_ = new ZNPNode_ZPP_Body();
               }
               else
               {
                  _loc5_ = ZNPNode_ZPP_Body.zpp_pool;
                  ZNPNode_ZPP_Body.zpp_pool = _loc5_.next;
                  _loc5_.next = null;
               }
               null;
               _loc5_.elt = param1;
               _loc4_ = _loc5_;
               _loc4_.next = _loc3_.head;
               _loc3_.head = _loc4_;
               _loc3_.modified = true;
               _loc3_.length = _loc3_.length + 1;
               param1;
            }
            _loc6_ = param1.constraints.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_.elt;
               if(_loc7_.space == this)
               {
                  wake_constraint(_loc7_);
               }
               _loc6_ = _loc6_.next;
            }
            _loc8_ = param1.arbiters.head;
            while(_loc8_ != null)
            {
               _loc9_ = _loc8_.elt;
               if(_loc9_.sleeping)
               {
                  _loc9_.sleeping = false;
                  _loc9_.up_stamp = _loc9_.up_stamp + (stamp + (!!midstep?0:1) - _loc9_.sleep_stamp);
                  if(_loc9_.type == ZPP_Arbiter.COL)
                  {
                     _loc10_ = _loc9_.colarb;
                     if(_loc10_.stat)
                     {
                        _loc11_ = c_arbiters_true;
                        if(ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                        {
                           _loc13_ = new ZNPNode_ZPP_ColArbiter();
                        }
                        else
                        {
                           _loc13_ = ZNPNode_ZPP_ColArbiter.zpp_pool;
                           ZNPNode_ZPP_ColArbiter.zpp_pool = _loc13_.next;
                           _loc13_.next = null;
                        }
                        null;
                        _loc13_.elt = _loc10_;
                        _loc12_ = _loc13_;
                        _loc12_.next = _loc11_.head;
                        _loc11_.head = _loc12_;
                        _loc11_.modified = true;
                        _loc11_.length = _loc11_.length + 1;
                        _loc10_;
                     }
                     else
                     {
                        _loc11_ = c_arbiters_false;
                        if(ZNPNode_ZPP_ColArbiter.zpp_pool == null)
                        {
                           _loc13_ = new ZNPNode_ZPP_ColArbiter();
                        }
                        else
                        {
                           _loc13_ = ZNPNode_ZPP_ColArbiter.zpp_pool;
                           ZNPNode_ZPP_ColArbiter.zpp_pool = _loc13_.next;
                           _loc13_.next = null;
                        }
                        null;
                        _loc13_.elt = _loc10_;
                        _loc12_ = _loc13_;
                        _loc12_.next = _loc11_.head;
                        _loc11_.head = _loc12_;
                        _loc11_.modified = true;
                        _loc11_.length = _loc11_.length + 1;
                        _loc10_;
                     }
                  }
                  else if(_loc9_.type == ZPP_Arbiter.FLUID)
                  {
                     _loc14_ = f_arbiters;
                     _loc15_ = _loc9_.fluidarb;
                     if(ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
                     {
                        _loc17_ = new ZNPNode_ZPP_FluidArbiter();
                     }
                     else
                     {
                        _loc17_ = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                        ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc17_.next;
                        _loc17_.next = null;
                     }
                     null;
                     _loc17_.elt = _loc15_;
                     _loc16_ = _loc17_;
                     _loc16_.next = _loc14_.head;
                     _loc14_.head = _loc16_;
                     _loc14_.modified = true;
                     _loc14_.length = _loc14_.length + 1;
                     _loc15_;
                  }
                  else
                  {
                     _loc18_ = s_arbiters;
                     _loc19_ = _loc9_.sensorarb;
                     if(ZNPNode_ZPP_SensorArbiter.zpp_pool == null)
                     {
                        _loc21_ = new ZNPNode_ZPP_SensorArbiter();
                     }
                     else
                     {
                        _loc21_ = ZNPNode_ZPP_SensorArbiter.zpp_pool;
                        ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc21_.next;
                        _loc21_.next = null;
                     }
                     null;
                     _loc21_.elt = _loc19_;
                     _loc20_ = _loc21_;
                     _loc20_.next = _loc18_.head;
                     _loc18_.head = _loc20_;
                     _loc18_.modified = true;
                     _loc18_.length = _loc18_.length + 1;
                     _loc19_;
                  }
               }
               if(_loc9_.type != ZPP_Arbiter.SENSOR && !_loc9_.cleared && _loc9_.up_stamp == stamp && (_loc9_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
               {
                  if(_loc9_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc9_.b1.component.sleeping)
                  {
                     _loc22_ = _loc9_.b1;
                     if(!_loc22_.world)
                     {
                        _loc22_.component.waket = stamp + (!!midstep?0:1);
                        if(_loc22_.component.sleeping)
                        {
                           really_wake(_loc22_,false);
                        }
                     }
                  }
                  if(_loc9_.b2.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc9_.b2.component.sleeping)
                  {
                     _loc22_ = _loc9_.b2;
                     if(!_loc22_.world)
                     {
                        _loc22_.component.waket = stamp + (!!midstep?0:1);
                        if(_loc22_.component.sleeping)
                        {
                           really_wake(_loc22_,false);
                        }
                     }
                  }
               }
               _loc8_ = _loc8_.next;
            }
            if(!param2 && param1.type == ZPP_Flags.id_BodyType_DYNAMIC)
            {
               bodyCbWake(param1);
            }
            if(!param2 && !bphase.is_sweep && param1.type != ZPP_Flags.id_BodyType_STATIC)
            {
               _loc23_ = param1.shapes.head;
               while(_loc23_ != null)
               {
                  _loc24_ = _loc23_.elt;
                  if(_loc24_.node != null)
                  {
                     bphase.sync(_loc24_);
                  }
                  _loc23_ = _loc23_.next;
               }
            }
         }
         else
         {
            wakeIsland(param1.component.island);
         }
      }
      
      public function rayMultiCast(param1:Ray, param2:Boolean, param3:InteractionFilter) : RayResultList
      {
         return bphase.rayMultiCast(param1.zpp_inner,param2,param3 == null?null:param3.zpp_inner);
      }
      
      public function rayCast(param1:Ray, param2:Boolean, param3:InteractionFilter) : RayResult
      {
         return bphase.rayCast(param1.zpp_inner,param2,param3 == null?null:param3.zpp_inner);
      }
      
      public function push_callback(param1:ZPP_Listener) : ZPP_Callback
      {
         var _loc2_:* = null as ZPP_Callback;
         if(ZPP_Callback.zpp_pool == null)
         {
            _loc2_ = new ZPP_Callback();
         }
         else
         {
            _loc2_ = ZPP_Callback.zpp_pool;
            ZPP_Callback.zpp_pool = _loc2_.next;
            _loc2_.next = null;
         }
         null;
         callbacks.push(_loc2_);
         _loc2_.listener = param1;
         return _loc2_;
      }
      
      public function prestep(param1:Number) : void
      {
         var _loc5_:* = null as ZPP_Constraint;
         var _loc10_:* = null as ZPP_ColArbiter;
         var _loc11_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc12_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc13_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc14_:Boolean = false;
         var _loc15_:* = false;
         var _loc16_:* = null as ZPP_Shape;
         var _loc17_:* = null as ZPP_Shape;
         var _loc18_:* = null as ZNPList_ZPP_Interactor;
         var _loc19_:* = null as ZNPNode_ZPP_Interactor;
         var _loc20_:* = null as ZNPNode_ZPP_Interactor;
         var _loc21_:* = null as ZPP_Interactor;
         var _loc22_:* = null as ZPP_Compound;
         var _loc23_:* = null as ZPP_Compound;
         var _loc24_:* = 0;
         var _loc25_:int = 0;
         var _loc26_:* = null as ZPP_Interactor;
         var _loc27_:* = null as ZPP_CbSet;
         var _loc28_:* = null as ZPP_CbSet;
         var _loc29_:* = null as ZPP_CbSetPair;
         var _loc30_:* = null as ZNPList_ZPP_CbSetPair;
         var _loc31_:* = null as ZNPNode_ZPP_CbSetPair;
         var _loc32_:* = null as ZPP_CbSetPair;
         var _loc33_:* = null as ZPP_CallbackSet;
         var _loc34_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc35_:* = null as ZPP_InteractionListener;
         var _loc36_:* = null as ZPP_Callback;
         var _loc37_:* = null as ZPP_Interactor;
         var _loc38_:* = null as ZPP_Interactor;
         var _loc39_:* = null as ZPP_OptionType;
         var _loc40_:* = null as ZNPList_ZPP_CbType;
         var _loc41_:Boolean = false;
         var _loc42_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc43_:* = null as ZPP_Arbiter;
         var _loc44_:* = null as ZNPList_ZPP_Arbiter;
         var _loc45_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc46_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc47_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc48_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc49_:* = null as ZPP_Body;
         var _loc50_:* = null as ZPP_Contact;
         var _loc51_:* = null as ZPP_Contact;
         var _loc52_:* = null as ZPP_Contact;
         var _loc53_:* = null as ZPP_IContact;
         var _loc54_:* = null as ZPP_IContact;
         var _loc55_:* = null as ZPP_ColArbiter;
         var _loc56_:Number = NaN;
         var _loc57_:Number = NaN;
         var _loc58_:* = null as ZPP_Contact;
         var _loc59_:* = null as ZPP_Contact;
         var _loc60_:* = null as ZPP_Contact;
         var _loc61_:* = null as ZPP_IContact;
         var _loc62_:* = null as ZPP_IContact;
         var _loc63_:* = null as ZPP_IContact;
         var _loc64_:Number = NaN;
         var _loc65_:Number = NaN;
         var _loc66_:Number = NaN;
         var _loc67_:Number = NaN;
         var _loc68_:Number = NaN;
         var _loc69_:Number = NaN;
         var _loc70_:Number = NaN;
         var _loc74_:* = null as ZPP_FluidArbiter;
         var _loc75_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc76_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc77_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc78_:* = null as ZPP_FluidArbiter;
         var _loc79_:Number = NaN;
         var _loc80_:Number = NaN;
         var _loc81_:Number = NaN;
         var _loc82_:Number = NaN;
         var _loc83_:* = null as ZPP_Polygon;
         var _loc84_:Number = NaN;
         var _loc85_:* = null as ZNPNode_ZPP_Edge;
         var _loc86_:* = null as ZPP_Edge;
         var _loc87_:Number = NaN;
         var _loc88_:Number = NaN;
         var _loc89_:Number = NaN;
         var _loc90_:Number = NaN;
         var _loc91_:Number = NaN;
         var _loc95_:* = null as ZPP_SensorArbiter;
         var _loc96_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc97_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc98_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc99_:* = null as ZPP_SensorArbiter;
         var _loc2_:ZPP_Space = this;
         var _loc3_:ZNPNode_ZPP_Constraint = null;
         var _loc4_:ZNPNode_ZPP_Constraint = live_constraints.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            if(_loc5_.preStep(param1))
            {
               _loc4_ = live_constraints.erase(_loc3_);
               constraintCbBreak(_loc5_);
               if(_loc5_.removeOnBreak)
               {
                  _loc5_.component.sleeping = true;
                  midstep = false;
                  if(_loc5_.compound != null)
                  {
                     _loc5_.compound.wrap_constraints.remove(_loc5_.outer);
                  }
                  else
                  {
                     wrap_constraints.remove(_loc5_.outer);
                  }
                  midstep = true;
               }
               else
               {
                  _loc5_.active = false;
               }
               _loc5_.clearcache();
            }
            else
            {
               _loc3_ = _loc4_;
               _loc4_ = _loc4_.next;
            }
         }
         var _loc6_:ZNPNode_ZPP_ColArbiter = null;
         var _loc7_:ZNPList_ZPP_ColArbiter = c_arbiters_true;
         var _loc8_:ZNPNode_ZPP_ColArbiter = _loc7_.head;
         var _loc9_:* = c_arbiters_false != null;
         if(!!_loc9_ && _loc8_ == null)
         {
            _loc9_ = false;
            _loc8_ = c_arbiters_false.head;
            _loc7_ = c_arbiters_false;
            _loc6_ = null;
         }
         while(_loc8_ != null)
         {
            _loc10_ = _loc8_.elt;
            if(!_loc10_.cleared && (!!_loc10_.b1.component.sleeping && _loc10_.b2.component.sleeping))
            {
               _loc10_.sleep_stamp = stamp;
               _loc10_.sleeping = true;
               if(_loc6_ == null)
               {
                  _loc11_ = _loc7_.head;
                  _loc12_ = _loc11_.next;
                  _loc7_.head = _loc12_;
                  if(_loc7_.head == null)
                  {
                     _loc7_.pushmod = true;
                  }
               }
               else
               {
                  _loc11_ = _loc6_.next;
                  _loc12_ = _loc11_.next;
                  _loc6_.next = _loc12_;
                  if(_loc12_ == null)
                  {
                     _loc7_.pushmod = true;
                  }
               }
               _loc13_ = _loc11_;
               _loc13_.elt = null;
               _loc13_.next = ZNPNode_ZPP_ColArbiter.zpp_pool;
               ZNPNode_ZPP_ColArbiter.zpp_pool = _loc13_;
               _loc7_.modified = true;
               _loc7_.length = _loc7_.length - 1;
               _loc7_.pushmod = true;
               _loc8_ = _loc12_;
               if(!!_loc9_ && _loc8_ == null)
               {
                  _loc9_ = false;
                  _loc8_ = c_arbiters_false.head;
                  _loc7_ = c_arbiters_false;
                  _loc6_ = null;
               }
            }
            else
            {
               if(!_loc10_.cleared || _loc10_.present != 0 || _loc10_.intchange)
               {
                  _loc14_ = _loc10_.up_stamp == stamp - 1 && !_loc10_.cleared && !_loc10_.intchange;
                  _loc15_ = Boolean(!!_loc10_.fresh && !_loc10_.cleared && !_loc10_.intchange);
                  if(_loc15_ || _loc14_ || _loc10_.cleared || _loc10_.intchange)
                  {
                     _loc16_ = _loc10_.ws1;
                     _loc17_ = _loc10_.ws2;
                     _loc18_ = mrca1;
                     while(_loc18_.head != null)
                     {
                        _loc19_ = _loc18_.head;
                        _loc18_.head = _loc19_.next;
                        _loc20_ = _loc19_;
                        _loc20_.elt = null;
                        _loc20_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                        ZNPNode_ZPP_Interactor.zpp_pool = _loc20_;
                        if(_loc18_.head == null)
                        {
                           _loc18_.pushmod = true;
                        }
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length - 1;
                     }
                     _loc18_.pushmod = true;
                     _loc18_ = mrca2;
                     while(_loc18_.head != null)
                     {
                        _loc19_ = _loc18_.head;
                        _loc18_.head = _loc19_.next;
                        _loc20_ = _loc19_;
                        _loc20_.elt = null;
                        _loc20_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                        ZNPNode_ZPP_Interactor.zpp_pool = _loc20_;
                        if(_loc18_.head == null)
                        {
                           _loc18_.pushmod = true;
                        }
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length - 1;
                     }
                     _loc18_.pushmod = true;
                     if(_loc16_.cbSet != null)
                     {
                        _loc18_ = mrca1;
                        if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                           _loc20_ = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                           _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                           _loc20_.next = null;
                        }
                        null;
                        _loc20_.elt = _loc16_;
                        _loc19_ = _loc20_;
                        _loc19_.next = _loc18_.head;
                        _loc18_.head = _loc19_;
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length + 1;
                        _loc16_;
                     }
                     if(_loc16_.body.cbSet != null)
                     {
                        _loc18_ = mrca1;
                        _loc21_ = _loc16_.body;
                        if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                           _loc20_ = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                           _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                           _loc20_.next = null;
                        }
                        null;
                        _loc20_.elt = _loc21_;
                        _loc19_ = _loc20_;
                        _loc19_.next = _loc18_.head;
                        _loc18_.head = _loc19_;
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length + 1;
                        _loc21_;
                     }
                     if(_loc17_.cbSet != null)
                     {
                        _loc18_ = mrca2;
                        if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                           _loc20_ = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                           _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                           _loc20_.next = null;
                        }
                        null;
                        _loc20_.elt = _loc17_;
                        _loc19_ = _loc20_;
                        _loc19_.next = _loc18_.head;
                        _loc18_.head = _loc19_;
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length + 1;
                        _loc17_;
                     }
                     if(_loc17_.body.cbSet != null)
                     {
                        _loc18_ = mrca2;
                        _loc21_ = _loc17_.body;
                        if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                           _loc20_ = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                           _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                           _loc20_.next = null;
                        }
                        null;
                        _loc20_.elt = _loc21_;
                        _loc19_ = _loc20_;
                        _loc19_.next = _loc18_.head;
                        _loc18_.head = _loc19_;
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length + 1;
                        _loc21_;
                     }
                     _loc22_ = _loc16_.body.compound;
                     _loc23_ = _loc17_.body.compound;
                     while(_loc22_ != _loc23_)
                     {
                        _loc24_ = int(_loc22_ == null?0:_loc22_.depth);
                        _loc25_ = _loc23_ == null?0:_loc23_.depth;
                        if(_loc24_ < _loc25_)
                        {
                           if(_loc23_.cbSet != null)
                           {
                              _loc18_ = mrca2;
                              if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                              {
                                 _loc20_ = new ZNPNode_ZPP_Interactor();
                              }
                              else
                              {
                                 _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                                 ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                                 _loc20_.next = null;
                              }
                              null;
                              _loc20_.elt = _loc23_;
                              _loc19_ = _loc20_;
                              _loc19_.next = _loc18_.head;
                              _loc18_.head = _loc19_;
                              _loc18_.modified = true;
                              _loc18_.length = _loc18_.length + 1;
                              _loc23_;
                           }
                           _loc23_ = _loc23_.compound;
                        }
                        else
                        {
                           if(_loc22_.cbSet != null)
                           {
                              _loc18_ = mrca1;
                              if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                              {
                                 _loc20_ = new ZNPNode_ZPP_Interactor();
                              }
                              else
                              {
                                 _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                                 ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                                 _loc20_.next = null;
                              }
                              null;
                              _loc20_.elt = _loc22_;
                              _loc19_ = _loc20_;
                              _loc19_.next = _loc18_.head;
                              _loc18_.head = _loc19_;
                              _loc18_.modified = true;
                              _loc18_.length = _loc18_.length + 1;
                              _loc22_;
                           }
                           _loc22_ = _loc22_.compound;
                        }
                     }
                     _loc19_ = mrca1.head;
                     while(_loc19_ != null)
                     {
                        _loc21_ = _loc19_.elt;
                        _loc20_ = mrca2.head;
                        while(_loc20_ != null)
                        {
                           _loc26_ = _loc20_.elt;
                           _loc27_ = _loc21_.cbSet;
                           _loc28_ = _loc26_.cbSet;
                           _loc29_ = null;
                           _loc30_ = _loc27_.cbpairs.length < _loc28_.cbpairs.length?_loc27_.cbpairs:_loc28_.cbpairs;
                           _loc31_ = _loc30_.head;
                           while(_loc31_ != null)
                           {
                              _loc32_ = _loc31_.elt;
                              if(_loc32_.a == _loc27_ && _loc32_.b == _loc28_ || _loc32_.a == _loc28_ && _loc32_.b == _loc27_)
                              {
                                 _loc29_ = _loc32_;
                                 break;
                              }
                              _loc31_ = _loc31_.next;
                           }
                           if(_loc29_ == null)
                           {
                              if(ZPP_CbSetPair.zpp_pool == null)
                              {
                                 _loc32_ = new ZPP_CbSetPair();
                              }
                              else
                              {
                                 _loc32_ = ZPP_CbSetPair.zpp_pool;
                                 ZPP_CbSetPair.zpp_pool = _loc32_.next;
                                 _loc32_.next = null;
                              }
                              _loc32_.zip_listeners = true;
                              if(ZPP_CbSet.setlt(_loc27_,_loc28_))
                              {
                                 _loc32_.a = _loc27_;
                                 _loc32_.b = _loc28_;
                              }
                              else
                              {
                                 _loc32_.a = _loc28_;
                                 _loc32_.b = _loc27_;
                              }
                              _loc29_ = _loc32_;
                              _loc27_.cbpairs.add(_loc29_);
                              if(_loc28_ != _loc27_)
                              {
                                 _loc28_.cbpairs.add(_loc29_);
                              }
                           }
                           if(_loc29_.zip_listeners)
                           {
                              _loc29_.zip_listeners = false;
                              _loc29_.__validate();
                           }
                           if(_loc29_.listeners.head == null)
                           {
                              _loc20_ = _loc20_.next;
                           }
                           else
                           {
                              _loc33_ = ZPP_Interactor.get(_loc21_,_loc26_);
                              if(_loc15_ || _loc10_.intchange)
                              {
                                 if(_loc33_ == null)
                                 {
                                    _loc33_ = ZPP_CallbackSet.get(_loc21_,_loc26_);
                                    add_callbackset(_loc33_);
                                 }
                                 _loc24_ = int(ZPP_Flags.id_CbEvent_BEGIN);
                                 _loc29_ = null;
                                 _loc30_ = _loc27_.cbpairs.length < _loc28_.cbpairs.length?_loc27_.cbpairs:_loc28_.cbpairs;
                                 _loc31_ = _loc30_.head;
                                 while(_loc31_ != null)
                                 {
                                    _loc32_ = _loc31_.elt;
                                    if(_loc32_.a == _loc27_ && _loc32_.b == _loc28_ || _loc32_.a == _loc28_ && _loc32_.b == _loc27_)
                                    {
                                       _loc29_ = _loc32_;
                                       break;
                                    }
                                    _loc31_ = _loc31_.next;
                                 }
                                 if(_loc29_ == null)
                                 {
                                    if(ZPP_CbSetPair.zpp_pool == null)
                                    {
                                       _loc32_ = new ZPP_CbSetPair();
                                    }
                                    else
                                    {
                                       _loc32_ = ZPP_CbSetPair.zpp_pool;
                                       ZPP_CbSetPair.zpp_pool = _loc32_.next;
                                       _loc32_.next = null;
                                    }
                                    _loc32_.zip_listeners = true;
                                    if(ZPP_CbSet.setlt(_loc27_,_loc28_))
                                    {
                                       _loc32_.a = _loc27_;
                                       _loc32_.b = _loc28_;
                                    }
                                    else
                                    {
                                       _loc32_.a = _loc28_;
                                       _loc32_.b = _loc27_;
                                    }
                                    _loc29_ = _loc32_;
                                    _loc27_.cbpairs.add(_loc29_);
                                    if(_loc28_ != _loc27_)
                                    {
                                       _loc28_.cbpairs.add(_loc29_);
                                    }
                                 }
                                 if(_loc29_.zip_listeners)
                                 {
                                    _loc29_.zip_listeners = false;
                                    _loc29_.__validate();
                                 }
                                 _loc34_ = _loc29_.listeners.head;
                                 while(_loc34_ != null)
                                 {
                                    _loc35_ = _loc34_.elt;
                                    if(_loc35_.event == _loc24_)
                                    {
                                       if((_loc35_.itype & _loc10_.type) != 0 && _loc33_.empty_arb(_loc35_.itype))
                                       {
                                          _loc36_ = _loc2_.push_callback(_loc35_);
                                          _loc36_.event = ZPP_Flags.id_CbEvent_BEGIN;
                                          _loc37_ = _loc33_.int1;
                                          _loc38_ = _loc33_.int2;
                                          _loc39_ = _loc35_.options1;
                                          _loc40_ = _loc37_.cbTypes;
                                          if(!!_loc39_.nonemptyintersection(_loc40_,_loc39_.includes) && !_loc39_.nonemptyintersection(_loc40_,_loc39_.excludes) && (!!_loc39_.nonemptyintersection(_loc40_,_loc39_.includes) && !_loc39_.nonemptyintersection(_loc40_,_loc39_.excludes)))
                                          {
                                             _loc36_.int1 = _loc37_;
                                             _loc36_.int2 = _loc38_;
                                          }
                                          else
                                          {
                                             _loc36_.int1 = _loc38_;
                                             _loc36_.int2 = _loc37_;
                                          }
                                          _loc36_.set = _loc33_;
                                       }
                                    }
                                    _loc34_ = _loc34_.next;
                                 }
                                 _loc41_ = false;
                                 _loc42_ = _loc33_.arbiters.head;
                                 while(_loc42_ != null)
                                 {
                                    _loc43_ = _loc42_.elt;
                                    if(_loc43_ == _loc10_)
                                    {
                                       _loc41_ = true;
                                       break;
                                    }
                                    _loc42_ = _loc42_.next;
                                 }
                                 if(!_loc41_)
                                 {
                                    _loc44_ = _loc33_.arbiters;
                                    if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                    {
                                       _loc45_ = new ZNPNode_ZPP_Arbiter();
                                    }
                                    else
                                    {
                                       _loc45_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                                       ZNPNode_ZPP_Arbiter.zpp_pool = _loc45_.next;
                                       _loc45_.next = null;
                                    }
                                    null;
                                    _loc45_.elt = _loc10_;
                                    _loc42_ = _loc45_;
                                    _loc42_.next = _loc44_.head;
                                    _loc44_.head = _loc42_;
                                    _loc44_.modified = true;
                                    _loc44_.length = _loc44_.length + 1;
                                    _loc10_;
                                    §§push(true);
                                 }
                                 else
                                 {
                                    §§push(false);
                                 }
                                 _loc10_.present = _loc10_.present + 1;
                              }
                              else
                              {
                                 _loc10_.present = _loc10_.present - 1;
                                 _loc33_.remove_arb(_loc10_);
                                 _loc24_ = int(ZPP_Flags.id_CbEvent_END);
                                 _loc29_ = null;
                                 _loc30_ = _loc27_.cbpairs.length < _loc28_.cbpairs.length?_loc27_.cbpairs:_loc28_.cbpairs;
                                 _loc31_ = _loc30_.head;
                                 while(_loc31_ != null)
                                 {
                                    _loc32_ = _loc31_.elt;
                                    if(_loc32_.a == _loc27_ && _loc32_.b == _loc28_ || _loc32_.a == _loc28_ && _loc32_.b == _loc27_)
                                    {
                                       _loc29_ = _loc32_;
                                       break;
                                    }
                                    _loc31_ = _loc31_.next;
                                 }
                                 if(_loc29_ == null)
                                 {
                                    if(ZPP_CbSetPair.zpp_pool == null)
                                    {
                                       _loc32_ = new ZPP_CbSetPair();
                                    }
                                    else
                                    {
                                       _loc32_ = ZPP_CbSetPair.zpp_pool;
                                       ZPP_CbSetPair.zpp_pool = _loc32_.next;
                                       _loc32_.next = null;
                                    }
                                    _loc32_.zip_listeners = true;
                                    if(ZPP_CbSet.setlt(_loc27_,_loc28_))
                                    {
                                       _loc32_.a = _loc27_;
                                       _loc32_.b = _loc28_;
                                    }
                                    else
                                    {
                                       _loc32_.a = _loc28_;
                                       _loc32_.b = _loc27_;
                                    }
                                    _loc29_ = _loc32_;
                                    _loc27_.cbpairs.add(_loc29_);
                                    if(_loc28_ != _loc27_)
                                    {
                                       _loc28_.cbpairs.add(_loc29_);
                                    }
                                 }
                                 if(_loc29_.zip_listeners)
                                 {
                                    _loc29_.zip_listeners = false;
                                    _loc29_.__validate();
                                 }
                                 _loc34_ = _loc29_.listeners.head;
                                 while(_loc34_ != null)
                                 {
                                    _loc35_ = _loc34_.elt;
                                    if(_loc35_.event == _loc24_)
                                    {
                                       if((_loc35_.itype & _loc10_.type) != 0 && _loc33_.empty_arb(_loc35_.itype))
                                       {
                                          _loc36_ = _loc2_.push_callback(_loc35_);
                                          _loc36_.event = ZPP_Flags.id_CbEvent_END;
                                          _loc37_ = _loc33_.int1;
                                          _loc38_ = _loc33_.int2;
                                          _loc39_ = _loc35_.options1;
                                          _loc40_ = _loc37_.cbTypes;
                                          if(!!_loc39_.nonemptyintersection(_loc40_,_loc39_.includes) && !_loc39_.nonemptyintersection(_loc40_,_loc39_.excludes) && (!!_loc39_.nonemptyintersection(_loc40_,_loc39_.includes) && !_loc39_.nonemptyintersection(_loc40_,_loc39_.excludes)))
                                          {
                                             _loc36_.int1 = _loc37_;
                                             _loc36_.int2 = _loc38_;
                                          }
                                          else
                                          {
                                             _loc36_.int1 = _loc38_;
                                             _loc36_.int2 = _loc37_;
                                          }
                                          _loc36_.set = _loc33_;
                                       }
                                    }
                                    _loc34_ = _loc34_.next;
                                 }
                                 if(_loc33_.arbiters.head == null)
                                 {
                                    remove_callbackset(_loc33_);
                                 }
                              }
                              _loc20_ = _loc20_.next;
                           }
                        }
                        _loc19_ = _loc19_.next;
                     }
                  }
                  _loc10_.fresh = false;
                  _loc10_.intchange = false;
               }
               if(_loc10_.cleared || _loc10_.up_stamp + (_loc10_.type == ZPP_Arbiter.COL?6:0) < stamp)
               {
                  if(!_loc10_.cleared)
                  {
                     _loc44_ = _loc10_.b1.arbiters;
                     _loc42_ = null;
                     _loc45_ = _loc44_.head;
                     _loc14_ = false;
                     while(_loc45_ != null)
                     {
                        if(_loc45_.elt == _loc10_)
                        {
                           if(_loc42_ == null)
                           {
                              _loc46_ = _loc44_.head;
                              _loc47_ = _loc46_.next;
                              _loc44_.head = _loc47_;
                              if(_loc44_.head == null)
                              {
                                 _loc44_.pushmod = true;
                              }
                           }
                           else
                           {
                              _loc46_ = _loc42_.next;
                              _loc47_ = _loc46_.next;
                              _loc42_.next = _loc47_;
                              if(_loc47_ == null)
                              {
                                 _loc44_.pushmod = true;
                              }
                           }
                           _loc48_ = _loc46_;
                           _loc48_.elt = null;
                           _loc48_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                           ZNPNode_ZPP_Arbiter.zpp_pool = _loc48_;
                           _loc44_.modified = true;
                           _loc44_.length = _loc44_.length - 1;
                           _loc44_.pushmod = true;
                           _loc47_;
                           _loc14_ = true;
                           break;
                        }
                        _loc42_ = _loc45_;
                        _loc45_ = _loc45_.next;
                     }
                     _loc14_;
                     _loc44_ = _loc10_.b2.arbiters;
                     _loc42_ = null;
                     _loc45_ = _loc44_.head;
                     _loc14_ = false;
                     while(_loc45_ != null)
                     {
                        if(_loc45_.elt == _loc10_)
                        {
                           if(_loc42_ == null)
                           {
                              _loc46_ = _loc44_.head;
                              _loc47_ = _loc46_.next;
                              _loc44_.head = _loc47_;
                              if(_loc44_.head == null)
                              {
                                 _loc44_.pushmod = true;
                              }
                           }
                           else
                           {
                              _loc46_ = _loc42_.next;
                              _loc47_ = _loc46_.next;
                              _loc42_.next = _loc47_;
                              if(_loc47_ == null)
                              {
                                 _loc44_.pushmod = true;
                              }
                           }
                           _loc48_ = _loc46_;
                           _loc48_.elt = null;
                           _loc48_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                           ZNPNode_ZPP_Arbiter.zpp_pool = _loc48_;
                           _loc44_.modified = true;
                           _loc44_.length = _loc44_.length - 1;
                           _loc44_.pushmod = true;
                           _loc47_;
                           _loc14_ = true;
                           break;
                        }
                        _loc42_ = _loc45_;
                        _loc45_ = _loc45_.next;
                     }
                     _loc14_;
                     if(_loc10_.pair != null)
                     {
                        _loc10_.pair.arb = null;
                        _loc10_.pair = null;
                     }
                  }
                  _loc49_ = null;
                  _loc10_.b2 = _loc49_;
                  _loc10_.b1 = _loc49_;
                  _loc10_.active = false;
                  _loc10_.intchange = false;
                  while(_loc10_.contacts.next != null)
                  {
                     _loc51_ = _loc10_.contacts;
                     _loc52_ = _loc51_.next;
                     _loc51_.pop();
                     _loc50_ = _loc52_;
                     _loc50_.arbiter = null;
                     _loc50_.next = ZPP_Contact.zpp_pool;
                     ZPP_Contact.zpp_pool = _loc50_;
                     _loc53_ = _loc10_.innards;
                     _loc54_ = _loc53_.next;
                     _loc53_.next = _loc54_.next;
                     _loc54_._inuse = false;
                     if(_loc53_.next == null)
                     {
                        _loc53_.pushmod = true;
                     }
                     _loc53_.modified = true;
                     _loc53_.length = _loc53_.length - 1;
                  }
                  _loc55_ = _loc10_;
                  null;
                  _loc55_.next = ZPP_ColArbiter.zpp_pool;
                  ZPP_ColArbiter.zpp_pool = _loc55_;
                  _loc10_.pre_dt = -1;
                  if(_loc6_ == null)
                  {
                     _loc11_ = _loc7_.head;
                     _loc12_ = _loc11_.next;
                     _loc7_.head = _loc12_;
                     if(_loc7_.head == null)
                     {
                        _loc7_.pushmod = true;
                     }
                  }
                  else
                  {
                     _loc11_ = _loc6_.next;
                     _loc12_ = _loc11_.next;
                     _loc6_.next = _loc12_;
                     if(_loc12_ == null)
                     {
                        _loc7_.pushmod = true;
                     }
                  }
                  _loc13_ = _loc11_;
                  _loc13_.elt = null;
                  _loc13_.next = ZNPNode_ZPP_ColArbiter.zpp_pool;
                  ZNPNode_ZPP_ColArbiter.zpp_pool = _loc13_;
                  _loc7_.modified = true;
                  _loc7_.length = _loc7_.length - 1;
                  _loc7_.pushmod = true;
                  _loc8_ = _loc12_;
                  if(!!_loc9_ && _loc8_ == null)
                  {
                     _loc9_ = false;
                     _loc8_ = c_arbiters_false.head;
                     _loc7_ = c_arbiters_false;
                     _loc6_ = null;
                  }
               }
               else
               {
                  _loc14_ = _loc10_.active;
                  _loc15_ = _loc10_.up_stamp == stamp;
                  _loc10_.presentable = _loc15_;
                  _loc10_.active = _loc15_;
                  if((_loc10_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                  {
                     if(_loc10_.active)
                     {
                        if(_loc10_.invalidated)
                        {
                           _loc10_.invalidated = false;
                           if(_loc10_.s1.material.elasticity <= -1.79e308 || _loc10_.s2.material.elasticity <= -1.79e308)
                           {
                              _loc10_.restitution = 0;
                           }
                           else if(_loc10_.s1.material.elasticity >= 1.79e308 || _loc10_.s2.material.elasticity >= 1.79e308)
                           {
                              _loc10_.restitution = 1;
                           }
                           else
                           {
                              _loc10_.restitution = (_loc10_.s1.material.elasticity + _loc10_.s2.material.elasticity) / 2;
                           }
                           if(_loc10_.restitution < 0)
                           {
                              _loc10_.restitution = 0;
                           }
                           if(_loc10_.restitution > 1)
                           {
                              _loc10_.restitution = 1;
                           }
                           _loc56_ = _loc10_.s1.material.dynamicFriction * _loc10_.s2.material.dynamicFriction;
                           §§push(_loc10_);
                           if(_loc56_ == 0)
                           {
                              §§push(0);
                           }
                           else
                           {
                              sf32(_loc56_,0);
                              si32(1597463007 - (li32(0) >> 1),0);
                              _loc57_ = lf32(0);
                              §§push(1 / (_loc57_ * (1.5 - 0.5 * _loc56_ * _loc57_ * _loc57_)));
                           }
                           §§pop().dyn_fric = §§pop();
                           _loc56_ = _loc10_.s1.material.staticFriction * _loc10_.s2.material.staticFriction;
                           §§push(_loc10_);
                           if(_loc56_ == 0)
                           {
                              §§push(0);
                           }
                           else
                           {
                              sf32(_loc56_,0);
                              si32(1597463007 - (li32(0) >> 1),0);
                              _loc57_ = lf32(0);
                              §§push(1 / (_loc57_ * (1.5 - 0.5 * _loc56_ * _loc57_ * _loc57_)));
                           }
                           §§pop().stat_fric = §§pop();
                           _loc56_ = _loc10_.s1.material.rollingFriction * _loc10_.s2.material.rollingFriction;
                           §§push(_loc10_);
                           if(_loc56_ == 0)
                           {
                              §§push(0);
                           }
                           else
                           {
                              sf32(_loc56_,0);
                              si32(1597463007 - (li32(0) >> 1),0);
                              _loc57_ = lf32(0);
                              §§push(1 / (_loc57_ * (1.5 - 0.5 * _loc56_ * _loc57_ * _loc57_)));
                           }
                           §§pop().rfric = §§pop();
                        }
                        if(_loc10_.pre_dt == -1)
                        {
                           _loc10_.pre_dt = param1;
                        }
                        _loc56_ = param1 / _loc10_.pre_dt;
                        _loc10_.pre_dt = param1;
                        _loc57_ = Number(_loc10_.b1.smass + _loc10_.b2.smass);
                        _loc10_.hc2 = false;
                        _loc15_ = true;
                        _loc50_ = null;
                        _loc53_ = null;
                        _loc54_ = _loc10_.innards.next;
                        _loc51_ = _loc10_.contacts.next;
                        while(_loc51_ != null)
                        {
                           _loc52_ = _loc51_;
                           if(_loc52_.stamp + 6 < _loc10_.stamp)
                           {
                              _loc58_ = _loc10_.contacts;
                              if(_loc50_ == null)
                              {
                                 _loc59_ = _loc58_.next;
                                 _loc60_ = _loc59_.next;
                                 _loc58_.next = _loc60_;
                                 if(_loc58_.next == null)
                                 {
                                    _loc58_.pushmod = true;
                                 }
                              }
                              else
                              {
                                 _loc59_ = _loc50_.next;
                                 _loc60_ = _loc59_.next;
                                 _loc50_.next = _loc60_;
                                 if(_loc60_ == null)
                                 {
                                    _loc58_.pushmod = true;
                                 }
                              }
                              _loc59_._inuse = false;
                              _loc58_.modified = true;
                              _loc58_.length = _loc58_.length - 1;
                              _loc58_.pushmod = true;
                              _loc51_ = _loc60_;
                              _loc61_ = _loc10_.innards;
                              if(_loc53_ == null)
                              {
                                 _loc62_ = _loc61_.next;
                                 _loc63_ = _loc62_.next;
                                 _loc61_.next = _loc63_;
                                 if(_loc61_.next == null)
                                 {
                                    _loc61_.pushmod = true;
                                 }
                              }
                              else
                              {
                                 _loc62_ = _loc53_.next;
                                 _loc63_ = _loc62_.next;
                                 _loc53_.next = _loc63_;
                                 if(_loc63_ == null)
                                 {
                                    _loc61_.pushmod = true;
                                 }
                              }
                              _loc62_._inuse = false;
                              _loc61_.modified = true;
                              _loc61_.length = _loc61_.length - 1;
                              _loc61_.pushmod = true;
                              _loc54_ = _loc63_;
                              _loc58_ = _loc52_;
                              _loc58_.arbiter = null;
                              _loc58_.next = ZPP_Contact.zpp_pool;
                              ZPP_Contact.zpp_pool = _loc58_;
                           }
                           else
                           {
                              _loc61_ = _loc52_.inner;
                              _loc41_ = _loc52_.active;
                              _loc52_.active = _loc52_.stamp == _loc10_.stamp;
                              if(_loc41_ != _loc52_.active)
                              {
                                 _loc10_.contacts.modified = true;
                              }
                              if(_loc52_.active)
                              {
                                 if(_loc15_)
                                 {
                                    _loc15_ = false;
                                    _loc10_.c1 = _loc61_;
                                    _loc10_.oc1 = _loc52_;
                                 }
                                 else
                                 {
                                    _loc10_.hc2 = true;
                                    _loc10_.c2 = _loc61_;
                                    _loc10_.oc2 = _loc52_;
                                 }
                                 _loc61_.r2x = _loc52_.px - _loc10_.b2.posx;
                                 _loc61_.r2y = _loc52_.py - _loc10_.b2.posy;
                                 _loc61_.r1x = _loc52_.px - _loc10_.b1.posx;
                                 _loc61_.r1y = _loc52_.py - _loc10_.b1.posy;
                                 _loc65_ = Number(_loc61_.r2x * _loc10_.nx + _loc61_.r2y * _loc10_.ny);
                                 _loc64_ = Number(_loc57_ + _loc10_.b2.sinertia * (_loc65_ * _loc65_));
                                 _loc65_ = Number(_loc61_.r1x * _loc10_.nx + _loc61_.r1y * _loc10_.ny);
                                 _loc64_ = Number(_loc64_ + _loc10_.b1.sinertia * (_loc65_ * _loc65_));
                                 _loc61_.tMass = _loc64_ < 1.0e-8?Number(0):1 / _loc64_;
                                 _loc66_ = _loc10_.ny * _loc61_.r2x - _loc10_.nx * _loc61_.r2y;
                                 _loc65_ = Number(_loc57_ + _loc10_.b2.sinertia * (_loc66_ * _loc66_));
                                 _loc66_ = _loc10_.ny * _loc61_.r1x - _loc10_.nx * _loc61_.r1y;
                                 _loc65_ = Number(_loc65_ + _loc10_.b1.sinertia * (_loc66_ * _loc66_));
                                 _loc61_.nMass = _loc65_ < 1.0e-8?Number(0):1 / _loc65_;
                                 _loc68_ = Number(_loc10_.b2.angvel + _loc10_.b2.kinangvel);
                                 _loc66_ = _loc10_.b2.velx + _loc10_.b2.kinvelx - _loc61_.r2y * _loc68_;
                                 _loc67_ = Number(Number(_loc10_.b2.vely + _loc10_.b2.kinvely) + _loc61_.r2x * _loc68_);
                                 _loc68_ = Number(_loc10_.b1.angvel + _loc10_.b1.kinangvel);
                                 _loc66_ = _loc66_ - (_loc10_.b1.velx + _loc10_.b1.kinvelx - _loc61_.r1y * _loc68_);
                                 _loc67_ = _loc67_ - (Number(Number(_loc10_.b1.vely + _loc10_.b1.kinvely) + _loc61_.r1x * _loc68_));
                                 _loc68_ = Number(_loc10_.nx * _loc66_ + _loc10_.ny * _loc67_);
                                 _loc69_ = 0.1;
                                 _loc70_ = 1 - 0.9 * _loc68_ * _loc68_;
                                 if(_loc70_ < 0)
                                 {
                                    _loc70_ = 0;
                                 }
                                 _loc70_ = _loc70_ - _loc52_.dist * 0.01;
                                 if(_loc70_ < 0)
                                 {
                                    _loc70_ = 0;
                                 }
                                 if(_loc70_ > 1)
                                 {
                                    _loc70_ = 1;
                                 }
                                 _loc69_ = Number(_loc69_ + (0.8 - 0.1) * _loc70_);
                                 if(_loc69_ > 1)
                                 {
                                    _loc69_ = 1;
                                 }
                                 if(_loc52_.sBias == -1)
                                 {
                                    _loc52_.sBias = _loc69_;
                                 }
                                 else
                                 {
                                    _loc52_.sBias = Number(0.85 * _loc52_.sBias + (1 - 0.85) * _loc69_);
                                 }
                                 _loc61_.biasCoef = _loc52_.sBias;
                                 if(_loc10_.stat)
                                 {
                                    _loc61_.biasCoef = _loc61_.biasCoef * 2;
                                    if(_loc61_.biasCoef > 1)
                                    {
                                       _loc61_.biasCoef = 1;
                                    }
                                 }
                                 _loc52_.elasticity = _loc10_.restitution;
                                 _loc61_.bounce = _loc68_ * _loc52_.elasticity;
                                 _loc68_ = _loc67_ * _loc10_.nx - _loc66_ * _loc10_.ny;
                                 if(_loc68_ * _loc68_ > 4)
                                 {
                                    _loc61_.friction = _loc10_.dyn_fric;
                                 }
                                 else
                                 {
                                    _loc61_.friction = _loc10_.stat_fric;
                                 }
                                 _loc61_.jnAcc = _loc61_.jnAcc * _loc56_;
                                 _loc61_.jtAcc = _loc61_.jtAcc * _loc56_;
                              }
                              _loc50_ = _loc51_;
                              _loc53_ = _loc54_;
                              _loc54_ = _loc54_.next;
                              _loc51_ = _loc51_.next;
                           }
                        }
                        _loc10_.jrAcc = _loc10_.jrAcc * _loc56_;
                        if(!_loc15_)
                        {
                           _loc10_.rn1a = _loc10_.ny * _loc10_.c1.r1x - _loc10_.nx * _loc10_.c1.r1y;
                           _loc10_.rt1a = Number(_loc10_.c1.r1x * _loc10_.nx + _loc10_.c1.r1y * _loc10_.ny);
                           _loc10_.rn1b = _loc10_.ny * _loc10_.c1.r2x - _loc10_.nx * _loc10_.c1.r2y;
                           _loc10_.rt1b = Number(_loc10_.c1.r2x * _loc10_.nx + _loc10_.c1.r2y * _loc10_.ny);
                           _loc10_.k1x = _loc10_.b2.kinvelx - _loc10_.c1.r2y * _loc10_.b2.kinangvel - (_loc10_.b1.kinvelx - _loc10_.c1.r1y * _loc10_.b1.kinangvel);
                           _loc10_.k1y = Number(_loc10_.b2.kinvely + _loc10_.c1.r2x * _loc10_.b2.kinangvel) - (Number(_loc10_.b1.kinvely + _loc10_.c1.r1x * _loc10_.b1.kinangvel));
                        }
                        if(_loc10_.hc2)
                        {
                           _loc10_.rn2a = _loc10_.ny * _loc10_.c2.r1x - _loc10_.nx * _loc10_.c2.r1y;
                           _loc10_.rt2a = Number(_loc10_.c2.r1x * _loc10_.nx + _loc10_.c2.r1y * _loc10_.ny);
                           _loc10_.rn2b = _loc10_.ny * _loc10_.c2.r2x - _loc10_.nx * _loc10_.c2.r2y;
                           _loc10_.rt2b = Number(_loc10_.c2.r2x * _loc10_.nx + _loc10_.c2.r2y * _loc10_.ny);
                           _loc10_.k2x = _loc10_.b2.kinvelx - _loc10_.c2.r2y * _loc10_.b2.kinangvel - (_loc10_.b1.kinvelx - _loc10_.c2.r1y * _loc10_.b1.kinangvel);
                           _loc10_.k2y = Number(_loc10_.b2.kinvely + _loc10_.c2.r2x * _loc10_.b2.kinangvel) - (Number(_loc10_.b1.kinvely + _loc10_.c2.r1x * _loc10_.b1.kinangvel));
                           _loc10_.kMassa = Number(Number(_loc57_ + _loc10_.b1.sinertia * _loc10_.rn1a * _loc10_.rn1a) + _loc10_.b2.sinertia * _loc10_.rn1b * _loc10_.rn1b);
                           _loc10_.kMassb = Number(Number(_loc57_ + _loc10_.b1.sinertia * _loc10_.rn1a * _loc10_.rn2a) + _loc10_.b2.sinertia * _loc10_.rn1b * _loc10_.rn2b);
                           _loc10_.kMassc = Number(Number(_loc57_ + _loc10_.b1.sinertia * _loc10_.rn2a * _loc10_.rn2a) + _loc10_.b2.sinertia * _loc10_.rn2b * _loc10_.rn2b);
                           if(_loc10_.kMassa * _loc10_.kMassa < 400000 * (_loc10_.kMassa * _loc10_.kMassc - _loc10_.kMassb * _loc10_.kMassb))
                           {
                              _loc10_.Ka = _loc10_.kMassa;
                              _loc10_.Kb = _loc10_.kMassb;
                              _loc10_.Kc = _loc10_.kMassc;
                              _loc64_ = _loc10_.kMassa * _loc10_.kMassc - _loc10_.kMassb * _loc10_.kMassb;
                              if(_loc64_ != _loc64_)
                              {
                                 _loc65_ = 0;
                                 _loc10_.kMassc = _loc65_;
                                 _loc65_ = _loc65_;
                                 _loc10_.kMassb = _loc65_;
                                 _loc10_.kMassa = _loc65_;
                              }
                              else if(_loc64_ == 0)
                              {
                                 _loc24_ = 0;
                                 if(_loc10_.kMassa != 0)
                                 {
                                    _loc10_.kMassa = 1 / _loc10_.kMassa;
                                 }
                                 else
                                 {
                                    _loc10_.kMassa = 0;
                                    _loc24_ = _loc24_ | 1;
                                 }
                                 if(_loc10_.kMassc != 0)
                                 {
                                    _loc10_.kMassc = 1 / _loc10_.kMassc;
                                 }
                                 else
                                 {
                                    _loc10_.kMassc = 0;
                                    _loc24_ = _loc24_ | 2;
                                 }
                                 _loc10_.kMassb = 0;
                                 _loc24_;
                              }
                              else
                              {
                                 _loc64_ = 1 / _loc64_;
                                 _loc65_ = _loc10_.kMassc * _loc64_;
                                 _loc10_.kMassc = _loc10_.kMassa * _loc64_;
                                 _loc10_.kMassa = _loc65_;
                                 _loc10_.kMassb = _loc10_.kMassb * -_loc64_;
                              }
                           }
                           else
                           {
                              _loc10_.hc2 = false;
                              if(_loc10_.oc2.dist < _loc10_.oc1.dist)
                              {
                                 _loc61_ = _loc10_.c1;
                                 _loc10_.c1 = _loc10_.c2;
                                 _loc10_.c2 = _loc61_;
                              }
                              _loc10_.oc2.active = false;
                              _loc10_.contacts.modified = true;
                           }
                        }
                        _loc10_.surfacex = _loc10_.b2.svelx;
                        _loc10_.surfacey = _loc10_.b2.svely;
                        _loc64_ = 1;
                        _loc10_.surfacex = Number(_loc10_.surfacex + _loc10_.b1.svelx * _loc64_);
                        _loc10_.surfacey = Number(_loc10_.surfacey + _loc10_.b1.svely * _loc64_);
                        _loc10_.surfacex = -_loc10_.surfacex;
                        _loc10_.surfacey = -_loc10_.surfacey;
                        _loc10_.rMass = Number(_loc10_.b1.smass + _loc10_.b2.smass);
                        if(_loc10_.rMass != 0)
                        {
                           _loc10_.rMass = 1 / _loc10_.rMass;
                        }
                        §§push(!_loc15_);
                     }
                     else
                     {
                        §§push(null);
                     }
                     _loc10_.active = false;
                  }
                  else
                  {
                     _loc15_ = true;
                     _loc50_ = null;
                     _loc53_ = null;
                     _loc54_ = _loc10_.innards.next;
                     _loc10_.hc2 = false;
                     _loc51_ = _loc10_.contacts.next;
                     while(_loc51_ != null)
                     {
                        _loc52_ = _loc51_;
                        if(_loc52_.stamp + 6 < _loc10_.stamp)
                        {
                           _loc58_ = _loc10_.contacts;
                           if(_loc50_ == null)
                           {
                              _loc59_ = _loc58_.next;
                              _loc60_ = _loc59_.next;
                              _loc58_.next = _loc60_;
                              if(_loc58_.next == null)
                              {
                                 _loc58_.pushmod = true;
                              }
                           }
                           else
                           {
                              _loc59_ = _loc50_.next;
                              _loc60_ = _loc59_.next;
                              _loc50_.next = _loc60_;
                              if(_loc60_ == null)
                              {
                                 _loc58_.pushmod = true;
                              }
                           }
                           _loc59_._inuse = false;
                           _loc58_.modified = true;
                           _loc58_.length = _loc58_.length - 1;
                           _loc58_.pushmod = true;
                           _loc51_ = _loc60_;
                           _loc61_ = _loc10_.innards;
                           if(_loc53_ == null)
                           {
                              _loc62_ = _loc61_.next;
                              _loc63_ = _loc62_.next;
                              _loc61_.next = _loc63_;
                              if(_loc61_.next == null)
                              {
                                 _loc61_.pushmod = true;
                              }
                           }
                           else
                           {
                              _loc62_ = _loc53_.next;
                              _loc63_ = _loc62_.next;
                              _loc53_.next = _loc63_;
                              if(_loc63_ == null)
                              {
                                 _loc61_.pushmod = true;
                              }
                           }
                           _loc62_._inuse = false;
                           _loc61_.modified = true;
                           _loc61_.length = _loc61_.length - 1;
                           _loc61_.pushmod = true;
                           _loc54_ = _loc63_;
                           _loc58_ = _loc52_;
                           _loc58_.arbiter = null;
                           _loc58_.next = ZPP_Contact.zpp_pool;
                           ZPP_Contact.zpp_pool = _loc58_;
                        }
                        else
                        {
                           _loc61_ = _loc52_.inner;
                           _loc41_ = _loc52_.active;
                           _loc52_.active = _loc52_.stamp == _loc10_.stamp;
                           if(_loc41_ != _loc52_.active)
                           {
                              _loc10_.contacts.modified = true;
                           }
                           if(_loc52_.active)
                           {
                              if(_loc15_)
                              {
                                 _loc15_ = false;
                                 _loc10_.c1 = _loc61_;
                                 _loc10_.oc1 = _loc52_;
                              }
                              else
                              {
                                 _loc10_.hc2 = true;
                                 _loc10_.c2 = _loc61_;
                                 _loc10_.oc2 = _loc52_;
                              }
                           }
                           _loc50_ = _loc51_;
                           _loc53_ = _loc54_;
                           _loc54_ = _loc54_.next;
                           _loc51_ = _loc51_.next;
                        }
                     }
                     if(_loc15_)
                     {
                        _loc10_.active = false;
                     }
                  }
                  if(_loc14_ != _loc10_.active)
                  {
                     _loc10_.b1.arbiters.modified = true;
                     _loc10_.b2.arbiters.modified = true;
                     _loc7_.modified = true;
                  }
                  _loc6_ = _loc8_;
                  _loc8_ = _loc8_.next;
                  if(!!_loc9_ && _loc8_ == null)
                  {
                     _loc9_ = false;
                     _loc8_ = c_arbiters_false.head;
                     _loc7_ = c_arbiters_false;
                     _loc6_ = null;
                  }
               }
            }
         }
         var _loc71_:ZNPNode_ZPP_FluidArbiter = null;
         var _loc72_:ZNPList_ZPP_FluidArbiter = f_arbiters;
         var _loc73_:ZNPNode_ZPP_FluidArbiter = _loc72_.head;
         _loc9_ = false;
         if(!!_loc9_ && _loc73_ == null)
         {
            _loc9_ = false;
            _loc73_ = null.begin();
            _loc72_ = null;
            _loc71_ = null;
         }
         while(_loc73_ != null)
         {
            _loc74_ = _loc73_.elt;
            if(!_loc74_.cleared && (!!_loc74_.b1.component.sleeping && _loc74_.b2.component.sleeping))
            {
               _loc74_.sleep_stamp = stamp;
               _loc74_.sleeping = true;
               if(_loc71_ == null)
               {
                  _loc75_ = _loc72_.head;
                  _loc76_ = _loc75_.next;
                  _loc72_.head = _loc76_;
                  if(_loc72_.head == null)
                  {
                     _loc72_.pushmod = true;
                  }
               }
               else
               {
                  _loc75_ = _loc71_.next;
                  _loc76_ = _loc75_.next;
                  _loc71_.next = _loc76_;
                  if(_loc76_ == null)
                  {
                     _loc72_.pushmod = true;
                  }
               }
               _loc77_ = _loc75_;
               _loc77_.elt = null;
               _loc77_.next = ZNPNode_ZPP_FluidArbiter.zpp_pool;
               ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc77_;
               _loc72_.modified = true;
               _loc72_.length = _loc72_.length - 1;
               _loc72_.pushmod = true;
               _loc73_ = _loc76_;
               if(!!_loc9_ && _loc73_ == null)
               {
                  _loc9_ = false;
                  _loc73_ = null.begin();
                  _loc72_ = null;
                  _loc71_ = null;
               }
            }
            else
            {
               if(!_loc74_.cleared || _loc74_.present != 0 || _loc74_.intchange)
               {
                  _loc14_ = _loc74_.up_stamp == stamp - 1 && !_loc74_.cleared && !_loc74_.intchange;
                  _loc15_ = Boolean(!!_loc74_.fresh && !_loc74_.cleared && !_loc74_.intchange);
                  if(_loc15_ || _loc14_ || _loc74_.cleared || _loc74_.intchange)
                  {
                     _loc16_ = _loc74_.ws1;
                     _loc17_ = _loc74_.ws2;
                     _loc18_ = mrca1;
                     while(_loc18_.head != null)
                     {
                        _loc19_ = _loc18_.head;
                        _loc18_.head = _loc19_.next;
                        _loc20_ = _loc19_;
                        _loc20_.elt = null;
                        _loc20_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                        ZNPNode_ZPP_Interactor.zpp_pool = _loc20_;
                        if(_loc18_.head == null)
                        {
                           _loc18_.pushmod = true;
                        }
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length - 1;
                     }
                     _loc18_.pushmod = true;
                     _loc18_ = mrca2;
                     while(_loc18_.head != null)
                     {
                        _loc19_ = _loc18_.head;
                        _loc18_.head = _loc19_.next;
                        _loc20_ = _loc19_;
                        _loc20_.elt = null;
                        _loc20_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                        ZNPNode_ZPP_Interactor.zpp_pool = _loc20_;
                        if(_loc18_.head == null)
                        {
                           _loc18_.pushmod = true;
                        }
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length - 1;
                     }
                     _loc18_.pushmod = true;
                     if(_loc16_.cbSet != null)
                     {
                        _loc18_ = mrca1;
                        if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                           _loc20_ = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                           _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                           _loc20_.next = null;
                        }
                        null;
                        _loc20_.elt = _loc16_;
                        _loc19_ = _loc20_;
                        _loc19_.next = _loc18_.head;
                        _loc18_.head = _loc19_;
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length + 1;
                        _loc16_;
                     }
                     if(_loc16_.body.cbSet != null)
                     {
                        _loc18_ = mrca1;
                        _loc21_ = _loc16_.body;
                        if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                           _loc20_ = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                           _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                           _loc20_.next = null;
                        }
                        null;
                        _loc20_.elt = _loc21_;
                        _loc19_ = _loc20_;
                        _loc19_.next = _loc18_.head;
                        _loc18_.head = _loc19_;
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length + 1;
                        _loc21_;
                     }
                     if(_loc17_.cbSet != null)
                     {
                        _loc18_ = mrca2;
                        if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                           _loc20_ = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                           _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                           _loc20_.next = null;
                        }
                        null;
                        _loc20_.elt = _loc17_;
                        _loc19_ = _loc20_;
                        _loc19_.next = _loc18_.head;
                        _loc18_.head = _loc19_;
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length + 1;
                        _loc17_;
                     }
                     if(_loc17_.body.cbSet != null)
                     {
                        _loc18_ = mrca2;
                        _loc21_ = _loc17_.body;
                        if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                           _loc20_ = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                           _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                           _loc20_.next = null;
                        }
                        null;
                        _loc20_.elt = _loc21_;
                        _loc19_ = _loc20_;
                        _loc19_.next = _loc18_.head;
                        _loc18_.head = _loc19_;
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length + 1;
                        _loc21_;
                     }
                     _loc22_ = _loc16_.body.compound;
                     _loc23_ = _loc17_.body.compound;
                     while(_loc22_ != _loc23_)
                     {
                        _loc24_ = int(_loc22_ == null?0:_loc22_.depth);
                        _loc25_ = _loc23_ == null?0:_loc23_.depth;
                        if(_loc24_ < _loc25_)
                        {
                           if(_loc23_.cbSet != null)
                           {
                              _loc18_ = mrca2;
                              if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                              {
                                 _loc20_ = new ZNPNode_ZPP_Interactor();
                              }
                              else
                              {
                                 _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                                 ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                                 _loc20_.next = null;
                              }
                              null;
                              _loc20_.elt = _loc23_;
                              _loc19_ = _loc20_;
                              _loc19_.next = _loc18_.head;
                              _loc18_.head = _loc19_;
                              _loc18_.modified = true;
                              _loc18_.length = _loc18_.length + 1;
                              _loc23_;
                           }
                           _loc23_ = _loc23_.compound;
                        }
                        else
                        {
                           if(_loc22_.cbSet != null)
                           {
                              _loc18_ = mrca1;
                              if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                              {
                                 _loc20_ = new ZNPNode_ZPP_Interactor();
                              }
                              else
                              {
                                 _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                                 ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                                 _loc20_.next = null;
                              }
                              null;
                              _loc20_.elt = _loc22_;
                              _loc19_ = _loc20_;
                              _loc19_.next = _loc18_.head;
                              _loc18_.head = _loc19_;
                              _loc18_.modified = true;
                              _loc18_.length = _loc18_.length + 1;
                              _loc22_;
                           }
                           _loc22_ = _loc22_.compound;
                        }
                     }
                     _loc19_ = mrca1.head;
                     while(_loc19_ != null)
                     {
                        _loc21_ = _loc19_.elt;
                        _loc20_ = mrca2.head;
                        while(_loc20_ != null)
                        {
                           _loc26_ = _loc20_.elt;
                           _loc27_ = _loc21_.cbSet;
                           _loc28_ = _loc26_.cbSet;
                           _loc29_ = null;
                           _loc30_ = _loc27_.cbpairs.length < _loc28_.cbpairs.length?_loc27_.cbpairs:_loc28_.cbpairs;
                           _loc31_ = _loc30_.head;
                           while(_loc31_ != null)
                           {
                              _loc32_ = _loc31_.elt;
                              if(_loc32_.a == _loc27_ && _loc32_.b == _loc28_ || _loc32_.a == _loc28_ && _loc32_.b == _loc27_)
                              {
                                 _loc29_ = _loc32_;
                                 break;
                              }
                              _loc31_ = _loc31_.next;
                           }
                           if(_loc29_ == null)
                           {
                              if(ZPP_CbSetPair.zpp_pool == null)
                              {
                                 _loc32_ = new ZPP_CbSetPair();
                              }
                              else
                              {
                                 _loc32_ = ZPP_CbSetPair.zpp_pool;
                                 ZPP_CbSetPair.zpp_pool = _loc32_.next;
                                 _loc32_.next = null;
                              }
                              _loc32_.zip_listeners = true;
                              if(ZPP_CbSet.setlt(_loc27_,_loc28_))
                              {
                                 _loc32_.a = _loc27_;
                                 _loc32_.b = _loc28_;
                              }
                              else
                              {
                                 _loc32_.a = _loc28_;
                                 _loc32_.b = _loc27_;
                              }
                              _loc29_ = _loc32_;
                              _loc27_.cbpairs.add(_loc29_);
                              if(_loc28_ != _loc27_)
                              {
                                 _loc28_.cbpairs.add(_loc29_);
                              }
                           }
                           if(_loc29_.zip_listeners)
                           {
                              _loc29_.zip_listeners = false;
                              _loc29_.__validate();
                           }
                           if(_loc29_.listeners.head == null)
                           {
                              _loc20_ = _loc20_.next;
                           }
                           else
                           {
                              _loc33_ = ZPP_Interactor.get(_loc21_,_loc26_);
                              if(_loc15_ || _loc74_.intchange)
                              {
                                 if(_loc33_ == null)
                                 {
                                    _loc33_ = ZPP_CallbackSet.get(_loc21_,_loc26_);
                                    add_callbackset(_loc33_);
                                 }
                                 _loc24_ = int(ZPP_Flags.id_CbEvent_BEGIN);
                                 _loc29_ = null;
                                 _loc30_ = _loc27_.cbpairs.length < _loc28_.cbpairs.length?_loc27_.cbpairs:_loc28_.cbpairs;
                                 _loc31_ = _loc30_.head;
                                 while(_loc31_ != null)
                                 {
                                    _loc32_ = _loc31_.elt;
                                    if(_loc32_.a == _loc27_ && _loc32_.b == _loc28_ || _loc32_.a == _loc28_ && _loc32_.b == _loc27_)
                                    {
                                       _loc29_ = _loc32_;
                                       break;
                                    }
                                    _loc31_ = _loc31_.next;
                                 }
                                 if(_loc29_ == null)
                                 {
                                    if(ZPP_CbSetPair.zpp_pool == null)
                                    {
                                       _loc32_ = new ZPP_CbSetPair();
                                    }
                                    else
                                    {
                                       _loc32_ = ZPP_CbSetPair.zpp_pool;
                                       ZPP_CbSetPair.zpp_pool = _loc32_.next;
                                       _loc32_.next = null;
                                    }
                                    _loc32_.zip_listeners = true;
                                    if(ZPP_CbSet.setlt(_loc27_,_loc28_))
                                    {
                                       _loc32_.a = _loc27_;
                                       _loc32_.b = _loc28_;
                                    }
                                    else
                                    {
                                       _loc32_.a = _loc28_;
                                       _loc32_.b = _loc27_;
                                    }
                                    _loc29_ = _loc32_;
                                    _loc27_.cbpairs.add(_loc29_);
                                    if(_loc28_ != _loc27_)
                                    {
                                       _loc28_.cbpairs.add(_loc29_);
                                    }
                                 }
                                 if(_loc29_.zip_listeners)
                                 {
                                    _loc29_.zip_listeners = false;
                                    _loc29_.__validate();
                                 }
                                 _loc34_ = _loc29_.listeners.head;
                                 while(_loc34_ != null)
                                 {
                                    _loc35_ = _loc34_.elt;
                                    if(_loc35_.event == _loc24_)
                                    {
                                       if((_loc35_.itype & _loc74_.type) != 0 && _loc33_.empty_arb(_loc35_.itype))
                                       {
                                          _loc36_ = _loc2_.push_callback(_loc35_);
                                          _loc36_.event = ZPP_Flags.id_CbEvent_BEGIN;
                                          _loc37_ = _loc33_.int1;
                                          _loc38_ = _loc33_.int2;
                                          _loc39_ = _loc35_.options1;
                                          _loc40_ = _loc37_.cbTypes;
                                          if(!!_loc39_.nonemptyintersection(_loc40_,_loc39_.includes) && !_loc39_.nonemptyintersection(_loc40_,_loc39_.excludes) && (!!_loc39_.nonemptyintersection(_loc40_,_loc39_.includes) && !_loc39_.nonemptyintersection(_loc40_,_loc39_.excludes)))
                                          {
                                             _loc36_.int1 = _loc37_;
                                             _loc36_.int2 = _loc38_;
                                          }
                                          else
                                          {
                                             _loc36_.int1 = _loc38_;
                                             _loc36_.int2 = _loc37_;
                                          }
                                          _loc36_.set = _loc33_;
                                       }
                                    }
                                    _loc34_ = _loc34_.next;
                                 }
                                 _loc41_ = false;
                                 _loc42_ = _loc33_.arbiters.head;
                                 while(_loc42_ != null)
                                 {
                                    _loc43_ = _loc42_.elt;
                                    if(_loc43_ == _loc74_)
                                    {
                                       _loc41_ = true;
                                       break;
                                    }
                                    _loc42_ = _loc42_.next;
                                 }
                                 if(!_loc41_)
                                 {
                                    _loc44_ = _loc33_.arbiters;
                                    if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                    {
                                       _loc45_ = new ZNPNode_ZPP_Arbiter();
                                    }
                                    else
                                    {
                                       _loc45_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                                       ZNPNode_ZPP_Arbiter.zpp_pool = _loc45_.next;
                                       _loc45_.next = null;
                                    }
                                    null;
                                    _loc45_.elt = _loc74_;
                                    _loc42_ = _loc45_;
                                    _loc42_.next = _loc44_.head;
                                    _loc44_.head = _loc42_;
                                    _loc44_.modified = true;
                                    _loc44_.length = _loc44_.length + 1;
                                    _loc74_;
                                    §§push(true);
                                 }
                                 else
                                 {
                                    §§push(false);
                                 }
                                 _loc74_.present = _loc74_.present + 1;
                              }
                              else
                              {
                                 _loc74_.present = _loc74_.present - 1;
                                 _loc33_.remove_arb(_loc74_);
                                 _loc24_ = int(ZPP_Flags.id_CbEvent_END);
                                 _loc29_ = null;
                                 _loc30_ = _loc27_.cbpairs.length < _loc28_.cbpairs.length?_loc27_.cbpairs:_loc28_.cbpairs;
                                 _loc31_ = _loc30_.head;
                                 while(_loc31_ != null)
                                 {
                                    _loc32_ = _loc31_.elt;
                                    if(_loc32_.a == _loc27_ && _loc32_.b == _loc28_ || _loc32_.a == _loc28_ && _loc32_.b == _loc27_)
                                    {
                                       _loc29_ = _loc32_;
                                       break;
                                    }
                                    _loc31_ = _loc31_.next;
                                 }
                                 if(_loc29_ == null)
                                 {
                                    if(ZPP_CbSetPair.zpp_pool == null)
                                    {
                                       _loc32_ = new ZPP_CbSetPair();
                                    }
                                    else
                                    {
                                       _loc32_ = ZPP_CbSetPair.zpp_pool;
                                       ZPP_CbSetPair.zpp_pool = _loc32_.next;
                                       _loc32_.next = null;
                                    }
                                    _loc32_.zip_listeners = true;
                                    if(ZPP_CbSet.setlt(_loc27_,_loc28_))
                                    {
                                       _loc32_.a = _loc27_;
                                       _loc32_.b = _loc28_;
                                    }
                                    else
                                    {
                                       _loc32_.a = _loc28_;
                                       _loc32_.b = _loc27_;
                                    }
                                    _loc29_ = _loc32_;
                                    _loc27_.cbpairs.add(_loc29_);
                                    if(_loc28_ != _loc27_)
                                    {
                                       _loc28_.cbpairs.add(_loc29_);
                                    }
                                 }
                                 if(_loc29_.zip_listeners)
                                 {
                                    _loc29_.zip_listeners = false;
                                    _loc29_.__validate();
                                 }
                                 _loc34_ = _loc29_.listeners.head;
                                 while(_loc34_ != null)
                                 {
                                    _loc35_ = _loc34_.elt;
                                    if(_loc35_.event == _loc24_)
                                    {
                                       if((_loc35_.itype & _loc74_.type) != 0 && _loc33_.empty_arb(_loc35_.itype))
                                       {
                                          _loc36_ = _loc2_.push_callback(_loc35_);
                                          _loc36_.event = ZPP_Flags.id_CbEvent_END;
                                          _loc37_ = _loc33_.int1;
                                          _loc38_ = _loc33_.int2;
                                          _loc39_ = _loc35_.options1;
                                          _loc40_ = _loc37_.cbTypes;
                                          if(!!_loc39_.nonemptyintersection(_loc40_,_loc39_.includes) && !_loc39_.nonemptyintersection(_loc40_,_loc39_.excludes) && (!!_loc39_.nonemptyintersection(_loc40_,_loc39_.includes) && !_loc39_.nonemptyintersection(_loc40_,_loc39_.excludes)))
                                          {
                                             _loc36_.int1 = _loc37_;
                                             _loc36_.int2 = _loc38_;
                                          }
                                          else
                                          {
                                             _loc36_.int1 = _loc38_;
                                             _loc36_.int2 = _loc37_;
                                          }
                                          _loc36_.set = _loc33_;
                                       }
                                    }
                                    _loc34_ = _loc34_.next;
                                 }
                                 if(_loc33_.arbiters.head == null)
                                 {
                                    remove_callbackset(_loc33_);
                                 }
                              }
                              _loc20_ = _loc20_.next;
                           }
                        }
                        _loc19_ = _loc19_.next;
                     }
                  }
                  _loc74_.fresh = false;
                  _loc74_.intchange = false;
               }
               if(_loc74_.cleared || _loc74_.up_stamp + (_loc74_.type == ZPP_Arbiter.COL?6:0) < stamp)
               {
                  if(!_loc74_.cleared)
                  {
                     _loc44_ = _loc74_.b1.arbiters;
                     _loc42_ = null;
                     _loc45_ = _loc44_.head;
                     _loc14_ = false;
                     while(_loc45_ != null)
                     {
                        if(_loc45_.elt == _loc74_)
                        {
                           if(_loc42_ == null)
                           {
                              _loc46_ = _loc44_.head;
                              _loc47_ = _loc46_.next;
                              _loc44_.head = _loc47_;
                              if(_loc44_.head == null)
                              {
                                 _loc44_.pushmod = true;
                              }
                           }
                           else
                           {
                              _loc46_ = _loc42_.next;
                              _loc47_ = _loc46_.next;
                              _loc42_.next = _loc47_;
                              if(_loc47_ == null)
                              {
                                 _loc44_.pushmod = true;
                              }
                           }
                           _loc48_ = _loc46_;
                           _loc48_.elt = null;
                           _loc48_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                           ZNPNode_ZPP_Arbiter.zpp_pool = _loc48_;
                           _loc44_.modified = true;
                           _loc44_.length = _loc44_.length - 1;
                           _loc44_.pushmod = true;
                           _loc47_;
                           _loc14_ = true;
                           break;
                        }
                        _loc42_ = _loc45_;
                        _loc45_ = _loc45_.next;
                     }
                     _loc14_;
                     _loc44_ = _loc74_.b2.arbiters;
                     _loc42_ = null;
                     _loc45_ = _loc44_.head;
                     _loc14_ = false;
                     while(_loc45_ != null)
                     {
                        if(_loc45_.elt == _loc74_)
                        {
                           if(_loc42_ == null)
                           {
                              _loc46_ = _loc44_.head;
                              _loc47_ = _loc46_.next;
                              _loc44_.head = _loc47_;
                              if(_loc44_.head == null)
                              {
                                 _loc44_.pushmod = true;
                              }
                           }
                           else
                           {
                              _loc46_ = _loc42_.next;
                              _loc47_ = _loc46_.next;
                              _loc42_.next = _loc47_;
                              if(_loc47_ == null)
                              {
                                 _loc44_.pushmod = true;
                              }
                           }
                           _loc48_ = _loc46_;
                           _loc48_.elt = null;
                           _loc48_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                           ZNPNode_ZPP_Arbiter.zpp_pool = _loc48_;
                           _loc44_.modified = true;
                           _loc44_.length = _loc44_.length - 1;
                           _loc44_.pushmod = true;
                           _loc47_;
                           _loc14_ = true;
                           break;
                        }
                        _loc42_ = _loc45_;
                        _loc45_ = _loc45_.next;
                     }
                     _loc14_;
                     if(_loc74_.pair != null)
                     {
                        _loc74_.pair.arb = null;
                        _loc74_.pair = null;
                     }
                  }
                  _loc49_ = null;
                  _loc74_.b2 = _loc49_;
                  _loc74_.b1 = _loc49_;
                  _loc74_.active = false;
                  _loc74_.intchange = false;
                  _loc78_ = _loc74_;
                  _loc78_.next = ZPP_FluidArbiter.zpp_pool;
                  ZPP_FluidArbiter.zpp_pool = _loc78_;
                  _loc74_.pre_dt = -1;
                  if(_loc71_ == null)
                  {
                     _loc75_ = _loc72_.head;
                     _loc76_ = _loc75_.next;
                     _loc72_.head = _loc76_;
                     if(_loc72_.head == null)
                     {
                        _loc72_.pushmod = true;
                     }
                  }
                  else
                  {
                     _loc75_ = _loc71_.next;
                     _loc76_ = _loc75_.next;
                     _loc71_.next = _loc76_;
                     if(_loc76_ == null)
                     {
                        _loc72_.pushmod = true;
                     }
                  }
                  _loc77_ = _loc75_;
                  _loc77_.elt = null;
                  _loc77_.next = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                  ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc77_;
                  _loc72_.modified = true;
                  _loc72_.length = _loc72_.length - 1;
                  _loc72_.pushmod = true;
                  _loc73_ = _loc76_;
                  if(!!_loc9_ && _loc73_ == null)
                  {
                     _loc9_ = false;
                     _loc73_ = null.begin();
                     _loc72_ = null;
                     _loc71_ = null;
                  }
               }
               else
               {
                  _loc14_ = _loc74_.active;
                  _loc15_ = _loc74_.up_stamp == stamp;
                  _loc74_.presentable = _loc15_;
                  _loc74_.active = _loc15_;
                  if((_loc74_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                  {
                     if(_loc74_.active)
                     {
                        if(_loc74_.pre_dt == -1)
                        {
                           _loc74_.pre_dt = param1;
                        }
                        _loc56_ = param1 / _loc74_.pre_dt;
                        _loc74_.pre_dt = param1;
                        _loc74_.r1x = _loc74_.centroidx - _loc74_.b1.posx;
                        _loc74_.r1y = _loc74_.centroidy - _loc74_.b1.posy;
                        _loc74_.r2x = _loc74_.centroidx - _loc74_.b2.posx;
                        _loc74_.r2y = _loc74_.centroidy - _loc74_.b2.posy;
                        if(!!_loc74_.ws1.fluidEnabled && _loc74_.ws1.fluidProperties.wrap_gravity != null)
                        {
                           _loc57_ = _loc74_.ws1.fluidProperties.gravityx;
                           _loc64_ = _loc74_.ws1.fluidProperties.gravityy;
                        }
                        else
                        {
                           _loc57_ = gravityx;
                           _loc64_ = gravityy;
                        }
                        if(!!_loc74_.ws2.fluidEnabled && _loc74_.ws2.fluidProperties.wrap_gravity != null)
                        {
                           _loc65_ = _loc74_.ws2.fluidProperties.gravityx;
                           _loc66_ = _loc74_.ws2.fluidProperties.gravityy;
                        }
                        else
                        {
                           _loc65_ = gravityx;
                           _loc66_ = gravityy;
                        }
                        _loc67_ = 0;
                        _loc68_ = 0;
                        if(!!_loc74_.ws1.fluidEnabled && _loc74_.ws2.fluidEnabled)
                        {
                           _loc69_ = _loc74_.overlap * _loc74_.ws1.fluidProperties.density;
                           _loc70_ = _loc74_.overlap * _loc74_.ws2.fluidProperties.density;
                           if(_loc69_ > _loc70_)
                           {
                              _loc79_ = Number(_loc69_ + _loc70_);
                              _loc67_ = _loc67_ - _loc57_ * _loc79_;
                              _loc68_ = _loc68_ - _loc64_ * _loc79_;
                           }
                           else if(_loc69_ < _loc70_)
                           {
                              _loc79_ = Number(_loc69_ + _loc70_);
                              _loc67_ = Number(_loc67_ + _loc65_ * _loc79_);
                              _loc68_ = Number(_loc68_ + _loc66_ * _loc79_);
                           }
                           else
                           {
                              _loc79_ = Number(_loc57_ + _loc65_);
                              _loc80_ = Number(_loc64_ + _loc66_);
                              _loc81_ = 0.5;
                              _loc79_ = _loc79_ * _loc81_;
                              _loc80_ = _loc80_ * _loc81_;
                              if(Number(_loc74_.ws1.worldCOMx * _loc79_ + _loc74_.ws1.worldCOMy * _loc80_) > Number(_loc74_.ws2.worldCOMx * _loc79_ + _loc74_.ws2.worldCOMy * _loc80_))
                              {
                                 _loc81_ = Number(_loc69_ + _loc70_);
                                 _loc67_ = _loc67_ - _loc79_ * _loc81_;
                                 _loc68_ = _loc68_ - _loc80_ * _loc81_;
                              }
                              else
                              {
                                 _loc81_ = Number(_loc69_ + _loc70_);
                                 _loc67_ = Number(_loc67_ + _loc79_ * _loc81_);
                                 _loc68_ = Number(_loc68_ + _loc80_ * _loc81_);
                              }
                           }
                        }
                        else if(_loc74_.ws1.fluidEnabled)
                        {
                           _loc69_ = _loc74_.overlap * _loc74_.ws1.fluidProperties.density;
                           _loc70_ = _loc69_;
                           _loc67_ = _loc67_ - _loc57_ * _loc70_;
                           _loc68_ = _loc68_ - _loc64_ * _loc70_;
                        }
                        else if(_loc74_.ws2.fluidEnabled)
                        {
                           _loc69_ = _loc74_.overlap * _loc74_.ws2.fluidProperties.density;
                           _loc70_ = _loc69_;
                           _loc67_ = Number(_loc67_ + _loc65_ * _loc70_);
                           _loc68_ = Number(_loc68_ + _loc66_ * _loc70_);
                        }
                        _loc69_ = param1;
                        _loc67_ = _loc67_ * _loc69_;
                        _loc68_ = _loc68_ * _loc69_;
                        _loc74_.buoyx = _loc67_;
                        _loc74_.buoyy = _loc68_;
                        if(_loc74_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                        {
                           _loc69_ = 1 / param1;
                           _loc74_.b1.forcex = _loc74_.b1.forcex - _loc67_ * _loc69_;
                           _loc74_.b1.forcey = _loc74_.b1.forcey - _loc68_ * _loc69_;
                           _loc74_.b1.torque = _loc74_.b1.torque - (_loc68_ * _loc74_.r1x - _loc67_ * _loc74_.r1y) / param1;
                        }
                        if(_loc74_.b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
                        {
                           _loc69_ = 1 / param1;
                           _loc74_.b2.forcex = Number(_loc74_.b2.forcex + _loc67_ * _loc69_);
                           _loc74_.b2.forcey = Number(_loc74_.b2.forcey + _loc68_ * _loc69_);
                           _loc74_.b2.torque = Number(_loc74_.b2.torque + (_loc68_ * _loc74_.r2x - _loc67_ * _loc74_.r2y) / param1);
                        }
                        if((!_loc74_.ws1.fluidEnabled || _loc74_.ws1.fluidProperties.viscosity == 0) && (!_loc74_.ws2.fluidEnabled || _loc74_.ws2.fluidProperties.viscosity == 0))
                        {
                           _loc74_.nodrag = true;
                           _loc74_.dampx = 0;
                           _loc74_.dampy = 0;
                           _loc74_.adamp = 0;
                        }
                        else
                        {
                           _loc74_.nodrag = false;
                           _loc69_ = 0;
                           if(_loc74_.ws1.fluidEnabled)
                           {
                              _loc74_.ws2.validate_angDrag();
                              _loc69_ = Number(_loc69_ + _loc74_.ws1.fluidProperties.viscosity * _loc74_.ws2.angDrag * _loc74_.overlap / _loc74_.ws2.area);
                           }
                           if(_loc74_.ws2.fluidEnabled)
                           {
                              _loc74_.ws1.validate_angDrag();
                              _loc69_ = Number(_loc69_ + _loc74_.ws2.fluidProperties.viscosity * _loc74_.ws1.angDrag * _loc74_.overlap / _loc74_.ws1.area);
                           }
                           if(_loc69_ != 0)
                           {
                              _loc70_ = Number(_loc74_.b1.sinertia + _loc74_.b2.sinertia);
                              if(_loc70_ != 0)
                              {
                                 _loc74_.wMass = 1 / _loc70_;
                              }
                              else
                              {
                                 _loc74_.wMass = 0;
                              }
                              _loc69_ = _loc69_ * 0.0004;
                              _loc80_ = 2 * Math.PI * _loc69_;
                              _loc74_.agamma = 1 / (_loc80_ * param1 * (2 + _loc80_ * param1));
                              _loc81_ = 1 / (Number(1 + _loc74_.agamma));
                              _loc79_ = _loc80_ * _loc80_ * _loc74_.agamma;
                              _loc74_.agamma = _loc74_.agamma * _loc81_;
                              _loc74_.wMass = _loc74_.wMass * _loc81_;
                           }
                           else
                           {
                              _loc74_.wMass = 0;
                              _loc74_.agamma = 0;
                           }
                           _loc70_ = _loc74_.b2.velx + _loc74_.b2.kinvelx - _loc74_.r2y * (_loc74_.b2.angvel + _loc74_.b2.kinangvel) - (_loc74_.b1.velx + _loc74_.b1.kinvelx - _loc74_.r1y * (_loc74_.b2.angvel + _loc74_.b2.kinangvel));
                           _loc79_ = Number(Number(_loc74_.b2.vely + _loc74_.b2.kinvely) + _loc74_.r2x * (_loc74_.b2.angvel + _loc74_.b2.kinangvel)) - (Number(Number(_loc74_.b1.vely + _loc74_.b1.kinvely) + _loc74_.r1x * (_loc74_.b1.angvel + _loc74_.b1.kinangvel)));
                           if(Number(_loc70_ * _loc70_ + _loc79_ * _loc79_) >= 1.0e-8)
                           {
                              _loc80_ = Number(_loc70_ * _loc70_ + _loc79_ * _loc79_);
                              sf32(_loc80_,0);
                              si32(1597463007 - (li32(0) >> 1),0);
                              _loc82_ = lf32(0);
                              _loc81_ = _loc82_ * (1.5 - 0.5 * _loc80_ * _loc82_ * _loc82_);
                              _loc82_ = _loc81_;
                              _loc70_ = _loc70_ * _loc82_;
                              _loc79_ = _loc79_ * _loc82_;
                              _loc74_.nx = _loc70_;
                              _loc74_.ny = _loc79_;
                           }
                           _loc80_ = 0;
                           if(_loc74_.ws1.fluidEnabled)
                           {
                              _loc81_ = -_loc74_.ws1.fluidProperties.viscosity * _loc74_.overlap / _loc74_.ws2.area;
                              if(_loc74_.ws2.type == ZPP_Flags.id_ShapeType_CIRCLE)
                              {
                                 _loc80_ = _loc80_ - _loc81_ * _loc74_.ws2.circle.radius * 0.5 / (2 * _loc74_.ws2.circle.radius * Math.PI);
                              }
                              else
                              {
                                 _loc83_ = _loc74_.ws2.polygon;
                                 _loc82_ = 0;
                                 _loc84_ = 0;
                                 _loc85_ = _loc83_.edges.head;
                                 while(_loc85_ != null)
                                 {
                                    _loc86_ = _loc85_.elt;
                                    _loc82_ = Number(_loc82_ + _loc86_.length);
                                    _loc87_ = _loc81_ * _loc86_.length * (_loc86_.gnormx * _loc74_.nx + _loc86_.gnormy * _loc74_.ny);
                                    if(_loc87_ > 0)
                                    {
                                       _loc87_ = _loc87_ * -0.5;
                                       _loc87_ = _loc87_;
                                    }
                                    _loc84_ = _loc84_ - _loc87_ * 0.5 * 0.5;
                                    _loc85_ = _loc85_.next;
                                 }
                                 _loc80_ = Number(_loc80_ + _loc84_ / _loc82_);
                              }
                           }
                           if(_loc74_.ws2.fluidEnabled)
                           {
                              _loc81_ = -_loc74_.ws2.fluidProperties.viscosity * _loc74_.overlap / _loc74_.ws1.area;
                              if(_loc74_.ws1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                              {
                                 _loc80_ = _loc80_ - _loc81_ * _loc74_.ws1.circle.radius * 0.5 / (2 * _loc74_.ws1.circle.radius * Math.PI);
                              }
                              else
                              {
                                 _loc83_ = _loc74_.ws1.polygon;
                                 _loc82_ = 0;
                                 _loc84_ = 0;
                                 _loc85_ = _loc83_.edges.head;
                                 while(_loc85_ != null)
                                 {
                                    _loc86_ = _loc85_.elt;
                                    _loc82_ = Number(_loc82_ + _loc86_.length);
                                    _loc87_ = _loc81_ * _loc86_.length * (_loc86_.gnormx * _loc74_.nx + _loc86_.gnormy * _loc74_.ny);
                                    if(_loc87_ > 0)
                                    {
                                       _loc87_ = _loc87_ * -0.5;
                                       _loc87_ = _loc87_;
                                    }
                                    _loc84_ = _loc84_ - _loc87_ * 0.5 * 0.5;
                                    _loc85_ = _loc85_.next;
                                 }
                                 _loc80_ = Number(_loc80_ + _loc84_ / _loc82_);
                              }
                           }
                           if(_loc80_ != 0)
                           {
                              _loc81_ = Number(_loc74_.b1.smass + _loc74_.b2.smass);
                              _loc82_ = _loc81_;
                              _loc84_ = 0;
                              _loc87_ = _loc81_;
                              if(_loc74_.b1.sinertia != 0)
                              {
                                 _loc88_ = _loc74_.r1x * _loc74_.b1.sinertia;
                                 _loc89_ = _loc74_.r1y * _loc74_.b1.sinertia;
                                 _loc82_ = Number(_loc82_ + _loc89_ * _loc74_.r1y);
                                 _loc84_ = Number(_loc84_ + -_loc89_ * _loc74_.r1x);
                                 _loc87_ = Number(_loc87_ + _loc88_ * _loc74_.r1x);
                              }
                              if(_loc74_.b2.sinertia != 0)
                              {
                                 _loc88_ = _loc74_.r2x * _loc74_.b2.sinertia;
                                 _loc89_ = _loc74_.r2y * _loc74_.b2.sinertia;
                                 _loc82_ = Number(_loc82_ + _loc89_ * _loc74_.r2y);
                                 _loc84_ = Number(_loc84_ + -_loc89_ * _loc74_.r2x);
                                 _loc87_ = Number(_loc87_ + _loc88_ * _loc74_.r2x);
                              }
                              _loc88_ = _loc82_ * _loc87_ - _loc84_ * _loc84_;
                              if(_loc88_ != _loc88_)
                              {
                                 _loc87_ = 0;
                                 _loc84_ = _loc87_;
                                 _loc82_ = _loc84_;
                              }
                              else if(_loc88_ == 0)
                              {
                                 _loc24_ = 0;
                                 if(_loc82_ != 0)
                                 {
                                    _loc82_ = 1 / _loc82_;
                                 }
                                 else
                                 {
                                    _loc82_ = 0;
                                    _loc24_ = _loc24_ | 1;
                                 }
                                 if(_loc87_ != 0)
                                 {
                                    _loc87_ = 1 / _loc87_;
                                 }
                                 else
                                 {
                                    _loc87_ = 0;
                                    _loc24_ = _loc24_ | 2;
                                 }
                                 _loc84_ = 0;
                                 _loc24_;
                              }
                              else
                              {
                                 _loc88_ = 1 / _loc88_;
                                 _loc89_ = _loc87_ * _loc88_;
                                 _loc87_ = _loc82_ * _loc88_;
                                 _loc82_ = _loc89_;
                                 _loc84_ = _loc84_ * -_loc88_;
                              }
                              _loc74_.vMassa = _loc82_;
                              _loc74_.vMassb = _loc84_;
                              _loc74_.vMassc = _loc87_;
                              _loc90_ = 2 * Math.PI * _loc80_;
                              _loc74_.lgamma = 1 / (_loc90_ * param1 * (2 + _loc90_ * param1));
                              _loc91_ = 1 / (Number(1 + _loc74_.lgamma));
                              _loc88_ = _loc90_ * _loc90_ * _loc74_.lgamma;
                              _loc74_.lgamma = _loc74_.lgamma * _loc91_;
                              _loc89_ = _loc91_;
                              _loc74_.vMassa = _loc74_.vMassa * _loc89_;
                              _loc74_.vMassb = _loc74_.vMassb * _loc89_;
                              _loc74_.vMassc = _loc74_.vMassc * _loc89_;
                           }
                           else
                           {
                              _loc74_.vMassa = 0;
                              _loc74_.vMassb = 0;
                              _loc74_.vMassc = 0;
                              _loc74_.lgamma = 0;
                           }
                        }
                        _loc69_ = _loc56_;
                        _loc74_.dampx = _loc74_.dampx * _loc69_;
                        _loc74_.dampy = _loc74_.dampy * _loc69_;
                        _loc74_.adamp = _loc74_.adamp * _loc56_;
                     }
                  }
                  if(_loc14_ != _loc74_.active)
                  {
                     _loc74_.b1.arbiters.modified = true;
                     _loc74_.b2.arbiters.modified = true;
                     _loc72_.modified = true;
                  }
                  _loc71_ = _loc73_;
                  _loc73_ = _loc73_.next;
                  if(!!_loc9_ && _loc73_ == null)
                  {
                     _loc9_ = false;
                     _loc73_ = null.begin();
                     _loc72_ = null;
                     _loc71_ = null;
                  }
               }
            }
         }
         var _loc92_:ZNPNode_ZPP_SensorArbiter = null;
         var _loc93_:ZNPList_ZPP_SensorArbiter = s_arbiters;
         var _loc94_:ZNPNode_ZPP_SensorArbiter = _loc93_.head;
         _loc9_ = false;
         if(!!_loc9_ && _loc94_ == null)
         {
            _loc9_ = false;
            _loc94_ = null.begin();
            _loc93_ = null;
            _loc92_ = null;
         }
         while(_loc94_ != null)
         {
            _loc95_ = _loc94_.elt;
            if(!_loc95_.cleared && (!!_loc95_.b1.component.sleeping && _loc95_.b2.component.sleeping))
            {
               _loc95_.sleep_stamp = stamp;
               _loc95_.sleeping = true;
               if(_loc92_ == null)
               {
                  _loc96_ = _loc93_.head;
                  _loc97_ = _loc96_.next;
                  _loc93_.head = _loc97_;
                  if(_loc93_.head == null)
                  {
                     _loc93_.pushmod = true;
                  }
               }
               else
               {
                  _loc96_ = _loc92_.next;
                  _loc97_ = _loc96_.next;
                  _loc92_.next = _loc97_;
                  if(_loc97_ == null)
                  {
                     _loc93_.pushmod = true;
                  }
               }
               _loc98_ = _loc96_;
               _loc98_.elt = null;
               _loc98_.next = ZNPNode_ZPP_SensorArbiter.zpp_pool;
               ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc98_;
               _loc93_.modified = true;
               _loc93_.length = _loc93_.length - 1;
               _loc93_.pushmod = true;
               _loc94_ = _loc97_;
               if(!!_loc9_ && _loc94_ == null)
               {
                  _loc9_ = false;
                  _loc94_ = null.begin();
                  _loc93_ = null;
                  _loc92_ = null;
               }
            }
            else
            {
               if(!_loc95_.cleared || _loc95_.present != 0 || _loc95_.intchange)
               {
                  _loc14_ = _loc95_.up_stamp == stamp - 1 && !_loc95_.cleared && !_loc95_.intchange;
                  _loc15_ = Boolean(!!_loc95_.fresh && !_loc95_.cleared && !_loc95_.intchange);
                  if(_loc15_ || _loc14_ || _loc95_.cleared || _loc95_.intchange)
                  {
                     _loc16_ = _loc95_.ws1;
                     _loc17_ = _loc95_.ws2;
                     _loc18_ = mrca1;
                     while(_loc18_.head != null)
                     {
                        _loc19_ = _loc18_.head;
                        _loc18_.head = _loc19_.next;
                        _loc20_ = _loc19_;
                        _loc20_.elt = null;
                        _loc20_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                        ZNPNode_ZPP_Interactor.zpp_pool = _loc20_;
                        if(_loc18_.head == null)
                        {
                           _loc18_.pushmod = true;
                        }
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length - 1;
                     }
                     _loc18_.pushmod = true;
                     _loc18_ = mrca2;
                     while(_loc18_.head != null)
                     {
                        _loc19_ = _loc18_.head;
                        _loc18_.head = _loc19_.next;
                        _loc20_ = _loc19_;
                        _loc20_.elt = null;
                        _loc20_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                        ZNPNode_ZPP_Interactor.zpp_pool = _loc20_;
                        if(_loc18_.head == null)
                        {
                           _loc18_.pushmod = true;
                        }
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length - 1;
                     }
                     _loc18_.pushmod = true;
                     if(_loc16_.cbSet != null)
                     {
                        _loc18_ = mrca1;
                        if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                           _loc20_ = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                           _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                           _loc20_.next = null;
                        }
                        null;
                        _loc20_.elt = _loc16_;
                        _loc19_ = _loc20_;
                        _loc19_.next = _loc18_.head;
                        _loc18_.head = _loc19_;
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length + 1;
                        _loc16_;
                     }
                     if(_loc16_.body.cbSet != null)
                     {
                        _loc18_ = mrca1;
                        _loc21_ = _loc16_.body;
                        if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                           _loc20_ = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                           _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                           _loc20_.next = null;
                        }
                        null;
                        _loc20_.elt = _loc21_;
                        _loc19_ = _loc20_;
                        _loc19_.next = _loc18_.head;
                        _loc18_.head = _loc19_;
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length + 1;
                        _loc21_;
                     }
                     if(_loc17_.cbSet != null)
                     {
                        _loc18_ = mrca2;
                        if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                           _loc20_ = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                           _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                           _loc20_.next = null;
                        }
                        null;
                        _loc20_.elt = _loc17_;
                        _loc19_ = _loc20_;
                        _loc19_.next = _loc18_.head;
                        _loc18_.head = _loc19_;
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length + 1;
                        _loc17_;
                     }
                     if(_loc17_.body.cbSet != null)
                     {
                        _loc18_ = mrca2;
                        _loc21_ = _loc17_.body;
                        if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                        {
                           _loc20_ = new ZNPNode_ZPP_Interactor();
                        }
                        else
                        {
                           _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                           ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                           _loc20_.next = null;
                        }
                        null;
                        _loc20_.elt = _loc21_;
                        _loc19_ = _loc20_;
                        _loc19_.next = _loc18_.head;
                        _loc18_.head = _loc19_;
                        _loc18_.modified = true;
                        _loc18_.length = _loc18_.length + 1;
                        _loc21_;
                     }
                     _loc22_ = _loc16_.body.compound;
                     _loc23_ = _loc17_.body.compound;
                     while(_loc22_ != _loc23_)
                     {
                        _loc24_ = int(_loc22_ == null?0:_loc22_.depth);
                        _loc25_ = _loc23_ == null?0:_loc23_.depth;
                        if(_loc24_ < _loc25_)
                        {
                           if(_loc23_.cbSet != null)
                           {
                              _loc18_ = mrca2;
                              if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                              {
                                 _loc20_ = new ZNPNode_ZPP_Interactor();
                              }
                              else
                              {
                                 _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                                 ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                                 _loc20_.next = null;
                              }
                              null;
                              _loc20_.elt = _loc23_;
                              _loc19_ = _loc20_;
                              _loc19_.next = _loc18_.head;
                              _loc18_.head = _loc19_;
                              _loc18_.modified = true;
                              _loc18_.length = _loc18_.length + 1;
                              _loc23_;
                           }
                           _loc23_ = _loc23_.compound;
                        }
                        else
                        {
                           if(_loc22_.cbSet != null)
                           {
                              _loc18_ = mrca1;
                              if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                              {
                                 _loc20_ = new ZNPNode_ZPP_Interactor();
                              }
                              else
                              {
                                 _loc20_ = ZNPNode_ZPP_Interactor.zpp_pool;
                                 ZNPNode_ZPP_Interactor.zpp_pool = _loc20_.next;
                                 _loc20_.next = null;
                              }
                              null;
                              _loc20_.elt = _loc22_;
                              _loc19_ = _loc20_;
                              _loc19_.next = _loc18_.head;
                              _loc18_.head = _loc19_;
                              _loc18_.modified = true;
                              _loc18_.length = _loc18_.length + 1;
                              _loc22_;
                           }
                           _loc22_ = _loc22_.compound;
                        }
                     }
                     _loc19_ = mrca1.head;
                     while(_loc19_ != null)
                     {
                        _loc21_ = _loc19_.elt;
                        _loc20_ = mrca2.head;
                        while(_loc20_ != null)
                        {
                           _loc26_ = _loc20_.elt;
                           _loc27_ = _loc21_.cbSet;
                           _loc28_ = _loc26_.cbSet;
                           _loc29_ = null;
                           _loc30_ = _loc27_.cbpairs.length < _loc28_.cbpairs.length?_loc27_.cbpairs:_loc28_.cbpairs;
                           _loc31_ = _loc30_.head;
                           while(_loc31_ != null)
                           {
                              _loc32_ = _loc31_.elt;
                              if(_loc32_.a == _loc27_ && _loc32_.b == _loc28_ || _loc32_.a == _loc28_ && _loc32_.b == _loc27_)
                              {
                                 _loc29_ = _loc32_;
                                 break;
                              }
                              _loc31_ = _loc31_.next;
                           }
                           if(_loc29_ == null)
                           {
                              if(ZPP_CbSetPair.zpp_pool == null)
                              {
                                 _loc32_ = new ZPP_CbSetPair();
                              }
                              else
                              {
                                 _loc32_ = ZPP_CbSetPair.zpp_pool;
                                 ZPP_CbSetPair.zpp_pool = _loc32_.next;
                                 _loc32_.next = null;
                              }
                              _loc32_.zip_listeners = true;
                              if(ZPP_CbSet.setlt(_loc27_,_loc28_))
                              {
                                 _loc32_.a = _loc27_;
                                 _loc32_.b = _loc28_;
                              }
                              else
                              {
                                 _loc32_.a = _loc28_;
                                 _loc32_.b = _loc27_;
                              }
                              _loc29_ = _loc32_;
                              _loc27_.cbpairs.add(_loc29_);
                              if(_loc28_ != _loc27_)
                              {
                                 _loc28_.cbpairs.add(_loc29_);
                              }
                           }
                           if(_loc29_.zip_listeners)
                           {
                              _loc29_.zip_listeners = false;
                              _loc29_.__validate();
                           }
                           if(_loc29_.listeners.head == null)
                           {
                              _loc20_ = _loc20_.next;
                           }
                           else
                           {
                              _loc33_ = ZPP_Interactor.get(_loc21_,_loc26_);
                              if(_loc15_ || _loc95_.intchange)
                              {
                                 if(_loc33_ == null)
                                 {
                                    _loc33_ = ZPP_CallbackSet.get(_loc21_,_loc26_);
                                    add_callbackset(_loc33_);
                                 }
                                 _loc24_ = int(ZPP_Flags.id_CbEvent_BEGIN);
                                 _loc29_ = null;
                                 _loc30_ = _loc27_.cbpairs.length < _loc28_.cbpairs.length?_loc27_.cbpairs:_loc28_.cbpairs;
                                 _loc31_ = _loc30_.head;
                                 while(_loc31_ != null)
                                 {
                                    _loc32_ = _loc31_.elt;
                                    if(_loc32_.a == _loc27_ && _loc32_.b == _loc28_ || _loc32_.a == _loc28_ && _loc32_.b == _loc27_)
                                    {
                                       _loc29_ = _loc32_;
                                       break;
                                    }
                                    _loc31_ = _loc31_.next;
                                 }
                                 if(_loc29_ == null)
                                 {
                                    if(ZPP_CbSetPair.zpp_pool == null)
                                    {
                                       _loc32_ = new ZPP_CbSetPair();
                                    }
                                    else
                                    {
                                       _loc32_ = ZPP_CbSetPair.zpp_pool;
                                       ZPP_CbSetPair.zpp_pool = _loc32_.next;
                                       _loc32_.next = null;
                                    }
                                    _loc32_.zip_listeners = true;
                                    if(ZPP_CbSet.setlt(_loc27_,_loc28_))
                                    {
                                       _loc32_.a = _loc27_;
                                       _loc32_.b = _loc28_;
                                    }
                                    else
                                    {
                                       _loc32_.a = _loc28_;
                                       _loc32_.b = _loc27_;
                                    }
                                    _loc29_ = _loc32_;
                                    _loc27_.cbpairs.add(_loc29_);
                                    if(_loc28_ != _loc27_)
                                    {
                                       _loc28_.cbpairs.add(_loc29_);
                                    }
                                 }
                                 if(_loc29_.zip_listeners)
                                 {
                                    _loc29_.zip_listeners = false;
                                    _loc29_.__validate();
                                 }
                                 _loc34_ = _loc29_.listeners.head;
                                 while(_loc34_ != null)
                                 {
                                    _loc35_ = _loc34_.elt;
                                    if(_loc35_.event == _loc24_)
                                    {
                                       if((_loc35_.itype & _loc95_.type) != 0 && _loc33_.empty_arb(_loc35_.itype))
                                       {
                                          _loc36_ = _loc2_.push_callback(_loc35_);
                                          _loc36_.event = ZPP_Flags.id_CbEvent_BEGIN;
                                          _loc37_ = _loc33_.int1;
                                          _loc38_ = _loc33_.int2;
                                          _loc39_ = _loc35_.options1;
                                          _loc40_ = _loc37_.cbTypes;
                                          if(!!_loc39_.nonemptyintersection(_loc40_,_loc39_.includes) && !_loc39_.nonemptyintersection(_loc40_,_loc39_.excludes) && (!!_loc39_.nonemptyintersection(_loc40_,_loc39_.includes) && !_loc39_.nonemptyintersection(_loc40_,_loc39_.excludes)))
                                          {
                                             _loc36_.int1 = _loc37_;
                                             _loc36_.int2 = _loc38_;
                                          }
                                          else
                                          {
                                             _loc36_.int1 = _loc38_;
                                             _loc36_.int2 = _loc37_;
                                          }
                                          _loc36_.set = _loc33_;
                                       }
                                    }
                                    _loc34_ = _loc34_.next;
                                 }
                                 _loc41_ = false;
                                 _loc42_ = _loc33_.arbiters.head;
                                 while(_loc42_ != null)
                                 {
                                    _loc43_ = _loc42_.elt;
                                    if(_loc43_ == _loc95_)
                                    {
                                       _loc41_ = true;
                                       break;
                                    }
                                    _loc42_ = _loc42_.next;
                                 }
                                 if(!_loc41_)
                                 {
                                    _loc44_ = _loc33_.arbiters;
                                    if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                    {
                                       _loc45_ = new ZNPNode_ZPP_Arbiter();
                                    }
                                    else
                                    {
                                       _loc45_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                                       ZNPNode_ZPP_Arbiter.zpp_pool = _loc45_.next;
                                       _loc45_.next = null;
                                    }
                                    null;
                                    _loc45_.elt = _loc95_;
                                    _loc42_ = _loc45_;
                                    _loc42_.next = _loc44_.head;
                                    _loc44_.head = _loc42_;
                                    _loc44_.modified = true;
                                    _loc44_.length = _loc44_.length + 1;
                                    _loc95_;
                                    §§push(true);
                                 }
                                 else
                                 {
                                    §§push(false);
                                 }
                                 _loc95_.present = _loc95_.present + 1;
                              }
                              else
                              {
                                 _loc95_.present = _loc95_.present - 1;
                                 _loc33_.remove_arb(_loc95_);
                                 _loc24_ = int(ZPP_Flags.id_CbEvent_END);
                                 _loc29_ = null;
                                 _loc30_ = _loc27_.cbpairs.length < _loc28_.cbpairs.length?_loc27_.cbpairs:_loc28_.cbpairs;
                                 _loc31_ = _loc30_.head;
                                 while(_loc31_ != null)
                                 {
                                    _loc32_ = _loc31_.elt;
                                    if(_loc32_.a == _loc27_ && _loc32_.b == _loc28_ || _loc32_.a == _loc28_ && _loc32_.b == _loc27_)
                                    {
                                       _loc29_ = _loc32_;
                                       break;
                                    }
                                    _loc31_ = _loc31_.next;
                                 }
                                 if(_loc29_ == null)
                                 {
                                    if(ZPP_CbSetPair.zpp_pool == null)
                                    {
                                       _loc32_ = new ZPP_CbSetPair();
                                    }
                                    else
                                    {
                                       _loc32_ = ZPP_CbSetPair.zpp_pool;
                                       ZPP_CbSetPair.zpp_pool = _loc32_.next;
                                       _loc32_.next = null;
                                    }
                                    _loc32_.zip_listeners = true;
                                    if(ZPP_CbSet.setlt(_loc27_,_loc28_))
                                    {
                                       _loc32_.a = _loc27_;
                                       _loc32_.b = _loc28_;
                                    }
                                    else
                                    {
                                       _loc32_.a = _loc28_;
                                       _loc32_.b = _loc27_;
                                    }
                                    _loc29_ = _loc32_;
                                    _loc27_.cbpairs.add(_loc29_);
                                    if(_loc28_ != _loc27_)
                                    {
                                       _loc28_.cbpairs.add(_loc29_);
                                    }
                                 }
                                 if(_loc29_.zip_listeners)
                                 {
                                    _loc29_.zip_listeners = false;
                                    _loc29_.__validate();
                                 }
                                 _loc34_ = _loc29_.listeners.head;
                                 while(_loc34_ != null)
                                 {
                                    _loc35_ = _loc34_.elt;
                                    if(_loc35_.event == _loc24_)
                                    {
                                       if((_loc35_.itype & _loc95_.type) != 0 && _loc33_.empty_arb(_loc35_.itype))
                                       {
                                          _loc36_ = _loc2_.push_callback(_loc35_);
                                          _loc36_.event = ZPP_Flags.id_CbEvent_END;
                                          _loc37_ = _loc33_.int1;
                                          _loc38_ = _loc33_.int2;
                                          _loc39_ = _loc35_.options1;
                                          _loc40_ = _loc37_.cbTypes;
                                          if(!!_loc39_.nonemptyintersection(_loc40_,_loc39_.includes) && !_loc39_.nonemptyintersection(_loc40_,_loc39_.excludes) && (!!_loc39_.nonemptyintersection(_loc40_,_loc39_.includes) && !_loc39_.nonemptyintersection(_loc40_,_loc39_.excludes)))
                                          {
                                             _loc36_.int1 = _loc37_;
                                             _loc36_.int2 = _loc38_;
                                          }
                                          else
                                          {
                                             _loc36_.int1 = _loc38_;
                                             _loc36_.int2 = _loc37_;
                                          }
                                          _loc36_.set = _loc33_;
                                       }
                                    }
                                    _loc34_ = _loc34_.next;
                                 }
                                 if(_loc33_.arbiters.head == null)
                                 {
                                    remove_callbackset(_loc33_);
                                 }
                              }
                              _loc20_ = _loc20_.next;
                           }
                        }
                        _loc19_ = _loc19_.next;
                     }
                  }
                  _loc95_.fresh = false;
                  _loc95_.intchange = false;
               }
               if(_loc95_.cleared || _loc95_.up_stamp + (_loc95_.type == ZPP_Arbiter.COL?6:0) < stamp)
               {
                  if(!_loc95_.cleared)
                  {
                     _loc44_ = _loc95_.b1.arbiters;
                     _loc42_ = null;
                     _loc45_ = _loc44_.head;
                     _loc14_ = false;
                     while(_loc45_ != null)
                     {
                        if(_loc45_.elt == _loc95_)
                        {
                           if(_loc42_ == null)
                           {
                              _loc46_ = _loc44_.head;
                              _loc47_ = _loc46_.next;
                              _loc44_.head = _loc47_;
                              if(_loc44_.head == null)
                              {
                                 _loc44_.pushmod = true;
                              }
                           }
                           else
                           {
                              _loc46_ = _loc42_.next;
                              _loc47_ = _loc46_.next;
                              _loc42_.next = _loc47_;
                              if(_loc47_ == null)
                              {
                                 _loc44_.pushmod = true;
                              }
                           }
                           _loc48_ = _loc46_;
                           _loc48_.elt = null;
                           _loc48_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                           ZNPNode_ZPP_Arbiter.zpp_pool = _loc48_;
                           _loc44_.modified = true;
                           _loc44_.length = _loc44_.length - 1;
                           _loc44_.pushmod = true;
                           _loc47_;
                           _loc14_ = true;
                           break;
                        }
                        _loc42_ = _loc45_;
                        _loc45_ = _loc45_.next;
                     }
                     _loc14_;
                     _loc44_ = _loc95_.b2.arbiters;
                     _loc42_ = null;
                     _loc45_ = _loc44_.head;
                     _loc14_ = false;
                     while(_loc45_ != null)
                     {
                        if(_loc45_.elt == _loc95_)
                        {
                           if(_loc42_ == null)
                           {
                              _loc46_ = _loc44_.head;
                              _loc47_ = _loc46_.next;
                              _loc44_.head = _loc47_;
                              if(_loc44_.head == null)
                              {
                                 _loc44_.pushmod = true;
                              }
                           }
                           else
                           {
                              _loc46_ = _loc42_.next;
                              _loc47_ = _loc46_.next;
                              _loc42_.next = _loc47_;
                              if(_loc47_ == null)
                              {
                                 _loc44_.pushmod = true;
                              }
                           }
                           _loc48_ = _loc46_;
                           _loc48_.elt = null;
                           _loc48_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                           ZNPNode_ZPP_Arbiter.zpp_pool = _loc48_;
                           _loc44_.modified = true;
                           _loc44_.length = _loc44_.length - 1;
                           _loc44_.pushmod = true;
                           _loc47_;
                           _loc14_ = true;
                           break;
                        }
                        _loc42_ = _loc45_;
                        _loc45_ = _loc45_.next;
                     }
                     _loc14_;
                     if(_loc95_.pair != null)
                     {
                        _loc95_.pair.arb = null;
                        _loc95_.pair = null;
                     }
                  }
                  _loc49_ = null;
                  _loc95_.b2 = _loc49_;
                  _loc95_.b1 = _loc49_;
                  _loc95_.active = false;
                  _loc95_.intchange = false;
                  _loc99_ = _loc95_;
                  _loc99_.next = ZPP_SensorArbiter.zpp_pool;
                  ZPP_SensorArbiter.zpp_pool = _loc99_;
                  if(_loc92_ == null)
                  {
                     _loc96_ = _loc93_.head;
                     _loc97_ = _loc96_.next;
                     _loc93_.head = _loc97_;
                     if(_loc93_.head == null)
                     {
                        _loc93_.pushmod = true;
                     }
                  }
                  else
                  {
                     _loc96_ = _loc92_.next;
                     _loc97_ = _loc96_.next;
                     _loc92_.next = _loc97_;
                     if(_loc97_ == null)
                     {
                        _loc93_.pushmod = true;
                     }
                  }
                  _loc98_ = _loc96_;
                  _loc98_.elt = null;
                  _loc98_.next = ZNPNode_ZPP_SensorArbiter.zpp_pool;
                  ZNPNode_ZPP_SensorArbiter.zpp_pool = _loc98_;
                  _loc93_.modified = true;
                  _loc93_.length = _loc93_.length - 1;
                  _loc93_.pushmod = true;
                  _loc94_ = _loc97_;
                  if(!!_loc9_ && _loc94_ == null)
                  {
                     _loc9_ = false;
                     _loc94_ = null.begin();
                     _loc93_ = null;
                     _loc92_ = null;
                  }
               }
               else
               {
                  _loc14_ = _loc95_.active;
                  _loc15_ = _loc95_.up_stamp == stamp;
                  _loc95_.presentable = _loc15_;
                  _loc95_.active = _loc15_;
                  if((_loc95_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                  {
                  }
                  if(_loc14_ != _loc95_.active)
                  {
                     _loc95_.b1.arbiters.modified = true;
                     _loc95_.b2.arbiters.modified = true;
                     _loc93_.modified = true;
                  }
                  _loc92_ = _loc94_;
                  _loc94_ = _loc94_.next;
                  if(!!_loc9_ && _loc94_ == null)
                  {
                     _loc9_ = false;
                     _loc94_ = null.begin();
                     _loc93_ = null;
                     _loc92_ = null;
                  }
               }
            }
         }
      }
      
      public function nullListenerType(param1:ZPP_CbSet, param2:ZPP_CbSet) : void
      {
         var _loc4_:* = null as ZNPNode_ZPP_Interactor;
         var _loc5_:* = null as ZPP_Interactor;
         var _loc6_:* = null as ZPP_Compound;
         var _loc7_:* = null as ZNPNode_ZPP_Body;
         var _loc8_:* = null as ZPP_Body;
         var _loc9_:* = null as ZNPNode_ZPP_Compound;
         var _loc10_:* = null as ZPP_Compound;
         var _loc11_:* = null as ZPP_Shape;
         var _loc12_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc13_:* = null as ZPP_Arbiter;
         var _loc14_:* = null as ZPP_Interactor;
         var _loc15_:* = null as ZNPNode_ZPP_Interactor;
         var _loc16_:* = null as ZPP_Interactor;
         var _loc17_:* = null as ZPP_CallbackSet;
         var _loc18_:* = null as ZPP_Arbiter;
         var _loc3_:ZNPList_ZPP_Interactor = new ZNPList_ZPP_Interactor();
         _loc4_ = param1.interactors.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            _loc3_.add(_loc5_);
            _loc4_ = _loc4_.next;
         }
         if(param1 != param2)
         {
            _loc4_ = param2.interactors.head;
            while(_loc4_ != null)
            {
               _loc5_ = _loc4_.elt;
               _loc3_.add(_loc5_);
               _loc4_ = _loc4_.next;
            }
         }
         while(_loc3_.head != null)
         {
            _loc5_ = _loc3_.pop_unsafe();
            if(_loc5_.icompound != null)
            {
               _loc6_ = _loc5_.icompound;
               _loc7_ = _loc6_.bodies.head;
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.elt;
                  _loc3_.add(_loc8_);
                  _loc7_ = _loc7_.next;
               }
               _loc9_ = _loc6_.compounds.head;
               while(_loc9_ != null)
               {
                  _loc10_ = _loc9_.elt;
                  _loc3_.add(_loc10_);
                  _loc9_ = _loc9_.next;
               }
            }
            else
            {
               _loc8_ = _loc5_.ibody != null?_loc5_.ibody:_loc5_.ishape.body;
               _loc11_ = _loc5_.ishape != null?_loc5_.ishape:null;
               _loc12_ = _loc8_.arbiters.head;
               while(_loc12_ != null)
               {
                  _loc13_ = _loc12_.elt;
                  if(_loc13_.present == 0)
                  {
                     _loc12_ = _loc12_.next;
                  }
                  else if(_loc11_ != null && !(_loc13_.ws1 == _loc11_ || _loc13_.ws2 == _loc11_))
                  {
                     _loc12_ = _loc12_.next;
                  }
                  else
                  {
                     MRCA_chains(_loc13_.ws1,_loc13_.ws2);
                     _loc4_ = mrca1.head;
                     while(_loc4_ != null)
                     {
                        _loc14_ = _loc4_.elt;
                        if(_loc14_.cbSet != param1 && _loc14_.cbSet != param2)
                        {
                           _loc4_ = _loc4_.next;
                        }
                        else
                        {
                           _loc15_ = mrca2.head;
                           while(_loc15_ != null)
                           {
                              _loc16_ = _loc15_.elt;
                              if(_loc14_.cbSet == param1 && _loc16_.cbSet != param2 || _loc14_.cbSet == param2 && _loc16_.cbSet != param1)
                              {
                                 _loc15_ = _loc15_.next;
                              }
                              else
                              {
                                 _loc17_ = ZPP_Interactor.get(_loc14_,_loc16_);
                                 if(_loc17_ != null)
                                 {
                                    while(_loc17_.arbiters.head != null)
                                    {
                                       _loc18_ = _loc17_.arbiters.pop_unsafe();
                                       _loc18_.present = _loc18_.present - 1;
                                    }
                                    remove_callbackset(_loc17_);
                                 }
                                 _loc15_ = _loc15_.next;
                              }
                           }
                           _loc4_ = _loc4_.next;
                        }
                     }
                     _loc12_ = _loc12_.next;
                  }
               }
            }
         }
      }
      
      public function nullInteractorType(param1:ZPP_Interactor, param2:ZPP_Interactor = undefined) : void
      {
         var _loc3_:* = null as ZPP_Compound;
         var _loc4_:* = null as ZNPNode_ZPP_Body;
         var _loc5_:* = null as ZPP_Body;
         var _loc6_:* = null as ZNPNode_ZPP_Compound;
         var _loc7_:* = null as ZPP_Compound;
         var _loc8_:* = null as ZPP_Shape;
         var _loc9_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc10_:* = null as ZPP_Arbiter;
         var _loc11_:* = null as ZNPNode_ZPP_Interactor;
         var _loc12_:* = null as ZPP_Interactor;
         var _loc13_:* = null as ZNPNode_ZPP_Interactor;
         var _loc14_:* = null as ZPP_Interactor;
         var _loc15_:* = null as ZPP_CallbackSet;
         if(param2 == null)
         {
            param2 = param1;
         }
         if(param1.icompound != null)
         {
            _loc3_ = param1.icompound;
            _loc4_ = _loc3_.bodies.head;
            while(_loc4_ != null)
            {
               _loc5_ = _loc4_.elt;
               nullInteractorType(_loc5_,param2);
               _loc4_ = _loc4_.next;
            }
            _loc6_ = _loc3_.compounds.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_.elt;
               nullInteractorType(_loc7_,param2);
               _loc6_ = _loc6_.next;
            }
         }
         else
         {
            _loc5_ = param1.ibody != null?param1.ibody:param1.ishape.body;
            _loc8_ = param1.ishape != null?param1.ishape:null;
            _loc9_ = _loc5_.arbiters.head;
            while(_loc9_ != null)
            {
               _loc10_ = _loc9_.elt;
               if(_loc10_.present == 0)
               {
                  _loc9_ = _loc9_.next;
               }
               else if(_loc8_ != null && !(_loc10_.ws1 == _loc8_ || _loc10_.ws2 == _loc8_))
               {
                  _loc9_ = _loc9_.next;
               }
               else
               {
                  MRCA_chains(_loc10_.ws1,_loc10_.ws2);
                  _loc11_ = mrca1.head;
                  while(_loc11_ != null)
                  {
                     _loc12_ = _loc11_.elt;
                     _loc13_ = mrca2.head;
                     while(_loc13_ != null)
                     {
                        _loc14_ = _loc13_.elt;
                        if(_loc12_ != param2 && _loc14_ != param2)
                        {
                           _loc13_ = _loc13_.next;
                        }
                        else
                        {
                           _loc15_ = ZPP_Interactor.get(_loc12_,_loc14_);
                           if(_loc15_ != null)
                           {
                              _loc10_.present = _loc10_.present - 1;
                              _loc15_.remove_arb(_loc10_);
                              if(_loc15_.arbiters.head == null)
                              {
                                 remove_callbackset(_loc15_);
                              }
                           }
                           _loc13_ = _loc13_.next;
                        }
                     }
                     _loc11_ = _loc11_.next;
                  }
                  _loc9_ = _loc9_.next;
               }
            }
         }
      }
      
      public function non_inlined_wake(param1:ZPP_Body, param2:Boolean = false) : void
      {
         var _loc3_:ZPP_Body = param1;
         if(!_loc3_.world)
         {
            _loc3_.component.waket = stamp + (!!midstep?0:1);
            if(_loc3_.component.sleeping)
            {
               really_wake(_loc3_,param2);
            }
         }
      }
      
      public function narrowPhase(param1:ZPP_Shape, param2:ZPP_Shape, param3:Boolean, param4:ZPP_Arbiter = undefined) : ZPP_Arbiter
      {
         var _loc10_:* = false;
         var _loc12_:* = null as ZPP_Constraint;
         var _loc13_:* = null as ZPP_InteractionGroup;
         var _loc14_:* = null as ZPP_Interactor;
         var _loc15_:* = null as ZPP_InteractionGroup;
         var _loc16_:* = false;
         var _loc17_:* = null as ZPP_InteractionFilter;
         var _loc18_:* = null as ZPP_InteractionFilter;
         var _loc19_:* = null as ZPP_Shape;
         var _loc20_:* = null as ZPP_Shape;
         var _loc21_:* = null as ZPP_Arbiter;
         var _loc22_:* = null as ZPP_Arbiter;
         var _loc23_:* = null as ZPP_Body;
         var _loc24_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc25_:* = null as ZPP_Arbiter;
         var _loc26_:* = null as ZPP_FluidArbiter;
         var _loc27_:Boolean = false;
         var _loc28_:* = null as ZNPList_ZPP_Arbiter;
         var _loc29_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc30_:Boolean = false;
         var _loc31_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc32_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc33_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc34_:int = 0;
         var _loc35_:* = null as ZNPList_ZPP_FluidArbiter;
         var _loc36_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc37_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc38_:* = null as ZNPList_ZPP_Interactor;
         var _loc39_:* = null as ZNPNode_ZPP_Interactor;
         var _loc40_:* = null as ZNPNode_ZPP_Interactor;
         var _loc41_:* = null as ZPP_Compound;
         var _loc42_:* = null as ZPP_Compound;
         var _loc43_:int = 0;
         var _loc44_:int = 0;
         var _loc45_:* = null as ZPP_Interactor;
         var _loc46_:* = null as ZPP_CbSet;
         var _loc47_:* = null as ZPP_CbSet;
         var _loc48_:* = null as ZPP_CbSetPair;
         var _loc49_:* = null as ZNPList_ZPP_CbSetPair;
         var _loc50_:* = null as ZNPNode_ZPP_CbSetPair;
         var _loc51_:* = null as ZPP_CbSetPair;
         var _loc52_:* = null as ZPP_CallbackSet;
         var _loc53_:* = null as ZPP_CallbackSet;
         var _loc54_:* = null as ZNPList_ZPP_InteractionListener;
         var _loc55_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc56_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc57_:* = null as ZPP_InteractionListener;
         var _loc58_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc59_:* = null as ZNPNode_ZPP_InteractionListener;
         var _loc60_:Boolean = false;
         var _loc61_:Boolean = false;
         var _loc62_:* = null as String;
         var _loc63_:* = null as ZNPNode_ZPP_CallbackSet;
         var _loc64_:* = null as ZPP_CallbackSet;
         var _loc65_:* = null as ZPP_Callback;
         var _loc66_:* = null as ZPP_Interactor;
         var _loc67_:* = null as ZPP_Interactor;
         var _loc68_:* = null as ZPP_OptionType;
         var _loc69_:* = null as ZNPList_ZPP_CbType;
         var _loc70_:* = null as PreFlag;
         var _loc71_:* = null as ZPP_ColArbiter;
         var _loc72_:Number = NaN;
         var _loc73_:Number = NaN;
         var _loc74_:* = null as ZPP_FluidArbiter;
         var _loc75_:* = null as ZNPList_ZPP_ColArbiter;
         var _loc76_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc77_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc79_:* = null as ZPP_Contact;
         var _loc80_:* = null as ZPP_IContact;
         var _loc81_:* = null as ZPP_IContact;
         var _loc82_:* = null as ZPP_Contact;
         var _loc83_:* = null as ZPP_Contact;
         var _loc84_:* = null as ZPP_Contact;
         var _loc85_:* = null as ZPP_Contact;
         var _loc86_:* = null as ZPP_Contact;
         var _loc87_:* = null as ZPP_IContact;
         var _loc88_:* = null as ZPP_IContact;
         var _loc89_:* = null as ZPP_IContact;
         var _loc91_:* = null as ZPP_ColArbiter;
         var _loc92_:* = null as ZPP_SensorArbiter;
         var _loc93_:* = null as ZNPList_ZPP_SensorArbiter;
         var _loc94_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc95_:* = null as ZNPNode_ZPP_SensorArbiter;
         var _loc96_:* = null as ZPP_SensorArbiter;
         var _loc5_:ZPP_Space = this;
         var _loc6_:ZPP_Arbiter = null;
         var _loc7_:ZPP_Body = param1.body;
         var _loc8_:ZPP_Body = param2.body;
         _loc10_ = false;
         var _loc11_:ZNPNode_ZPP_Constraint = _loc7_.constraints.head;
         while(_loc11_ != null)
         {
            _loc12_ = _loc11_.elt;
            if(!!_loc12_.ignore && _loc12_.pair_exists(_loc7_.id,_loc8_.id))
            {
               _loc10_ = true;
               break;
            }
            _loc11_ = _loc11_.next;
         }
         if((param1.fluidEnabled || param2.fluidEnabled) && ((_loc17_.fluidMask & _loc18_.fluidGroup) != 0 && (_loc18_.fluidMask & _loc17_.fluidGroup) != 0) && !(!!param1.fluidEnabled && _loc7_.type == ZPP_Flags.id_BodyType_DYNAMIC && !param2.fluidEnabled && _loc8_.type != ZPP_Flags.id_BodyType_DYNAMIC || !!param2.fluidEnabled && _loc8_.type == ZPP_Flags.id_BodyType_DYNAMIC && !param1.fluidEnabled && _loc7_.type != ZPP_Flags.id_BodyType_DYNAMIC || !!param1.fluidEnabled && _loc7_.type != ZPP_Flags.id_BodyType_DYNAMIC && _loc8_.type != ZPP_Flags.id_BodyType_DYNAMIC || !!param2.fluidEnabled && _loc8_.type != ZPP_Flags.id_BodyType_DYNAMIC && _loc7_.type != ZPP_Flags.id_BodyType_DYNAMIC))
         {
            §§push(0);
         }
         else
         {
            _loc17_ = param1.filter;
            _loc18_ = param2.filter;
            if((_loc17_.collisionMask & _loc18_.collisionGroup) != 0 && (_loc18_.collisionMask & _loc17_.collisionGroup) != 0 && !(_loc7_.imass == 0 && _loc8_.imass == 0 && _loc7_.iinertia == 0 && _loc8_.iinertia == 0))
            {
               §§push(1);
            }
            else
            {
               _loc17_ = param1.filter;
               _loc18_ = param2.filter;
               §§push((_loc17_.sensorMask & _loc18_.sensorGroup) != 0 && (_loc18_.sensorMask & _loc17_.sensorGroup) != 0?2:-1);
            }
         }
         if(param1.type > param2.type)
         {
            _loc19_ = param2;
            _loc20_ = param1;
         }
         else if(param1.type == param2.type)
         {
            if(param1.id < param2.id)
            {
               _loc19_ = param1;
               _loc20_ = param2;
            }
            else
            {
               _loc20_ = param1;
               _loc19_ = param2;
            }
         }
         else
         {
            _loc19_ = param1;
            _loc20_ = param2;
         }
         _loc10_ = _loc19_ == param2;
         if(param4 == null)
         {
            _loc22_ = null;
            _loc23_ = _loc7_.arbiters.length < _loc8_.arbiters.length?_loc7_:_loc8_;
            _loc24_ = _loc23_.arbiters.head;
            while(_loc24_ != null)
            {
               _loc25_ = _loc24_.elt;
               if(_loc25_.id == _loc19_.id && _loc25_.di == _loc20_.id)
               {
                  _loc22_ = _loc25_;
                  break;
               }
               _loc24_ = _loc24_.next;
            }
            §§push(_loc22_);
         }
         else
         {
            §§push(param4);
         }
         _loc21_ = §§pop();
         _loc16_ = _loc21_ == null;
         _loc27_ = false;
         if(_loc16_)
         {
            if(ZPP_FluidArbiter.zpp_pool == null)
            {
               _loc26_ = new ZPP_FluidArbiter();
            }
            else
            {
               _loc26_ = ZPP_FluidArbiter.zpp_pool;
               ZPP_FluidArbiter.zpp_pool = _loc26_.next;
               _loc26_.next = null;
            }
            _loc26_.pdampx = 0;
            _loc26_.pdampy = 0;
            _loc26_.padamp = 0;
         }
         else if(_loc21_.fluidarb == null)
         {
            _loc21_.cleared = true;
            _loc28_ = _loc21_.b1.arbiters;
            _loc24_ = null;
            _loc29_ = _loc28_.head;
            _loc30_ = false;
            while(_loc29_ != null)
            {
               if(_loc29_.elt == _loc21_)
               {
                  if(_loc24_ == null)
                  {
                     _loc31_ = _loc28_.head;
                     _loc32_ = _loc31_.next;
                     _loc28_.head = _loc32_;
                     if(_loc28_.head == null)
                     {
                        _loc28_.pushmod = true;
                     }
                  }
                  else
                  {
                     _loc31_ = _loc24_.next;
                     _loc32_ = _loc31_.next;
                     _loc24_.next = _loc32_;
                     if(_loc32_ == null)
                     {
                        _loc28_.pushmod = true;
                     }
                  }
                  _loc33_ = _loc31_;
                  _loc33_.elt = null;
                  _loc33_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                  ZNPNode_ZPP_Arbiter.zpp_pool = _loc33_;
                  _loc28_.modified = true;
                  _loc28_.length = _loc28_.length - 1;
                  _loc28_.pushmod = true;
                  _loc32_;
                  _loc30_ = true;
                  break;
               }
               _loc24_ = _loc29_;
               _loc29_ = _loc29_.next;
            }
            _loc30_;
            _loc28_ = _loc21_.b2.arbiters;
            _loc24_ = null;
            _loc29_ = _loc28_.head;
            _loc30_ = false;
            while(_loc29_ != null)
            {
               if(_loc29_.elt == _loc21_)
               {
                  if(_loc24_ == null)
                  {
                     _loc31_ = _loc28_.head;
                     _loc32_ = _loc31_.next;
                     _loc28_.head = _loc32_;
                     if(_loc28_.head == null)
                     {
                        _loc28_.pushmod = true;
                     }
                  }
                  else
                  {
                     _loc31_ = _loc24_.next;
                     _loc32_ = _loc31_.next;
                     _loc24_.next = _loc32_;
                     if(_loc32_ == null)
                     {
                        _loc28_.pushmod = true;
                     }
                  }
                  _loc33_ = _loc31_;
                  _loc33_.elt = null;
                  _loc33_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                  ZNPNode_ZPP_Arbiter.zpp_pool = _loc33_;
                  _loc28_.modified = true;
                  _loc28_.length = _loc28_.length - 1;
                  _loc28_.pushmod = true;
                  _loc32_;
                  _loc30_ = true;
                  break;
               }
               _loc24_ = _loc29_;
               _loc29_ = _loc29_.next;
            }
            _loc30_;
            if(_loc21_.pair != null)
            {
               _loc21_.pair.arb = null;
               _loc21_.pair = null;
            }
            _loc21_.active = false;
            f_arbiters.modified = true;
            if(ZPP_FluidArbiter.zpp_pool == null)
            {
               _loc26_ = new ZPP_FluidArbiter();
            }
            else
            {
               _loc26_ = ZPP_FluidArbiter.zpp_pool;
               ZPP_FluidArbiter.zpp_pool = _loc26_.next;
               _loc26_.next = null;
            }
            _loc26_.pdampx = 0;
            _loc26_.pdampy = 0;
            _loc26_.padamp = 0;
            _loc26_.intchange = true;
            _loc16_ = true;
            _loc27_ = true;
         }
         else
         {
            _loc26_ = _loc21_.fluidarb;
         }
         _loc34_ = ZPP_Flags.id_InteractionType_FLUID;
         if(_loc16_ || _loc26_.stamp != stamp)
         {
            _loc26_.stamp = stamp;
            if(ZPP_Collide.flowCollide(_loc19_,_loc20_,_loc26_))
            {
               if(_loc16_)
               {
                  _loc26_.b1 = param1.body;
                  _loc26_.ws1 = param1;
                  _loc26_.b2 = param2.body;
                  _loc26_.ws2 = param2;
                  _loc26_.id = _loc19_.id;
                  _loc26_.di = _loc20_.id;
                  _loc28_ = _loc26_.b1.arbiters;
                  if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                  {
                     _loc29_ = new ZNPNode_ZPP_Arbiter();
                  }
                  else
                  {
                     _loc29_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc29_.next;
                     _loc29_.next = null;
                  }
                  null;
                  _loc29_.elt = _loc26_;
                  _loc24_ = _loc29_;
                  _loc24_.next = _loc28_.head;
                  _loc28_.head = _loc24_;
                  _loc28_.modified = true;
                  _loc28_.length = _loc28_.length + 1;
                  _loc26_;
                  _loc28_ = _loc26_.b2.arbiters;
                  if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                  {
                     _loc29_ = new ZNPNode_ZPP_Arbiter();
                  }
                  else
                  {
                     _loc29_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc29_.next;
                     _loc29_.next = null;
                  }
                  null;
                  _loc29_.elt = _loc26_;
                  _loc24_ = _loc29_;
                  _loc24_.next = _loc28_.head;
                  _loc28_.head = _loc24_;
                  _loc28_.modified = true;
                  _loc28_.length = _loc28_.length + 1;
                  _loc26_;
                  _loc26_.active = true;
                  _loc26_.present = 0;
                  _loc26_.cleared = false;
                  _loc26_.sleeping = false;
                  _loc26_.fresh = false;
                  _loc26_.presentable = false;
                  _loc26_.nx = 0;
                  _loc26_.ny = 1;
                  _loc26_.dampx = 0;
                  _loc26_.dampy = 0;
                  _loc26_.adamp = 0;
                  _loc35_ = f_arbiters;
                  if(ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
                  {
                     _loc37_ = new ZNPNode_ZPP_FluidArbiter();
                  }
                  else
                  {
                     _loc37_ = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                     ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc37_.next;
                     _loc37_.next = null;
                  }
                  null;
                  _loc37_.elt = _loc26_;
                  _loc36_ = _loc37_;
                  _loc36_.next = _loc35_.head;
                  _loc35_.head = _loc36_;
                  _loc35_.modified = true;
                  _loc35_.length = _loc35_.length + 1;
                  _loc26_;
                  _loc26_.fresh = !_loc27_;
               }
               else
               {
                  _loc26_.fresh = _loc26_.up_stamp < stamp - 1;
               }
               _loc26_.up_stamp = _loc26_.stamp;
               if(_loc26_.fresh || (_loc26_.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
               {
                  _loc26_.immState = ZPP_Flags.id_ImmState_ACCEPT;
                  _loc30_ = false;
                  _loc38_ = mrca1;
                  while(_loc38_.head != null)
                  {
                     _loc39_ = _loc38_.head;
                     _loc38_.head = _loc39_.next;
                     _loc40_ = _loc39_;
                     _loc40_.elt = null;
                     _loc40_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                     ZNPNode_ZPP_Interactor.zpp_pool = _loc40_;
                     if(_loc38_.head == null)
                     {
                        _loc38_.pushmod = true;
                     }
                     _loc38_.modified = true;
                     _loc38_.length = _loc38_.length - 1;
                  }
                  _loc38_.pushmod = true;
                  _loc38_ = mrca2;
                  while(_loc38_.head != null)
                  {
                     _loc39_ = _loc38_.head;
                     _loc38_.head = _loc39_.next;
                     _loc40_ = _loc39_;
                     _loc40_.elt = null;
                     _loc40_.next = ZNPNode_ZPP_Interactor.zpp_pool;
                     ZNPNode_ZPP_Interactor.zpp_pool = _loc40_;
                     if(_loc38_.head == null)
                     {
                        _loc38_.pushmod = true;
                     }
                     _loc38_.modified = true;
                     _loc38_.length = _loc38_.length - 1;
                  }
                  _loc38_.pushmod = true;
                  if(param1.cbSet != null)
                  {
                     _loc38_ = mrca1;
                     if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                     {
                        _loc40_ = new ZNPNode_ZPP_Interactor();
                     }
                     else
                     {
                        _loc40_ = ZNPNode_ZPP_Interactor.zpp_pool;
                        ZNPNode_ZPP_Interactor.zpp_pool = _loc40_.next;
                        _loc40_.next = null;
                     }
                     null;
                     _loc40_.elt = param1;
                     _loc39_ = _loc40_;
                     _loc39_.next = _loc38_.head;
                     _loc38_.head = _loc39_;
                     _loc38_.modified = true;
                     _loc38_.length = _loc38_.length + 1;
                     param1;
                  }
                  if(param1.body.cbSet != null)
                  {
                     _loc38_ = mrca1;
                     _loc14_ = param1.body;
                     if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                     {
                        _loc40_ = new ZNPNode_ZPP_Interactor();
                     }
                     else
                     {
                        _loc40_ = ZNPNode_ZPP_Interactor.zpp_pool;
                        ZNPNode_ZPP_Interactor.zpp_pool = _loc40_.next;
                        _loc40_.next = null;
                     }
                     null;
                     _loc40_.elt = _loc14_;
                     _loc39_ = _loc40_;
                     _loc39_.next = _loc38_.head;
                     _loc38_.head = _loc39_;
                     _loc38_.modified = true;
                     _loc38_.length = _loc38_.length + 1;
                     _loc14_;
                  }
                  if(param2.cbSet != null)
                  {
                     _loc38_ = mrca2;
                     if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                     {
                        _loc40_ = new ZNPNode_ZPP_Interactor();
                     }
                     else
                     {
                        _loc40_ = ZNPNode_ZPP_Interactor.zpp_pool;
                        ZNPNode_ZPP_Interactor.zpp_pool = _loc40_.next;
                        _loc40_.next = null;
                     }
                     null;
                     _loc40_.elt = param2;
                     _loc39_ = _loc40_;
                     _loc39_.next = _loc38_.head;
                     _loc38_.head = _loc39_;
                     _loc38_.modified = true;
                     _loc38_.length = _loc38_.length + 1;
                     param2;
                  }
                  if(param2.body.cbSet != null)
                  {
                     _loc38_ = mrca2;
                     _loc14_ = param2.body;
                     if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                     {
                        _loc40_ = new ZNPNode_ZPP_Interactor();
                     }
                     else
                     {
                        _loc40_ = ZNPNode_ZPP_Interactor.zpp_pool;
                        ZNPNode_ZPP_Interactor.zpp_pool = _loc40_.next;
                        _loc40_.next = null;
                     }
                     null;
                     _loc40_.elt = _loc14_;
                     _loc39_ = _loc40_;
                     _loc39_.next = _loc38_.head;
                     _loc38_.head = _loc39_;
                     _loc38_.modified = true;
                     _loc38_.length = _loc38_.length + 1;
                     _loc14_;
                  }
                  _loc41_ = param1.body.compound;
                  _loc42_ = param2.body.compound;
                  while(_loc41_ != _loc42_)
                  {
                     _loc43_ = _loc41_ == null?0:_loc41_.depth;
                     _loc44_ = _loc42_ == null?0:_loc42_.depth;
                     if(_loc43_ < _loc44_)
                     {
                        if(_loc42_.cbSet != null)
                        {
                           _loc38_ = mrca2;
                           if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                           {
                              _loc40_ = new ZNPNode_ZPP_Interactor();
                           }
                           else
                           {
                              _loc40_ = ZNPNode_ZPP_Interactor.zpp_pool;
                              ZNPNode_ZPP_Interactor.zpp_pool = _loc40_.next;
                              _loc40_.next = null;
                           }
                           null;
                           _loc40_.elt = _loc42_;
                           _loc39_ = _loc40_;
                           _loc39_.next = _loc38_.head;
                           _loc38_.head = _loc39_;
                           _loc38_.modified = true;
                           _loc38_.length = _loc38_.length + 1;
                           _loc42_;
                        }
                        _loc42_ = _loc42_.compound;
                     }
                     else
                     {
                        if(_loc41_.cbSet != null)
                        {
                           _loc38_ = mrca1;
                           if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                           {
                              _loc40_ = new ZNPNode_ZPP_Interactor();
                           }
                           else
                           {
                              _loc40_ = ZNPNode_ZPP_Interactor.zpp_pool;
                              ZNPNode_ZPP_Interactor.zpp_pool = _loc40_.next;
                              _loc40_.next = null;
                           }
                           null;
                           _loc40_.elt = _loc41_;
                           _loc39_ = _loc40_;
                           _loc39_.next = _loc38_.head;
                           _loc38_.head = _loc39_;
                           _loc38_.modified = true;
                           _loc38_.length = _loc38_.length + 1;
                           _loc41_;
                        }
                        _loc41_ = _loc41_.compound;
                     }
                  }
                  _loc39_ = mrca1.head;
                  while(_loc39_ != null)
                  {
                     _loc14_ = _loc39_.elt;
                     _loc40_ = mrca2.head;
                     while(_loc40_ != null)
                     {
                        _loc45_ = _loc40_.elt;
                        _loc46_ = _loc14_.cbSet;
                        _loc47_ = _loc45_.cbSet;
                        _loc48_ = null;
                        _loc49_ = _loc46_.cbpairs.length < _loc47_.cbpairs.length?_loc46_.cbpairs:_loc47_.cbpairs;
                        _loc50_ = _loc49_.head;
                        while(_loc50_ != null)
                        {
                           _loc51_ = _loc50_.elt;
                           if(_loc51_.a == _loc46_ && _loc51_.b == _loc47_ || _loc51_.a == _loc47_ && _loc51_.b == _loc46_)
                           {
                              _loc48_ = _loc51_;
                              break;
                           }
                           _loc50_ = _loc50_.next;
                        }
                        if(_loc48_ == null)
                        {
                           if(ZPP_CbSetPair.zpp_pool == null)
                           {
                              _loc51_ = new ZPP_CbSetPair();
                           }
                           else
                           {
                              _loc51_ = ZPP_CbSetPair.zpp_pool;
                              ZPP_CbSetPair.zpp_pool = _loc51_.next;
                              _loc51_.next = null;
                           }
                           _loc51_.zip_listeners = true;
                           if(ZPP_CbSet.setlt(_loc46_,_loc47_))
                           {
                              _loc51_.a = _loc46_;
                              _loc51_.b = _loc47_;
                           }
                           else
                           {
                              _loc51_.a = _loc47_;
                              _loc51_.b = _loc46_;
                           }
                           _loc48_ = _loc51_;
                           _loc46_.cbpairs.add(_loc48_);
                           if(_loc47_ != _loc46_)
                           {
                              _loc47_.cbpairs.add(_loc48_);
                           }
                        }
                        if(_loc48_.zip_listeners)
                        {
                           _loc48_.zip_listeners = false;
                           _loc48_.__validate();
                        }
                        if(_loc48_.listeners.head == null)
                        {
                           _loc40_ = _loc40_.next;
                        }
                        else
                        {
                           _loc52_ = null;
                           _loc53_ = null;
                           _loc54_ = prelisteners;
                           while(_loc54_.head != null)
                           {
                              _loc55_ = _loc54_.head;
                              _loc54_.head = _loc55_.next;
                              _loc56_ = _loc55_;
                              _loc56_.elt = null;
                              _loc56_.next = ZNPNode_ZPP_InteractionListener.zpp_pool;
                              ZNPNode_ZPP_InteractionListener.zpp_pool = _loc56_;
                              if(_loc54_.head == null)
                              {
                                 _loc54_.pushmod = true;
                              }
                              _loc54_.modified = true;
                              _loc54_.length = _loc54_.length - 1;
                           }
                           _loc54_.pushmod = true;
                           _loc55_ = null;
                           _loc43_ = ZPP_Flags.id_CbEvent_PRE;
                           _loc48_ = null;
                           _loc49_ = _loc46_.cbpairs.length < _loc47_.cbpairs.length?_loc46_.cbpairs:_loc47_.cbpairs;
                           _loc50_ = _loc49_.head;
                           while(_loc50_ != null)
                           {
                              _loc51_ = _loc50_.elt;
                              if(_loc51_.a == _loc46_ && _loc51_.b == _loc47_ || _loc51_.a == _loc47_ && _loc51_.b == _loc46_)
                              {
                                 _loc48_ = _loc51_;
                                 break;
                              }
                              _loc50_ = _loc50_.next;
                           }
                           if(_loc48_ == null)
                           {
                              if(ZPP_CbSetPair.zpp_pool == null)
                              {
                                 _loc51_ = new ZPP_CbSetPair();
                              }
                              else
                              {
                                 _loc51_ = ZPP_CbSetPair.zpp_pool;
                                 ZPP_CbSetPair.zpp_pool = _loc51_.next;
                                 _loc51_.next = null;
                              }
                              _loc51_.zip_listeners = true;
                              if(ZPP_CbSet.setlt(_loc46_,_loc47_))
                              {
                                 _loc51_.a = _loc46_;
                                 _loc51_.b = _loc47_;
                              }
                              else
                              {
                                 _loc51_.a = _loc47_;
                                 _loc51_.b = _loc46_;
                              }
                              _loc48_ = _loc51_;
                              _loc46_.cbpairs.add(_loc48_);
                              if(_loc47_ != _loc46_)
                              {
                                 _loc47_.cbpairs.add(_loc48_);
                              }
                           }
                           if(_loc48_.zip_listeners)
                           {
                              _loc48_.zip_listeners = false;
                              _loc48_.__validate();
                           }
                           _loc56_ = _loc48_.listeners.head;
                           while(_loc56_ != null)
                           {
                              _loc57_ = _loc56_.elt;
                              if(_loc57_.event == _loc43_)
                              {
                                 if((_loc57_.itype & _loc34_) != 0)
                                 {
                                    _loc54_ = _loc5_.prelisteners;
                                    if(ZNPNode_ZPP_InteractionListener.zpp_pool == null)
                                    {
                                       _loc59_ = new ZNPNode_ZPP_InteractionListener();
                                    }
                                    else
                                    {
                                       _loc59_ = ZNPNode_ZPP_InteractionListener.zpp_pool;
                                       ZNPNode_ZPP_InteractionListener.zpp_pool = _loc59_.next;
                                       _loc59_.next = null;
                                    }
                                    null;
                                    _loc59_.elt = _loc57_;
                                    _loc58_ = _loc59_;
                                    if(_loc55_ == null)
                                    {
                                       _loc58_.next = _loc54_.head;
                                       _loc54_.head = _loc58_;
                                    }
                                    else
                                    {
                                       _loc58_.next = _loc55_.next;
                                       _loc55_.next = _loc58_;
                                    }
                                    _loc60_ = true;
                                    _loc54_.modified = _loc60_;
                                    _loc54_.pushmod = _loc60_;
                                    _loc54_.length = _loc54_.length + 1;
                                    _loc55_ = _loc58_;
                                    _loc30_ = _loc30_ || !_loc57_.pure;
                                 }
                              }
                              _loc56_ = _loc56_.next;
                           }
                           if(prelisteners.head == null)
                           {
                              _loc40_ = _loc40_.next;
                           }
                           else
                           {
                              _loc52_ = ZPP_Interactor.get(_loc14_,_loc45_);
                              if(_loc52_ == null)
                              {
                                 _loc53_ = ZPP_CallbackSet.get(_loc14_,_loc45_);
                                 add_callbackset(_loc53_);
                              }
                              if(_loc52_ == null || _loc52_.FLUIDstamp != stamp && (_loc52_.FLUIDstate & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                              {
                                 if(_loc53_ != null)
                                 {
                                    _loc52_ = _loc53_;
                                 }
                                 if(_loc52_ != null)
                                 {
                                    _loc56_ = prelisteners.head;
                                    while(_loc56_ != null)
                                    {
                                       _loc57_ = _loc56_.elt;
                                       if(_loc57_.itype == ZPP_Flags.id_InteractionType_ANY)
                                       {
                                          _loc52_.COLLISIONstamp = stamp;
                                          _loc52_.SENSORstamp = stamp;
                                          _loc52_.FLUIDstamp = stamp;
                                       }
                                       else
                                       {
                                          _loc52_.FLUIDstamp = stamp;
                                       }
                                       _loc56_ = _loc56_.next;
                                    }
                                 }
                                 _loc60_ = _loc26_.active;
                                 _loc26_.active = true;
                                 _loc61_ = false;
                                 precb.zpp_inner.pre_arbiter = _loc26_;
                                 precb.zpp_inner.set = _loc52_;
                                 _loc56_ = prelisteners.head;
                                 while(_loc56_ != null)
                                 {
                                    _loc57_ = _loc56_.elt;
                                    precb.zpp_inner.listener = _loc57_;
                                    if(_loc52_.int1 == null)
                                    {
                                       _loc62_ = "";
                                       _loc62_ = _loc62_ + "OKAY WTF IS HAPPENING HERE\n";
                                       _loc62_ = _loc62_ + ("ncallbackset is null? " + (_loc53_ == null?"yes":"no") + "\n");
                                       _loc62_ = _loc62_ + "assuming yes, let\'s find callbacksets on interactor\n";
                                       _loc62_ = _loc62_ + ("i1 (id=" + _loc14_.id + "):\n");
                                       _loc63_ = _loc14_.cbsets.head;
                                       while(_loc63_ != null)
                                       {
                                          _loc64_ = _loc63_.elt;
                                          _loc62_ = _loc62_ + ("  (" + _loc64_.id + " " + (_loc64_.int1 == null?"null":"") + "," + _loc64_.di + " " + (_loc64_.int2 == null?"null":"") + ") arbs size=" + _loc64_.arbiters.length + " freed=" + Std.string(_loc64_.freed) + " lazydel=" + Std.string(_loc64_.lazydel) + "\n");
                                          _loc63_ = _loc63_.next;
                                       }
                                       _loc62_ = _loc62_ + ("i2 (id=" + _loc45_.id + "):\n");
                                       _loc63_ = _loc45_.cbsets.head;
                                       while(_loc63_ != null)
                                       {
                                          _loc64_ = _loc63_.elt;
                                          _loc62_ = _loc62_ + ("  (" + _loc64_.id + " " + (_loc64_.int1 == null?"null":"") + "," + _loc64_.di + " " + (_loc64_.int2 == null?"null":"") + ") arbs size=" + _loc64_.arbiters.length + " freed=" + Std.string(_loc64_.freed) + " lazydel=" + Std.string(_loc64_.lazydel) + "\n");
                                          _loc63_ = _loc63_.next;
                                       }
                                       Boot.lastError = new Error();
                                       throw _loc62_;
                                    }
                                    _loc65_ = precb.zpp_inner;
                                    _loc66_ = _loc52_.int1;
                                    _loc67_ = _loc52_.int2;
                                    _loc68_ = _loc57_.options1;
                                    _loc69_ = _loc66_.cbTypes;
                                    if(!!_loc68_.nonemptyintersection(_loc69_,_loc68_.includes) && !_loc68_.nonemptyintersection(_loc69_,_loc68_.excludes) && (!!_loc68_.nonemptyintersection(_loc69_,_loc68_.includes) && !_loc68_.nonemptyintersection(_loc69_,_loc68_.excludes)))
                                    {
                                       _loc65_.int1 = _loc66_;
                                       _loc65_.int2 = _loc67_;
                                    }
                                    else
                                    {
                                       _loc65_.int1 = _loc67_;
                                       _loc65_.int2 = _loc66_;
                                    }
                                    precb.zpp_inner.pre_swapped = _loc14_ != precb.zpp_inner.int1;
                                    _loc70_ = _loc57_.handlerp(precb);
                                    if(_loc70_ != null)
                                    {
                                       §§push(_loc26_);
                                       §§push(_loc70_);
                                       if(ZPP_Flags.PreFlag_ACCEPT == null)
                                       {
                                          ZPP_Flags.§internal§ = true;
                                          ZPP_Flags.PreFlag_ACCEPT = new PreFlag();
                                          ZPP_Flags.§internal§ = false;
                                       }
                                       if(§§pop() == ZPP_Flags.PreFlag_ACCEPT)
                                       {
                                          §§push(ZPP_Flags.id_ImmState_ACCEPT | ZPP_Flags.id_ImmState_ALWAYS);
                                       }
                                       else
                                       {
                                          §§push(_loc70_);
                                          if(ZPP_Flags.PreFlag_ACCEPT_ONCE == null)
                                          {
                                             ZPP_Flags.§internal§ = true;
                                             ZPP_Flags.PreFlag_ACCEPT_ONCE = new PreFlag();
                                             ZPP_Flags.§internal§ = false;
                                          }
                                          if(§§pop() == ZPP_Flags.PreFlag_ACCEPT_ONCE)
                                          {
                                             §§push(ZPP_Flags.id_ImmState_ACCEPT);
                                          }
                                          else
                                          {
                                             §§push(_loc70_);
                                             if(ZPP_Flags.PreFlag_IGNORE == null)
                                             {
                                                ZPP_Flags.§internal§ = true;
                                                ZPP_Flags.PreFlag_IGNORE = new PreFlag();
                                                ZPP_Flags.§internal§ = false;
                                             }
                                             §§push(§§pop() == ZPP_Flags.PreFlag_IGNORE?ZPP_Flags.id_ImmState_IGNORE | ZPP_Flags.id_ImmState_ALWAYS:ZPP_Flags.id_ImmState_IGNORE);
                                          }
                                       }
                                       §§pop().immState = §§pop();
                                    }
                                    _loc56_ = _loc56_.next;
                                 }
                                 if((_loc26_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
                                 {
                                    if(_loc26_.type == ZPP_Arbiter.COL)
                                    {
                                       _loc71_ = _loc26_.colarb;
                                       _loc72_ = Number(_loc71_.nx * _loc71_.nx + _loc71_.ny * _loc71_.ny);
                                       _loc73_ = 1 / Math.sqrt(_loc72_);
                                       _loc71_.nx = _loc71_.nx * _loc73_;
                                       _loc71_.ny = _loc71_.ny * _loc73_;
                                    }
                                 }
                                 _loc26_.active = _loc60_;
                                 if(_loc52_ != null)
                                 {
                                    _loc56_ = prelisteners.head;
                                    while(_loc56_ != null)
                                    {
                                       _loc57_ = _loc56_.elt;
                                       if(_loc57_.itype == ZPP_Flags.id_InteractionType_ANY)
                                       {
                                          _loc52_.COLLISIONstate = _loc26_.immState;
                                          _loc52_.SENSORstate = _loc26_.immState;
                                          _loc52_.FLUIDstate = _loc26_.immState;
                                       }
                                       else
                                       {
                                          _loc52_.FLUIDstate = _loc26_.immState;
                                       }
                                       _loc56_ = _loc56_.next;
                                    }
                                 }
                              }
                              else if(_loc52_ == null)
                              {
                                 if((_loc26_.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                                 {
                                    _loc26_.immState = ZPP_Flags.id_ImmState_ACCEPT;
                                 }
                              }
                              else
                              {
                                 _loc26_.immState = _loc52_.FLUIDstate;
                              }
                              _loc40_ = _loc40_.next;
                           }
                        }
                     }
                     _loc39_ = _loc39_.next;
                  }
                  if(!!_loc30_ && (_loc26_.immState & ZPP_Flags.id_ImmState_ALWAYS) == 0)
                  {
                     if(_loc26_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                     {
                        _loc23_ = _loc26_.b1;
                        if(!_loc23_.world)
                        {
                           _loc23_.component.waket = stamp + (!!midstep?0:1);
                           if(_loc23_.component.sleeping)
                           {
                              really_wake(_loc23_,false);
                           }
                        }
                     }
                     if(_loc26_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
                     {
                        _loc23_ = _loc26_.b2;
                        if(!_loc23_.world)
                        {
                           _loc23_.component.waket = stamp + (!!midstep?0:1);
                           if(_loc23_.component.sleeping)
                           {
                              really_wake(_loc23_,false);
                           }
                        }
                     }
                  }
               }
               if((_loc26_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
               {
                  if(_loc26_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc26_.b1.component.sleeping)
                  {
                     _loc23_ = _loc26_.b1;
                     if(!_loc23_.world)
                     {
                        _loc23_.component.waket = stamp + (!!midstep?0:1);
                        if(_loc23_.component.sleeping)
                        {
                           really_wake(_loc23_,false);
                        }
                     }
                  }
                  if(_loc26_.b2.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc26_.b2.component.sleeping)
                  {
                     _loc23_ = _loc26_.b2;
                     if(!_loc23_.world)
                     {
                        _loc23_.component.waket = stamp + (!!midstep?0:1);
                        if(_loc23_.component.sleeping)
                        {
                           really_wake(_loc23_,false);
                        }
                     }
                  }
               }
               if(_loc26_.sleeping)
               {
                  _loc26_.sleeping = false;
                  _loc35_ = f_arbiters;
                  if(ZNPNode_ZPP_FluidArbiter.zpp_pool == null)
                  {
                     _loc37_ = new ZNPNode_ZPP_FluidArbiter();
                  }
                  else
                  {
                     _loc37_ = ZNPNode_ZPP_FluidArbiter.zpp_pool;
                     ZNPNode_ZPP_FluidArbiter.zpp_pool = _loc37_.next;
                     _loc37_.next = null;
                  }
                  null;
                  _loc37_.elt = _loc26_;
                  _loc36_ = _loc37_;
                  _loc36_.next = _loc35_.head;
                  _loc35_.head = _loc36_;
                  _loc35_.modified = true;
                  _loc35_.length = _loc35_.length + 1;
                  _loc26_;
               }
               §§push(_loc26_);
            }
            else if(_loc16_)
            {
               _loc74_ = _loc26_;
               _loc74_.next = ZPP_FluidArbiter.zpp_pool;
               ZPP_FluidArbiter.zpp_pool = _loc74_;
               §§push(null);
            }
            else
            {
               §§push(null);
            }
         }
         else
         {
            §§push(null);
         }
         _loc6_ = §§pop();
         return _loc6_;
      }
      
      public function listeners_subber(param1:Listener) : void
      {
         remListener(param1.zpp_inner);
      }
      
      public function listeners_adder(param1:Listener) : Boolean
      {
         if(param1.zpp_inner.space != this)
         {
            if(param1.zpp_inner.space != null)
            {
               param1.zpp_inner.space.outer.zpp_inner.wrap_listeners.remove(param1);
            }
            addListener(param1.zpp_inner);
            return true;
         }
         return false;
      }
      
      public function iterateVel(param1:int, param2:Boolean) : void
      {
         var _loc5_:int = 0;
         var _loc6_:* = null as ZNPNode_ZPP_FluidArbiter;
         var _loc7_:* = null as ZPP_FluidArbiter;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:* = null as ZNPNode_ZPP_Constraint;
         var _loc14_:* = null as ZNPNode_ZPP_Constraint;
         var _loc15_:* = null as ZPP_Constraint;
         var _loc16_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc17_:Boolean = false;
         var _loc18_:* = null as ZPP_ColArbiter;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc3_:Number = !!param2?1:0;
         var _loc4_:int = 0;
         while(_loc4_ < param1)
         {
            _loc4_++;
            _loc5_ = _loc4_;
            _loc6_ = f_arbiters.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_.elt;
               if(!!_loc7_.active && (_loc7_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
               {
                  if(!_loc7_.nodrag)
                  {
                     _loc8_ = Number(_loc7_.b1.angvel + _loc7_.b1.kinangvel);
                     _loc9_ = Number(_loc7_.b2.angvel + _loc7_.b2.kinangvel);
                     _loc10_ = _loc7_.b1.velx + _loc7_.b1.kinvelx - _loc7_.r1y * _loc8_ - (_loc7_.b2.velx + _loc7_.b2.kinvelx - _loc7_.r2y * _loc9_);
                     _loc11_ = Number(Number(_loc7_.b1.vely + _loc7_.b1.kinvely) + _loc7_.r1x * _loc8_) - (Number(Number(_loc7_.b2.vely + _loc7_.b2.kinvely) + _loc7_.r2x * _loc9_));
                     _loc12_ = Number(_loc7_.vMassa * _loc10_ + _loc7_.vMassb * _loc11_);
                     _loc11_ = Number(_loc7_.vMassb * _loc10_ + _loc7_.vMassc * _loc11_);
                     _loc10_ = _loc12_;
                     _loc12_ = _loc7_.lgamma;
                     _loc10_ = _loc10_ - _loc7_.dampx * _loc12_;
                     _loc11_ = _loc11_ - _loc7_.dampy * _loc12_;
                     _loc12_ = 1;
                     _loc7_.dampx = Number(_loc7_.dampx + _loc10_ * _loc12_);
                     _loc7_.dampy = Number(_loc7_.dampy + _loc11_ * _loc12_);
                     _loc12_ = _loc7_.b1.imass;
                     _loc7_.b1.velx = _loc7_.b1.velx - _loc10_ * _loc12_;
                     _loc7_.b1.vely = _loc7_.b1.vely - _loc11_ * _loc12_;
                     _loc12_ = _loc7_.b2.imass;
                     _loc7_.b2.velx = Number(_loc7_.b2.velx + _loc10_ * _loc12_);
                     _loc7_.b2.vely = Number(_loc7_.b2.vely + _loc11_ * _loc12_);
                     _loc7_.b1.angvel = _loc7_.b1.angvel - _loc7_.b1.iinertia * (_loc11_ * _loc7_.r1x - _loc10_ * _loc7_.r1y);
                     _loc7_.b2.angvel = Number(_loc7_.b2.angvel + _loc7_.b2.iinertia * (_loc11_ * _loc7_.r2x - _loc10_ * _loc7_.r2y));
                     _loc12_ = (_loc8_ - _loc9_) * _loc7_.wMass - _loc7_.adamp * _loc7_.agamma;
                     _loc7_.adamp = Number(_loc7_.adamp + _loc12_);
                     _loc7_.b1.angvel = _loc7_.b1.angvel - _loc12_ * _loc7_.b1.iinertia;
                     _loc7_.b2.angvel = Number(_loc7_.b2.angvel + _loc12_ * _loc7_.b2.iinertia);
                  }
               }
               _loc6_ = _loc6_.next;
            }
            _loc13_ = null;
            _loc14_ = live_constraints.head;
            while(_loc14_ != null)
            {
               _loc15_ = _loc14_.elt;
               if(_loc15_.applyImpulseVel())
               {
                  _loc14_ = live_constraints.erase(_loc13_);
                  constraintCbBreak(_loc15_);
                  if(_loc15_.removeOnBreak)
                  {
                     _loc15_.component.sleeping = true;
                     midstep = false;
                     if(_loc15_.compound != null)
                     {
                        _loc15_.compound.wrap_constraints.remove(_loc15_.outer);
                     }
                     else
                     {
                        wrap_constraints.remove(_loc15_.outer);
                     }
                     midstep = true;
                  }
                  else
                  {
                     _loc15_.active = false;
                  }
                  _loc15_.clearcache();
               }
               else
               {
                  _loc13_ = _loc14_;
                  _loc14_ = _loc14_.next;
               }
            }
            _loc16_ = c_arbiters_false.head;
            _loc17_ = true;
            if(_loc16_ == null)
            {
               _loc16_ = c_arbiters_true.head;
               _loc17_ = false;
            }
            while(_loc16_ != null)
            {
               _loc18_ = _loc16_.elt;
               if(!!_loc18_.active && (_loc18_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
               {
                  _loc20_ = _loc18_.k1x + _loc18_.b2.velx - _loc18_.c1.r2y * _loc18_.b2.angvel - (_loc18_.b1.velx - _loc18_.c1.r1y * _loc18_.b1.angvel);
                  _loc21_ = Number(Number(_loc18_.k1y + _loc18_.b2.vely) + _loc18_.c1.r2x * _loc18_.b2.angvel) - (Number(_loc18_.b1.vely + _loc18_.c1.r1x * _loc18_.b1.angvel));
                  if(_loc18_.hc2)
                  {
                     _loc22_ = _loc18_.k2x + _loc18_.b2.velx - _loc18_.c2.r2y * _loc18_.b2.angvel - (_loc18_.b1.velx - _loc18_.c2.r1y * _loc18_.b1.angvel);
                     _loc23_ = Number(Number(_loc18_.k2y + _loc18_.b2.vely) + _loc18_.c2.r2x * _loc18_.b2.angvel) - (Number(_loc18_.b1.vely + _loc18_.c2.r1x * _loc18_.b1.angvel));
                     _loc24_ = _loc18_.c1.jnAcc;
                     _loc25_ = _loc18_.c2.jnAcc;
                     _loc26_ = Number(Number(Number(_loc20_ * _loc18_.nx + _loc21_ * _loc18_.ny) + _loc18_.surfacey) + _loc3_ * _loc18_.c1.bounce) - (Number(_loc18_.Ka * _loc24_ + _loc18_.Kb * _loc25_));
                     _loc27_ = Number(Number(Number(_loc22_ * _loc18_.nx + _loc23_ * _loc18_.ny) + _loc18_.surfacey) + _loc3_ * _loc18_.c2.bounce) - (Number(_loc18_.Kb * _loc24_ + _loc18_.Kc * _loc25_));
                     _loc28_ = -(_loc18_.kMassa * _loc26_ + _loc18_.kMassb * _loc27_);
                     _loc29_ = -(_loc18_.kMassb * _loc26_ + _loc18_.kMassc * _loc27_);
                     if(_loc28_ >= 0 && _loc29_ >= 0)
                     {
                        _loc26_ = _loc28_ - _loc24_;
                        _loc27_ = _loc29_ - _loc25_;
                        _loc18_.c1.jnAcc = _loc28_;
                        _loc18_.c2.jnAcc = _loc29_;
                     }
                     else
                     {
                        _loc28_ = -_loc18_.c1.nMass * _loc26_;
                        if(_loc28_ >= 0 && Number(_loc18_.Kb * _loc28_ + _loc27_) >= 0)
                        {
                           _loc26_ = _loc28_ - _loc24_;
                           _loc27_ = -_loc25_;
                           _loc18_.c1.jnAcc = _loc28_;
                           _loc18_.c2.jnAcc = 0;
                        }
                        else
                        {
                           _loc29_ = -_loc18_.c2.nMass * _loc27_;
                           if(_loc29_ >= 0 && Number(_loc18_.Kb * _loc29_ + _loc26_) >= 0)
                           {
                              _loc26_ = -_loc24_;
                              _loc27_ = _loc29_ - _loc25_;
                              _loc18_.c1.jnAcc = 0;
                              _loc18_.c2.jnAcc = _loc29_;
                           }
                           else if(_loc26_ >= 0 && _loc27_ >= 0)
                           {
                              _loc26_ = -_loc24_;
                              _loc27_ = -_loc25_;
                              _loc30_ = 0;
                              _loc18_.c2.jnAcc = _loc30_;
                              _loc18_.c1.jnAcc = _loc30_;
                           }
                        }
                     }
                     _loc10_ = Number(_loc26_ + _loc27_);
                     _loc8_ = _loc18_.nx * _loc10_;
                     _loc9_ = _loc18_.ny * _loc10_;
                     _loc18_.b2.velx = Number(_loc18_.b2.velx + _loc8_ * _loc18_.b2.imass);
                     _loc18_.b2.vely = Number(_loc18_.b2.vely + _loc9_ * _loc18_.b2.imass);
                     _loc18_.b1.velx = _loc18_.b1.velx - _loc8_ * _loc18_.b1.imass;
                     _loc18_.b1.vely = _loc18_.b1.vely - _loc9_ * _loc18_.b1.imass;
                     _loc18_.b2.angvel = Number(_loc18_.b2.angvel + (_loc18_.rn1b * _loc26_ + _loc18_.rn2b * _loc27_) * _loc18_.b2.iinertia);
                     _loc18_.b1.angvel = _loc18_.b1.angvel - (_loc18_.rn1a * _loc26_ + _loc18_.rn2a * _loc27_) * _loc18_.b1.iinertia;
                     _loc20_ = _loc18_.k1x + _loc18_.b2.velx - _loc18_.c1.r2y * _loc18_.b2.angvel - (_loc18_.b1.velx - _loc18_.c1.r1y * _loc18_.b1.angvel);
                     _loc21_ = Number(Number(_loc18_.k1y + _loc18_.b2.vely) + _loc18_.c1.r2x * _loc18_.b2.angvel) - (Number(_loc18_.b1.vely + _loc18_.c1.r1x * _loc18_.b1.angvel));
                     _loc10_ = (_loc21_ * _loc18_.nx - _loc20_ * _loc18_.ny + _loc18_.surfacex) * _loc18_.c1.tMass;
                     _loc11_ = _loc18_.c1.friction * _loc18_.c1.jnAcc;
                     _loc12_ = _loc18_.c1.jtAcc;
                     _loc19_ = _loc12_ - _loc10_;
                     if(_loc19_ > _loc11_)
                     {
                        _loc19_ = _loc11_;
                     }
                     else if(_loc19_ < -_loc11_)
                     {
                        _loc19_ = -_loc11_;
                     }
                     _loc10_ = _loc19_ - _loc12_;
                     _loc18_.c1.jtAcc = _loc19_;
                     _loc8_ = -_loc18_.ny * _loc10_;
                     _loc9_ = _loc18_.nx * _loc10_;
                     _loc18_.b2.velx = Number(_loc18_.b2.velx + _loc8_ * _loc18_.b2.imass);
                     _loc18_.b2.vely = Number(_loc18_.b2.vely + _loc9_ * _loc18_.b2.imass);
                     _loc18_.b1.velx = _loc18_.b1.velx - _loc8_ * _loc18_.b1.imass;
                     _loc18_.b1.vely = _loc18_.b1.vely - _loc9_ * _loc18_.b1.imass;
                     _loc18_.b2.angvel = Number(_loc18_.b2.angvel + _loc18_.rt1b * _loc10_ * _loc18_.b2.iinertia);
                     _loc18_.b1.angvel = _loc18_.b1.angvel - _loc18_.rt1a * _loc10_ * _loc18_.b1.iinertia;
                     _loc22_ = _loc18_.k2x + _loc18_.b2.velx - _loc18_.c2.r2y * _loc18_.b2.angvel - (_loc18_.b1.velx - _loc18_.c2.r1y * _loc18_.b1.angvel);
                     _loc23_ = Number(Number(_loc18_.k2y + _loc18_.b2.vely) + _loc18_.c2.r2x * _loc18_.b2.angvel) - (Number(_loc18_.b1.vely + _loc18_.c2.r1x * _loc18_.b1.angvel));
                     _loc10_ = (_loc23_ * _loc18_.nx - _loc22_ * _loc18_.ny + _loc18_.surfacex) * _loc18_.c2.tMass;
                     _loc11_ = _loc18_.c2.friction * _loc18_.c2.jnAcc;
                     _loc12_ = _loc18_.c2.jtAcc;
                     _loc19_ = _loc12_ - _loc10_;
                     if(_loc19_ > _loc11_)
                     {
                        _loc19_ = _loc11_;
                     }
                     else if(_loc19_ < -_loc11_)
                     {
                        _loc19_ = -_loc11_;
                     }
                     _loc10_ = _loc19_ - _loc12_;
                     _loc18_.c2.jtAcc = _loc19_;
                     _loc8_ = -_loc18_.ny * _loc10_;
                     _loc9_ = _loc18_.nx * _loc10_;
                     _loc18_.b2.velx = Number(_loc18_.b2.velx + _loc8_ * _loc18_.b2.imass);
                     _loc18_.b2.vely = Number(_loc18_.b2.vely + _loc9_ * _loc18_.b2.imass);
                     _loc18_.b1.velx = _loc18_.b1.velx - _loc8_ * _loc18_.b1.imass;
                     _loc18_.b1.vely = _loc18_.b1.vely - _loc9_ * _loc18_.b1.imass;
                     _loc18_.b2.angvel = Number(_loc18_.b2.angvel + _loc18_.rt2b * _loc10_ * _loc18_.b2.iinertia);
                     _loc18_.b1.angvel = _loc18_.b1.angvel - _loc18_.rt2a * _loc10_ * _loc18_.b1.iinertia;
                  }
                  else
                  {
                     _loc10_ = (Number(_loc3_ * _loc18_.c1.bounce + (Number(_loc18_.nx * _loc20_ + _loc18_.ny * _loc21_))) + _loc18_.surfacey) * _loc18_.c1.nMass;
                     _loc12_ = _loc18_.c1.jnAcc;
                     _loc19_ = _loc12_ - _loc10_;
                     if(_loc19_ < 0)
                     {
                        _loc19_ = 0;
                     }
                     _loc10_ = _loc19_ - _loc12_;
                     _loc18_.c1.jnAcc = _loc19_;
                     _loc8_ = _loc18_.nx * _loc10_;
                     _loc9_ = _loc18_.ny * _loc10_;
                     _loc18_.b2.velx = Number(_loc18_.b2.velx + _loc8_ * _loc18_.b2.imass);
                     _loc18_.b2.vely = Number(_loc18_.b2.vely + _loc9_ * _loc18_.b2.imass);
                     _loc18_.b1.velx = _loc18_.b1.velx - _loc8_ * _loc18_.b1.imass;
                     _loc18_.b1.vely = _loc18_.b1.vely - _loc9_ * _loc18_.b1.imass;
                     _loc18_.b2.angvel = Number(_loc18_.b2.angvel + _loc18_.rn1b * _loc10_ * _loc18_.b2.iinertia);
                     _loc18_.b1.angvel = _loc18_.b1.angvel - _loc18_.rn1a * _loc10_ * _loc18_.b1.iinertia;
                     _loc20_ = _loc18_.k1x + _loc18_.b2.velx - _loc18_.c1.r2y * _loc18_.b2.angvel - (_loc18_.b1.velx - _loc18_.c1.r1y * _loc18_.b1.angvel);
                     _loc21_ = Number(Number(_loc18_.k1y + _loc18_.b2.vely) + _loc18_.c1.r2x * _loc18_.b2.angvel) - (Number(_loc18_.b1.vely + _loc18_.c1.r1x * _loc18_.b1.angvel));
                     _loc10_ = (_loc21_ * _loc18_.nx - _loc20_ * _loc18_.ny + _loc18_.surfacex) * _loc18_.c1.tMass;
                     _loc11_ = _loc18_.c1.friction * _loc18_.c1.jnAcc;
                     _loc12_ = _loc18_.c1.jtAcc;
                     _loc19_ = _loc12_ - _loc10_;
                     if(_loc19_ > _loc11_)
                     {
                        _loc19_ = _loc11_;
                     }
                     else if(_loc19_ < -_loc11_)
                     {
                        _loc19_ = -_loc11_;
                     }
                     _loc10_ = _loc19_ - _loc12_;
                     _loc18_.c1.jtAcc = _loc19_;
                     _loc8_ = -_loc18_.ny * _loc10_;
                     _loc9_ = _loc18_.nx * _loc10_;
                     _loc18_.b2.velx = Number(_loc18_.b2.velx + _loc8_ * _loc18_.b2.imass);
                     _loc18_.b2.vely = Number(_loc18_.b2.vely + _loc9_ * _loc18_.b2.imass);
                     _loc18_.b1.velx = _loc18_.b1.velx - _loc8_ * _loc18_.b1.imass;
                     _loc18_.b1.vely = _loc18_.b1.vely - _loc9_ * _loc18_.b1.imass;
                     _loc18_.b2.angvel = Number(_loc18_.b2.angvel + _loc18_.rt1b * _loc10_ * _loc18_.b2.iinertia);
                     _loc18_.b1.angvel = _loc18_.b1.angvel - _loc18_.rt1a * _loc10_ * _loc18_.b1.iinertia;
                     if(_loc18_.radius != 0)
                     {
                        _loc22_ = _loc18_.b2.angvel - _loc18_.b1.angvel;
                        _loc10_ = _loc22_ * _loc18_.rMass;
                        _loc11_ = _loc18_.rfric * _loc18_.c1.jnAcc;
                        _loc12_ = _loc18_.jrAcc;
                        _loc18_.jrAcc = _loc18_.jrAcc - _loc10_;
                        if(_loc18_.jrAcc > _loc11_)
                        {
                           _loc18_.jrAcc = _loc11_;
                        }
                        else if(_loc18_.jrAcc < -_loc11_)
                        {
                           _loc18_.jrAcc = -_loc11_;
                        }
                        _loc10_ = _loc18_.jrAcc - _loc12_;
                        _loc18_.b2.angvel = Number(_loc18_.b2.angvel + _loc10_ * _loc18_.b2.iinertia);
                        _loc18_.b1.angvel = _loc18_.b1.angvel - _loc10_ * _loc18_.b1.iinertia;
                     }
                  }
               }
               _loc16_ = _loc16_.next;
               if(!!_loc17_ && _loc16_ == null)
               {
                  _loc16_ = c_arbiters_true.head;
                  _loc17_ = false;
               }
            }
         }
      }
      
      public function iteratePos(param1:int) : void
      {
         var _loc3_:int = 0;
         var _loc4_:* = null as ZNPNode_ZPP_Constraint;
         var _loc5_:* = null as ZNPNode_ZPP_Constraint;
         var _loc6_:* = null as ZPP_Constraint;
         var _loc7_:* = null as ZNPNode_ZPP_ColArbiter;
         var _loc8_:Boolean = false;
         var _loc9_:* = null as ZPP_ColArbiter;
         var _loc10_:* = null as ZPP_IContact;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:* = null as ZPP_Body;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:Number = NaN;
         var _loc39_:Number = NaN;
         var _loc40_:Number = NaN;
         var _loc41_:Number = NaN;
         var _loc42_:Number = NaN;
         var _loc43_:Number = NaN;
         var _loc44_:Number = NaN;
         var _loc45_:Number = NaN;
         var _loc46_:Number = NaN;
         var _loc47_:Number = NaN;
         var _loc48_:Number = NaN;
         var _loc2_:int = 0;
         while(_loc2_ < param1)
         {
            _loc2_++;
            _loc3_ = _loc2_;
            _loc4_ = null;
            _loc5_ = live_constraints.head;
            while(_loc5_ != null)
            {
               _loc6_ = _loc5_.elt;
               if(!_loc6_.__velocity && _loc6_.stiff)
               {
                  if(_loc6_.applyImpulsePos())
                  {
                     _loc5_ = live_constraints.erase(_loc4_);
                     constraintCbBreak(_loc6_);
                     if(_loc6_.removeOnBreak)
                     {
                        _loc6_.component.sleeping = true;
                        midstep = false;
                        if(_loc6_.compound != null)
                        {
                           _loc6_.compound.wrap_constraints.remove(_loc6_.outer);
                        }
                        else
                        {
                           wrap_constraints.remove(_loc6_.outer);
                        }
                        midstep = true;
                     }
                     else
                     {
                        _loc6_.active = false;
                     }
                     _loc6_.clearcache();
                     continue;
                  }
               }
               _loc4_ = _loc5_;
               _loc5_ = _loc5_.next;
            }
            _loc7_ = c_arbiters_false.head;
            _loc8_ = true;
            if(_loc7_ == null)
            {
               _loc7_ = c_arbiters_true.head;
               _loc8_ = false;
            }
            while(_loc7_ != null)
            {
               _loc9_ = _loc7_.elt;
               if(!!_loc9_.active && (_loc9_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
               {
                  if(_loc9_.ptype == 2)
                  {
                     _loc10_ = _loc9_.c1;
                     _loc13_ = _loc9_.b2.axisy * _loc10_.lr2x - _loc9_.b2.axisx * _loc10_.lr2y;
                     _loc14_ = Number(_loc10_.lr2x * _loc9_.b2.axisx + _loc10_.lr2y * _loc9_.b2.axisy);
                     _loc15_ = 1;
                     _loc13_ = Number(_loc13_ + _loc9_.b2.posx * _loc15_);
                     _loc14_ = Number(_loc14_ + _loc9_.b2.posy * _loc15_);
                     _loc15_ = _loc9_.b1.axisy * _loc10_.lr1x - _loc9_.b1.axisx * _loc10_.lr1y;
                     _loc16_ = Number(_loc10_.lr1x * _loc9_.b1.axisx + _loc10_.lr1y * _loc9_.b1.axisy);
                     _loc17_ = 1;
                     _loc15_ = Number(_loc15_ + _loc9_.b1.posx * _loc17_);
                     _loc16_ = Number(_loc16_ + _loc9_.b1.posy * _loc17_);
                     _loc17_ = _loc13_ - _loc15_;
                     _loc18_ = _loc14_ - _loc16_;
                     _loc19_ = Number(_loc17_ * _loc17_ + _loc18_ * _loc18_);
                     _loc20_ = _loc9_.radius - 0.25;
                     if(_loc19_ < _loc20_ * _loc20_)
                     {
                        if(_loc19_ < 1.0e-8 * 1.0e-8)
                        {
                           if(_loc9_.b1.smass != 0)
                           {
                              _loc9_.b1.posx = Number(_loc9_.b1.posx + 1.0e-7);
                           }
                           else
                           {
                              _loc9_.b2.posx = Number(_loc9_.b2.posx + 1.0e-7);
                           }
                        }
                        else
                        {
                           if(_loc19_ == 0)
                           {
                              §§push(0);
                           }
                           else
                           {
                              sf32(_loc19_,0);
                              si32(1597463007 - (li32(0) >> 1),0);
                              _loc21_ = lf32(0);
                              §§push(1 / (_loc21_ * (1.5 - 0.5 * _loc19_ * _loc21_ * _loc21_)));
                           }
                           _loc19_ = §§pop();
                           _loc21_ = 1 / _loc19_;
                           _loc17_ = _loc17_ * _loc21_;
                           _loc18_ = _loc18_ * _loc21_;
                           _loc21_ = 0.5 * (_loc15_ + _loc13_);
                           _loc22_ = 0.5 * (_loc16_ + _loc14_);
                           _loc23_ = _loc19_ - _loc20_;
                           _loc15_ = _loc21_ - _loc9_.b1.posx;
                           _loc16_ = _loc22_ - _loc9_.b1.posy;
                           _loc13_ = _loc21_ - _loc9_.b2.posx;
                           _loc14_ = _loc22_ - _loc9_.b2.posy;
                           _loc24_ = _loc18_ * _loc15_ - _loc17_ * _loc16_;
                           _loc25_ = _loc18_ * _loc13_ - _loc17_ * _loc14_;
                           _loc26_ = Number(Number(Number(_loc9_.b2.smass + _loc25_ * _loc25_ * _loc9_.b2.sinertia) + _loc9_.b1.smass) + _loc24_ * _loc24_ * _loc9_.b1.sinertia);
                           if(_loc26_ != 0)
                           {
                              _loc27_ = -_loc9_.c1.biasCoef * _loc23_ / _loc26_;
                              _loc30_ = _loc27_;
                              _loc28_ = _loc17_ * _loc30_;
                              _loc29_ = _loc18_ * _loc30_;
                              _loc30_ = _loc9_.b1.imass;
                              _loc9_.b1.posx = _loc9_.b1.posx - _loc28_ * _loc30_;
                              _loc9_.b1.posy = _loc9_.b1.posy - _loc29_ * _loc30_;
                              _loc31_ = _loc9_.b1;
                              _loc30_ = -_loc24_ * _loc9_.b1.iinertia * _loc27_;
                              _loc31_.rot = Number(_loc31_.rot + _loc30_);
                              if(_loc30_ * _loc30_ > 0.0001)
                              {
                                 _loc31_.axisx = Number(Math.sin(_loc31_.rot));
                                 _loc31_.axisy = Number(Math.cos(_loc31_.rot));
                                 null;
                              }
                              else
                              {
                                 _loc32_ = _loc30_ * _loc30_;
                                 _loc33_ = 1 - 0.5 * _loc32_;
                                 _loc34_ = 1 - _loc32_ * _loc32_ / 8;
                                 _loc35_ = (_loc33_ * _loc31_.axisx + _loc30_ * _loc31_.axisy) * _loc34_;
                                 _loc31_.axisy = (_loc33_ * _loc31_.axisy - _loc30_ * _loc31_.axisx) * _loc34_;
                                 _loc31_.axisx = _loc35_;
                              }
                              _loc30_ = _loc9_.b2.imass;
                              _loc9_.b2.posx = Number(_loc9_.b2.posx + _loc28_ * _loc30_);
                              _loc9_.b2.posy = Number(_loc9_.b2.posy + _loc29_ * _loc30_);
                              _loc31_ = _loc9_.b2;
                              _loc30_ = _loc25_ * _loc9_.b2.iinertia * _loc27_;
                              _loc31_.rot = Number(_loc31_.rot + _loc30_);
                              if(_loc30_ * _loc30_ > 0.0001)
                              {
                                 _loc31_.axisx = Number(Math.sin(_loc31_.rot));
                                 _loc31_.axisy = Number(Math.cos(_loc31_.rot));
                                 null;
                              }
                              else
                              {
                                 _loc32_ = _loc30_ * _loc30_;
                                 _loc33_ = 1 - 0.5 * _loc32_;
                                 _loc34_ = 1 - _loc32_ * _loc32_ / 8;
                                 _loc35_ = (_loc33_ * _loc31_.axisx + _loc30_ * _loc31_.axisy) * _loc34_;
                                 _loc31_.axisy = (_loc33_ * _loc31_.axisy - _loc30_ * _loc31_.axisx) * _loc34_;
                                 _loc31_.axisx = _loc35_;
                              }
                           }
                        }
                     }
                  }
                  else
                  {
                     _loc16_ = 0;
                     _loc17_ = 0;
                     if(_loc9_.ptype == 0)
                     {
                        _loc11_ = _loc9_.b1.axisy * _loc9_.lnormx - _loc9_.b1.axisx * _loc9_.lnormy;
                        _loc12_ = Number(_loc9_.lnormx * _loc9_.b1.axisx + _loc9_.lnormy * _loc9_.b1.axisy);
                        _loc13_ = Number(_loc9_.lproj + (Number(_loc11_ * _loc9_.b1.posx + _loc12_ * _loc9_.b1.posy)));
                        _loc14_ = _loc9_.b2.axisy * _loc9_.c1.lr1x - _loc9_.b2.axisx * _loc9_.c1.lr1y;
                        _loc15_ = Number(_loc9_.c1.lr1x * _loc9_.b2.axisx + _loc9_.c1.lr1y * _loc9_.b2.axisy);
                        _loc18_ = 1;
                        _loc14_ = Number(_loc14_ + _loc9_.b2.posx * _loc18_);
                        _loc15_ = Number(_loc15_ + _loc9_.b2.posy * _loc18_);
                        if(_loc9_.hc2)
                        {
                           _loc16_ = _loc9_.b2.axisy * _loc9_.c2.lr1x - _loc9_.b2.axisx * _loc9_.c2.lr1y;
                           _loc17_ = Number(_loc9_.c2.lr1x * _loc9_.b2.axisx + _loc9_.c2.lr1y * _loc9_.b2.axisy);
                           _loc18_ = 1;
                           _loc16_ = Number(_loc16_ + _loc9_.b2.posx * _loc18_);
                           _loc17_ = Number(_loc17_ + _loc9_.b2.posy * _loc18_);
                        }
                     }
                     else
                     {
                        _loc11_ = _loc9_.b2.axisy * _loc9_.lnormx - _loc9_.b2.axisx * _loc9_.lnormy;
                        _loc12_ = Number(_loc9_.lnormx * _loc9_.b2.axisx + _loc9_.lnormy * _loc9_.b2.axisy);
                        _loc13_ = Number(_loc9_.lproj + (Number(_loc11_ * _loc9_.b2.posx + _loc12_ * _loc9_.b2.posy)));
                        _loc14_ = _loc9_.b1.axisy * _loc9_.c1.lr1x - _loc9_.b1.axisx * _loc9_.c1.lr1y;
                        _loc15_ = Number(_loc9_.c1.lr1x * _loc9_.b1.axisx + _loc9_.c1.lr1y * _loc9_.b1.axisy);
                        _loc18_ = 1;
                        _loc14_ = Number(_loc14_ + _loc9_.b1.posx * _loc18_);
                        _loc15_ = Number(_loc15_ + _loc9_.b1.posy * _loc18_);
                        if(_loc9_.hc2)
                        {
                           _loc16_ = _loc9_.b1.axisy * _loc9_.c2.lr1x - _loc9_.b1.axisx * _loc9_.c2.lr1y;
                           _loc17_ = Number(_loc9_.c2.lr1x * _loc9_.b1.axisx + _loc9_.c2.lr1y * _loc9_.b1.axisy);
                           _loc18_ = 1;
                           _loc16_ = Number(_loc16_ + _loc9_.b1.posx * _loc18_);
                           _loc17_ = Number(_loc17_ + _loc9_.b1.posy * _loc18_);
                        }
                     }
                     _loc18_ = _loc14_ * _loc11_ + _loc15_ * _loc12_ - _loc13_ - _loc9_.radius;
                     _loc18_ = Number(_loc18_ + 0.25);
                     _loc19_ = 0;
                     if(_loc9_.hc2)
                     {
                        _loc19_ = _loc16_ * _loc11_ + _loc17_ * _loc12_ - _loc13_ - _loc9_.radius;
                        _loc19_ = Number(_loc19_ + 0.25);
                     }
                     if(_loc18_ < 0 || _loc19_ < 0)
                     {
                        if(_loc9_.rev)
                        {
                           _loc11_ = -_loc11_;
                           _loc12_ = -_loc12_;
                        }
                        _loc20_ = _loc14_ - _loc9_.b1.posx;
                        _loc21_ = _loc15_ - _loc9_.b1.posy;
                        _loc22_ = _loc14_ - _loc9_.b2.posx;
                        _loc23_ = _loc15_ - _loc9_.b2.posy;
                        _loc24_ = 0;
                        _loc25_ = 0;
                        _loc26_ = 0;
                        _loc27_ = 0;
                        if(_loc9_.hc2)
                        {
                           _loc24_ = _loc16_ - _loc9_.b1.posx;
                           _loc25_ = _loc17_ - _loc9_.b1.posy;
                           _loc26_ = _loc16_ - _loc9_.b2.posx;
                           _loc27_ = _loc17_ - _loc9_.b2.posy;
                           _loc28_ = _loc12_ * _loc20_ - _loc11_ * _loc21_;
                           _loc29_ = _loc12_ * _loc22_ - _loc11_ * _loc23_;
                           _loc30_ = _loc12_ * _loc24_ - _loc11_ * _loc25_;
                           _loc32_ = _loc12_ * _loc26_ - _loc11_ * _loc27_;
                           _loc33_ = Number(_loc9_.b1.smass + _loc9_.b2.smass);
                           _loc9_.kMassa = Number(Number(_loc33_ + _loc9_.b1.sinertia * _loc28_ * _loc28_) + _loc9_.b2.sinertia * _loc29_ * _loc29_);
                           _loc9_.kMassb = Number(Number(_loc33_ + _loc9_.b1.sinertia * _loc28_ * _loc30_) + _loc9_.b2.sinertia * _loc29_ * _loc32_);
                           _loc9_.kMassc = Number(Number(_loc33_ + _loc9_.b1.sinertia * _loc30_ * _loc30_) + _loc9_.b2.sinertia * _loc32_ * _loc32_);
                           _loc34_ = _loc9_.kMassa;
                           _loc35_ = _loc9_.kMassb;
                           _loc36_ = _loc9_.kMassc;
                           _loc37_ = (_loc9_.c1.biasCoef + _loc9_.c2.biasCoef) * 0.5;
                           _loc38_ = _loc18_ * _loc37_;
                           _loc39_ = _loc19_ * _loc37_;
                           while(true)
                           {
                              _loc40_ = _loc38_;
                              _loc41_ = _loc39_;
                              _loc40_ = -_loc40_;
                              _loc41_ = -_loc41_;
                              _loc42_ = _loc9_.kMassa * _loc9_.kMassc - _loc9_.kMassb * _loc9_.kMassb;
                              if(_loc42_ != _loc42_)
                              {
                                 _loc41_ = 0;
                                 _loc40_ = _loc41_;
                              }
                              else if(_loc42_ == 0)
                              {
                                 if(_loc9_.kMassa != 0)
                                 {
                                    _loc40_ = _loc40_ / _loc9_.kMassa;
                                 }
                                 else
                                 {
                                    _loc40_ = 0;
                                 }
                                 if(_loc9_.kMassc != 0)
                                 {
                                    _loc41_ = _loc41_ / _loc9_.kMassc;
                                 }
                                 else
                                 {
                                    _loc41_ = 0;
                                 }
                              }
                              else
                              {
                                 _loc42_ = 1 / _loc42_;
                                 _loc43_ = _loc42_ * (_loc9_.kMassc * _loc40_ - _loc9_.kMassb * _loc41_);
                                 _loc41_ = _loc42_ * (_loc9_.kMassa * _loc41_ - _loc9_.kMassb * _loc40_);
                                 _loc40_ = _loc43_;
                              }
                              if(_loc40_ >= 0 && _loc41_ >= 0)
                              {
                                 _loc42_ = (_loc40_ + _loc41_) * _loc9_.b1.imass;
                                 _loc9_.b1.posx = _loc9_.b1.posx - _loc11_ * _loc42_;
                                 _loc9_.b1.posy = _loc9_.b1.posy - _loc12_ * _loc42_;
                                 _loc31_ = _loc9_.b1;
                                 _loc42_ = -_loc9_.b1.iinertia * (_loc28_ * _loc40_ + _loc30_ * _loc41_);
                                 _loc31_.rot = Number(_loc31_.rot + _loc42_);
                                 if(_loc42_ * _loc42_ > 0.0001)
                                 {
                                    _loc31_.axisx = Number(Math.sin(_loc31_.rot));
                                    _loc31_.axisy = Number(Math.cos(_loc31_.rot));
                                    null;
                                 }
                                 else
                                 {
                                    _loc43_ = _loc42_ * _loc42_;
                                    _loc44_ = 1 - 0.5 * _loc43_;
                                    _loc45_ = 1 - _loc43_ * _loc43_ / 8;
                                    _loc46_ = (_loc44_ * _loc31_.axisx + _loc42_ * _loc31_.axisy) * _loc45_;
                                    _loc31_.axisy = (_loc44_ * _loc31_.axisy - _loc42_ * _loc31_.axisx) * _loc45_;
                                    _loc31_.axisx = _loc46_;
                                 }
                                 _loc42_ = (_loc40_ + _loc41_) * _loc9_.b2.imass;
                                 _loc9_.b2.posx = Number(_loc9_.b2.posx + _loc11_ * _loc42_);
                                 _loc9_.b2.posy = Number(_loc9_.b2.posy + _loc12_ * _loc42_);
                                 _loc31_ = _loc9_.b2;
                                 _loc42_ = _loc9_.b2.iinertia * (_loc29_ * _loc40_ + _loc32_ * _loc41_);
                                 _loc31_.rot = Number(_loc31_.rot + _loc42_);
                                 if(_loc42_ * _loc42_ > 0.0001)
                                 {
                                    _loc31_.axisx = Number(Math.sin(_loc31_.rot));
                                    _loc31_.axisy = Number(Math.cos(_loc31_.rot));
                                    null;
                                    break;
                                 }
                                 _loc43_ = _loc42_ * _loc42_;
                                 _loc44_ = 1 - 0.5 * _loc43_;
                                 _loc45_ = 1 - _loc43_ * _loc43_ / 8;
                                 _loc46_ = (_loc44_ * _loc31_.axisx + _loc42_ * _loc31_.axisy) * _loc45_;
                                 _loc31_.axisy = (_loc44_ * _loc31_.axisy - _loc42_ * _loc31_.axisx) * _loc45_;
                                 _loc31_.axisx = _loc46_;
                                 break;
                              }
                              _loc40_ = -_loc38_ / _loc34_;
                              _loc41_ = 0;
                              _loc42_ = Number(_loc35_ * _loc40_ + _loc39_);
                              if(_loc40_ >= 0 && _loc42_ >= 0)
                              {
                                 _loc43_ = (_loc40_ + _loc41_) * _loc9_.b1.imass;
                                 _loc9_.b1.posx = _loc9_.b1.posx - _loc11_ * _loc43_;
                                 _loc9_.b1.posy = _loc9_.b1.posy - _loc12_ * _loc43_;
                                 _loc31_ = _loc9_.b1;
                                 _loc43_ = -_loc9_.b1.iinertia * (_loc28_ * _loc40_ + _loc30_ * _loc41_);
                                 _loc31_.rot = Number(_loc31_.rot + _loc43_);
                                 if(_loc43_ * _loc43_ > 0.0001)
                                 {
                                    _loc31_.axisx = Number(Math.sin(_loc31_.rot));
                                    _loc31_.axisy = Number(Math.cos(_loc31_.rot));
                                    null;
                                 }
                                 else
                                 {
                                    _loc44_ = _loc43_ * _loc43_;
                                    _loc45_ = 1 - 0.5 * _loc44_;
                                    _loc46_ = 1 - _loc44_ * _loc44_ / 8;
                                    _loc47_ = (_loc45_ * _loc31_.axisx + _loc43_ * _loc31_.axisy) * _loc46_;
                                    _loc31_.axisy = (_loc45_ * _loc31_.axisy - _loc43_ * _loc31_.axisx) * _loc46_;
                                    _loc31_.axisx = _loc47_;
                                 }
                                 _loc43_ = (_loc40_ + _loc41_) * _loc9_.b2.imass;
                                 _loc9_.b2.posx = Number(_loc9_.b2.posx + _loc11_ * _loc43_);
                                 _loc9_.b2.posy = Number(_loc9_.b2.posy + _loc12_ * _loc43_);
                                 _loc31_ = _loc9_.b2;
                                 _loc43_ = _loc9_.b2.iinertia * (_loc29_ * _loc40_ + _loc32_ * _loc41_);
                                 _loc31_.rot = Number(_loc31_.rot + _loc43_);
                                 if(_loc43_ * _loc43_ > 0.0001)
                                 {
                                    _loc31_.axisx = Number(Math.sin(_loc31_.rot));
                                    _loc31_.axisy = Number(Math.cos(_loc31_.rot));
                                    null;
                                    break;
                                 }
                                 _loc44_ = _loc43_ * _loc43_;
                                 _loc45_ = 1 - 0.5 * _loc44_;
                                 _loc46_ = 1 - _loc44_ * _loc44_ / 8;
                                 _loc47_ = (_loc45_ * _loc31_.axisx + _loc43_ * _loc31_.axisy) * _loc46_;
                                 _loc31_.axisy = (_loc45_ * _loc31_.axisy - _loc43_ * _loc31_.axisx) * _loc46_;
                                 _loc31_.axisx = _loc47_;
                                 break;
                              }
                              _loc40_ = 0;
                              _loc41_ = -_loc39_ / _loc36_;
                              _loc43_ = Number(_loc35_ * _loc41_ + _loc38_);
                              if(_loc41_ >= 0 && _loc43_ >= 0)
                              {
                                 _loc44_ = (_loc40_ + _loc41_) * _loc9_.b1.imass;
                                 _loc9_.b1.posx = _loc9_.b1.posx - _loc11_ * _loc44_;
                                 _loc9_.b1.posy = _loc9_.b1.posy - _loc12_ * _loc44_;
                                 _loc31_ = _loc9_.b1;
                                 _loc44_ = -_loc9_.b1.iinertia * (_loc28_ * _loc40_ + _loc30_ * _loc41_);
                                 _loc31_.rot = Number(_loc31_.rot + _loc44_);
                                 if(_loc44_ * _loc44_ > 0.0001)
                                 {
                                    _loc31_.axisx = Number(Math.sin(_loc31_.rot));
                                    _loc31_.axisy = Number(Math.cos(_loc31_.rot));
                                    null;
                                 }
                                 else
                                 {
                                    _loc45_ = _loc44_ * _loc44_;
                                    _loc46_ = 1 - 0.5 * _loc45_;
                                    _loc47_ = 1 - _loc45_ * _loc45_ / 8;
                                    _loc48_ = (_loc46_ * _loc31_.axisx + _loc44_ * _loc31_.axisy) * _loc47_;
                                    _loc31_.axisy = (_loc46_ * _loc31_.axisy - _loc44_ * _loc31_.axisx) * _loc47_;
                                    _loc31_.axisx = _loc48_;
                                 }
                                 _loc44_ = (_loc40_ + _loc41_) * _loc9_.b2.imass;
                                 _loc9_.b2.posx = Number(_loc9_.b2.posx + _loc11_ * _loc44_);
                                 _loc9_.b2.posy = Number(_loc9_.b2.posy + _loc12_ * _loc44_);
                                 _loc31_ = _loc9_.b2;
                                 _loc44_ = _loc9_.b2.iinertia * (_loc29_ * _loc40_ + _loc32_ * _loc41_);
                                 _loc31_.rot = Number(_loc31_.rot + _loc44_);
                                 if(_loc44_ * _loc44_ > 0.0001)
                                 {
                                    _loc31_.axisx = Number(Math.sin(_loc31_.rot));
                                    _loc31_.axisy = Number(Math.cos(_loc31_.rot));
                                    null;
                                    break;
                                 }
                                 _loc45_ = _loc44_ * _loc44_;
                                 _loc46_ = 1 - 0.5 * _loc45_;
                                 _loc47_ = 1 - _loc45_ * _loc45_ / 8;
                                 _loc48_ = (_loc46_ * _loc31_.axisx + _loc44_ * _loc31_.axisy) * _loc47_;
                                 _loc31_.axisy = (_loc46_ * _loc31_.axisy - _loc44_ * _loc31_.axisx) * _loc47_;
                                 _loc31_.axisx = _loc48_;
                                 break;
                              }
                           }
                        }
                        else
                        {
                           _loc28_ = _loc12_ * _loc20_ - _loc11_ * _loc21_;
                           _loc29_ = _loc12_ * _loc22_ - _loc11_ * _loc23_;
                           _loc30_ = Number(Number(Number(_loc9_.b2.smass + _loc29_ * _loc29_ * _loc9_.b2.sinertia) + _loc9_.b1.smass) + _loc28_ * _loc28_ * _loc9_.b1.sinertia);
                           if(_loc30_ != 0)
                           {
                              _loc32_ = -_loc9_.c1.biasCoef * _loc18_ / _loc30_;
                              _loc35_ = _loc32_;
                              _loc33_ = _loc11_ * _loc35_;
                              _loc34_ = _loc12_ * _loc35_;
                              _loc35_ = _loc9_.b1.imass;
                              _loc9_.b1.posx = _loc9_.b1.posx - _loc33_ * _loc35_;
                              _loc9_.b1.posy = _loc9_.b1.posy - _loc34_ * _loc35_;
                              _loc31_ = _loc9_.b1;
                              _loc35_ = -_loc28_ * _loc9_.b1.iinertia * _loc32_;
                              _loc31_.rot = Number(_loc31_.rot + _loc35_);
                              if(_loc35_ * _loc35_ > 0.0001)
                              {
                                 _loc31_.axisx = Number(Math.sin(_loc31_.rot));
                                 _loc31_.axisy = Number(Math.cos(_loc31_.rot));
                                 null;
                              }
                              else
                              {
                                 _loc36_ = _loc35_ * _loc35_;
                                 _loc37_ = 1 - 0.5 * _loc36_;
                                 _loc38_ = 1 - _loc36_ * _loc36_ / 8;
                                 _loc39_ = (_loc37_ * _loc31_.axisx + _loc35_ * _loc31_.axisy) * _loc38_;
                                 _loc31_.axisy = (_loc37_ * _loc31_.axisy - _loc35_ * _loc31_.axisx) * _loc38_;
                                 _loc31_.axisx = _loc39_;
                              }
                              _loc35_ = _loc9_.b2.imass;
                              _loc9_.b2.posx = Number(_loc9_.b2.posx + _loc33_ * _loc35_);
                              _loc9_.b2.posy = Number(_loc9_.b2.posy + _loc34_ * _loc35_);
                              _loc31_ = _loc9_.b2;
                              _loc35_ = _loc29_ * _loc9_.b2.iinertia * _loc32_;
                              _loc31_.rot = Number(_loc31_.rot + _loc35_);
                              if(_loc35_ * _loc35_ > 0.0001)
                              {
                                 _loc31_.axisx = Number(Math.sin(_loc31_.rot));
                                 _loc31_.axisy = Number(Math.cos(_loc31_.rot));
                                 null;
                              }
                              else
                              {
                                 _loc36_ = _loc35_ * _loc35_;
                                 _loc37_ = 1 - 0.5 * _loc36_;
                                 _loc38_ = 1 - _loc36_ * _loc36_ / 8;
                                 _loc39_ = (_loc37_ * _loc31_.axisx + _loc35_ * _loc31_.axisy) * _loc38_;
                                 _loc31_.axisy = (_loc37_ * _loc31_.axisy - _loc35_ * _loc31_.axisx) * _loc38_;
                                 _loc31_.axisx = _loc39_;
                              }
                           }
                        }
                     }
                  }
               }
               _loc7_ = _loc7_.next;
               if(!!_loc8_ && _loc7_ == null)
               {
                  _loc7_ = c_arbiters_true.head;
                  _loc8_ = false;
               }
            }
         }
      }
      
      public function gravity_validate() : void
      {
         wrap_gravity.zpp_inner.x = gravityx;
         wrap_gravity.zpp_inner.y = gravityy;
      }
      
      public function gravity_invalidate(param1:ZPP_Vec2) : void
      {
         var _loc3_:* = null as ZNPNode_ZPP_Body;
         var _loc4_:* = null as ZPP_Body;
         var _loc5_:* = null as ZPP_Body;
         var _loc6_:* = null as ZNPNode_ZPP_Compound;
         var _loc7_:* = null as ZPP_Compound;
         var _loc8_:* = null as ZPP_Compound;
         gravityx = param1.x;
         gravityy = param1.y;
         var _loc2_:ZNPList_ZPP_Compound = new ZNPList_ZPP_Compound();
         _loc3_ = bodies.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
            _loc5_ = _loc4_;
            if(!_loc5_.world)
            {
               _loc5_.component.waket = stamp + (!!midstep?0:1);
               if(_loc5_.component.sleeping)
               {
                  really_wake(_loc5_,false);
               }
            }
            _loc3_ = _loc3_.next;
         }
         _loc6_ = compounds.head;
         while(_loc6_ != null)
         {
            _loc7_ = _loc6_.elt;
            _loc2_.add(_loc7_);
            _loc6_ = _loc6_.next;
         }
         while(_loc2_.head != null)
         {
            _loc7_ = _loc2_.pop_unsafe();
            _loc3_ = _loc7_.bodies.head;
            while(_loc3_ != null)
            {
               _loc4_ = _loc3_.elt;
               _loc5_ = _loc4_;
               if(!_loc5_.world)
               {
                  _loc5_.component.waket = stamp + (!!midstep?0:1);
                  if(_loc5_.component.sleeping)
                  {
                     really_wake(_loc5_,false);
                  }
               }
               _loc3_ = _loc3_.next;
            }
            _loc6_ = _loc7_.compounds.head;
            while(_loc6_ != null)
            {
               _loc8_ = _loc6_.elt;
               _loc2_.add(_loc8_);
               _loc6_ = _loc6_.next;
            }
         }
      }
      
      public function getgravity() : void
      {
         wrap_gravity = Vec2.get(gravityx,gravityy);
         wrap_gravity.zpp_inner._inuse = true;
         wrap_gravity.zpp_inner._invalidate = gravity_invalidate;
         wrap_gravity.zpp_inner._validate = gravity_validate;
      }
      
      public function freshListenerType(param1:ZPP_CbSet, param2:ZPP_CbSet) : void
      {
         var _loc4_:* = null as ZNPNode_ZPP_Interactor;
         var _loc5_:* = null as ZPP_Interactor;
         var _loc6_:* = null as ZPP_Compound;
         var _loc7_:* = null as ZNPNode_ZPP_Body;
         var _loc8_:* = null as ZPP_Body;
         var _loc9_:* = null as ZNPNode_ZPP_Compound;
         var _loc10_:* = null as ZPP_Compound;
         var _loc11_:* = null as ZPP_Shape;
         var _loc12_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc13_:* = null as ZPP_Arbiter;
         var _loc14_:* = null as ZPP_Interactor;
         var _loc15_:* = null as ZNPNode_ZPP_Interactor;
         var _loc16_:* = null as ZPP_Interactor;
         var _loc17_:* = null as ZPP_CallbackSet;
         var _loc18_:Boolean = false;
         var _loc19_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc20_:* = null as ZPP_Arbiter;
         var _loc21_:* = null as ZNPList_ZPP_Arbiter;
         var _loc22_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc3_:ZNPList_ZPP_Interactor = new ZNPList_ZPP_Interactor();
         _loc4_ = param1.interactors.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            _loc3_.add(_loc5_);
            _loc4_ = _loc4_.next;
         }
         if(param1 != param2)
         {
            _loc4_ = param2.interactors.head;
            while(_loc4_ != null)
            {
               _loc5_ = _loc4_.elt;
               _loc3_.add(_loc5_);
               _loc4_ = _loc4_.next;
            }
         }
         while(_loc3_.head != null)
         {
            _loc5_ = _loc3_.pop_unsafe();
            if(_loc5_.icompound != null)
            {
               _loc6_ = _loc5_.icompound;
               _loc7_ = _loc6_.bodies.head;
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.elt;
                  _loc3_.add(_loc8_);
                  _loc7_ = _loc7_.next;
               }
               _loc9_ = _loc6_.compounds.head;
               while(_loc9_ != null)
               {
                  _loc10_ = _loc9_.elt;
                  _loc3_.add(_loc10_);
                  _loc9_ = _loc9_.next;
               }
            }
            else
            {
               _loc8_ = _loc5_.ibody != null?_loc5_.ibody:_loc5_.ishape.body;
               _loc11_ = _loc5_.ishape != null?_loc5_.ishape:null;
               _loc12_ = _loc8_.arbiters.head;
               while(_loc12_ != null)
               {
                  _loc13_ = _loc12_.elt;
                  if(!_loc13_.presentable)
                  {
                     _loc12_ = _loc12_.next;
                  }
                  else if(_loc11_ != null && !(_loc13_.ws1 == _loc11_ || _loc13_.ws2 == _loc11_))
                  {
                     _loc12_ = _loc12_.next;
                  }
                  else
                  {
                     MRCA_chains(_loc13_.ws1,_loc13_.ws2);
                     _loc4_ = mrca1.head;
                     while(_loc4_ != null)
                     {
                        _loc14_ = _loc4_.elt;
                        if(_loc14_.cbSet != param1 && _loc14_.cbSet != param2)
                        {
                           _loc4_ = _loc4_.next;
                        }
                        else
                        {
                           _loc15_ = mrca2.head;
                           while(_loc15_ != null)
                           {
                              _loc16_ = _loc15_.elt;
                              if(_loc14_.cbSet == param1 && _loc16_.cbSet != param2 || _loc14_.cbSet == param2 && _loc16_.cbSet != param1)
                              {
                                 _loc15_ = _loc15_.next;
                              }
                              else
                              {
                                 _loc17_ = ZPP_Interactor.get(_loc14_,_loc16_);
                                 if(_loc17_ == null)
                                 {
                                    _loc17_ = ZPP_CallbackSet.get(_loc14_,_loc16_);
                                    add_callbackset(_loc17_);
                                 }
                                 _loc18_ = false;
                                 _loc19_ = _loc17_.arbiters.head;
                                 while(_loc19_ != null)
                                 {
                                    _loc20_ = _loc19_.elt;
                                    if(_loc20_ == _loc13_)
                                    {
                                       _loc18_ = true;
                                       break;
                                    }
                                    _loc19_ = _loc19_.next;
                                 }
                                 if(!_loc18_)
                                 {
                                    _loc21_ = _loc17_.arbiters;
                                    if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                    {
                                       _loc22_ = new ZNPNode_ZPP_Arbiter();
                                    }
                                    else
                                    {
                                       _loc22_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                                       ZNPNode_ZPP_Arbiter.zpp_pool = _loc22_.next;
                                       _loc22_.next = null;
                                    }
                                    null;
                                    _loc22_.elt = _loc13_;
                                    _loc19_ = _loc22_;
                                    _loc19_.next = _loc21_.head;
                                    _loc21_.head = _loc19_;
                                    _loc21_.modified = true;
                                    _loc21_.length = _loc21_.length + 1;
                                    _loc13_;
                                    §§push(true);
                                 }
                                 else
                                 {
                                    §§push(false);
                                 }
                                 _loc13_.present = _loc13_.present + 1;
                                 _loc15_ = _loc15_.next;
                              }
                           }
                           _loc4_ = _loc4_.next;
                        }
                     }
                     _loc12_ = _loc12_.next;
                  }
               }
            }
         }
      }
      
      public function freshInteractorType(param1:ZPP_Interactor, param2:ZPP_Interactor = undefined) : void
      {
         var _loc3_:* = null as ZPP_Compound;
         var _loc4_:* = null as ZNPNode_ZPP_Body;
         var _loc5_:* = null as ZPP_Body;
         var _loc6_:* = null as ZNPNode_ZPP_Compound;
         var _loc7_:* = null as ZPP_Compound;
         var _loc8_:* = null as ZPP_Shape;
         var _loc9_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc10_:* = null as ZPP_Arbiter;
         var _loc11_:* = null as ZNPNode_ZPP_Interactor;
         var _loc12_:* = null as ZPP_Interactor;
         var _loc13_:* = null as ZNPNode_ZPP_Interactor;
         var _loc14_:* = null as ZPP_Interactor;
         var _loc15_:* = null as ZPP_CbSet;
         var _loc16_:* = null as ZPP_CbSet;
         var _loc17_:* = null as ZPP_CbSetPair;
         var _loc18_:* = null as ZNPList_ZPP_CbSetPair;
         var _loc19_:* = null as ZNPNode_ZPP_CbSetPair;
         var _loc20_:* = null as ZPP_CbSetPair;
         var _loc21_:* = null as ZPP_CallbackSet;
         var _loc22_:Boolean = false;
         var _loc23_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc24_:* = null as ZPP_Arbiter;
         var _loc25_:* = null as ZNPList_ZPP_Arbiter;
         var _loc26_:* = null as ZNPNode_ZPP_Arbiter;
         if(param2 == null)
         {
            param2 = param1;
         }
         if(param1.icompound != null)
         {
            _loc3_ = param1.icompound;
            _loc4_ = _loc3_.bodies.head;
            while(_loc4_ != null)
            {
               _loc5_ = _loc4_.elt;
               freshInteractorType(_loc5_,param2);
               _loc4_ = _loc4_.next;
            }
            _loc6_ = _loc3_.compounds.head;
            while(_loc6_ != null)
            {
               _loc7_ = _loc6_.elt;
               freshInteractorType(_loc7_,param2);
               _loc6_ = _loc6_.next;
            }
         }
         else
         {
            _loc5_ = param1.ibody != null?param1.ibody:param1.ishape.body;
            _loc8_ = param1.ishape != null?param1.ishape:null;
            _loc9_ = _loc5_.arbiters.head;
            while(_loc9_ != null)
            {
               _loc10_ = _loc9_.elt;
               if(!_loc10_.presentable)
               {
                  _loc9_ = _loc9_.next;
               }
               else if(_loc8_ != null && !(_loc10_.ws1 == _loc8_ || _loc10_.ws2 == _loc8_))
               {
                  _loc9_ = _loc9_.next;
               }
               else
               {
                  MRCA_chains(_loc10_.ws1,_loc10_.ws2);
                  _loc11_ = mrca1.head;
                  while(_loc11_ != null)
                  {
                     _loc12_ = _loc11_.elt;
                     _loc13_ = mrca2.head;
                     while(_loc13_ != null)
                     {
                        _loc14_ = _loc13_.elt;
                        if(_loc12_ != param2 && _loc14_ != param2)
                        {
                           _loc13_ = _loc13_.next;
                        }
                        else
                        {
                           _loc15_ = _loc12_.cbSet;
                           _loc16_ = _loc14_.cbSet;
                           _loc15_.validate();
                           _loc16_.validate();
                           _loc17_ = null;
                           _loc18_ = _loc15_.cbpairs.length < _loc16_.cbpairs.length?_loc15_.cbpairs:_loc16_.cbpairs;
                           _loc19_ = _loc18_.head;
                           while(_loc19_ != null)
                           {
                              _loc20_ = _loc19_.elt;
                              if(_loc20_.a == _loc15_ && _loc20_.b == _loc16_ || _loc20_.a == _loc16_ && _loc20_.b == _loc15_)
                              {
                                 _loc17_ = _loc20_;
                                 break;
                              }
                              _loc19_ = _loc19_.next;
                           }
                           if(_loc17_ == null)
                           {
                              if(ZPP_CbSetPair.zpp_pool == null)
                              {
                                 _loc20_ = new ZPP_CbSetPair();
                              }
                              else
                              {
                                 _loc20_ = ZPP_CbSetPair.zpp_pool;
                                 ZPP_CbSetPair.zpp_pool = _loc20_.next;
                                 _loc20_.next = null;
                              }
                              _loc20_.zip_listeners = true;
                              if(ZPP_CbSet.setlt(_loc15_,_loc16_))
                              {
                                 _loc20_.a = _loc15_;
                                 _loc20_.b = _loc16_;
                              }
                              else
                              {
                                 _loc20_.a = _loc16_;
                                 _loc20_.b = _loc15_;
                              }
                              _loc17_ = _loc20_;
                              _loc15_.cbpairs.add(_loc17_);
                              if(_loc16_ != _loc15_)
                              {
                                 _loc16_.cbpairs.add(_loc17_);
                              }
                           }
                           if(_loc17_.zip_listeners)
                           {
                              _loc17_.zip_listeners = false;
                              _loc17_.__validate();
                           }
                           if(_loc17_.listeners.head != null)
                           {
                              _loc21_ = ZPP_Interactor.get(_loc12_,_loc14_);
                              if(_loc21_ == null)
                              {
                                 _loc21_ = ZPP_CallbackSet.get(_loc12_,_loc14_);
                                 add_callbackset(_loc21_);
                              }
                              _loc22_ = false;
                              _loc23_ = _loc21_.arbiters.head;
                              while(_loc23_ != null)
                              {
                                 _loc24_ = _loc23_.elt;
                                 if(_loc24_ == _loc10_)
                                 {
                                    _loc22_ = true;
                                    break;
                                 }
                                 _loc23_ = _loc23_.next;
                              }
                              if(!_loc22_)
                              {
                                 _loc25_ = _loc21_.arbiters;
                                 if(ZNPNode_ZPP_Arbiter.zpp_pool == null)
                                 {
                                    _loc26_ = new ZNPNode_ZPP_Arbiter();
                                 }
                                 else
                                 {
                                    _loc26_ = ZNPNode_ZPP_Arbiter.zpp_pool;
                                    ZNPNode_ZPP_Arbiter.zpp_pool = _loc26_.next;
                                    _loc26_.next = null;
                                 }
                                 null;
                                 _loc26_.elt = _loc10_;
                                 _loc23_ = _loc26_;
                                 _loc23_.next = _loc25_.head;
                                 _loc25_.head = _loc23_;
                                 _loc25_.modified = true;
                                 _loc25_.length = _loc25_.length + 1;
                                 _loc10_;
                                 §§push(true);
                              }
                              else
                              {
                                 §§push(false);
                              }
                              _loc10_.present = _loc10_.present + 1;
                           }
                           _loc13_ = _loc13_.next;
                        }
                     }
                     _loc11_ = _loc11_.next;
                  }
                  _loc9_ = _loc9_.next;
               }
            }
         }
      }
      
      public function doForests(param1:Number) : void
      {
         var _loc3_:* = null as ZPP_ColArbiter;
         var _loc4_:* = null as ZPP_Component;
         var _loc5_:* = null as ZPP_Component;
         var _loc6_:* = null as ZPP_Component;
         var _loc7_:* = null as ZPP_Component;
         var _loc8_:* = null as ZPP_Component;
         var _loc10_:* = null as ZPP_FluidArbiter;
         var _loc11_:* = null as ZNPNode_ZPP_Constraint;
         var _loc12_:* = null as ZPP_Constraint;
         var _loc13_:* = null as ZPP_Body;
         var _loc14_:* = null as ZNPList_ZPP_Body;
         var _loc15_:* = null as ZPP_Body;
         var _loc16_:* = null as ZPP_Island;
         var _loc17_:* = null as ZPP_Island;
         var _loc18_:* = null as ZPP_Island;
         var _loc19_:* = null as ZNPList_ZPP_Component;
         var _loc20_:* = null as ZNPNode_ZPP_Component;
         var _loc21_:* = null as ZNPNode_ZPP_Component;
         var _loc22_:Boolean = false;
         var _loc23_:* = null as ZNPList_ZPP_Constraint;
         var _loc24_:* = null as ZPP_Constraint;
         var _loc25_:* = null as ZNPNode_ZPP_Shape;
         var _loc26_:* = null as ZPP_Shape;
         var _loc27_:* = null as ZNPNode_ZPP_Body;
         var _loc28_:* = null as ZNPNode_ZPP_Body;
         var _loc29_:* = null as ZNPNode_ZPP_Constraint;
         var _loc2_:ZNPNode_ZPP_ColArbiter = c_arbiters_false.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            if(!_loc3_.cleared && _loc3_.up_stamp == stamp && (_loc3_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
            {
               if(_loc3_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc3_.b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
               {
                  if(_loc3_.b1.component == _loc3_.b1.component.parent)
                  {
                     §§push(_loc3_.b1.component);
                  }
                  else
                  {
                     _loc5_ = _loc3_.b1.component;
                     _loc6_ = null;
                     while(_loc5_ != _loc5_.parent)
                     {
                        _loc7_ = _loc5_.parent;
                        _loc5_.parent = _loc6_;
                        _loc6_ = _loc5_;
                        _loc5_ = _loc7_;
                     }
                     while(_loc6_ != null)
                     {
                        _loc7_ = _loc6_.parent;
                        _loc6_.parent = _loc5_;
                        _loc6_ = _loc7_;
                     }
                     §§push(_loc5_);
                  }
                  _loc4_ = §§pop();
                  if(_loc3_.b2.component == _loc3_.b2.component.parent)
                  {
                     §§push(_loc3_.b2.component);
                  }
                  else
                  {
                     _loc6_ = _loc3_.b2.component;
                     _loc7_ = null;
                     while(_loc6_ != _loc6_.parent)
                     {
                        _loc8_ = _loc6_.parent;
                        _loc6_.parent = _loc7_;
                        _loc7_ = _loc6_;
                        _loc6_ = _loc8_;
                     }
                     while(_loc7_ != null)
                     {
                        _loc8_ = _loc7_.parent;
                        _loc7_.parent = _loc6_;
                        _loc7_ = _loc8_;
                     }
                     §§push(_loc6_);
                  }
                  _loc5_ = §§pop();
                  if(_loc4_ != _loc5_)
                  {
                     if(_loc4_.rank < _loc5_.rank)
                     {
                        _loc4_.parent = _loc5_;
                     }
                     else if(_loc4_.rank > _loc5_.rank)
                     {
                        _loc5_.parent = _loc4_;
                     }
                     else
                     {
                        _loc5_.parent = _loc4_;
                        _loc4_.rank = _loc4_.rank + 1;
                     }
                  }
               }
            }
            _loc2_ = _loc2_.next;
         }
         var _loc9_:ZNPNode_ZPP_FluidArbiter = f_arbiters.head;
         while(_loc9_ != null)
         {
            _loc10_ = _loc9_.elt;
            if(!_loc10_.cleared && _loc10_.up_stamp == stamp && (_loc10_.immState & ZPP_Flags.id_ImmState_ACCEPT) != 0)
            {
               if(_loc10_.b1.type == ZPP_Flags.id_BodyType_DYNAMIC && _loc10_.b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
               {
                  if(_loc10_.b1.component == _loc10_.b1.component.parent)
                  {
                     §§push(_loc10_.b1.component);
                  }
                  else
                  {
                     _loc5_ = _loc10_.b1.component;
                     _loc6_ = null;
                     while(_loc5_ != _loc5_.parent)
                     {
                        _loc7_ = _loc5_.parent;
                        _loc5_.parent = _loc6_;
                        _loc6_ = _loc5_;
                        _loc5_ = _loc7_;
                     }
                     while(_loc6_ != null)
                     {
                        _loc7_ = _loc6_.parent;
                        _loc6_.parent = _loc5_;
                        _loc6_ = _loc7_;
                     }
                     §§push(_loc5_);
                  }
                  _loc4_ = §§pop();
                  if(_loc10_.b2.component == _loc10_.b2.component.parent)
                  {
                     §§push(_loc10_.b2.component);
                  }
                  else
                  {
                     _loc6_ = _loc10_.b2.component;
                     _loc7_ = null;
                     while(_loc6_ != _loc6_.parent)
                     {
                        _loc8_ = _loc6_.parent;
                        _loc6_.parent = _loc7_;
                        _loc7_ = _loc6_;
                        _loc6_ = _loc8_;
                     }
                     while(_loc7_ != null)
                     {
                        _loc8_ = _loc7_.parent;
                        _loc7_.parent = _loc6_;
                        _loc7_ = _loc8_;
                     }
                     §§push(_loc6_);
                  }
                  _loc5_ = §§pop();
                  if(_loc4_ != _loc5_)
                  {
                     if(_loc4_.rank < _loc5_.rank)
                     {
                        _loc4_.parent = _loc5_;
                     }
                     else if(_loc4_.rank > _loc5_.rank)
                     {
                        _loc5_.parent = _loc4_;
                     }
                     else
                     {
                        _loc5_.parent = _loc4_;
                        _loc4_.rank = _loc4_.rank + 1;
                     }
                  }
               }
            }
            _loc9_ = _loc9_.next;
         }
         _loc11_ = live_constraints.head;
         while(_loc11_ != null)
         {
            _loc12_ = _loc11_.elt;
            _loc12_.forest();
            _loc11_ = _loc11_.next;
         }
         while(live.head != null)
         {
            _loc14_ = live;
            _loc15_ = _loc14_.head.elt;
            _loc14_.pop();
            _loc13_ = _loc15_;
            _loc4_ = _loc13_.component;
            if(_loc4_ == _loc4_.parent)
            {
               §§push(_loc4_);
            }
            else
            {
               _loc6_ = _loc4_;
               _loc7_ = null;
               while(_loc6_ != _loc6_.parent)
               {
                  _loc8_ = _loc6_.parent;
                  _loc6_.parent = _loc7_;
                  _loc7_ = _loc6_;
                  _loc6_ = _loc8_;
               }
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.parent;
                  _loc7_.parent = _loc6_;
                  _loc7_ = _loc8_;
               }
               §§push(_loc6_);
            }
            _loc5_ = §§pop();
            if(_loc5_.island == null)
            {
               if(ZPP_Island.zpp_pool == null)
               {
                  _loc5_.island = new ZPP_Island();
               }
               else
               {
                  _loc5_.island = ZPP_Island.zpp_pool;
                  ZPP_Island.zpp_pool = _loc5_.island.next;
                  _loc5_.island.next = null;
               }
               _loc5_.island.waket = 0;
               _loc16_ = islands;
               _loc17_ = _loc5_.island;
               _loc17_._inuse = true;
               _loc18_ = _loc17_;
               _loc18_.next = _loc16_.next;
               _loc16_.next = _loc18_;
               _loc16_.modified = true;
               _loc16_.length = _loc16_.length + 1;
               _loc17_;
               _loc5_.island.sleep = true;
            }
            _loc4_.island = _loc5_.island;
            _loc19_ = _loc4_.island.comps;
            if(ZNPNode_ZPP_Component.zpp_pool == null)
            {
               _loc21_ = new ZNPNode_ZPP_Component();
            }
            else
            {
               _loc21_ = ZNPNode_ZPP_Component.zpp_pool;
               ZNPNode_ZPP_Component.zpp_pool = _loc21_.next;
               _loc21_.next = null;
            }
            null;
            _loc21_.elt = _loc4_;
            _loc20_ = _loc21_;
            _loc20_.next = _loc19_.head;
            _loc19_.head = _loc20_;
            _loc19_.modified = true;
            _loc19_.length = _loc19_.length + 1;
            _loc4_;
            _loc22_ = _loc13_.atRest(param1);
            _loc4_.island.sleep = !!_loc4_.island.sleep && _loc22_;
            if(_loc4_.waket > _loc4_.island.waket)
            {
               _loc4_.island.waket = _loc4_.waket;
            }
         }
         while(live_constraints.head != null)
         {
            _loc23_ = live_constraints;
            _loc24_ = _loc23_.head.elt;
            _loc23_.pop();
            _loc12_ = _loc24_;
            _loc4_ = _loc12_.component;
            if(_loc4_ == _loc4_.parent)
            {
               §§push(_loc4_);
            }
            else
            {
               _loc6_ = _loc4_;
               _loc7_ = null;
               while(_loc6_ != _loc6_.parent)
               {
                  _loc8_ = _loc6_.parent;
                  _loc6_.parent = _loc7_;
                  _loc7_ = _loc6_;
                  _loc6_ = _loc8_;
               }
               while(_loc7_ != null)
               {
                  _loc8_ = _loc7_.parent;
                  _loc7_.parent = _loc6_;
                  _loc7_ = _loc8_;
               }
               §§push(_loc6_);
            }
            _loc5_ = §§pop();
            _loc4_.island = _loc5_.island;
            _loc19_ = _loc4_.island.comps;
            if(ZNPNode_ZPP_Component.zpp_pool == null)
            {
               _loc21_ = new ZNPNode_ZPP_Component();
            }
            else
            {
               _loc21_ = ZNPNode_ZPP_Component.zpp_pool;
               ZNPNode_ZPP_Component.zpp_pool = _loc21_.next;
               _loc21_.next = null;
            }
            null;
            _loc21_.elt = _loc4_;
            _loc20_ = _loc21_;
            _loc20_.next = _loc19_.head;
            _loc19_.head = _loc20_;
            _loc19_.modified = true;
            _loc19_.length = _loc19_.length + 1;
            _loc4_;
            if(_loc4_.waket > _loc4_.island.waket)
            {
               _loc4_.island.waket = _loc4_.waket;
            }
         }
         while(islands.next != null)
         {
            _loc17_ = islands;
            _loc18_ = _loc17_.next;
            _loc17_.pop();
            _loc16_ = _loc18_;
            if(_loc16_.sleep)
            {
               _loc20_ = _loc16_.comps.head;
               while(_loc20_ != null)
               {
                  _loc4_ = _loc20_.elt;
                  if(_loc4_.isBody)
                  {
                     _loc13_ = _loc4_.body;
                     _loc13_.velx = 0;
                     _loc13_.vely = 0;
                     _loc13_.angvel = 0;
                     _loc13_.forcex = 0;
                     _loc13_.forcey = 0;
                     _loc13_.torque = 0;
                     _loc4_.sleeping = true;
                     if(!bphase.is_sweep)
                     {
                        _loc25_ = _loc13_.shapes.head;
                        while(_loc25_ != null)
                        {
                           _loc26_ = _loc25_.elt;
                           bphase.sync(_loc26_);
                           _loc25_ = _loc25_.next;
                        }
                     }
                     bodyCbSleep(_loc13_);
                  }
                  else
                  {
                     _loc12_ = _loc4_.constraint;
                     constraintCbSleep(_loc12_);
                     _loc4_.sleeping = true;
                  }
                  _loc20_ = _loc20_.next;
               }
            }
            else
            {
               while(_loc16_.comps.head != null)
               {
                  _loc19_ = _loc16_.comps;
                  _loc5_ = _loc19_.head.elt;
                  _loc19_.pop();
                  _loc4_ = _loc5_;
                  _loc4_.waket = _loc16_.waket;
                  if(_loc4_.isBody)
                  {
                     _loc14_ = live;
                     _loc13_ = _loc4_.body;
                     if(ZNPNode_ZPP_Body.zpp_pool == null)
                     {
                        _loc28_ = new ZNPNode_ZPP_Body();
                     }
                     else
                     {
                        _loc28_ = ZNPNode_ZPP_Body.zpp_pool;
                        ZNPNode_ZPP_Body.zpp_pool = _loc28_.next;
                        _loc28_.next = null;
                     }
                     null;
                     _loc28_.elt = _loc13_;
                     _loc27_ = _loc28_;
                     _loc27_.next = _loc14_.head;
                     _loc14_.head = _loc27_;
                     _loc14_.modified = true;
                     _loc14_.length = _loc14_.length + 1;
                     _loc13_;
                  }
                  else
                  {
                     _loc23_ = live_constraints;
                     _loc12_ = _loc4_.constraint;
                     if(ZNPNode_ZPP_Constraint.zpp_pool == null)
                     {
                        _loc29_ = new ZNPNode_ZPP_Constraint();
                     }
                     else
                     {
                        _loc29_ = ZNPNode_ZPP_Constraint.zpp_pool;
                        ZNPNode_ZPP_Constraint.zpp_pool = _loc29_.next;
                        _loc29_.next = null;
                     }
                     null;
                     _loc29_.elt = _loc12_;
                     _loc11_ = _loc29_;
                     _loc11_.next = _loc23_.head;
                     _loc23_.head = _loc11_;
                     _loc23_.modified = true;
                     _loc23_.length = _loc23_.length + 1;
                     _loc12_;
                  }
                  _loc4_.sleeping = false;
                  _loc4_.island = null;
                  _loc4_.parent = _loc4_;
                  _loc4_.rank = 0;
               }
               _loc17_ = _loc16_;
               _loc17_.next = ZPP_Island.zpp_pool;
               ZPP_Island.zpp_pool = _loc17_;
            }
         }
      }
      
      public function constraints_subber(param1:Constraint) : void
      {
         remConstraint(param1.zpp_inner);
      }
      
      public function constraints_adder(param1:Constraint) : Boolean
      {
         if(param1.zpp_inner.space != this)
         {
            if(param1.zpp_inner.space != null)
            {
               param1.zpp_inner.space.outer.zpp_inner.wrap_constraints.remove(param1);
            }
            addConstraint(param1.zpp_inner);
            return true;
         }
         return false;
      }
      
      public function constraintCbWake(param1:ZPP_Constraint) : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_ConstraintListener;
         var _loc3_:* = null as ZPP_ConstraintListener;
         var _loc4_:* = null as ZPP_Callback;
         if(param1.cbSet != null)
         {
            if(midstep)
            {
               _loc2_ = param1.cbSet.conlisteners.head;
               while(_loc2_ != null)
               {
                  _loc3_ = _loc2_.elt;
                  if(_loc3_.event != ZPP_Flags.id_CbEvent_WAKE)
                  {
                     _loc2_ = _loc2_.next;
                  }
                  else
                  {
                     _loc4_ = push_callback(_loc3_);
                     _loc4_.event = ZPP_Flags.id_CbEvent_WAKE;
                     _loc4_.constraint = param1;
                     _loc2_ = _loc2_.next;
                  }
               }
            }
            else
            {
               param1.component.woken = true;
            }
         }
      }
      
      public function constraintCbSleep(param1:ZPP_Constraint) : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_ConstraintListener;
         var _loc3_:* = null as ZPP_ConstraintListener;
         var _loc4_:* = null as ZPP_Callback;
         if(param1.cbSet != null)
         {
            _loc2_ = param1.cbSet.conlisteners.head;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.elt;
               if(_loc3_.event != ZPP_Flags.id_CbEvent_SLEEP)
               {
                  _loc2_ = _loc2_.next;
               }
               else
               {
                  _loc4_ = push_callback(_loc3_);
                  _loc4_.event = ZPP_Flags.id_CbEvent_SLEEP;
                  _loc4_.constraint = param1;
                  _loc2_ = _loc2_.next;
               }
            }
         }
      }
      
      public function constraintCbBreak(param1:ZPP_Constraint) : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_ConstraintListener;
         var _loc3_:* = null as ZPP_ConstraintListener;
         var _loc4_:* = null as ZPP_Callback;
         if(param1.cbSet != null)
         {
            _loc2_ = param1.cbSet.conlisteners.head;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.elt;
               if(_loc3_.event != ZPP_Flags.id_CbEvent_BREAK)
               {
                  _loc2_ = _loc2_.next;
               }
               else
               {
                  _loc4_ = push_callback(_loc3_);
                  _loc4_.event = ZPP_Flags.id_CbEvent_BREAK;
                  _loc4_.constraint = param1;
                  _loc2_ = _loc2_.next;
               }
            }
         }
      }
      
      public function compounds_subber(param1:Compound) : void
      {
         remCompound(param1.zpp_inner);
      }
      
      public function compounds_adder(param1:Compound) : Boolean
      {
         if(param1.zpp_inner.space != this)
         {
            if(param1.zpp_inner.space != null)
            {
               param1.zpp_inner.space.wrap_compounds.remove(param1);
            }
            addCompound(param1.zpp_inner);
            return true;
         }
         return false;
      }
      
      public function clear() : void
      {
         var _loc1_:* = null as ZPP_Listener;
         var _loc2_:* = null as ZPP_CallbackSet;
         var _loc3_:* = null as ZPP_CallbackSet;
         var _loc4_:* = null as ZPP_Interactor;
         var _loc5_:int = 0;
         var _loc6_:* = null as ZPP_ColArbiter;
         var _loc7_:* = null as ZNPList_ZPP_Arbiter;
         var _loc8_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc9_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc10_:Boolean = false;
         var _loc11_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc12_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc13_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc14_:* = null as ZPP_Body;
         var _loc15_:* = null as ZPP_Contact;
         var _loc16_:* = null as ZPP_Contact;
         var _loc17_:* = null as ZPP_Contact;
         var _loc18_:* = null as ZPP_IContact;
         var _loc19_:* = null as ZPP_IContact;
         var _loc20_:* = null as ZPP_ColArbiter;
         var _loc21_:* = null as ZPP_SensorArbiter;
         var _loc22_:* = null as ZPP_SensorArbiter;
         var _loc23_:* = null as ZPP_FluidArbiter;
         var _loc24_:* = null as ZPP_FluidArbiter;
         var _loc25_:* = null as ZPP_Island;
         var _loc26_:* = null as ZPP_Component;
         var _loc27_:* = null as ZPP_Island;
         var _loc28_:* = null as ZPP_Constraint;
         var _loc30_:* = null as ZPP_Compound;
         var _loc31_:* = null as ZNPNode_ZPP_Body;
         var _loc32_:* = null as ZNPNode_ZPP_Constraint;
         var _loc33_:* = null as ZNPNode_ZPP_Compound;
         var _loc34_:* = null as ZPP_Compound;
         global_lin_drag = 0.015;
         global_ang_drag = 0.015;
         while(listeners.head != null)
         {
            _loc1_ = listeners.pop_unsafe();
            remListener(_loc1_);
         }
         while(callbackset_list.next != null)
         {
            _loc2_ = callbackset_list.pop_unsafe();
            _loc2_.arbiters.clear();
            _loc3_ = _loc2_;
            _loc4_ = null;
            _loc3_.int2 = _loc4_;
            _loc3_.int1 = _loc4_;
            _loc5_ = -1;
            _loc3_.di = _loc5_;
            _loc3_.id = _loc5_;
            _loc3_.freed = true;
            null;
            _loc3_.next = ZPP_CallbackSet.zpp_pool;
            ZPP_CallbackSet.zpp_pool = _loc3_;
         }
         while(c_arbiters_true.head != null)
         {
            _loc6_ = c_arbiters_true.pop_unsafe();
            if(!_loc6_.cleared)
            {
               _loc7_ = _loc6_.b1.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc6_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     _loc7_.length = _loc7_.length - 1;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               _loc7_ = _loc6_.b2.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc6_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     _loc7_.length = _loc7_.length - 1;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               if(_loc6_.pair != null)
               {
                  _loc6_.pair.arb = null;
                  _loc6_.pair = null;
               }
            }
            _loc14_ = null;
            _loc6_.b2 = _loc14_;
            _loc6_.b1 = _loc14_;
            _loc6_.active = false;
            _loc6_.intchange = false;
            while(_loc6_.contacts.next != null)
            {
               _loc16_ = _loc6_.contacts;
               _loc17_ = _loc16_.next;
               _loc16_.pop();
               _loc15_ = _loc17_;
               _loc15_.arbiter = null;
               _loc15_.next = ZPP_Contact.zpp_pool;
               ZPP_Contact.zpp_pool = _loc15_;
               _loc18_ = _loc6_.innards;
               _loc19_ = _loc18_.next;
               _loc18_.next = _loc19_.next;
               _loc19_._inuse = false;
               if(_loc18_.next == null)
               {
                  _loc18_.pushmod = true;
               }
               _loc18_.modified = true;
               _loc18_.length = _loc18_.length - 1;
            }
            _loc20_ = _loc6_;
            null;
            _loc20_.next = ZPP_ColArbiter.zpp_pool;
            ZPP_ColArbiter.zpp_pool = _loc20_;
            _loc6_.pre_dt = -1;
         }
         while(c_arbiters_false.head != null)
         {
            _loc6_ = c_arbiters_false.pop_unsafe();
            if(!_loc6_.cleared)
            {
               _loc7_ = _loc6_.b1.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc6_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     _loc7_.length = _loc7_.length - 1;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               _loc7_ = _loc6_.b2.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc6_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     _loc7_.length = _loc7_.length - 1;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               if(_loc6_.pair != null)
               {
                  _loc6_.pair.arb = null;
                  _loc6_.pair = null;
               }
            }
            _loc14_ = null;
            _loc6_.b2 = _loc14_;
            _loc6_.b1 = _loc14_;
            _loc6_.active = false;
            _loc6_.intchange = false;
            while(_loc6_.contacts.next != null)
            {
               _loc16_ = _loc6_.contacts;
               _loc17_ = _loc16_.next;
               _loc16_.pop();
               _loc15_ = _loc17_;
               _loc15_.arbiter = null;
               _loc15_.next = ZPP_Contact.zpp_pool;
               ZPP_Contact.zpp_pool = _loc15_;
               _loc18_ = _loc6_.innards;
               _loc19_ = _loc18_.next;
               _loc18_.next = _loc19_.next;
               _loc19_._inuse = false;
               if(_loc18_.next == null)
               {
                  _loc18_.pushmod = true;
               }
               _loc18_.modified = true;
               _loc18_.length = _loc18_.length - 1;
            }
            _loc20_ = _loc6_;
            null;
            _loc20_.next = ZPP_ColArbiter.zpp_pool;
            ZPP_ColArbiter.zpp_pool = _loc20_;
            _loc6_.pre_dt = -1;
         }
         while(s_arbiters.head != null)
         {
            _loc21_ = s_arbiters.pop_unsafe();
            if(!_loc21_.cleared)
            {
               _loc7_ = _loc21_.b1.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc21_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     _loc7_.length = _loc7_.length - 1;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               _loc7_ = _loc21_.b2.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc21_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     _loc7_.length = _loc7_.length - 1;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               if(_loc21_.pair != null)
               {
                  _loc21_.pair.arb = null;
                  _loc21_.pair = null;
               }
            }
            _loc14_ = null;
            _loc21_.b2 = _loc14_;
            _loc21_.b1 = _loc14_;
            _loc21_.active = false;
            _loc21_.intchange = false;
            _loc22_ = _loc21_;
            _loc22_.next = ZPP_SensorArbiter.zpp_pool;
            ZPP_SensorArbiter.zpp_pool = _loc22_;
         }
         while(f_arbiters.head != null)
         {
            _loc23_ = f_arbiters.pop_unsafe();
            if(!_loc23_.cleared)
            {
               _loc7_ = _loc23_.b1.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc23_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     _loc7_.length = _loc7_.length - 1;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               _loc7_ = _loc23_.b2.arbiters;
               _loc8_ = null;
               _loc9_ = _loc7_.head;
               _loc10_ = false;
               while(_loc9_ != null)
               {
                  if(_loc9_.elt == _loc23_)
                  {
                     if(_loc8_ == null)
                     {
                        _loc11_ = _loc7_.head;
                        _loc12_ = _loc11_.next;
                        _loc7_.head = _loc12_;
                        if(_loc7_.head == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc11_ = _loc8_.next;
                        _loc12_ = _loc11_.next;
                        _loc8_.next = _loc12_;
                        if(_loc12_ == null)
                        {
                           _loc7_.pushmod = true;
                        }
                     }
                     _loc13_ = _loc11_;
                     _loc13_.elt = null;
                     _loc13_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc13_;
                     _loc7_.modified = true;
                     _loc7_.length = _loc7_.length - 1;
                     _loc7_.pushmod = true;
                     _loc12_;
                     _loc10_ = true;
                     break;
                  }
                  _loc8_ = _loc9_;
                  _loc9_ = _loc9_.next;
               }
               _loc10_;
               if(_loc23_.pair != null)
               {
                  _loc23_.pair.arb = null;
                  _loc23_.pair = null;
               }
            }
            _loc14_ = null;
            _loc23_.b2 = _loc14_;
            _loc23_.b1 = _loc14_;
            _loc23_.active = false;
            _loc23_.intchange = false;
            _loc24_ = _loc23_;
            _loc24_.next = ZPP_FluidArbiter.zpp_pool;
            ZPP_FluidArbiter.zpp_pool = _loc24_;
            _loc23_.pre_dt = -1;
         }
         bphase.clear();
         while(bodies.head != null)
         {
            _loc14_ = bodies.pop_unsafe();
            if(_loc14_.component != null)
            {
               _loc25_ = _loc14_.component.island;
               if(_loc25_ != null)
               {
                  while(_loc25_.comps.head != null)
                  {
                     _loc26_ = _loc25_.comps.pop_unsafe();
                     _loc26_.sleeping = false;
                     _loc26_.island = null;
                     _loc26_.parent = _loc26_;
                     _loc26_.rank = 0;
                  }
                  _loc27_ = _loc25_;
                  _loc27_.next = ZPP_Island.zpp_pool;
                  ZPP_Island.zpp_pool = _loc27_;
               }
            }
            _loc14_.removedFromSpace();
            _loc14_.space = null;
         }
         while(constraints.head != null)
         {
            _loc28_ = constraints.pop_unsafe();
            if(_loc28_.component != null)
            {
               _loc25_ = _loc28_.component.island;
               if(_loc25_ != null)
               {
                  while(_loc25_.comps.head != null)
                  {
                     _loc26_ = _loc25_.comps.pop_unsafe();
                     _loc26_.sleeping = false;
                     _loc26_.island = null;
                     _loc26_.parent = _loc26_;
                     _loc26_.rank = 0;
                  }
                  _loc27_ = _loc25_;
                  _loc27_.next = ZPP_Island.zpp_pool;
                  ZPP_Island.zpp_pool = _loc27_;
               }
            }
            _loc28_.removedFromSpace();
            _loc28_.space = null;
         }
         kinematics.clear();
         var _loc29_:ZNPList_ZPP_Compound = new ZNPList_ZPP_Compound();
         while(compounds.head != null)
         {
            _loc30_ = compounds.pop_unsafe();
            _loc29_.add(_loc30_);
         }
         while(_loc29_.head != null)
         {
            _loc30_ = _loc29_.pop_unsafe();
            _loc30_.removedFromSpace();
            _loc30_.space = null;
            _loc31_ = _loc30_.bodies.head;
            while(_loc31_ != null)
            {
               _loc14_ = _loc31_.elt;
               if(_loc14_.component != null)
               {
                  _loc25_ = _loc14_.component.island;
                  if(_loc25_ != null)
                  {
                     while(_loc25_.comps.head != null)
                     {
                        _loc26_ = _loc25_.comps.pop_unsafe();
                        _loc26_.sleeping = false;
                        _loc26_.island = null;
                        _loc26_.parent = _loc26_;
                        _loc26_.rank = 0;
                     }
                     _loc27_ = _loc25_;
                     _loc27_.next = ZPP_Island.zpp_pool;
                     ZPP_Island.zpp_pool = _loc27_;
                  }
               }
               _loc14_.removedFromSpace();
               _loc14_.space = null;
               _loc31_ = _loc31_.next;
            }
            _loc32_ = _loc30_.constraints.head;
            while(_loc32_ != null)
            {
               _loc28_ = _loc32_.elt;
               if(_loc28_.component != null)
               {
                  _loc25_ = _loc28_.component.island;
                  if(_loc25_ != null)
                  {
                     while(_loc25_.comps.head != null)
                     {
                        _loc26_ = _loc25_.comps.pop_unsafe();
                        _loc26_.sleeping = false;
                        _loc26_.island = null;
                        _loc26_.parent = _loc26_;
                        _loc26_.rank = 0;
                     }
                     _loc27_ = _loc25_;
                     _loc27_.next = ZPP_Island.zpp_pool;
                     ZPP_Island.zpp_pool = _loc27_;
                  }
               }
               _loc28_.removedFromSpace();
               _loc28_.space = null;
               _loc32_ = _loc32_.next;
            }
            _loc33_ = _loc30_.compounds.head;
            while(_loc33_ != null)
            {
               _loc34_ = _loc33_.elt;
               _loc29_.add(_loc34_);
               _loc33_ = _loc33_.next;
            }
         }
         staticsleep.clear();
         live.clear();
         live_constraints.clear();
         stamp = 0;
         time = 0;
         gravityx = 0;
         gravityy = 0;
         mrca1.clear();
         mrca2.clear();
         prelisteners.clear();
         cbsets.clear();
      }
      
      public function bodyCbWake(param1:ZPP_Body) : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_BodyListener;
         var _loc3_:* = null as ZPP_BodyListener;
         var _loc4_:* = null as ZPP_Callback;
         if(param1.type == ZPP_Flags.id_BodyType_DYNAMIC && param1.cbSet != null)
         {
            if(midstep)
            {
               _loc2_ = param1.cbSet.bodylisteners.head;
               while(_loc2_ != null)
               {
                  _loc3_ = _loc2_.elt;
                  if(_loc3_.event != ZPP_Flags.id_CbEvent_WAKE)
                  {
                     _loc2_ = _loc2_.next;
                  }
                  else
                  {
                     _loc4_ = push_callback(_loc3_);
                     _loc4_.event = ZPP_Flags.id_CbEvent_WAKE;
                     _loc4_.body = param1;
                     _loc2_ = _loc2_.next;
                  }
               }
            }
            else
            {
               param1.component.woken = true;
            }
         }
      }
      
      public function bodyCbSleep(param1:ZPP_Body) : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_BodyListener;
         var _loc3_:* = null as ZPP_BodyListener;
         var _loc4_:* = null as ZPP_Callback;
         if(param1.type == ZPP_Flags.id_BodyType_DYNAMIC && param1.cbSet != null)
         {
            _loc2_ = param1.cbSet.bodylisteners.head;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.elt;
               if(_loc3_.event != ZPP_Flags.id_CbEvent_SLEEP)
               {
                  _loc2_ = _loc2_.next;
               }
               else
               {
                  _loc4_ = push_callback(_loc3_);
                  _loc4_.event = ZPP_Flags.id_CbEvent_SLEEP;
                  _loc4_.body = param1;
                  _loc2_ = _loc2_.next;
               }
            }
         }
      }
      
      public function bodies_subber(param1:Body) : void
      {
         remBody(param1.zpp_inner);
      }
      
      public function bodies_adder(param1:Body) : Boolean
      {
         if(param1.zpp_inner.space != this)
         {
            if(param1.zpp_inner.space != null)
            {
               param1.zpp_inner.space.outer.zpp_inner.wrap_bodies.remove(param1);
            }
            addBody(param1.zpp_inner);
            return true;
         }
         return false;
      }
      
      public function bodiesUnderPoint(param1:Number, param2:Number, param3:ZPP_InteractionFilter) : BodyList
      {
         return bphase.bodiesUnderPoint(param1,param2,param3);
      }
      
      public function bodiesInShape(param1:ZPP_Shape, param2:Boolean, param3:ZPP_InteractionFilter) : BodyList
      {
         return bphase.bodiesInShape(param1,param2,param3);
      }
      
      public function bodiesInCircle(param1:Vec2, param2:Number, param3:Boolean, param4:ZPP_InteractionFilter) : BodyList
      {
         var _loc5_:ZPP_Vec2 = param1.zpp_inner;
         §§push(bphase);
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         _loc5_ = param1.zpp_inner;
         §§push(param1.zpp_inner.x);
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         return §§pop().bodiesInCircle(§§pop(),param1.zpp_inner.y,param2,param3,param4);
      }
      
      public function bodiesInAABB(param1:AABB, param2:Boolean, param3:Boolean, param4:ZPP_InteractionFilter) : BodyList
      {
         return bphase.bodiesInAABB(param1.zpp_inner,param2,param3,param4);
      }
      
      public function added_shape(param1:ZPP_Shape, param2:Boolean = false) : void
      {
         var _loc3_:* = null as ZPP_Body;
         if(!param2)
         {
            _loc3_ = param1.body;
            if(!_loc3_.world)
            {
               _loc3_.component.waket = stamp + (!!midstep?0:1);
               if(_loc3_.component.sleeping)
               {
                  really_wake(_loc3_,false);
               }
            }
         }
         bphase.insert(param1);
         param1.addedToSpace();
      }
      
      public function add_callbackset(param1:ZPP_CallbackSet) : void
      {
         var _loc4_:* = null as ZNPNode_ZPP_CallbackSet;
         var _loc2_:ZNPList_ZPP_CallbackSet = param1.int1.cbsets;
         if(ZNPNode_ZPP_CallbackSet.zpp_pool == null)
         {
            _loc4_ = new ZNPNode_ZPP_CallbackSet();
         }
         else
         {
            _loc4_ = ZNPNode_ZPP_CallbackSet.zpp_pool;
            ZNPNode_ZPP_CallbackSet.zpp_pool = _loc4_.next;
            _loc4_.next = null;
         }
         null;
         _loc4_.elt = param1;
         var _loc3_:ZNPNode_ZPP_CallbackSet = _loc4_;
         _loc3_.next = _loc2_.head;
         _loc2_.head = _loc3_;
         _loc2_.modified = true;
         _loc2_.length = _loc2_.length + 1;
         param1;
         _loc2_ = param1.int2.cbsets;
         if(ZNPNode_ZPP_CallbackSet.zpp_pool == null)
         {
            _loc4_ = new ZNPNode_ZPP_CallbackSet();
         }
         else
         {
            _loc4_ = ZNPNode_ZPP_CallbackSet.zpp_pool;
            ZNPNode_ZPP_CallbackSet.zpp_pool = _loc4_.next;
            _loc4_.next = null;
         }
         null;
         _loc4_.elt = param1;
         _loc3_ = _loc4_;
         _loc3_.next = _loc2_.head;
         _loc2_.head = _loc3_;
         _loc2_.modified = true;
         _loc2_.length = _loc2_.length + 1;
         param1;
         var _loc5_:ZPP_CallbackSet = callbackset_list;
         param1._inuse = true;
         var _loc6_:ZPP_CallbackSet = param1;
         _loc6_.next = _loc5_.next;
         _loc5_.next = _loc6_;
         _loc5_.modified = true;
         _loc5_.length = _loc5_.length + 1;
         param1;
      }
      
      public function addListener(param1:ZPP_Listener) : void
      {
         param1.space = this;
         param1.addedToSpace();
         if(param1.interaction != null)
         {
            null;
         }
      }
      
      public function addConstraint(param1:ZPP_Constraint) : void
      {
         param1.space = this;
         param1.addedToSpace();
         if(param1.active)
         {
            param1.component.sleeping = true;
            wake_constraint(param1,true);
         }
      }
      
      public function addCompound(param1:ZPP_Compound) : void
      {
         var _loc3_:* = null as ZPP_Body;
         var _loc5_:* = null as ZPP_Constraint;
         var _loc7_:* = null as ZPP_Compound;
         param1.space = this;
         param1.addedToSpace();
         var _loc2_:ZNPNode_ZPP_Body = param1.bodies.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            addBody(_loc3_);
            _loc2_ = _loc2_.next;
         }
         var _loc4_:ZNPNode_ZPP_Constraint = param1.constraints.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            addConstraint(_loc5_);
            _loc4_ = _loc4_.next;
         }
         var _loc6_:ZNPNode_ZPP_Compound = param1.compounds.head;
         while(_loc6_ != null)
         {
            _loc7_ = _loc6_.elt;
            addCompound(_loc7_);
            _loc6_ = _loc6_.next;
         }
      }
      
      public function addBody(param1:ZPP_Body, param2:int = -1) : void
      {
         var _loc5_:* = null as ZPP_Shape;
         param1.space = this;
         param1.addedToSpace();
         param1.component.sleeping = true;
         var _loc3_:ZPP_Body = param1;
         if(!_loc3_.world)
         {
            _loc3_.component.waket = stamp + (!!midstep?0:1);
            if(_loc3_.component.sleeping)
            {
               really_wake(_loc3_,true);
            }
         }
         var _loc4_:ZNPNode_ZPP_Shape = param1.shapes.head;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_.elt;
            bphase.insert(_loc5_);
            _loc5_.addedToSpace();
            _loc4_ = _loc4_.next;
         }
         if(param1.type == ZPP_Flags.id_BodyType_STATIC)
         {
            static_validation(param1);
         }
         else if(param1.type != ZPP_Flags.id_BodyType_DYNAMIC)
         {
            if(param2 != ZPP_Flags.id_BodyType_KINEMATIC)
            {
               kinematics.add(param1);
            }
         }
      }
      
      public function MRCA_chains(param1:ZPP_Shape, param2:ZPP_Shape) : void
      {
         var _loc3_:* = null as ZNPList_ZPP_Interactor;
         var _loc4_:* = null as ZNPNode_ZPP_Interactor;
         var _loc5_:* = null as ZNPNode_ZPP_Interactor;
         var _loc6_:* = null as ZPP_Interactor;
         var _loc9_:int = 0;
         var _loc10_:int = 0;
         _loc3_ = mrca1;
         while(_loc3_.head != null)
         {
            _loc4_ = _loc3_.head;
            _loc3_.head = _loc4_.next;
            _loc5_ = _loc4_;
            _loc5_.elt = null;
            _loc5_.next = ZNPNode_ZPP_Interactor.zpp_pool;
            ZNPNode_ZPP_Interactor.zpp_pool = _loc5_;
            if(_loc3_.head == null)
            {
               _loc3_.pushmod = true;
            }
            _loc3_.modified = true;
            _loc3_.length = _loc3_.length - 1;
         }
         _loc3_.pushmod = true;
         _loc3_ = mrca2;
         while(_loc3_.head != null)
         {
            _loc4_ = _loc3_.head;
            _loc3_.head = _loc4_.next;
            _loc5_ = _loc4_;
            _loc5_.elt = null;
            _loc5_.next = ZNPNode_ZPP_Interactor.zpp_pool;
            ZNPNode_ZPP_Interactor.zpp_pool = _loc5_;
            if(_loc3_.head == null)
            {
               _loc3_.pushmod = true;
            }
            _loc3_.modified = true;
            _loc3_.length = _loc3_.length - 1;
         }
         _loc3_.pushmod = true;
         if(param1.cbSet != null)
         {
            _loc3_ = mrca1;
            if(ZNPNode_ZPP_Interactor.zpp_pool == null)
            {
               _loc5_ = new ZNPNode_ZPP_Interactor();
            }
            else
            {
               _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
               ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            null;
            _loc5_.elt = param1;
            _loc4_ = _loc5_;
            _loc4_.next = _loc3_.head;
            _loc3_.head = _loc4_;
            _loc3_.modified = true;
            _loc3_.length = _loc3_.length + 1;
            param1;
         }
         if(param1.body.cbSet != null)
         {
            _loc3_ = mrca1;
            _loc6_ = param1.body;
            if(ZNPNode_ZPP_Interactor.zpp_pool == null)
            {
               _loc5_ = new ZNPNode_ZPP_Interactor();
            }
            else
            {
               _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
               ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            null;
            _loc5_.elt = _loc6_;
            _loc4_ = _loc5_;
            _loc4_.next = _loc3_.head;
            _loc3_.head = _loc4_;
            _loc3_.modified = true;
            _loc3_.length = _loc3_.length + 1;
            _loc6_;
         }
         if(param2.cbSet != null)
         {
            _loc3_ = mrca2;
            if(ZNPNode_ZPP_Interactor.zpp_pool == null)
            {
               _loc5_ = new ZNPNode_ZPP_Interactor();
            }
            else
            {
               _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
               ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            null;
            _loc5_.elt = param2;
            _loc4_ = _loc5_;
            _loc4_.next = _loc3_.head;
            _loc3_.head = _loc4_;
            _loc3_.modified = true;
            _loc3_.length = _loc3_.length + 1;
            param2;
         }
         if(param2.body.cbSet != null)
         {
            _loc3_ = mrca2;
            _loc6_ = param2.body;
            if(ZNPNode_ZPP_Interactor.zpp_pool == null)
            {
               _loc5_ = new ZNPNode_ZPP_Interactor();
            }
            else
            {
               _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
               ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
               _loc5_.next = null;
            }
            null;
            _loc5_.elt = _loc6_;
            _loc4_ = _loc5_;
            _loc4_.next = _loc3_.head;
            _loc3_.head = _loc4_;
            _loc3_.modified = true;
            _loc3_.length = _loc3_.length + 1;
            _loc6_;
         }
         var _loc7_:ZPP_Compound = param1.body.compound;
         var _loc8_:ZPP_Compound = param2.body.compound;
         while(_loc7_ != _loc8_)
         {
            _loc9_ = _loc7_ == null?0:_loc7_.depth;
            _loc10_ = _loc8_ == null?0:_loc8_.depth;
            if(_loc9_ < _loc10_)
            {
               if(_loc8_.cbSet != null)
               {
                  _loc3_ = mrca2;
                  if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                  {
                     _loc5_ = new ZNPNode_ZPP_Interactor();
                  }
                  else
                  {
                     _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
                     ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
                     _loc5_.next = null;
                  }
                  null;
                  _loc5_.elt = _loc8_;
                  _loc4_ = _loc5_;
                  _loc4_.next = _loc3_.head;
                  _loc3_.head = _loc4_;
                  _loc3_.modified = true;
                  _loc3_.length = _loc3_.length + 1;
                  _loc8_;
               }
               _loc8_ = _loc8_.compound;
            }
            else
            {
               if(_loc7_.cbSet != null)
               {
                  _loc3_ = mrca1;
                  if(ZNPNode_ZPP_Interactor.zpp_pool == null)
                  {
                     _loc5_ = new ZNPNode_ZPP_Interactor();
                  }
                  else
                  {
                     _loc5_ = ZNPNode_ZPP_Interactor.zpp_pool;
                     ZNPNode_ZPP_Interactor.zpp_pool = _loc5_.next;
                     _loc5_.next = null;
                  }
                  null;
                  _loc5_.elt = _loc7_;
                  _loc4_ = _loc5_;
                  _loc4_.next = _loc3_.head;
                  _loc3_.head = _loc4_;
                  _loc3_.modified = true;
                  _loc3_.length = _loc3_.length + 1;
                  _loc7_;
               }
               _loc7_ = _loc7_.compound;
            }
         }
      }
   }
}
