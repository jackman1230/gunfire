package zpp_nape.constraint
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.constraint.Constraint;
   import nape.constraint.LineJoint;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.util.Debug;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.space.ZPP_Component;
   import zpp_nape.util.ZPP_Flags;
   
   public class ZPP_LineJoint extends ZPP_Constraint
   {
       
      
      public var zip_n:Boolean;
      
      public var wrap_n:Vec2;
      
      public var wrap_a2:Vec2;
      
      public var wrap_a1:Vec2;
      
      public var stepped:Boolean;
      
      public var scale:Number;
      
      public var pjAccy:Number;
      
      public var pjAccx:Number;
      
      public var outer_zn:LineJoint;
      
      public var nrely:Number;
      
      public var nrelx:Number;
      
      public var nlocaly:Number;
      
      public var nlocalx:Number;
      
      public var kMassc:Number;
      
      public var kMassb:Number;
      
      public var kMassa:Number;
      
      public var jointMin:Number;
      
      public var jointMax:Number;
      
      public var jMax:Number;
      
      public var jAccy:Number;
      
      public var jAccx:Number;
      
      public var gamma:Number;
      
      public var dot2:Number;
      
      public var dot1:Number;
      
      public var cx2:Number;
      
      public var cx1:Number;
      
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
      
      public function ZPP_LineJoint()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         a1localx = 0;
         a1localy = 0;
         a1relx = 0;
         a1rely = 0;
         a2localx = 0;
         a2localy = 0;
         a2relx = 0;
         a2rely = 0;
         nlocalx = 0;
         nlocaly = 0;
         nrelx = 0;
         nrely = 0;
         jAccx = 0;
         jAccy = 0;
         jMax = 1.79e308;
         jointMin = -1.79e308;
         jointMax = 1.79e308;
         stepped = false;
      }
      
      override public function warmStart() : void
      {
         var _loc1_:Number = scale * nrelx * jAccy - nrely * jAccx;
         var _loc2_:Number = Number(nrelx * jAccx + scale * nrely * jAccy);
         var _loc3_:Number = b1.imass;
         b1.velx = b1.velx - _loc1_ * _loc3_;
         b1.vely = b1.vely - _loc2_ * _loc3_;
         _loc3_ = b2.imass;
         b2.velx = Number(b2.velx + _loc1_ * _loc3_);
         b2.vely = Number(b2.vely + _loc2_ * _loc3_);
         b1.angvel = Number(b1.angvel + (scale * cx1 * jAccy - dot1 * jAccx) * b1.iinertia);
         b2.angvel = Number(b2.angvel + (dot2 * jAccx - scale * cx2 * jAccy) * b2.iinertia);
         pjAccx = jAccx;
         pjAccy = jAccy;
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
      
      public function validate_norm() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(zip_n)
         {
            zip_n = false;
            _loc1_ = Number(nlocalx * nlocalx + nlocaly * nlocaly);
            _loc2_ = 1 / Math.sqrt(_loc1_);
            _loc3_ = _loc2_;
            nlocalx = nlocalx * _loc3_;
            nlocaly = nlocaly * _loc3_;
         }
      }
      
      public function validate_n() : void
      {
         wrap_n.zpp_inner.x = nlocalx;
         wrap_n.zpp_inner.y = nlocaly;
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
            throw "Error: DistanceJoint cannot be simulated with body1 == body2";
         }
         if(b1.space != space || b2.space != space)
         {
            Boot.lastError = new Error();
            throw "Error: Constraints must have each body within the same space to which the constraint has been assigned";
         }
         if(jointMin > jointMax)
         {
            Boot.lastError = new Error();
            throw "Error: DistanceJoint must have jointMin <= jointMax";
         }
         if(Number(nlocalx * nlocalx + nlocaly * nlocaly) < 1.0e-8)
         {
            Boot.lastError = new Error();
            throw "Error: DistanceJoint direction must be non-degenerate";
         }
         if(b1.type != ZPP_Flags.id_BodyType_DYNAMIC && b2.type != ZPP_Flags.id_BodyType_DYNAMIC)
         {
            Boot.lastError = new Error();
            throw "Error: Constraints cannot have both bodies non-dynamic";
         }
      }
      
      public function setup_n() : void
      {
         wrap_n = Vec2.get(nlocalx,nlocaly);
         wrap_n.zpp_inner._inuse = true;
         wrap_n.zpp_inner._validate = validate_n;
         wrap_n.zpp_inner._invalidate = invalidate_n;
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
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc10_:* = 0;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         if(pre_dt == -1)
         {
            pre_dt = param1;
         }
         var _loc2_:Number = param1 / pre_dt;
         pre_dt = param1;
         stepped = true;
         validate_norm();
         a1relx = b1.axisy * a1localx - b1.axisx * a1localy;
         a1rely = Number(a1localx * b1.axisx + a1localy * b1.axisy);
         nrelx = b1.axisy * nlocalx - b1.axisx * nlocaly;
         nrely = Number(nlocalx * b1.axisx + nlocaly * b1.axisy);
         a2relx = b2.axisy * a2localx - b2.axisx * a2localy;
         a2rely = Number(a2localx * b2.axisx + a2localy * b2.axisy);
         var _loc3_:Number = b2.posx + a2relx - b1.posx - a1relx;
         var _loc4_:Number = b2.posy + a2rely - b1.posy - a1rely;
         var _loc5_:Number = _loc4_ * nrelx - _loc3_ * nrely;
         var _loc6_:Number = Number(nrelx * _loc3_ + nrely * _loc4_);
         if(_loc6_ > jointMax)
         {
            _loc6_ = _loc6_ - jointMax;
            scale = 1;
         }
         else if(_loc6_ < jointMin)
         {
            _loc6_ = jointMin - _loc6_;
            scale = -1;
         }
         else
         {
            _loc6_ = 0;
            scale = 0;
         }
         _loc7_ = Number(_loc3_ + a1relx);
         _loc8_ = Number(_loc4_ + a1rely);
         dot1 = Number(nrelx * _loc7_ + nrely * _loc8_);
         cx1 = _loc8_ * nrelx - _loc7_ * nrely;
         dot2 = Number(nrelx * a2relx + nrely * a2rely);
         cx2 = a2rely * nrelx - a2relx * nrely;
         kMassa = Number(Number(Number(b1.smass + b2.smass) + dot1 * dot1 * b1.sinertia) + dot2 * dot2 * b2.sinertia);
         kMassb = -scale * (dot1 * cx1 * b1.sinertia + dot2 * cx2 * b2.sinertia);
         kMassc = scale * scale * (Number(Number(b1.smass + b2.smass) + cx1 * cx1 * b1.sinertia) + cx2 * cx2 * b2.sinertia);
         _loc7_ = kMassa * kMassc - kMassb * kMassb;
         if(_loc7_ != _loc7_)
         {
            _loc8_ = 0;
            kMassc = _loc8_;
            _loc8_ = _loc8_;
            kMassb = _loc8_;
            kMassa = _loc8_;
            §§push(3);
         }
         else if(_loc7_ == 0)
         {
            _loc10_ = 0;
            if(kMassa != 0)
            {
               kMassa = 1 / kMassa;
            }
            else
            {
               kMassa = 0;
               _loc10_ = _loc10_ | 1;
            }
            if(kMassc != 0)
            {
               kMassc = 1 / kMassc;
            }
            else
            {
               kMassc = 0;
               _loc10_ = _loc10_ | 2;
            }
            kMassb = 0;
            §§push(_loc10_);
         }
         else
         {
            _loc7_ = 1 / _loc7_;
            _loc8_ = kMassc * _loc7_;
            kMassc = kMassa * _loc7_;
            kMassa = _loc8_;
            kMassb = kMassb * -_loc7_;
            §§push(0);
         }
         jAccy = 0;
         if(!stiff)
         {
            if(!!breakUnderError && Number(_loc5_ * _loc5_ + _loc6_ * _loc6_) > maxError * maxError)
            {
               return true;
            }
            _loc11_ = 2 * Math.PI * frequency;
            gamma = 1 / (_loc11_ * param1 * (2 * damping + _loc11_ * param1));
            _loc12_ = 1 / (Number(1 + gamma));
            _loc7_ = _loc11_ * _loc11_ * gamma;
            gamma = gamma * _loc12_;
            _loc8_ = _loc12_;
            kMassa = kMassa * _loc8_;
            kMassb = kMassb * _loc8_;
            kMassc = kMassc * _loc8_;
            biasx = _loc5_;
            biasy = _loc6_;
            _loc8_ = -param1 * _loc7_;
            biasx = biasx * _loc8_;
            biasy = biasy * _loc8_;
            _loc8_ = maxError;
            _loc11_ = Number(biasx * biasx + biasy * biasy);
            if(_loc11_ > _loc8_ * _loc8_)
            {
               sf32(_loc11_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc13_ = lf32(0);
               _loc12_ = _loc8_ * (_loc13_ * (1.5 - 0.5 * _loc11_ * _loc13_ * _loc13_));
               biasx = biasx * _loc12_;
               biasy = biasy * _loc12_;
            }
         }
         else
         {
            gamma = 0;
            biasx = 0;
            biasy = 0;
         }
         _loc7_ = _loc2_;
         jAccx = jAccx * _loc7_;
         jAccy = jAccy * _loc7_;
         return false;
      }
      
      override public function pair_exists(param1:int, param2:int) : Boolean
      {
         return b1.id == param1 && b2.id == param2 || b1.id == param2 && b2.id == param1;
      }
      
      public function invalidate_n(param1:ZPP_Vec2) : void
      {
         immutable_midstep("Constraint::" + "n");
         nlocalx = param1.x;
         nlocaly = param1.y;
         zip_n = true;
         wake();
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
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:* = null as Vec2;
         var _loc2_:LineJoint = outer_zn;
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
         §§push(_loc2_.zpp_inner_zn.b1 == null?null:_loc2_.zpp_inner_zn.b1.outer);
         if(_loc2_.zpp_inner_zn.wrap_n == null)
         {
            _loc2_.zpp_inner_zn.setup_n();
         }
         var _loc5_:Vec2 = §§pop().localToRelative(_loc2_.zpp_inner_zn.wrap_n);
         var _loc6_:ZPP_Vec2 = _loc5_.zpp_inner;
         §§push(_loc5_);
         §§push(1);
         §§push(Math);
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc6_ = _loc5_.zpp_inner;
         §§push(_loc5_.zpp_inner.x);
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc6_ = _loc5_.zpp_inner;
         §§push(§§pop() * _loc5_.zpp_inner.x);
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc6_ = _loc5_.zpp_inner;
         §§push(_loc5_.zpp_inner.y);
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§pop().muleq(§§pop() / §§pop().sqrt(Number(§§pop() + §§pop() * _loc5_.zpp_inner.y)));
         var _loc7_:Number = _loc2_.zpp_inner_zn.jointMin;
         var _loc8_:Number = _loc2_.zpp_inner_zn.jointMax;
         if(_loc7_ <= -1.79e308)
         {
            _loc7_ = -1000;
         }
         if(_loc8_ >= 1.79e308)
         {
            _loc8_ = 1000;
         }
         var _loc9_:Vec2 = _loc4_.sub(_loc3_);
         var _loc10_:Number = Number(_loc9_.dot(_loc5_));
         _loc9_.dispose();
         var _loc11_:Vec2 = _loc3_.add(_loc5_.mul(_loc7_,true));
         var _loc12_:Vec2 = _loc3_.add(_loc5_.mul(_loc8_,true));
         if(_loc10_ > _loc7_)
         {
            _loc13_ = _loc10_;
            _loc14_ = _loc8_;
            param1.drawLine(_loc11_,_loc3_.add(_loc5_.mul(_loc13_ < _loc14_?_loc13_:_loc14_,true),true),16776960);
         }
         if(_loc10_ < _loc8_)
         {
            _loc13_ = _loc10_;
            _loc14_ = _loc7_;
            param1.drawLine(_loc3_.add(_loc5_.mul(_loc13_ > _loc14_?_loc13_:_loc14_,true),true),_loc12_,65535);
         }
         if(!stiff)
         {
            _loc15_ = _loc10_ < jointMin?_loc11_.copy():_loc10_ > jointMax?_loc12_.copy():_loc3_.add(_loc5_.mul(_loc10_,true));
            param1.drawSpring(_loc15_,_loc4_,16711935);
            _loc15_.dispose();
         }
         param1.drawFilledCircle(_loc3_,2,255);
         param1.drawFilledCircle(_loc4_,2,16711680);
         _loc3_.dispose();
         _loc4_.dispose();
         _loc11_.dispose();
         _loc12_.dispose();
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
         var _loc3_:LineJoint = outer_zn;
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
         _loc3_ = outer_zn;
         §§push(_loc3_.zpp_inner_zn.wrap_a2);
         if(_loc3_.zpp_inner_zn.wrap_n == null)
         {
            _loc3_.zpp_inner_zn.setup_n();
         }
         var /*UnknownSlot*/:* = new §§pop().LineJoint(§§pop(),§§pop(),§§pop(),§§pop(),_loc3_.zpp_inner_zn.wrap_n,jointMin,jointMax);
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
         pjAccx = 0;
         pjAccy = 0;
         pre_dt = -1;
      }
      
      public function bodyImpulse(param1:ZPP_Body) : Vec3
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(stepped)
         {
            _loc2_ = scale * nrelx * (pjAccy + jAccy) - nrely * (pjAccx + jAccx);
            _loc3_ = Number(nrelx * (pjAccx + jAccx) + scale * nrely * (pjAccy + jAccy));
            if(param1 == b1)
            {
               return Vec3.get(-_loc2_,-_loc3_,scale * cx1 * _loc3_ - dot1 * _loc2_);
            }
            return Vec3.get(_loc2_,_loc3_,scale * cx1 * _loc3_ - dot1 * _loc2_);
         }
         return Vec3.get(0,0,0);
      }
      
      override public function applyImpulseVel() : Boolean
      {
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc3_:Number = b2.velx - b1.velx;
         var _loc4_:Number = b2.vely - b1.vely;
         _loc3_ = Number(_loc3_ + (b2.kinvelx - b1.kinvelx));
         _loc4_ = Number(_loc4_ + (b2.kinvely - b1.kinvely));
         var _loc1_:Number = _loc4_ * nrelx - _loc3_ * nrely + (b2.angvel + b2.kinangvel) * dot2 - (b1.angvel + b1.kinangvel) * dot1;
         var _loc2_:Number = scale * (nrelx * _loc3_ + nrely * _loc4_ - (b2.angvel + b2.kinangvel) * cx2 + (b1.angvel + b1.kinangvel) * cx1);
         _loc3_ = biasx - _loc1_;
         _loc4_ = biasy - _loc2_;
         var _loc5_:Number = Number(kMassa * _loc3_ + kMassb * _loc4_);
         _loc4_ = Number(kMassb * _loc3_ + kMassc * _loc4_);
         _loc3_ = _loc5_;
         _loc5_ = gamma;
         _loc3_ = _loc3_ - jAccx * _loc5_;
         _loc4_ = _loc4_ - jAccy * _loc5_;
         _loc5_ = jAccx;
         var _loc6_:Number = jAccy;
         _loc7_ = 1;
         jAccx = Number(jAccx + _loc3_ * _loc7_);
         jAccy = Number(jAccy + _loc4_ * _loc7_);
         if(jAccy > 0)
         {
            jAccy = 0;
         }
         if(breakUnderForce)
         {
            if(Number(jAccx * jAccx + jAccy * jAccy) > jMax * jMax)
            {
               return true;
            }
         }
         else if(!stiff)
         {
            _loc7_ = jMax;
            _loc8_ = Number(jAccx * jAccx + jAccy * jAccy);
            if(_loc8_ > _loc7_ * _loc7_)
            {
               sf32(_loc8_,0);
               si32(1597463007 - (li32(0) >> 1),0);
               _loc10_ = lf32(0);
               _loc9_ = _loc7_ * (_loc10_ * (1.5 - 0.5 * _loc8_ * _loc10_ * _loc10_));
               jAccx = jAccx * _loc9_;
               jAccy = jAccy * _loc9_;
            }
         }
         _loc3_ = jAccx - _loc5_;
         _loc4_ = jAccy - _loc6_;
         _loc5_ = scale * nrelx * _loc4_ - nrely * _loc3_;
         _loc6_ = Number(nrelx * _loc3_ + scale * nrely * _loc4_);
         _loc7_ = b1.imass;
         b1.velx = b1.velx - _loc5_ * _loc7_;
         b1.vely = b1.vely - _loc6_ * _loc7_;
         _loc7_ = b2.imass;
         b2.velx = Number(b2.velx + _loc5_ * _loc7_);
         b2.vely = Number(b2.vely + _loc6_ * _loc7_);
         b1.angvel = Number(b1.angvel + (scale * cx1 * _loc4_ - dot1 * _loc3_) * b1.iinertia);
         b2.angvel = Number(b2.angvel + (dot2 * _loc3_ - scale * cx2 * _loc4_) * b2.iinertia);
         return false;
      }
      
      override public function applyImpulsePos() : Boolean
      {
         var _loc9_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc1_:Number = b1.axisy * nlocalx - b1.axisx * nlocaly;
         var _loc2_:Number = Number(nlocalx * b1.axisx + nlocaly * b1.axisy);
         var _loc3_:Number = b1.axisy * a1localx - b1.axisx * a1localy;
         var _loc4_:Number = Number(a1localx * b1.axisx + a1localy * b1.axisy);
         var _loc5_:Number = b2.axisy * a2localx - b2.axisx * a2localy;
         var _loc6_:Number = Number(a2localx * b2.axisx + a2localy * b2.axisy);
         var _loc7_:Number = b2.posx + _loc5_ - b1.posx - _loc3_;
         var _loc8_:Number = b2.posy + _loc6_ - b1.posy - _loc4_;
         var _loc10_:Number = _loc8_ * _loc1_ - _loc7_ * _loc2_;
         var _loc11_:Number = Number(_loc1_ * _loc7_ + _loc2_ * _loc8_);
         if(_loc11_ > jointMax)
         {
            _loc11_ = _loc11_ - jointMax;
            _loc9_ = 1;
         }
         else if(_loc11_ < jointMin)
         {
            _loc11_ = jointMin - _loc11_;
            _loc9_ = -1;
         }
         else
         {
            _loc11_ = 0;
            _loc9_ = 0;
         }
         if(!!breakUnderError && Number(_loc10_ * _loc10_ + _loc11_ * _loc11_) > maxError * maxError)
         {
            return true;
         }
         if(Number(_loc10_ * _loc10_ + _loc11_ * _loc11_) < 0.01)
         {
            return false;
         }
         if(Number(_loc10_ * _loc10_ + _loc11_ * _loc11_) > 6)
         {
            _loc14_ = Number(b1.smass + b2.smass);
            if(_loc14_ > 1.0e-8)
            {
               _loc14_ = 0.8 / _loc14_;
               _loc15_ = _loc14_ * (_loc2_ * _loc10_ - _loc9_ * _loc1_ * _loc11_);
               _loc16_ = _loc14_ * (_loc1_ * _loc10_ * _loc9_ - _loc2_ * _loc10_);
               _loc17_ = b1.imass;
               b1.posx = b1.posx - _loc15_ * _loc17_;
               b1.posy = b1.posy - _loc16_ * _loc17_;
               _loc17_ = b2.imass;
               b2.posx = Number(b2.posx + _loc15_ * _loc17_);
               b2.posy = Number(b2.posy + _loc16_ * _loc17_);
               _loc7_ = b2.posx + _loc5_ - b1.posx - _loc3_;
               _loc8_ = b2.posy + _loc6_ - b1.posy - _loc4_;
               _loc10_ = _loc8_ * _loc1_ - _loc7_ * _loc2_;
               _loc11_ = Number(_loc1_ * _loc7_ + _loc2_ * _loc8_);
               if(_loc11_ > jointMax)
               {
                  _loc11_ = _loc11_ - jointMax;
                  _loc9_ = 1;
               }
               else if(_loc11_ < jointMin)
               {
                  _loc11_ = jointMin - _loc11_;
                  _loc9_ = -1;
               }
               else
               {
                  _loc11_ = 0;
                  _loc9_ = 0;
               }
            }
         }
         var _loc21_:Number = Number(_loc7_ + _loc3_);
         _loc22_ = Number(_loc8_ + _loc4_);
         _loc14_ = Number(_loc1_ * _loc21_ + _loc2_ * _loc22_);
         _loc16_ = _loc22_ * _loc1_ - _loc21_ * _loc2_;
         _loc15_ = Number(_loc1_ * _loc5_ + _loc2_ * _loc6_);
         _loc17_ = _loc6_ * _loc1_ - _loc5_ * _loc2_;
         var _loc18_:Number = Number(Number(Number(b1.smass + b2.smass) + _loc14_ * _loc14_ * b1.sinertia) + _loc15_ * _loc15_ * b2.sinertia);
         var _loc19_:Number = -_loc9_ * (_loc14_ * _loc16_ * b1.sinertia + _loc15_ * _loc17_ * b2.sinertia);
         var _loc20_:Number = _loc9_ * _loc9_ * (Number(Number(b1.smass + b2.smass) + _loc16_ * _loc16_ * b1.sinertia) + _loc17_ * _loc17_ * b2.sinertia);
         var _loc12_:Number = -_loc10_;
         var _loc13_:Number = -_loc11_;
         _loc21_ = _loc18_ * _loc20_ - _loc19_ * _loc19_;
         if(_loc21_ != _loc21_)
         {
            _loc13_ = 0;
            _loc12_ = _loc13_;
         }
         else if(_loc21_ == 0)
         {
            if(_loc18_ != 0)
            {
               _loc12_ = _loc12_ / _loc18_;
            }
            else
            {
               _loc12_ = 0;
            }
            if(_loc20_ != 0)
            {
               _loc13_ = _loc13_ / _loc20_;
            }
            else
            {
               _loc13_ = 0;
            }
         }
         else
         {
            _loc21_ = 1 / _loc21_;
            _loc22_ = _loc21_ * (_loc20_ * _loc12_ - _loc19_ * _loc13_);
            _loc13_ = _loc21_ * (_loc18_ * _loc13_ - _loc19_ * _loc12_);
            _loc12_ = _loc22_;
         }
         if(_loc13_ > 0)
         {
            _loc13_ = 0;
         }
         _loc21_ = _loc9_ * _loc1_ * _loc13_ - _loc2_ * _loc12_;
         _loc22_ = Number(_loc1_ * _loc12_ + _loc9_ * _loc2_ * _loc13_);
         var _loc23_:Number = b1.imass;
         b1.posx = b1.posx - _loc21_ * _loc23_;
         b1.posy = b1.posy - _loc22_ * _loc23_;
         _loc23_ = b2.imass;
         b2.posx = Number(b2.posx + _loc21_ * _loc23_);
         b2.posy = Number(b2.posy + _loc22_ * _loc23_);
         var _loc24_:ZPP_Body = b1;
         _loc23_ = (_loc9_ * _loc16_ * _loc13_ - _loc14_ * _loc12_) * b1.iinertia;
         _loc24_.rot = Number(_loc24_.rot + _loc23_);
         if(_loc23_ * _loc23_ > 0.0001)
         {
            _loc24_.axisx = Number(Math.sin(_loc24_.rot));
            _loc24_.axisy = Number(Math.cos(_loc24_.rot));
            null;
         }
         else
         {
            _loc25_ = _loc23_ * _loc23_;
            _loc26_ = 1 - 0.5 * _loc25_;
            _loc27_ = 1 - _loc25_ * _loc25_ / 8;
            _loc28_ = (_loc26_ * _loc24_.axisx + _loc23_ * _loc24_.axisy) * _loc27_;
            _loc24_.axisy = (_loc26_ * _loc24_.axisy - _loc23_ * _loc24_.axisx) * _loc27_;
            _loc24_.axisx = _loc28_;
         }
         _loc24_ = b2;
         _loc23_ = (_loc15_ * _loc12_ - _loc9_ * _loc17_ * _loc13_) * b2.iinertia;
         _loc24_.rot = Number(_loc24_.rot + _loc23_);
         if(_loc23_ * _loc23_ > 0.0001)
         {
            _loc24_.axisx = Number(Math.sin(_loc24_.rot));
            _loc24_.axisy = Number(Math.cos(_loc24_.rot));
            null;
         }
         else
         {
            _loc25_ = _loc23_ * _loc23_;
            _loc26_ = 1 - 0.5 * _loc25_;
            _loc27_ = 1 - _loc25_ * _loc25_ / 8;
            _loc28_ = (_loc26_ * _loc24_.axisx + _loc23_ * _loc24_.axisy) * _loc27_;
            _loc24_.axisy = (_loc26_ * _loc24_.axisy - _loc23_ * _loc24_.axisx) * _loc27_;
            _loc24_.axisx = _loc28_;
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
