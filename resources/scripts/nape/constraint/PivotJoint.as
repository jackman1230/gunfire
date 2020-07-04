package nape.constraint
{
   import flash.Boot;
   import nape.geom.MatMN;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.space.Space;
   import zpp_nape.constraint.ZPP_PivotJoint;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.space.ZPP_Space;
   
   public class PivotJoint extends Constraint
   {
       
      
      public var zpp_inner_zn:ZPP_PivotJoint;
      
      public function PivotJoint(param1:Body, param2:Body, param3:Vec2, param4:Vec2)
      {
         var _loc9_:* = null as ZPP_Vec2;
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner_zn = new ZPP_PivotJoint();
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
         if(zpp_inner_zn.wrap_a1 == null)
         {
            zpp_inner_zn.setup_a1();
         }
         var _loc6_:Vec2 = zpp_inner_zn.wrap_a1;
         _loc9_ = param3.zpp_inner;
         if(_loc9_._validate != null)
         {
            _loc9_._validate();
         }
         var _loc8_:Number = param3.zpp_inner.x;
         _loc9_ = param3.zpp_inner;
         if(_loc9_._validate != null)
         {
            _loc9_._validate();
         }
         var _loc10_:Number = param3.zpp_inner.y;
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
         if(param3.zpp_inner.weak)
         {
            param3.dispose();
         }
         _loc7_;
         if(zpp_inner_zn.wrap_a1 == null)
         {
            zpp_inner_zn.setup_a1();
         }
         zpp_inner_zn.wrap_a1;
         if(zpp_inner_zn.wrap_a2 == null)
         {
            zpp_inner_zn.setup_a2();
         }
         _loc6_ = zpp_inner_zn.wrap_a2;
         _loc9_ = param4.zpp_inner;
         if(_loc9_._validate != null)
         {
            _loc9_._validate();
         }
         _loc8_ = param4.zpp_inner.x;
         _loc9_ = param4.zpp_inner;
         if(_loc9_._validate != null)
         {
            _loc9_._validate();
         }
         _loc10_ = param4.zpp_inner.y;
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
         _loc7_ = _loc6_;
         if(param4.zpp_inner.weak)
         {
            param4.dispose();
         }
         _loc7_;
         if(zpp_inner_zn.wrap_a2 == null)
         {
            zpp_inner_zn.setup_a2();
         }
         zpp_inner_zn.wrap_a2;
      }
      
      override public function visitBodies(param1:Function) : void
      {
         if(false)
         {
            param1(zpp_inner_zn.b2 == null?null:zpp_inner_zn.b2.outer);
         }
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
      
      public function set anchor2(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         if(zpp_inner_zn.wrap_a2 == null)
         {
            zpp_inner_zn.setup_a2();
         }
         var _loc2_:Vec2 = zpp_inner_zn.wrap_a2;
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
         if(zpp_inner_zn.wrap_a2 == null)
         {
            zpp_inner_zn.setup_a2();
         }
         return zpp_inner_zn.wrap_a2;
      }
      
      public function set anchor1(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         if(zpp_inner_zn.wrap_a1 == null)
         {
            zpp_inner_zn.setup_a1();
         }
         var _loc2_:Vec2 = zpp_inner_zn.wrap_a1;
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
         if(zpp_inner_zn.wrap_a1 == null)
         {
            zpp_inner_zn.setup_a1();
         }
         return zpp_inner_zn.wrap_a1;
      }
      
      override public function impulse() : MatMN
      {
         var _loc1_:MatMN = new MatMN(2,1);
         _loc1_.zpp_inner.x[0 * _loc1_.zpp_inner.n] = Number(zpp_inner_zn.jAccx + zpp_inner_zn.pjAccx);
         _loc1_.zpp_inner.x[_loc1_.zpp_inner.n] = Number(zpp_inner_zn.jAccy + zpp_inner_zn.pjAccy);
         return _loc1_;
      }
      
      public function get body2() : Body
      {
         return zpp_inner_zn.b2 == null?null:zpp_inner_zn.b2.outer;
      }
      
      public function get body1() : Body
      {
         return zpp_inner_zn.b1 == null?null:zpp_inner_zn.b1.outer;
      }
      
      public function get anchor2() : Vec2
      {
         if(zpp_inner_zn.wrap_a2 == null)
         {
            zpp_inner_zn.setup_a2();
         }
         return zpp_inner_zn.wrap_a2;
      }
      
      public function get anchor1() : Vec2
      {
         if(zpp_inner_zn.wrap_a1 == null)
         {
            zpp_inner_zn.setup_a1();
         }
         return zpp_inner_zn.wrap_a1;
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
