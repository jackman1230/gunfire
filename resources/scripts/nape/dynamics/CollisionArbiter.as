package nape.dynamics
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import zpp_nape.dynamics.ZPP_ColArbiter;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.geom.ZPP_Vec3;
   
   public class CollisionArbiter extends Arbiter
   {
       
      
      public function CollisionArbiter()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
      }
      
      override public function totalImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
      {
         var _loc7_:* = null as Vec3;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = null as ZPP_Vec3;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:ZPP_ColArbiter = zpp_inner.colarb;
         if(!param2 || _loc6_.oc1.fresh)
         {
            _loc7_ = _loc6_.oc1.wrapper().totalImpulse(param1);
            _loc8_ = 1;
            _loc9_ = _loc8_;
            _loc10_ = _loc7_.zpp_inner;
            §§push(_loc3_);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc3_ = Number(§§pop() + _loc7_.zpp_inner.x * _loc9_);
            _loc10_ = _loc7_.zpp_inner;
            §§push(_loc4_);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc4_ = Number(§§pop() + _loc7_.zpp_inner.y * _loc9_);
            _loc10_ = _loc7_.zpp_inner;
            §§push(_loc5_);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc5_ = Number(§§pop() + _loc7_.zpp_inner.z * _loc8_);
            _loc7_.dispose();
         }
         if(_loc6_.hc2)
         {
            if(!param2 || _loc6_.oc2.fresh)
            {
               _loc7_ = _loc6_.oc2.wrapper().totalImpulse(param1);
               _loc8_ = 1;
               _loc9_ = _loc8_;
               _loc10_ = _loc7_.zpp_inner;
               §§push(_loc3_);
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc3_ = Number(§§pop() + _loc7_.zpp_inner.x * _loc9_);
               _loc10_ = _loc7_.zpp_inner;
               §§push(_loc4_);
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc4_ = Number(§§pop() + _loc7_.zpp_inner.y * _loc9_);
               _loc10_ = _loc7_.zpp_inner;
               §§push(_loc5_);
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc5_ = Number(§§pop() + _loc7_.zpp_inner.z * _loc8_);
               _loc7_.dispose();
            }
         }
         return Vec3.get(_loc3_,_loc4_,_loc5_);
      }
      
      public function tangentImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
      {
         var _loc7_:* = null as Vec3;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = null as ZPP_Vec3;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:ZPP_ColArbiter = zpp_inner.colarb;
         if(!param2 || _loc6_.oc1.fresh)
         {
            _loc7_ = _loc6_.oc1.wrapper().tangentImpulse(param1);
            _loc8_ = 1;
            _loc9_ = _loc8_;
            _loc10_ = _loc7_.zpp_inner;
            §§push(_loc3_);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc3_ = Number(§§pop() + _loc7_.zpp_inner.x * _loc9_);
            _loc10_ = _loc7_.zpp_inner;
            §§push(_loc4_);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc4_ = Number(§§pop() + _loc7_.zpp_inner.y * _loc9_);
            _loc10_ = _loc7_.zpp_inner;
            §§push(_loc5_);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc5_ = Number(§§pop() + _loc7_.zpp_inner.z * _loc8_);
            _loc7_.dispose();
         }
         if(_loc6_.hc2)
         {
            if(!param2 || _loc6_.oc2.fresh)
            {
               _loc7_ = _loc6_.oc2.wrapper().tangentImpulse(param1);
               _loc8_ = 1;
               _loc9_ = _loc8_;
               _loc10_ = _loc7_.zpp_inner;
               §§push(_loc3_);
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc3_ = Number(§§pop() + _loc7_.zpp_inner.x * _loc9_);
               _loc10_ = _loc7_.zpp_inner;
               §§push(_loc4_);
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc4_ = Number(§§pop() + _loc7_.zpp_inner.y * _loc9_);
               _loc10_ = _loc7_.zpp_inner;
               §§push(_loc5_);
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc5_ = Number(§§pop() + _loc7_.zpp_inner.z * _loc8_);
               _loc7_.dispose();
            }
         }
         return Vec3.get(_loc3_,_loc4_,_loc5_);
      }
      
      public function set radius(param1:Number) : Number
      {
         zpp_inner.colarb.radius = param1;
         return zpp_inner.colarb.radius;
      }
      
      public function set normal(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         if(zpp_inner.colarb.wrap_normal == null)
         {
            zpp_inner.colarb.getnormal();
         }
         var _loc2_:Vec2 = zpp_inner.colarb.wrap_normal;
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
         if(zpp_inner.colarb.wrap_normal == null)
         {
            zpp_inner.colarb.getnormal();
         }
         return zpp_inner.colarb.wrap_normal;
      }
      
      public function rollingImpulse(param1:Body = undefined, param2:Boolean = false) : Number
      {
         var _loc3_:ZPP_ColArbiter = zpp_inner.colarb;
         if(!param2 || _loc3_.oc1.fresh)
         {
            return Number(_loc3_.oc1.wrapper().rollingImpulse(param1));
         }
         return 0;
      }
      
      public function normalImpulse(param1:Body = undefined, param2:Boolean = false) : Vec3
      {
         var _loc7_:* = null as Vec3;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:* = null as ZPP_Vec3;
         var _loc3_:Number = 0;
         var _loc4_:Number = 0;
         var _loc5_:Number = 0;
         var _loc6_:ZPP_ColArbiter = zpp_inner.colarb;
         if(!param2 || _loc6_.oc1.fresh)
         {
            _loc7_ = _loc6_.oc1.wrapper().normalImpulse(param1);
            _loc8_ = 1;
            _loc9_ = _loc8_;
            _loc10_ = _loc7_.zpp_inner;
            §§push(_loc3_);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc3_ = Number(§§pop() + _loc7_.zpp_inner.x * _loc9_);
            _loc10_ = _loc7_.zpp_inner;
            §§push(_loc4_);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc4_ = Number(§§pop() + _loc7_.zpp_inner.y * _loc9_);
            _loc10_ = _loc7_.zpp_inner;
            §§push(_loc5_);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc5_ = Number(§§pop() + _loc7_.zpp_inner.z * _loc8_);
            _loc7_.dispose();
         }
         if(_loc6_.hc2)
         {
            if(!param2 || _loc6_.oc2.fresh)
            {
               _loc7_ = _loc6_.oc2.wrapper().normalImpulse(param1);
               _loc8_ = 1;
               _loc9_ = _loc8_;
               _loc10_ = _loc7_.zpp_inner;
               §§push(_loc3_);
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc3_ = Number(§§pop() + _loc7_.zpp_inner.x * _loc9_);
               _loc10_ = _loc7_.zpp_inner;
               §§push(_loc4_);
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc4_ = Number(§§pop() + _loc7_.zpp_inner.y * _loc9_);
               _loc10_ = _loc7_.zpp_inner;
               §§push(_loc5_);
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc5_ = Number(§§pop() + _loc7_.zpp_inner.z * _loc8_);
               _loc7_.dispose();
            }
         }
         return Vec3.get(_loc3_,_loc4_,_loc5_);
      }
      
      public function get staticFriction() : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc1_:ZPP_ColArbiter = zpp_inner.colarb;
         if(_loc1_.invalidated)
         {
            _loc1_.invalidated = false;
            if(_loc1_.s1.material.elasticity <= -1.79e308 || _loc1_.s2.material.elasticity <= -1.79e308)
            {
               _loc1_.restitution = 0;
            }
            else if(_loc1_.s1.material.elasticity >= 1.79e308 || _loc1_.s2.material.elasticity >= 1.79e308)
            {
               _loc1_.restitution = 1;
            }
            else
            {
               _loc1_.restitution = (_loc1_.s1.material.elasticity + _loc1_.s2.material.elasticity) / 2;
            }
            if(_loc1_.restitution < 0)
            {
               _loc1_.restitution = 0;
            }
            if(_loc1_.restitution > 1)
            {
               _loc1_.restitution = 1;
            }
            _loc2_ = _loc1_.s1.material.dynamicFriction * _loc1_.s2.material.dynamicFriction;
            §§push(_loc1_);
            if(_loc2_ == 0)
            {
               §§push(0);
            }
            else
            {
               sf32(_loc2_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc3_ = lf32(0);
               §§push(1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            §§pop().dyn_fric = §§pop();
            _loc2_ = _loc1_.s1.material.staticFriction * _loc1_.s2.material.staticFriction;
            §§push(_loc1_);
            if(_loc2_ == 0)
            {
               §§push(0);
            }
            else
            {
               sf32(_loc2_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc3_ = lf32(0);
               §§push(1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            §§pop().stat_fric = §§pop();
            _loc2_ = _loc1_.s1.material.rollingFriction * _loc1_.s2.material.rollingFriction;
            §§push(_loc1_);
            if(_loc2_ == 0)
            {
               §§push(0);
            }
            else
            {
               sf32(_loc2_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc3_ = lf32(0);
               §§push(1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            §§pop().rfric = §§pop();
         }
         return _loc1_.stat_fric;
      }
      
      public function get rollingFriction() : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc1_:ZPP_ColArbiter = zpp_inner.colarb;
         if(_loc1_.invalidated)
         {
            _loc1_.invalidated = false;
            if(_loc1_.s1.material.elasticity <= -1.79e308 || _loc1_.s2.material.elasticity <= -1.79e308)
            {
               _loc1_.restitution = 0;
            }
            else if(_loc1_.s1.material.elasticity >= 1.79e308 || _loc1_.s2.material.elasticity >= 1.79e308)
            {
               _loc1_.restitution = 1;
            }
            else
            {
               _loc1_.restitution = (_loc1_.s1.material.elasticity + _loc1_.s2.material.elasticity) / 2;
            }
            if(_loc1_.restitution < 0)
            {
               _loc1_.restitution = 0;
            }
            if(_loc1_.restitution > 1)
            {
               _loc1_.restitution = 1;
            }
            _loc2_ = _loc1_.s1.material.dynamicFriction * _loc1_.s2.material.dynamicFriction;
            §§push(_loc1_);
            if(_loc2_ == 0)
            {
               §§push(0);
            }
            else
            {
               sf32(_loc2_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc3_ = lf32(0);
               §§push(1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            §§pop().dyn_fric = §§pop();
            _loc2_ = _loc1_.s1.material.staticFriction * _loc1_.s2.material.staticFriction;
            §§push(_loc1_);
            if(_loc2_ == 0)
            {
               §§push(0);
            }
            else
            {
               sf32(_loc2_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc3_ = lf32(0);
               §§push(1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            §§pop().stat_fric = §§pop();
            _loc2_ = _loc1_.s1.material.rollingFriction * _loc1_.s2.material.rollingFriction;
            §§push(_loc1_);
            if(_loc2_ == 0)
            {
               §§push(0);
            }
            else
            {
               sf32(_loc2_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc3_ = lf32(0);
               §§push(1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            §§pop().rfric = §§pop();
         }
         return _loc1_.rfric;
      }
      
      public function get restitution() : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc1_:ZPP_ColArbiter = zpp_inner.colarb;
         if(_loc1_.invalidated)
         {
            _loc1_.invalidated = false;
            if(_loc1_.s1.material.elasticity <= -1.79e308 || _loc1_.s2.material.elasticity <= -1.79e308)
            {
               _loc1_.restitution = 0;
            }
            else if(_loc1_.s1.material.elasticity >= 1.79e308 || _loc1_.s2.material.elasticity >= 1.79e308)
            {
               _loc1_.restitution = 1;
            }
            else
            {
               _loc1_.restitution = (_loc1_.s1.material.elasticity + _loc1_.s2.material.elasticity) / 2;
            }
            if(_loc1_.restitution < 0)
            {
               _loc1_.restitution = 0;
            }
            if(_loc1_.restitution > 1)
            {
               _loc1_.restitution = 1;
            }
            _loc2_ = _loc1_.s1.material.dynamicFriction * _loc1_.s2.material.dynamicFriction;
            §§push(_loc1_);
            if(_loc2_ == 0)
            {
               §§push(0);
            }
            else
            {
               sf32(_loc2_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc3_ = lf32(0);
               §§push(1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            §§pop().dyn_fric = §§pop();
            _loc2_ = _loc1_.s1.material.staticFriction * _loc1_.s2.material.staticFriction;
            §§push(_loc1_);
            if(_loc2_ == 0)
            {
               §§push(0);
            }
            else
            {
               sf32(_loc2_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc3_ = lf32(0);
               §§push(1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            §§pop().stat_fric = §§pop();
            _loc2_ = _loc1_.s1.material.rollingFriction * _loc1_.s2.material.rollingFriction;
            §§push(_loc1_);
            if(_loc2_ == 0)
            {
               §§push(0);
            }
            else
            {
               sf32(_loc2_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc3_ = lf32(0);
               §§push(1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            §§pop().rfric = §§pop();
         }
         return _loc1_.restitution;
      }
      
      public function get radius() : Number
      {
         return zpp_inner.colarb.radius;
      }
      
      public function get normal() : Vec2
      {
         if(zpp_inner.colarb.wrap_normal == null)
         {
            zpp_inner.colarb.getnormal();
         }
         return zpp_inner.colarb.wrap_normal;
      }
      
      public function get dynamicFriction() : Number
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc1_:ZPP_ColArbiter = zpp_inner.colarb;
         if(_loc1_.invalidated)
         {
            _loc1_.invalidated = false;
            if(_loc1_.s1.material.elasticity <= -1.79e308 || _loc1_.s2.material.elasticity <= -1.79e308)
            {
               _loc1_.restitution = 0;
            }
            else if(_loc1_.s1.material.elasticity >= 1.79e308 || _loc1_.s2.material.elasticity >= 1.79e308)
            {
               _loc1_.restitution = 1;
            }
            else
            {
               _loc1_.restitution = (_loc1_.s1.material.elasticity + _loc1_.s2.material.elasticity) / 2;
            }
            if(_loc1_.restitution < 0)
            {
               _loc1_.restitution = 0;
            }
            if(_loc1_.restitution > 1)
            {
               _loc1_.restitution = 1;
            }
            _loc2_ = _loc1_.s1.material.dynamicFriction * _loc1_.s2.material.dynamicFriction;
            §§push(_loc1_);
            if(_loc2_ == 0)
            {
               §§push(0);
            }
            else
            {
               sf32(_loc2_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc3_ = lf32(0);
               §§push(1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            §§pop().dyn_fric = §§pop();
            _loc2_ = _loc1_.s1.material.staticFriction * _loc1_.s2.material.staticFriction;
            §§push(_loc1_);
            if(_loc2_ == 0)
            {
               §§push(0);
            }
            else
            {
               sf32(_loc2_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc3_ = lf32(0);
               §§push(1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            §§pop().stat_fric = §§pop();
            _loc2_ = _loc1_.s1.material.rollingFriction * _loc1_.s2.material.rollingFriction;
            §§push(_loc1_);
            if(_loc2_ == 0)
            {
               §§push(0);
            }
            else
            {
               sf32(_loc2_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc3_ = lf32(0);
               §§push(1 / (_loc3_ * (1.5 - 0.5 * _loc2_ * _loc3_ * _loc3_)));
            }
            §§pop().rfric = §§pop();
         }
         return _loc1_.dyn_fric;
      }
      
      public function get contacts() : ContactList
      {
         if(zpp_inner.colarb.wrap_contacts == null)
         {
            zpp_inner.colarb.setupcontacts();
         }
         return zpp_inner.colarb.wrap_contacts;
      }
   }
}
