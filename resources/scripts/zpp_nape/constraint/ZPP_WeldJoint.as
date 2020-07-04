package zpp_nape.constraint
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.constraint.Constraint;
   import nape.constraint.PivotJoint;
   import nape.constraint.WeldJoint;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.space.Space;
   import nape.util.Debug;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.space.ZPP_Component;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_WeldJoint extends ZPP_Constraint
   {
       
      
      public var wrap_a2:Vec2;
      
      public var wrap_a1:Vec2;
      
      public var stepped:Boolean;
      
      public var pjAccz:Number;
      
      public var pjAccy:Number;
      
      public var pjAccx:Number;
      
      public var phase:Number;
      
      public var outer_zn:WeldJoint;
      
      public var kMassf:Number;
      
      public var kMasse:Number;
      
      public var kMassd:Number;
      
      public var kMassc:Number;
      
      public var kMassb:Number;
      
      public var kMassa:Number;
      
      public var jMax:Number;
      
      public var jAccz:Number;
      
      public var jAccy:Number;
      
      public var jAccx:Number;
      
      public var gamma:Number;
      
      public var biasz:Number;
      
      public var biasy:Number;
      
      public var biasx:Number;
      
      public var b2:ZPP_Body;
      
      public var b1:ZPP_Body;
      
      public var a2rely:Number;
      
      public var a2relx:Number;
      
      public var a2localy:Number;
      
      public var a2localx:Number;
      
      public var a1rely:Number;
      
      public var a1relx:Number;
      
      public var a1localy:Number;
      
      public var a1localx:Number;
      
      public function ZPP_WeldJoint()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         phase = 0;
         jAccx = 0;
         jAccy = 0;
         jAccz = 0;
         jMax = 1.79e308;
         stepped = false;
         a1localx = 0;
         a1localy = 0;
         a1relx = 0;
         a1rely = 0;
         a2localx = 0;
         a2localy = 0;
         a2relx = 0;
         a2rely = 0;
      }
      
      override public function warmStart() : void
      {
         var _loc1_:Number = b1.imass;
         b1.velx = b1.velx - jAccx * _loc1_;
         b1.vely = b1.vely - jAccy * _loc1_;
         _loc1_ = b2.imass;
         b2.velx = Number(b2.velx + jAccx * _loc1_);
         b2.vely = Number(b2.vely + jAccy * _loc1_);
         b1.angvel = b1.angvel - (jAccy * a1relx - jAccx * a1rely + jAccz) * b1.iinertia;
         b2.angvel = Number(b2.angvel + (jAccy * a2relx - jAccx * a2rely + jAccz) * b2.iinertia);
         pjAccx = jAccx;
         pjAccy = jAccy;
         pjAccz = jAccz;
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
      
      public function validate_a2() : void
      {
         wrap_a2.zpp_inner.x = a2localx;
         wrap_a2.zpp_inner.y = a2localy;
      }
      
      public function validate_a1() : void
      {
         wrap_a1.zpp_inner.x = a1localx;
         wrap_a1.zpp_inner.y = a1localy;
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
            throw "Error: WeldJoint cannot be simulated with body1 == body2";
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
      
      public function setup_a2() : void
      {
         wrap_a2 = Vec2.get(a2localx,a2localy);
         wrap_a2.zpp_inner._inuse = true;
         wrap_a2.zpp_inner._validate = validate_a2;
         wrap_a2.zpp_inner._invalidate = invalidate_a2;
      }
      
      public function setup_a1() : void
      {
         wrap_a1 = Vec2.get(a1localx,a1localy);
         wrap_a1.zpp_inner._inuse = true;
         wrap_a1.zpp_inner._validate = validate_a1;
         wrap_a1.zpp_inner._invalidate = invalidate_a1;
      }
      
      override public function preStep(param1:Number) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc7_:* = 0;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         if(pre_dt == -1)
         {
            pre_dt = param1;
         }
         var _loc2_:Number = param1 / pre_dt;
         pre_dt = param1;
         stepped = true;
         a1relx = b1.axisy * a1localx - b1.axisx * a1localy;
         a1rely = Number(a1localx * b1.axisx + a1localy * b1.axisy);
         a2relx = b2.axisy * a2localx - b2.axisx * a2localy;
         a2rely = Number(a2localx * b2.axisx + a2localy * b2.axisy);
         _loc3_ = Number(b1.smass + b2.smass);
         kMassa = _loc3_;
         kMassb = 0;
         kMassd = _loc3_;
         kMassc = 0;
         kMasse = 0;
         kMassf = 0;
         if(b1.sinertia != 0)
         {
            _loc4_ = a1relx * b1.sinertia;
            _loc5_ = a1rely * b1.sinertia;
            kMassa = Number(kMassa + _loc5_ * a1rely);
            kMassb = Number(kMassb + -_loc5_ * a1relx);
            kMassd = Number(kMassd + _loc4_ * a1relx);
            kMassc = Number(kMassc + -_loc5_);
            kMasse = Number(kMasse + _loc4_);
            kMassf = Number(kMassf + b1.sinertia);
         }
         if(b2.sinertia != 0)
         {
            _loc4_ = a2relx * b2.sinertia;
            _loc5_ = a2rely * b2.sinertia;
            kMassa = Number(kMassa + _loc5_ * a2rely);
            kMassb = Number(kMassb + -_loc5_ * a2relx);
            kMassd = Number(kMassd + _loc4_ * a2relx);
            kMassc = Number(kMassc + -_loc5_);
            kMasse = Number(kMasse + _loc4_);
            kMassf = Number(kMassf + b2.sinertia);
         }
         _loc3_ = Number(Number(kMassa * (kMassd * kMassf - kMasse * kMasse) + kMassb * (kMassc * kMasse - kMassb * kMassf)) + kMassc * (kMassb * kMasse - kMassc * kMassd));
         if(_loc3_ != _loc3_)
         {
            kMassa = 0;
            kMassb = 0;
            kMassd = 0;
            kMassc = 0;
            kMasse = 0;
            kMassf = 0;
            §§push(7);
         }
         else if(_loc3_ == 0)
         {
            _loc7_ = 0;
            if(kMassa != 0)
            {
               kMassa = 1 / kMassa;
            }
            else
            {
               kMassa = 0;
               _loc7_ = _loc7_ | 1;
            }
            if(kMassd != 0)
            {
               kMassd = 1 / kMassd;
            }
            else
            {
               kMassd = 0;
               _loc7_ = _loc7_ | 2;
            }
            if(kMassf != 0)
            {
               kMassf = 1 / kMassf;
            }
            else
            {
               kMassf = 0;
               _loc7_ = _loc7_ | 4;
            }
            _loc4_ = 0;
            kMasse = _loc4_;
            _loc4_ = _loc4_;
            kMassc = _loc4_;
            kMassb = _loc4_;
            §§push(_loc7_);
         }
         else
         {
            _loc3_ = 1 / _loc3_;
            _loc4_ = _loc3_ * (kMassd * kMassf - kMasse * kMasse);
            _loc5_ = _loc3_ * (kMasse * kMassc - kMassb * kMassf);
            _loc8_ = _loc3_ * (kMassa * kMassf - kMassc * kMassc);
            _loc9_ = _loc3_ * (kMassb * kMasse - kMassc * kMassd);
            _loc10_ = _loc3_ * (kMassb * kMassc - kMassa * kMasse);
            _loc11_ = _loc3_ * (kMassa * kMassd - kMassb * kMassb);
            kMassa = _loc4_;
            kMassb = _loc5_;
            kMassd = _loc8_;
            kMassc = _loc9_;
            kMasse = _loc10_;
            kMassf = _loc11_;
            §§push(0);
         }
         jAccy = 0;
         jAccz = 0;
         if(!stiff)
         {
            _loc5_ = 2 * Math.PI * frequency;
            gamma = 1 / (_loc5_ * param1 * (2 * damping + _loc5_ * param1));
            _loc8_ = 1 / (Number(1 + gamma));
            _loc3_ = _loc5_ * _loc5_ * gamma;
            gamma = gamma * _loc8_;
            _loc4_ = _loc8_;
            kMassa = kMassa * _loc4_;
            kMassb = kMassb * _loc4_;
            kMassd = kMassd * _loc4_;
            kMassc = kMassc * _loc4_;
            kMasse = kMasse * _loc4_;
            kMassf = kMassf * _loc4_;
            biasx = Number(b2.posx + a2relx) - (Number(b1.posx + a1relx));
            biasy = Number(b2.posy + a2rely) - (Number(b1.posy + a1rely));
            biasz = b2.rot - b1.rot - phase;
            if(!!breakUnderError && Number(Number(biasx * biasx + biasy * biasy) + biasz * biasz) > maxError * maxError)
            {
               return true;
            }
            _loc4_ = -param1 * _loc3_;
            _loc5_ = _loc4_;
            biasx = biasx * _loc5_;
            biasy = biasy * _loc5_;
            biasz = biasz * _loc4_;
            _loc4_ = maxError;
            _loc5_ = Number(Number(biasx * biasx + biasy * biasy) + biasz * biasz);
            if(_loc5_ > _loc4_ * _loc4_)
            {
               sf32(_loc5_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc9_ = lf32(0);
               _loc8_ = _loc4_ * (_loc9_ * (1.5 - 0.5 * _loc5_ * _loc9_ * _loc9_));
               _loc9_ = _loc8_;
               biasx = biasx * _loc9_;
               biasy = biasy * _loc9_;
               biasz = biasz * _loc8_;
            }
         }
         else
         {
            biasx = 0;
            biasy = 0;
            biasz = 0;
            gamma = 0;
         }
         _loc3_ = _loc2_;
         _loc4_ = _loc3_;
         jAccx = jAccx * _loc4_;
         jAccy = jAccy * _loc4_;
         jAccz = jAccz * _loc3_;
         jMax = maxForce * param1;
         return false;
      }
      
      override public function pair_exists(param1:int, param2:int) : Boolean
      {
         return b1.id == param1 && b2.id == param2 || b1.id == param2 && b2.id == param1;
      }
      
      public function invalidate_a2(param1:ZPP_Vec2) : void
      {
         immutable_midstep("Constraint::" + "a2");
         a2localx = param1.x;
         a2localy = param1.y;
         wake();
      }
      
      public function invalidate_a1(param1:ZPP_Vec2) : void
      {
         immutable_midstep("Constraint::" + "a1");
         a1localx = param1.x;
         a1localy = param1.y;
         wake();
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
      
      override public function draw(param1:Debug) : void
      {
         var _loc5_:* = null as Vec2;
         var _loc6_:Number = NaN;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:* = null as Body;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc2_:WeldJoint = outer_zn;
         §§push(_loc2_.zpp_inner_zn.b1 == null?null:_loc2_.zpp_inner_zn.b1.outer);
         if(_loc2_.zpp_inner_zn.wrap_a1 == null)
         {
            _loc2_.zpp_inner_zn.setup_a1();
         }
         var _loc3_:Vec2 = §§pop().localToWorld(_loc2_.zpp_inner_zn.wrap_a1);
         §§push(_loc2_.zpp_inner_zn.b2 == null?null:_loc2_.zpp_inner_zn.b2.outer);
         if(_loc2_.zpp_inner_zn.wrap_a2 == null)
         {
            _loc2_.zpp_inner_zn.setup_a2();
         }
         var _loc4_:Vec2 = §§pop().localToWorld(_loc2_.zpp_inner_zn.wrap_a2);
         if(!stiff)
         {
            _loc5_ = _loc4_.sub(_loc3_);
            _loc7_ = _loc5_.zpp_inner;
            §§push(Math);
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc7_ = _loc5_.zpp_inner;
            §§push(_loc5_.zpp_inner.x);
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc7_ = _loc5_.zpp_inner;
            §§push(§§pop() * _loc5_.zpp_inner.x);
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc7_ = _loc5_.zpp_inner;
            §§push(_loc5_.zpp_inner.y);
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc6_ = Number(§§pop().sqrt(Number(§§pop() + §§pop() * _loc5_.zpp_inner.y)));
            if(_loc6_ != 0)
            {
               param1.drawSpring(_loc3_,_loc4_,16711935);
            }
            _loc5_.dispose();
            _loc8_ = 10;
            _loc9_ = 5 / Math.PI / 2;
            _loc10_ = _loc2_.zpp_inner_zn.b1 == null?null:_loc2_.zpp_inner_zn.b1.outer;
            if((_loc2_.zpp_inner_zn.b1 == null?null:_loc2_.zpp_inner_zn.b1.outer) != (_loc10_.zpp_inner.space == null?null:_loc10_.zpp_inner.space.outer).zpp_inner.__static)
            {
               _loc11_ = (_loc2_.zpp_inner_zn.b2 == null?null:_loc2_.zpp_inner_zn.b2.outer).zpp_inner.rot - _loc2_.zpp_inner_zn.phase;
               _loc12_ = (_loc2_.zpp_inner_zn.b1 == null?null:_loc2_.zpp_inner_zn.b1.outer).zpp_inner.rot;
               if(_loc12_ > _loc11_)
               {
                  _loc13_ = _loc12_;
                  _loc12_ = _loc11_;
                  _loc11_ = _loc13_;
               }
               _loc10_ = _loc2_.zpp_inner_zn.b1 == null?null:_loc2_.zpp_inner_zn.b1.outer;
               §§push(ZPP_AngleDraw);
               §§push(param1);
               if(_loc10_.zpp_inner.wrap_pos == null)
               {
                  _loc10_.zpp_inner.setupPosition();
               }
               §§pop().drawSpiralSpring(§§pop(),_loc10_.zpp_inner.wrap_pos,_loc12_,_loc11_,Number(_loc8_ + (_loc12_ - _loc12_) * _loc9_),Number(_loc8_ + (_loc11_ - _loc12_) * _loc9_),16711808);
               _loc10_ = _loc2_.zpp_inner_zn.b1 == null?null:_loc2_.zpp_inner_zn.b1.outer;
               §§push(ZPP_AngleDraw);
               §§push(param1);
               if(_loc10_.zpp_inner.wrap_pos == null)
               {
                  _loc10_.zpp_inner.setupPosition();
               }
               §§pop().indicator(§§pop(),_loc10_.zpp_inner.wrap_pos,(_loc2_.zpp_inner_zn.b1 == null?null:_loc2_.zpp_inner_zn.b1.outer).zpp_inner.rot,Number(_loc8_ + ((_loc2_.zpp_inner_zn.b1 == null?null:_loc2_.zpp_inner_zn.b1.outer).zpp_inner.rot - _loc12_) * _loc9_),16711808);
            }
            _loc10_ = _loc2_.zpp_inner_zn.b2 == null?null:_loc2_.zpp_inner_zn.b2.outer;
            if((_loc2_.zpp_inner_zn.b2 == null?null:_loc2_.zpp_inner_zn.b2.outer) != (_loc10_.zpp_inner.space == null?null:_loc10_.zpp_inner.space.outer).zpp_inner.__static)
            {
               _loc11_ = Number(_loc2_.zpp_inner_zn.phase + (_loc2_.zpp_inner_zn.b1 == null?null:_loc2_.zpp_inner_zn.b1.outer).zpp_inner.rot);
               _loc12_ = (_loc2_.zpp_inner_zn.b2 == null?null:_loc2_.zpp_inner_zn.b2.outer).zpp_inner.rot;
               if(_loc12_ > _loc11_)
               {
                  _loc13_ = _loc12_;
                  _loc12_ = _loc11_;
                  _loc11_ = _loc13_;
               }
               _loc10_ = _loc2_.zpp_inner_zn.b2 == null?null:_loc2_.zpp_inner_zn.b2.outer;
               §§push(ZPP_AngleDraw);
               §§push(param1);
               if(_loc10_.zpp_inner.wrap_pos == null)
               {
                  _loc10_.zpp_inner.setupPosition();
               }
               §§pop().drawSpiralSpring(§§pop(),_loc10_.zpp_inner.wrap_pos,_loc12_,_loc11_,Number(_loc8_ + (_loc12_ - _loc12_) * _loc9_),Number(_loc8_ + (_loc11_ - _loc12_) * _loc9_),8388863);
               _loc10_ = _loc2_.zpp_inner_zn.b2 == null?null:_loc2_.zpp_inner_zn.b2.outer;
               §§push(ZPP_AngleDraw);
               §§push(param1);
               if(_loc10_.zpp_inner.wrap_pos == null)
               {
                  _loc10_.zpp_inner.setupPosition();
               }
               §§pop().indicator(§§pop(),_loc10_.zpp_inner.wrap_pos,(_loc2_.zpp_inner_zn.b2 == null?null:_loc2_.zpp_inner_zn.b2.outer).zpp_inner.rot,Number(_loc8_ + ((_loc2_.zpp_inner_zn.b2 == null?null:_loc2_.zpp_inner_zn.b2.outer).zpp_inner.rot - _loc12_) * _loc9_),8388863);
            }
         }
         param1.drawFilledCircle(_loc3_,2,255);
         param1.drawFilledCircle(_loc4_,2,16711680);
         _loc3_.dispose();
         _loc4_.dispose();
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
         var _loc4_:* = null as Body;
         var _loc5_:int = 0;
         var _loc6_:* = null as ZPP_CopyHelper;
         var _loc3_:WeldJoint = outer_zn;
         §§push(§§newactivation());
         §§push();
         §§push(null);
         §§push(null);
         if(_loc3_.zpp_inner_zn.wrap_a1 == null)
         {
            _loc3_.zpp_inner_zn.setup_a1();
         }
         _loc3_ = outer_zn;
         §§push(_loc3_.zpp_inner_zn.wrap_a1);
         if(_loc3_.zpp_inner_zn.wrap_a2 == null)
         {
            _loc3_.zpp_inner_zn.setup_a2();
         }
         var /*UnknownSlot*/:* = new §§pop().PivotJoint(§§pop(),§§pop(),§§pop(),_loc3_.zpp_inner_zn.wrap_a2);
         copyto(ret);
         if(param1 != null && b1 != null)
         {
            _loc4_ = null;
            _loc5_ = 0;
            while(_loc5_ < int(param1.length))
            {
               _loc6_ = param1[_loc5_];
               _loc5_++;
               if(_loc6_.id == b1.id)
               {
                  _loc4_ = _loc6_.bc;
                  break;
               }
            }
            if(_loc4_ != null)
            {
               ret.zpp_inner_zn.b1 = _loc4_.zpp_inner;
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
            _loc4_ = null;
            _loc5_ = 0;
            while(_loc5_ < int(param1.length))
            {
               _loc6_ = param1[_loc5_];
               _loc5_++;
               if(_loc6_.id == b2.id)
               {
                  _loc4_ = _loc6_.bc;
                  break;
               }
            }
            if(_loc4_ != null)
            {
               ret.zpp_inner_zn.b2 = _loc4_.zpp_inner;
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
         jAccx = 0;
         jAccy = 0;
         jAccz = 0;
         pjAccx = 0;
         pjAccy = 0;
         pjAccz = 0;
         pre_dt = -1;
      }
      
      public function bodyImpulse(param1:ZPP_Body) : Vec3
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(stepped)
         {
            _loc2_ = Number(jAccx + pjAccx);
            _loc3_ = Number(jAccy + pjAccy);
            _loc4_ = Number(jAccz + pjAccz);
            if(param1 == b1)
            {
               return Vec3.get(-_loc2_,-_loc3_,-(_loc3_ * a1relx - _loc2_ * a1rely + _loc4_));
            }
            return Vec3.get(_loc2_,_loc3_,Number(_loc3_ * a2relx - _loc2_ * a2rely + _loc4_));
         }
         return Vec3.get(0,0,0);
      }
      
      override public function applyImpulseVel() : Boolean
      {
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc1_:Number = b2.velx + b2.kinvelx - a2rely * (b2.angvel + b2.kinangvel) - (b1.velx + b1.kinvelx - a1rely * (b1.angvel + b1.kinangvel));
         var _loc2_:Number = Number(Number(b2.vely + b2.kinvely) + a2relx * (b2.angvel + b2.kinangvel)) - (Number(Number(b1.vely + b1.kinvely) + a1relx * (b1.angvel + b1.kinangvel)));
         var _loc3_:Number = b2.angvel + b2.kinangvel - b1.angvel - b1.kinangvel;
         var _loc4_:Number = biasx - _loc1_;
         var _loc5_:Number = biasy - _loc2_;
         var _loc6_:Number = biasz - _loc3_;
         var _loc7_:Number = Number(Number(kMassa * _loc4_ + kMassb * _loc5_) + kMassc * _loc6_);
         var _loc8_:Number = Number(Number(kMassb * _loc4_ + kMassd * _loc5_) + kMasse * _loc6_);
         _loc6_ = Number(Number(kMassc * _loc4_ + kMasse * _loc5_) + kMassf * _loc6_);
         _loc4_ = _loc7_;
         _loc5_ = _loc8_;
         _loc7_ = gamma;
         _loc8_ = _loc7_;
         _loc4_ = _loc4_ - jAccx * _loc8_;
         _loc5_ = _loc5_ - jAccy * _loc8_;
         _loc6_ = _loc6_ - jAccz * _loc7_;
         _loc7_ = jAccx;
         _loc8_ = jAccy;
         var _loc9_:Number = jAccz;
         jAccx = Number(jAccx + _loc4_ * 1);
         jAccy = Number(jAccy + _loc5_ * 1);
         jAccz = Number(jAccz + _loc6_ * 1);
         if(breakUnderForce)
         {
            if(Number(Number(jAccx * jAccx + jAccy * jAccy) + jAccz * jAccz) > jMax * jMax)
            {
               return true;
            }
         }
         else if(!stiff)
         {
            _loc12_ = jMax;
            _loc13_ = Number(Number(jAccx * jAccx + jAccy * jAccy) + jAccz * jAccz);
            if(_loc13_ > _loc12_ * _loc12_)
            {
               sf32(_loc13_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc15_ = lf32(0);
               _loc14_ = _loc12_ * (_loc15_ * (1.5 - 0.5 * _loc13_ * _loc15_ * _loc15_));
               _loc15_ = _loc14_;
               jAccx = jAccx * _loc15_;
               jAccy = jAccy * _loc15_;
               jAccz = jAccz * _loc14_;
            }
         }
         _loc4_ = jAccx - _loc7_;
         _loc5_ = jAccy - _loc8_;
         _loc6_ = jAccz - _loc9_;
         _loc7_ = b1.imass;
         b1.velx = b1.velx - _loc4_ * _loc7_;
         b1.vely = b1.vely - _loc5_ * _loc7_;
         _loc7_ = b2.imass;
         b2.velx = Number(b2.velx + _loc4_ * _loc7_);
         b2.vely = Number(b2.vely + _loc5_ * _loc7_);
         b1.angvel = b1.angvel - (_loc5_ * a1relx - _loc4_ * a1rely + _loc6_) * b1.iinertia;
         b2.angvel = Number(b2.angvel + (_loc5_ * a2relx - _loc4_ * a2rely + _loc6_) * b2.iinertia);
         return false;
      }
      
      override public function applyImpulsePos() : Boolean
      {
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:int = 0;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc1_:Number = b1.axisy * a1localx - b1.axisx * a1localy;
         var _loc2_:Number = Number(a1localx * b1.axisx + a1localy * b1.axisy);
         var _loc3_:Number = b2.axisy * a2localx - b2.axisx * a2localy;
         var _loc4_:Number = Number(a2localx * b2.axisx + a2localy * b2.axisy);
         var _loc5_:Number = Number(b2.posx + _loc3_) - (Number(b1.posx + _loc1_));
         var _loc6_:Number = Number(b2.posy + _loc4_) - (Number(b1.posy + _loc2_));
         var _loc7_:Number = b2.rot - b1.rot - phase;
         if(!!breakUnderError && Number(Number(_loc5_ * _loc5_ + _loc6_ * _loc6_) + _loc7_ * _loc7_) > maxError * maxError)
         {
            return true;
         }
         var _loc11_:Boolean = true;
         if(Number(_loc5_ * _loc5_ + _loc6_ * _loc6_) < 0.01)
         {
            _loc11_ = false;
            _loc5_ = 0;
            _loc6_ = 0;
         }
         if(_loc7_ * _loc7_ < 1.0e-6)
         {
            if(!_loc11_)
            {
               return false;
            }
            _loc7_ = 0;
         }
         _loc12_ = 0.5;
         _loc13_ = _loc12_;
         _loc5_ = _loc5_ * _loc13_;
         _loc6_ = _loc6_ * _loc13_;
         _loc7_ = _loc7_ * _loc12_;
         if(Number(_loc5_ * _loc5_ + _loc6_ * _loc6_) > 6)
         {
            _loc12_ = Number(b1.smass + b2.smass);
            if(_loc12_ > 1.0e-8)
            {
               _loc12_ = 0.75 / _loc12_;
               _loc8_ = -_loc5_ * _loc12_;
               _loc9_ = -_loc6_ * _loc12_;
               _loc14_ = 20;
               _loc13_ = Number(_loc8_ * _loc8_ + _loc9_ * _loc9_);
               if(_loc13_ > _loc14_ * _loc14_)
               {
                  sf32(_loc13_,0);
                  si32(1597463007 - (li32(0) >> 1),0);
                  _loc16_ = lf32(0);
                  _loc15_ = _loc14_ * (_loc16_ * (1.5 - 0.5 * _loc13_ * _loc16_ * _loc16_));
                  _loc8_ = _loc8_ * _loc15_;
                  _loc9_ = _loc9_ * _loc15_;
               }
               _loc13_ = b1.imass;
               b1.posx = b1.posx - _loc8_ * _loc13_;
               b1.posy = b1.posy - _loc9_ * _loc13_;
               _loc13_ = b2.imass;
               b2.posx = Number(b2.posx + _loc8_ * _loc13_);
               b2.posy = Number(b2.posy + _loc9_ * _loc13_);
               _loc5_ = Number(b2.posx + _loc3_) - (Number(b1.posx + _loc1_));
               _loc6_ = Number(b2.posy + _loc4_) - (Number(b1.posy + _loc2_));
               _loc7_ = b2.rot - b1.rot - phase;
               _loc13_ = 0.5;
               _loc15_ = _loc13_;
               _loc5_ = _loc5_ * _loc15_;
               _loc6_ = _loc6_ * _loc15_;
               _loc7_ = _loc7_ * _loc13_;
            }
         }
         var _loc19_:Number = Number(b1.smass + b2.smass);
         _loc12_ = _loc19_;
         _loc13_ = 0;
         _loc15_ = _loc19_;
         _loc16_ = 0;
         var _loc17_:Number = 0;
         var _loc18_:Number = 0;
         if(b1.sinertia != 0)
         {
            _loc20_ = _loc1_ * b1.sinertia;
            _loc21_ = _loc2_ * b1.sinertia;
            _loc12_ = Number(_loc12_ + _loc21_ * _loc2_);
            _loc13_ = Number(_loc13_ + -_loc21_ * _loc1_);
            _loc15_ = Number(_loc15_ + _loc20_ * _loc1_);
            _loc16_ = Number(_loc16_ + -_loc21_);
            _loc17_ = Number(_loc17_ + _loc20_);
            _loc18_ = Number(_loc18_ + b1.sinertia);
         }
         if(b2.sinertia != 0)
         {
            _loc20_ = _loc3_ * b2.sinertia;
            _loc21_ = _loc4_ * b2.sinertia;
            _loc12_ = Number(_loc12_ + _loc21_ * _loc4_);
            _loc13_ = Number(_loc13_ + -_loc21_ * _loc3_);
            _loc15_ = Number(_loc15_ + _loc20_ * _loc3_);
            _loc16_ = Number(_loc16_ + -_loc21_);
            _loc17_ = Number(_loc17_ + _loc20_);
            _loc18_ = Number(_loc18_ + b2.sinertia);
         }
         _loc8_ = -_loc5_;
         _loc9_ = -_loc6_;
         var _loc10_:Number = -_loc7_;
         _loc14_ = 6;
         _loc19_ = Number(_loc8_ * _loc8_ + _loc9_ * _loc9_);
         if(_loc19_ > _loc14_ * _loc14_)
         {
            sf32(_loc19_,0);
            si32(1597463007 - (li32(0) >> 1),0);
            _loc21_ = lf32(0);
            _loc20_ = _loc14_ * (_loc21_ * (1.5 - 0.5 * _loc19_ * _loc21_ * _loc21_));
            _loc8_ = _loc8_ * _loc20_;
            _loc9_ = _loc9_ * _loc20_;
         }
         _loc19_ = -0.25;
         if(_loc10_ < _loc19_)
         {
            _loc19_;
         }
         else if(_loc10_ <= 0.25)
         {
            _loc10_;
         }
         _loc19_ = Number(Number(_loc12_ * (_loc15_ * _loc18_ - _loc17_ * _loc17_) + _loc13_ * (_loc16_ * _loc17_ - _loc13_ * _loc18_)) + _loc16_ * (_loc13_ * _loc17_ - _loc16_ * _loc15_));
         if(_loc19_ != _loc19_)
         {
            _loc10_ = 0;
            _loc9_ = _loc10_;
            _loc8_ = _loc9_;
         }
         else if(_loc19_ == 0)
         {
            if(_loc12_ != 0)
            {
               _loc8_ = _loc8_ / _loc12_;
            }
            else
            {
               _loc8_ = 0;
            }
            if(_loc15_ != 0)
            {
               _loc9_ = _loc9_ / _loc15_;
            }
            else
            {
               _loc9_ = 0;
            }
            if(_loc18_ != 0)
            {
               _loc10_ = _loc10_ / _loc18_;
            }
            else
            {
               _loc10_ = 0;
            }
         }
         else
         {
            _loc19_ = 1 / _loc19_;
            _loc20_ = _loc17_ * _loc16_ - _loc13_ * _loc18_;
            _loc21_ = _loc13_ * _loc17_ - _loc16_ * _loc15_;
            _loc22_ = _loc13_ * _loc16_ - _loc12_ * _loc17_;
            _loc23_ = _loc19_ * (Number(_loc8_ * (_loc15_ * _loc18_ - _loc17_ * _loc17_) + _loc9_ * _loc20_) + _loc10_ * _loc21_);
            _loc24_ = _loc19_ * (Number(_loc8_ * _loc20_ + _loc9_ * (_loc12_ * _loc18_ - _loc16_ * _loc16_)) + _loc10_ * _loc22_);
            _loc10_ = _loc19_ * (Number(_loc8_ * _loc21_ + _loc9_ * _loc22_) + _loc10_ * (_loc12_ * _loc15_ - _loc13_ * _loc13_));
            _loc8_ = _loc23_;
            _loc9_ = _loc24_;
         }
         _loc19_ = b1.imass;
         b1.posx = b1.posx - _loc8_ * _loc19_;
         b1.posy = b1.posy - _loc9_ * _loc19_;
         _loc19_ = b2.imass;
         b2.posx = Number(b2.posx + _loc8_ * _loc19_);
         b2.posy = Number(b2.posy + _loc9_ * _loc19_);
         var _loc25_:ZPP_Body = b1;
         _loc19_ = -(_loc9_ * _loc1_ - _loc8_ * _loc2_ + _loc10_) * b1.iinertia;
         _loc25_.rot = Number(_loc25_.rot + _loc19_);
         if(_loc19_ * _loc19_ > 0.0001)
         {
            _loc25_.axisx = Number(Math.sin(_loc25_.rot));
            _loc25_.axisy = Number(Math.cos(_loc25_.rot));
            null;
         }
         else
         {
            _loc20_ = _loc19_ * _loc19_;
            _loc21_ = 1 - 0.5 * _loc20_;
            _loc22_ = 1 - _loc20_ * _loc20_ / 8;
            _loc23_ = (_loc21_ * _loc25_.axisx + _loc19_ * _loc25_.axisy) * _loc22_;
            _loc25_.axisy = (_loc21_ * _loc25_.axisy - _loc19_ * _loc25_.axisx) * _loc22_;
            _loc25_.axisx = _loc23_;
         }
         _loc25_ = b2;
         _loc19_ = (_loc9_ * _loc3_ - _loc8_ * _loc4_ + _loc10_) * b2.iinertia;
         _loc25_.rot = Number(_loc25_.rot + _loc19_);
         if(_loc19_ * _loc19_ > 0.0001)
         {
            _loc25_.axisx = Number(Math.sin(_loc25_.rot));
            _loc25_.axisy = Number(Math.cos(_loc25_.rot));
            null;
         }
         else
         {
            _loc20_ = _loc19_ * _loc19_;
            _loc21_ = 1 - 0.5 * _loc20_;
            _loc22_ = 1 - _loc20_ * _loc20_ / 8;
            _loc23_ = (_loc21_ * _loc25_.axisx + _loc19_ * _loc25_.axisy) * _loc22_;
            _loc25_.axisy = (_loc21_ * _loc25_.axisy - _loc19_ * _loc25_.axisx) * _loc22_;
            _loc25_.axisx = _loc23_;
         }
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
