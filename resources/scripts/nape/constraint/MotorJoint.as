package nape.constraint
{
   import flash.Boot;
   import nape.geom.MatMN;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.space.Space;
   import zpp_nape.constraint.ZPP_MotorJoint;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.space.ZPP_Space;
   
   public class MotorJoint extends Constraint
   {
       
      
      public var zpp_inner_zn:ZPP_MotorJoint;
      
      public function MotorJoint(param1:Body, param2:Body, param3:Number = 0.0, param4:Number = 1.0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner_zn = new ZPP_MotorJoint();
         zpp_inner = zpp_inner_zn;
         zpp_inner.outer = this;
         zpp_inner_zn.outer_zn = this;
         super();
         zpp_inner.immutable_midstep("Constraint::" + "body1");
         var _loc5_:ZPP_Body = param1 == null?null:param1.zpp_inner;
         if(_loc5_ != zpp_inner_zn.b1)
         {
            if(zpp_inner_zn.b1 != null)
            {
               if(false)
               {
                  if(zpp_inner_zn.b1 != null)
                  {
                     zpp_inner_zn.b1.constraints.remove(zpp_inner);
                  }
               }
               §§push(false);
            }
            zpp_inner_zn.b1 = _loc5_;
            if(false && zpp_inner_zn.b2 != _loc5_)
            {
               if(_loc5_ != null)
               {
                  _loc5_.constraints.add(zpp_inner);
               }
            }
            §§push(false);
         }
         if(zpp_inner_zn.b1 == null)
         {
            null;
         }
         else
         {
            zpp_inner_zn.b1.outer;
         }
         zpp_inner.immutable_midstep("Constraint::" + "body2");
         _loc5_ = param2 == null?null:param2.zpp_inner;
         if(_loc5_ != zpp_inner_zn.b2)
         {
            if(zpp_inner_zn.b2 != null)
            {
               if(false)
               {
                  if(zpp_inner_zn.b2 != null)
                  {
                     zpp_inner_zn.b2.constraints.remove(zpp_inner);
                  }
               }
               §§push(false);
            }
            zpp_inner_zn.b2 = _loc5_;
            if(false && zpp_inner_zn.b1 != _loc5_)
            {
               if(_loc5_ != null)
               {
                  _loc5_.constraints.add(zpp_inner);
               }
            }
            §§push(false);
         }
         if(zpp_inner_zn.b2 == null)
         {
            null;
         }
         else
         {
            zpp_inner_zn.b2.outer;
         }
         zpp_inner.immutable_midstep("MotorJoint::rate");
         if(zpp_inner_zn.rate != param3)
         {
            zpp_inner_zn.rate = param3;
            zpp_inner.wake();
         }
         zpp_inner_zn.rate;
         zpp_inner.immutable_midstep("MotorJoint::ratio");
         if(zpp_inner_zn.ratio != param4)
         {
            zpp_inner_zn.ratio = param4;
            zpp_inner.wake();
         }
         zpp_inner_zn.ratio;
      }
      
      override public function visitBodies(param1:Function) : void
      {
         if(false)
         {
            param1(zpp_inner_zn.b2 == null?null:zpp_inner_zn.b2.outer);
         }
      }
      
      public function set ratio(param1:Number) : Number
      {
         zpp_inner.immutable_midstep("MotorJoint::ratio");
         if(zpp_inner_zn.ratio != param1)
         {
            zpp_inner_zn.ratio = param1;
            zpp_inner.wake();
         }
         return zpp_inner_zn.ratio;
      }
      
      public function set rate(param1:Number) : Number
      {
         zpp_inner.immutable_midstep("MotorJoint::rate");
         if(zpp_inner_zn.rate != param1)
         {
            zpp_inner_zn.rate = param1;
            zpp_inner.wake();
         }
         return zpp_inner_zn.rate;
      }
      
      public function set body2(param1:Body) : Body
      {
         zpp_inner.immutable_midstep("Constraint::" + "body2");
         var _loc2_:ZPP_Body = param1 == null?null:param1.zpp_inner;
         if(_loc2_ != zpp_inner_zn.b2)
         {
            if(zpp_inner_zn.b2 != null)
            {
               if(false)
               {
                  if(zpp_inner_zn.b2 != null)
                  {
                     zpp_inner_zn.b2.constraints.remove(zpp_inner);
                  }
               }
               §§push(false);
            }
            zpp_inner_zn.b2 = _loc2_;
            if(false && zpp_inner_zn.b1 != _loc2_)
            {
               if(_loc2_ != null)
               {
                  _loc2_.constraints.add(zpp_inner);
               }
            }
            §§push(false);
         }
         return zpp_inner_zn.b2 == null?null:zpp_inner_zn.b2.outer;
      }
      
      public function set body1(param1:Body) : Body
      {
         zpp_inner.immutable_midstep("Constraint::" + "body1");
         var _loc2_:ZPP_Body = param1 == null?null:param1.zpp_inner;
         if(_loc2_ != zpp_inner_zn.b1)
         {
            if(zpp_inner_zn.b1 != null)
            {
               if(false)
               {
                  if(zpp_inner_zn.b1 != null)
                  {
                     zpp_inner_zn.b1.constraints.remove(zpp_inner);
                  }
               }
               §§push(false);
            }
            zpp_inner_zn.b1 = _loc2_;
            if(false && zpp_inner_zn.b2 != _loc2_)
            {
               if(_loc2_ != null)
               {
                  _loc2_.constraints.add(zpp_inner);
               }
            }
            §§push(false);
         }
         return zpp_inner_zn.b1 == null?null:zpp_inner_zn.b1.outer;
      }
      
      override public function impulse() : MatMN
      {
         var _loc1_:MatMN = new MatMN(1,1);
         _loc1_.zpp_inner.x[0 * _loc1_.zpp_inner.n] = Number(zpp_inner_zn.jAcc + zpp_inner_zn.pjAcc);
         return _loc1_;
      }
      
      public function get ratio() : Number
      {
         return zpp_inner_zn.ratio;
      }
      
      public function get rate() : Number
      {
         return zpp_inner_zn.rate;
      }
      
      public function get body2() : Body
      {
         return zpp_inner_zn.b2 == null?null:zpp_inner_zn.b2.outer;
      }
      
      public function get body1() : Body
      {
         return zpp_inner_zn.b1 == null?null:zpp_inner_zn.b1.outer;
      }
      
      override public function bodyImpulse(param1:Body) : Vec3
      {
         if(!zpp_inner.active)
         {
            return Vec3.get();
         }
         return zpp_inner_zn.bodyImpulse(param1.zpp_inner);
      }
   }
}
