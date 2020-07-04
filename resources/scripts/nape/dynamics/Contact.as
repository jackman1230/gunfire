package nape.dynamics
{
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.dynamics.ZPP_ColArbiter;
   import zpp_nape.dynamics.ZPP_Contact;
   import zpp_nape.dynamics.ZPP_IContact;
   import zpp_nape.geom.ZPP_Vec2;
   
   public class Contact
   {
       
      
      public var zpp_inner:ZPP_Contact;
      
      public function Contact()
      {
      }
      
      public function totalImpulse(param1:Body = undefined) : Vec3
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc2_:ZPP_ColArbiter = zpp_inner.arbiter.colarb;
         var _loc3_:ZPP_IContact = zpp_inner.inner;
         var _loc4_:Number = Number(_loc3_.jnAcc + zpp_inner.pjnAcc);
         var _loc5_:Number = Number(_loc3_.jtAcc + zpp_inner.pjtAcc);
         var _loc6_:Number = Number(_loc2_.jrAcc + _loc2_.pjrAcc);
         if(param1 == null)
         {
            return Vec3.get(_loc2_.nx * _loc4_ - _loc2_.ny * _loc5_,Number(_loc2_.ny * _loc4_ + _loc2_.nx * _loc5_),_loc6_);
         }
         _loc7_ = _loc2_.nx * _loc4_ - _loc2_.ny * _loc5_;
         _loc8_ = Number(_loc2_.ny * _loc4_ + _loc2_.nx * _loc5_);
         if(param1 == _loc2_.b1.outer)
         {
            return Vec3.get(-_loc7_,-_loc8_,-(_loc8_ * _loc3_.r1x - _loc7_ * _loc3_.r1y) - _loc6_);
         }
         return Vec3.get(_loc7_,_loc8_,Number(_loc8_ * _loc3_.r2x - _loc7_ * _loc3_.r2y + _loc6_));
      }
      
      public function toString() : String
      {
         if(zpp_inner.arbiter == null || zpp_inner.arbiter.cleared)
         {
            return "{object-pooled}";
         }
         return "{Contact}";
      }
      
      public function tangentImpulse(param1:Body = undefined) : Vec3
      {
         var _loc2_:ZPP_ColArbiter = zpp_inner.arbiter.colarb;
         var _loc3_:ZPP_IContact = zpp_inner.inner;
         var _loc4_:Number = Number(_loc3_.jtAcc + zpp_inner.pjtAcc);
         if(param1 == null)
         {
            return Vec3.get(-_loc2_.ny * _loc4_,_loc2_.nx * _loc4_);
         }
         if(param1 == _loc2_.b1.outer)
         {
            return Vec3.get(_loc2_.ny * _loc4_,-_loc2_.nx * _loc4_,-(_loc3_.r1x * _loc2_.nx + _loc3_.r1y * _loc2_.ny) * _loc4_);
         }
         return Vec3.get(-_loc2_.ny * _loc4_,_loc2_.nx * _loc4_,(_loc3_.r2x * _loc2_.nx + _loc3_.r2y * _loc2_.ny) * _loc4_);
      }
      
      public function set position(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         if(zpp_inner.wrap_position == null)
         {
            zpp_inner.getposition();
         }
         var _loc2_:Vec2 = zpp_inner.wrap_position;
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
         if(zpp_inner.wrap_position == null)
         {
            zpp_inner.getposition();
         }
         return zpp_inner.wrap_position;
      }
      
      public function set penetration(param1:Number) : Number
      {
         zpp_inner.dist = -param1;
         return -zpp_inner.dist;
      }
      
      public function rollingImpulse(param1:Body = undefined) : Number
      {
         var _loc2_:ZPP_ColArbiter = zpp_inner.arbiter.colarb;
         var _loc3_:Number = Number(zpp_inner.arbiter.colarb.jrAcc + zpp_inner.arbiter.colarb.pjrAcc);
         if(param1 == null)
         {
            return _loc3_;
         }
         if(param1 == _loc2_.b1.outer)
         {
            return -_loc3_;
         }
         return _loc3_;
      }
      
      public function normalImpulse(param1:Body = undefined) : Vec3
      {
         var _loc2_:ZPP_ColArbiter = zpp_inner.arbiter.colarb;
         var _loc3_:ZPP_IContact = zpp_inner.inner;
         var _loc4_:Number = Number(_loc3_.jnAcc + zpp_inner.pjnAcc);
         if(param1 == null)
         {
            return Vec3.get(_loc2_.nx * _loc4_,_loc2_.ny * _loc4_);
         }
         if(param1 == _loc2_.b1.outer)
         {
            return Vec3.get(_loc2_.nx * -_loc4_,_loc2_.ny * -_loc4_,-(_loc2_.ny * _loc3_.r1x - _loc2_.nx * _loc3_.r1y) * _loc4_);
         }
         return Vec3.get(_loc2_.nx * _loc4_,_loc2_.ny * _loc4_,(_loc2_.ny * _loc3_.r2x - _loc2_.nx * _loc3_.r2y) * _loc4_);
      }
      
      public function get rollingFriction() : Number
      {
         return zpp_inner.arbiter.colarb.rfric;
      }
      
      public function get restitution() : Number
      {
         return zpp_inner.elasticity;
      }
      
      public function get position() : Vec2
      {
         if(zpp_inner.wrap_position == null)
         {
            zpp_inner.getposition();
         }
         return zpp_inner.wrap_position;
      }
      
      public function get penetration() : Number
      {
         return -zpp_inner.dist;
      }
      
      public function get friction() : Number
      {
         return zpp_inner.inner.friction;
      }
      
      public function get fresh() : Boolean
      {
         return zpp_inner.fresh;
      }
      
      public function get arbiter() : CollisionArbiter
      {
         var _loc1_:* = null as Arbiter;
         if(zpp_inner.arbiter == null)
         {
            §§push(null);
         }
         else
         {
            _loc1_ = zpp_inner.arbiter.outer;
            §§push(!!_loc1_.isCollisionArbiter()?_loc1_.zpp_inner.colarb.outer_zn:null);
         }
         return §§pop();
      }
      
      public function get active() : Boolean
      {
         return !!zpp_inner.active && zpp_inner.arbiter != null && zpp_inner.arbiter.active;
      }
   }
}
