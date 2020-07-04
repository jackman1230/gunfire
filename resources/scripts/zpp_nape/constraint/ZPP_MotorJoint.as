package zpp_nape.constraint
{
   import flash.Boot;
   import nape.constraint.Constraint;
   import nape.constraint.MotorJoint;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.space.ZPP_Component;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_MotorJoint extends ZPP_Constraint
   {
       
      
      public var stepped:Boolean;
      
      public var ratio:Number;
      
      public var rate:Number;
      
      public var pjAcc:Number;
      
      public var outer_zn:MotorJoint;
      
      public var kMass:Number;
      
      public var jMax:Number;
      
      public var jAcc:Number;
      
      public var b2:ZPP_Body;
      
      public var b1:ZPP_Body;
      
      public function ZPP_MotorJoint()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         jAcc = 0;
         stepped = false;
         __velocity = true;
      }
      
      override public function warmStart() : void
      {
         b1.angvel = b1.angvel - b1.iinertia * jAcc;
         b2.angvel = Number(b2.angvel + ratio * b2.iinertia * jAcc);
         pjAcc = jAcc;
      }
      
      override public function wake_connected() : void
      {
         if(b1 != null && b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
         {
            b1.wake();
         }
         if(b2 != null && b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
         {
            b2.wake();
         }
      }
      
      override public function validate() : void
      {
         if(b1 == null || b2 == null)
         {
            Boot.lastError = new Error();
            throw "Error: AngleJoint cannot be simulated null bodies";
         }
         if(b1 == b2)
         {
            Boot.lastError = new Error();
            throw "Error: MotorJoint cannot be simulated with body1 == body2";
         }
         if(b1.space != space || b2.space != space)
         {
            Boot.lastError = new Error();
            throw "Error: Constraints must have each body within the same space to which the constraint has been assigned";
         }
         if(b1.type != ZPP_Flags.id_BodyType_DYNAMIC && b2.type != ZPP_Flags.id_BodyType_DYNAMIC)
         {
            Boot.lastError = new Error();
            throw "Error: Constraints cannot have both bodies non-dynamic";
         }
      }
      
      override public function preStep(param1:Number) : Boolean
      {
         if(pre_dt == -1)
         {
            pre_dt = param1;
         }
         var _loc2_:Number = param1 / pre_dt;
         pre_dt = param1;
         stepped = true;
         kMass = Number(b1.sinertia + ratio * ratio * b2.sinertia);
         kMass = 1 / kMass;
         jAcc = jAcc * _loc2_;
         jMax = maxForce * param1;
         return false;
      }
      
      override public function pair_exists(param1:int, param2:int) : Boolean
      {
         return b1.id == param1 && b2.id == param2 || b1.id == param2 && b2.id == param1;
      }
      
      override public function inactiveBodies() : void
      {
         if(b1 != null)
         {
            b1.constraints.remove(this);
         }
         if(b2 != b1)
         {
            if(b2 != null)
            {
               b2.constraints.remove(this);
            }
         }
      }
      
      override public function forest() : void
      {
         var _loc1_:* = null as ZPP_Component;
         var _loc2_:* = null as ZPP_Component;
         var _loc3_:* = null as ZPP_Component;
         var _loc4_:* = null as ZPP_Component;
         var _loc5_:* = null as ZPP_Component;
         if(b1.type == ZPP_Flags.id_BodyType_DYNAMIC)
         {
            if(b1.component == b1.component.parent)
            {
               §§push(b1.component);
            }
            else
            {
               _loc2_ = b1.component;
               _loc3_ = null;
               while(_loc2_ != _loc2_.parent)
               {
                  _loc4_ = _loc2_.parent;
                  _loc2_.parent = _loc3_;
                  _loc3_ = _loc2_;
                  _loc2_ = _loc4_;
               }
               while(_loc3_ != null)
               {
                  _loc4_ = _loc3_.parent;
                  _loc3_.parent = _loc2_;
                  _loc3_ = _loc4_;
               }
               §§push(_loc2_);
            }
            _loc1_ = §§pop();
            if(component == component.parent)
            {
               §§push(component);
            }
            else
            {
               _loc3_ = component;
               _loc4_ = null;
               while(_loc3_ != _loc3_.parent)
               {
                  _loc5_ = _loc3_.parent;
                  _loc3_.parent = _loc4_;
                  _loc4_ = _loc3_;
                  _loc3_ = _loc5_;
               }
               while(_loc4_ != null)
               {
                  _loc5_ = _loc4_.parent;
                  _loc4_.parent = _loc3_;
                  _loc4_ = _loc5_;
               }
               §§push(_loc3_);
            }
            _loc2_ = §§pop();
            if(_loc1_ != _loc2_)
            {
               if(_loc1_.rank < _loc2_.rank)
               {
                  _loc1_.parent = _loc2_;
               }
               else if(_loc1_.rank > _loc2_.rank)
               {
                  _loc2_.parent = _loc1_;
               }
               else
               {
                  _loc2_.parent = _loc1_;
                  _loc1_.rank = _loc1_.rank + 1;
               }
            }
         }
         if(b2.type == ZPP_Flags.id_BodyType_DYNAMIC)
         {
            if(b2.component == b2.component.parent)
            {
               §§push(b2.component);
            }
            else
            {
               _loc2_ = b2.component;
               _loc3_ = null;
               while(_loc2_ != _loc2_.parent)
               {
                  _loc4_ = _loc2_.parent;
                  _loc2_.parent = _loc3_;
                  _loc3_ = _loc2_;
                  _loc2_ = _loc4_;
               }
               while(_loc3_ != null)
               {
                  _loc4_ = _loc3_.parent;
                  _loc3_.parent = _loc2_;
                  _loc3_ = _loc4_;
               }
               §§push(_loc2_);
            }
            _loc1_ = §§pop();
            if(component == component.parent)
            {
               §§push(component);
            }
            else
            {
               _loc3_ = component;
               _loc4_ = null;
               while(_loc3_ != _loc3_.parent)
               {
                  _loc5_ = _loc3_.parent;
                  _loc3_.parent = _loc4_;
                  _loc4_ = _loc3_;
                  _loc3_ = _loc5_;
               }
               while(_loc4_ != null)
               {
                  _loc5_ = _loc4_.parent;
                  _loc4_.parent = _loc3_;
                  _loc4_ = _loc5_;
               }
               §§push(_loc3_);
            }
            _loc2_ = §§pop();
            if(_loc1_ != _loc2_)
            {
               if(_loc1_.rank < _loc2_.rank)
               {
                  _loc1_.parent = _loc2_;
               }
               else if(_loc1_.rank > _loc2_.rank)
               {
                  _loc2_.parent = _loc1_;
               }
               else
               {
                  _loc2_.parent = _loc1_;
                  _loc1_.rank = _loc1_.rank + 1;
               }
            }
         }
      }
      
      override public function destroy() : void
      {
         b1.constraints.remove(this);
         if(b2 != b1)
         {
            b2.constraints.remove(this);
         }
      }
      
      override public function copy(param1:Array = undefined, param2:Array = undefined) : Constraint
      {
         var _loc3_:* = null as Body;
         var _loc4_:int = 0;
         var _loc5_:* = null as ZPP_CopyHelper;
         var ret:MotorJoint = new MotorJoint(null,null,rate,ratio);
         copyto(ret);
         if(param1 != null && b1 != null)
         {
            _loc3_ = null;
            _loc4_ = 0;
            while(_loc4_ < int(param1.length))
            {
               _loc5_ = param1[_loc4_];
               _loc4_++;
               if(_loc5_.id == b1.id)
               {
                  _loc3_ = _loc5_.bc;
                  break;
               }
            }
            if(_loc3_ != null)
            {
               ret.zpp_inner_zn.b1 = _loc3_.zpp_inner;
            }
            else
            {
               param2.push(ZPP_CopyHelper.todo(b1.id,function(param1:Body):void
               {
                  ret.zpp_inner_zn.b1 = param1.zpp_inner;
               }));
            }
         }
         if(param1 != null && b2 != null)
         {
            _loc3_ = null;
            _loc4_ = 0;
            while(_loc4_ < int(param1.length))
            {
               _loc5_ = param1[_loc4_];
               _loc4_++;
               if(_loc5_.id == b2.id)
               {
                  _loc3_ = _loc5_.bc;
                  break;
               }
            }
            if(_loc3_ != null)
            {
               ret.zpp_inner_zn.b2 = _loc3_.zpp_inner;
            }
            else
            {
               param2.push(ZPP_CopyHelper.todo(b2.id,function(param1:Body):void
               {
                  ret.zpp_inner_zn.b2 = param1.zpp_inner;
               }));
            }
         }
         return ret;
      }
      
      override public function clearcache() : void
      {
         jAcc = 0;
         pjAcc = 0;
         pre_dt = -1;
      }
      
      public function bodyImpulse(param1:ZPP_Body) : Vec3
      {
         if(stepped)
         {
            if(param1 == b1)
            {
               return Vec3.get(0,0,-(pjAcc + jAcc));
            }
            return Vec3.get(0,0,ratio * (pjAcc + jAcc));
         }
         return Vec3.get(0,0,0);
      }
      
      override public function applyImpulseVel() : Boolean
      {
         var _loc1_:Number = ratio * (b2.angvel + b2.kinangvel) - b1.angvel - b1.kinangvel - rate;
         var _loc2_:Number = -kMass * _loc1_;
         var _loc3_:Number = jAcc;
         jAcc = Number(jAcc + _loc2_);
         if(breakUnderForce)
         {
            if(jAcc > jMax || jAcc < -jMax)
            {
               return true;
            }
         }
         else if(jAcc < -jMax)
         {
            jAcc = -jMax;
         }
         else if(jAcc > jMax)
         {
            jAcc = jMax;
         }
         _loc2_ = jAcc - _loc3_;
         b1.angvel = b1.angvel - b1.iinertia * _loc2_;
         b2.angvel = Number(b2.angvel + ratio * b2.iinertia * _loc2_);
         return false;
      }
      
      override public function applyImpulsePos() : Boolean
      {
         return false;
      }
      
      override public function activeBodies() : void
      {
         if(b1 != null)
         {
            b1.constraints.add(this);
         }
         if(b2 != b1)
         {
            if(b2 != null)
            {
               b2.constraints.add(this);
            }
         }
      }
   }
}
