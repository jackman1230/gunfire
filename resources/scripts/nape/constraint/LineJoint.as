package nape.constraint
{
   import flash.Boot;
   import nape.geom.MatMN;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.space.Space;
   import zpp_nape.constraint.ZPP_LineJoint;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.space.ZPP_Space;
   
   public class LineJoint extends Constraint
   {
       
      
      public var zpp_inner_zn:ZPP_LineJoint;
      
      public function LineJoint(param1:Body, param2:Body, param3:Vec2, param4:Vec2, param5:Vec2, param6:Number, param7:Number)
      {
         var _loc12_:* = null as ZPP_Vec2;
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner_zn = new ZPP_LineJoint();
         zpp_inner = zpp_inner_zn;
         zpp_inner.outer = this;
         zpp_inner_zn.outer_zn = this;
         super();
         zpp_inner.immutable_midstep("Constraint::" + "body1");
         var _loc8_:ZPP_Body = param1 == null?null:param1.zpp_inner;
         if(_loc8_ != zpp_inner_zn.b1)
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
            zpp_inner_zn.b1 = _loc8_;
            if(false && zpp_inner_zn.b2 != _loc8_)
            {
               if(_loc8_ != null)
               {
                  _loc8_.constraints.add(zpp_inner);
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
         _loc8_ = param2 == null?null:param2.zpp_inner;
         if(_loc8_ != zpp_inner_zn.b2)
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
            zpp_inner_zn.b2 = _loc8_;
            if(false && zpp_inner_zn.b1 != _loc8_)
            {
               if(_loc8_ != null)
               {
                  _loc8_.constraints.add(zpp_inner);
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
         var _loc9_:Vec2 = zpp_inner_zn.wrap_a1;
         _loc12_ = param3.zpp_inner;
         if(_loc12_._validate != null)
         {
            _loc12_._validate();
         }
         var _loc11_:Number = param3.zpp_inner.x;
         _loc12_ = param3.zpp_inner;
         if(_loc12_._validate != null)
         {
            _loc12_._validate();
         }
         var _loc13_:Number = param3.zpp_inner.y;
         _loc12_ = _loc9_.zpp_inner;
         §§push(false);
         if(_loc12_._validate != null)
         {
            _loc12_._validate();
         }
         if(_loc9_.zpp_inner.x == _loc11_)
         {
            §§pop();
            _loc12_ = _loc9_.zpp_inner;
            if(_loc12_._validate != null)
            {
               _loc12_._validate();
            }
            §§push(_loc9_.zpp_inner.y == _loc13_);
         }
         if(!§§pop())
         {
            _loc9_.zpp_inner.x = _loc11_;
            _loc9_.zpp_inner.y = _loc13_;
            _loc12_ = _loc9_.zpp_inner;
            if(_loc12_._invalidate != null)
            {
               _loc12_._invalidate(_loc12_);
            }
         }
         var _loc10_:Vec2 = _loc9_;
         if(param3.zpp_inner.weak)
         {
            param3.dispose();
         }
         _loc10_;
         if(zpp_inner_zn.wrap_a1 == null)
         {
            zpp_inner_zn.setup_a1();
         }
         zpp_inner_zn.wrap_a1;
         if(zpp_inner_zn.wrap_a2 == null)
         {
            zpp_inner_zn.setup_a2();
         }
         _loc9_ = zpp_inner_zn.wrap_a2;
         _loc12_ = param4.zpp_inner;
         if(_loc12_._validate != null)
         {
            _loc12_._validate();
         }
         _loc11_ = param4.zpp_inner.x;
         _loc12_ = param4.zpp_inner;
         if(_loc12_._validate != null)
         {
            _loc12_._validate();
         }
         _loc13_ = param4.zpp_inner.y;
         _loc12_ = _loc9_.zpp_inner;
         §§push(false);
         if(_loc12_._validate != null)
         {
            _loc12_._validate();
         }
         if(_loc9_.zpp_inner.x == _loc11_)
         {
            §§pop();
            _loc12_ = _loc9_.zpp_inner;
            if(_loc12_._validate != null)
            {
               _loc12_._validate();
            }
            §§push(_loc9_.zpp_inner.y == _loc13_);
         }
         if(!§§pop())
         {
            _loc9_.zpp_inner.x = _loc11_;
            _loc9_.zpp_inner.y = _loc13_;
            _loc12_ = _loc9_.zpp_inner;
            if(_loc12_._invalidate != null)
            {
               _loc12_._invalidate(_loc12_);
            }
         }
         _loc10_ = _loc9_;
         if(param4.zpp_inner.weak)
         {
            param4.dispose();
         }
         _loc10_;
         if(zpp_inner_zn.wrap_a2 == null)
         {
            zpp_inner_zn.setup_a2();
         }
         zpp_inner_zn.wrap_a2;
         if(zpp_inner_zn.wrap_n == null)
         {
            zpp_inner_zn.setup_n();
         }
         _loc9_ = zpp_inner_zn.wrap_n;
         _loc12_ = param5.zpp_inner;
         if(_loc12_._validate != null)
         {
            _loc12_._validate();
         }
         _loc11_ = param5.zpp_inner.x;
         _loc12_ = param5.zpp_inner;
         if(_loc12_._validate != null)
         {
            _loc12_._validate();
         }
         _loc13_ = param5.zpp_inner.y;
         _loc12_ = _loc9_.zpp_inner;
         §§push(false);
         if(_loc12_._validate != null)
         {
            _loc12_._validate();
         }
         if(_loc9_.zpp_inner.x == _loc11_)
         {
            §§pop();
            _loc12_ = _loc9_.zpp_inner;
            if(_loc12_._validate != null)
            {
               _loc12_._validate();
            }
            §§push(_loc9_.zpp_inner.y == _loc13_);
         }
         if(!§§pop())
         {
            _loc9_.zpp_inner.x = _loc11_;
            _loc9_.zpp_inner.y = _loc13_;
            _loc12_ = _loc9_.zpp_inner;
            if(_loc12_._invalidate != null)
            {
               _loc12_._invalidate(_loc12_);
            }
         }
         _loc10_ = _loc9_;
         if(param5.zpp_inner.weak)
         {
            param5.dispose();
         }
         _loc10_;
         if(zpp_inner_zn.wrap_n == null)
         {
            zpp_inner_zn.setup_n();
         }
         zpp_inner_zn.wrap_n;
         zpp_inner.immutable_midstep("LineJoint::jointMin");
         if(zpp_inner_zn.jointMin != param6)
         {
            zpp_inner_zn.jointMin = param6;
            zpp_inner.wake();
         }
         zpp_inner_zn.jointMin;
         zpp_inner.immutable_midstep("LineJoint::jointMax");
         if(zpp_inner_zn.jointMax != param7)
         {
            zpp_inner_zn.jointMax = param7;
            zpp_inner.wake();
         }
         zpp_inner_zn.jointMax;
      }
      
      override public function visitBodies(param1:Function) : void
      {
         if(false)
         {
            param1(zpp_inner_zn.b2 == null?null:zpp_inner_zn.b2.outer);
         }
      }
      
      public function set jointMin(param1:Number) : Number
      {
         zpp_inner.immutable_midstep("LineJoint::jointMin");
         if(zpp_inner_zn.jointMin != param1)
         {
            zpp_inner_zn.jointMin = param1;
            zpp_inner.wake();
         }
         return zpp_inner_zn.jointMin;
      }
      
      public function set jointMax(param1:Number) : Number
      {
         zpp_inner.immutable_midstep("LineJoint::jointMax");
         if(zpp_inner_zn.jointMax != param1)
         {
            zpp_inner_zn.jointMax = param1;
            zpp_inner.wake();
         }
         return zpp_inner_zn.jointMax;
      }
      
      public function set direction(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         if(zpp_inner_zn.wrap_n == null)
         {
            zpp_inner_zn.setup_n();
         }
         var _loc2_:Vec2 = zpp_inner_zn.wrap_n;
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
         if(zpp_inner_zn.wrap_n == null)
         {
            zpp_inner_zn.setup_n();
         }
         return zpp_inner_zn.wrap_n;
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
      
      public function get jointMin() : Number
      {
         return zpp_inner_zn.jointMin;
      }
      
      public function get jointMax() : Number
      {
         return zpp_inner_zn.jointMax;
      }
      
      public function get direction() : Vec2
      {
         if(zpp_inner_zn.wrap_n == null)
         {
            zpp_inner_zn.setup_n();
         }
         return zpp_inner_zn.wrap_n;
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
