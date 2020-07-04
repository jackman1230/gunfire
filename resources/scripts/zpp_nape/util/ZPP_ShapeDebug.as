package zpp_nape.util
{
   import flash.Boot;
   import flash.display.Graphics;
   import flash.display.Shape;
   import nape.dynamics.Arbiter;
   import nape.dynamics.ArbiterList;
   import nape.dynamics.CollisionArbiter;
   import nape.dynamics.Contact;
   import nape.dynamics.ContactList;
   import nape.dynamics.FluidArbiter;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyList;
   import nape.shape.ShapeList;
   import nape.space.Space;
   import nape.util.ShapeDebug;
   import zpp_nape.constraint.ZPP_Constraint;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.dynamics.ZPP_Contact;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.dynamics.ZPP_SpaceArbiterList;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Mat23;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_Compound;
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.space.ZPP_Space;
   
   public class ZPP_ShapeDebug extends ZPP_Debug
   {
       
      
      public var shape:flash.display.Shape;
      
      public var outer_zn:ShapeDebug;
      
      public var graphics:Graphics;
      
      public var compoundstack:ZNPList_ZPP_Compound;
      
      public function ZPP_ShapeDebug(param1:int = 0, param2:int = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(param1,param2);
         shape = new flash.display.Shape();
         graphics = shape.graphics;
         isbmp = false;
         d_shape = this;
      }
      
      public function setbg(param1:int) : void
      {
         sup_setbg(param1);
      }
      
      public function draw_space(param1:ZPP_Space, param2:ZPP_Mat23, param3:Number, param4:Boolean) : void
      {
         var _loc5_:* = null as BodyList;
         var _loc6_:* = null as Body;
         var _loc7_:* = null as ShapeList;
         var _loc8_:* = null as nape.shape.Shape;
         var _loc9_:* = null as ZNPNode_ZPP_Body;
         var _loc10_:* = null as ZPP_Body;
         var _loc11_:* = null as ZNPNode_ZPP_Compound;
         var _loc12_:* = null as ZPP_Compound;
         var _loc13_:* = null as ZPP_Compound;
         var _loc14_:* = null as Space;
         var _loc15_:* = null as ZPP_SpaceArbiterList;
         var _loc16_:* = null;
         var _loc17_:* = null as Arbiter;
         var _loc18_:* = null as ZNPNode_ZPP_Constraint;
         var _loc19_:* = null as ZPP_Constraint;
         if(outer.cullingEnabled)
         {
            if(outer.drawBodies)
            {
               if(outer.drawBodyDetail)
               {
                  _loc5_ = param1.bphase.bodiesInAABB(iport,false,false,null);
                  while(!_loc5_.empty())
                  {
                     _loc6_ = _loc5_.shift();
                     draw_body(_loc6_.zpp_inner,param2,param3,param4);
                  }
               }
               else
               {
                  _loc7_ = param1.bphase.shapesInAABB(iport,false,false,null);
                  while(!_loc7_.empty())
                  {
                     _loc8_ = _loc7_.shift();
                     draw_shape(_loc8_.zpp_inner,param2,param3,param4);
                  }
               }
            }
         }
         else if(outer.drawBodies)
         {
            if(compoundstack == null)
            {
               compoundstack = new ZNPList_ZPP_Compound();
            }
            _loc9_ = param1.bodies.head;
            while(_loc9_ != null)
            {
               _loc10_ = _loc9_.elt;
               draw_body(_loc10_,param2,param3,param4);
               _loc9_ = _loc9_.next;
            }
            _loc11_ = param1.compounds.head;
            while(_loc11_ != null)
            {
               _loc12_ = _loc11_.elt;
               compoundstack.add(_loc12_);
               _loc11_ = _loc11_.next;
            }
            while(compoundstack.head != null)
            {
               _loc12_ = compoundstack.pop_unsafe();
               _loc9_ = _loc12_.bodies.head;
               while(_loc9_ != null)
               {
                  _loc10_ = _loc9_.elt;
                  draw_body(_loc10_,param2,param3,param4);
                  _loc9_ = _loc9_.next;
               }
               _loc11_ = _loc12_.compounds.head;
               while(_loc11_ != null)
               {
                  _loc13_ = _loc11_.elt;
                  compoundstack.add(_loc13_);
                  _loc11_ = _loc11_.next;
               }
            }
         }
         if(outer.drawCollisionArbiters || outer.drawFluidArbiters || outer.drawSensorArbiters)
         {
            _loc14_ = param1.outer;
            if(_loc14_.zpp_inner.wrap_arbiters == null)
            {
               _loc15_ = new ZPP_SpaceArbiterList();
               _loc15_.space = _loc14_.zpp_inner;
               _loc14_.zpp_inner.wrap_arbiters = _loc15_;
            }
            _loc16_ = _loc14_.zpp_inner.wrap_arbiters.iterator();
            while(_loc16_.hasNext())
            {
               _loc17_ = _loc16_.next();
               draw_arbiter(_loc17_.zpp_inner,param2,param3,param4);
            }
         }
         if(outer.drawConstraints)
         {
            if(compoundstack == null)
            {
               compoundstack = new ZNPList_ZPP_Compound();
            }
            _loc18_ = param1.constraints.head;
            while(_loc18_ != null)
            {
               _loc19_ = _loc18_.elt;
               if(_loc19_.active)
               {
                  _loc19_.draw(outer);
               }
               _loc18_ = _loc18_.next;
            }
            _loc11_ = param1.compounds.head;
            while(_loc11_ != null)
            {
               _loc12_ = _loc11_.elt;
               compoundstack.add(_loc12_);
               _loc11_ = _loc11_.next;
            }
            while(compoundstack.head != null)
            {
               _loc12_ = compoundstack.pop_unsafe();
               _loc18_ = _loc12_.constraints.head;
               while(_loc18_ != null)
               {
                  _loc19_ = _loc18_.elt;
                  if(_loc19_.active)
                  {
                     _loc19_.draw(outer);
                  }
                  _loc18_ = _loc18_.next;
               }
               _loc11_ = _loc12_.compounds.head;
               while(_loc11_ != null)
               {
                  _loc13_ = _loc11_.elt;
                  compoundstack.add(_loc13_);
                  _loc11_ = _loc11_.next;
               }
            }
         }
      }
      
      public function draw_shape(param1:ZPP_Shape, param2:ZPP_Mat23, param3:Number, param4:Boolean) : void
      {
         var _loc6_:* = 0;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:* = null as ZPP_Circle;
         var _loc17_:* = null as ZPP_Polygon;
         var _loc18_:* = null as ZPP_Vec2;
         var _loc19_:* = null as ZPP_Vec2;
         var _loc20_:* = null as ZPP_Vec2;
         var _loc21_:* = null as ZPP_Vec2;
         var _loc22_:* = null as ZPP_Vec2;
         var _loc23_:* = null as ZPP_Body;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:* = null as ZPP_Polygon;
         var _loc29_:* = null as ZPP_Vec2;
         var _loc30_:* = null as ZPP_AABB;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         if(outer.colour == null)
         {
            _loc6_ = int(16777215 * Math.exp(-(int(param1.id % 500)) / 1500));
         }
         else
         {
            _loc6_ = int(outer.colour(param1.id));
         }
         _loc7_ = ((_loc6_ & 16711680) >> 16) * 0.7;
         _loc8_ = ((_loc6_ & 65280) >> 8) * 0.7;
         _loc9_ = (_loc6_ & 255) * 0.7;
         var _loc5_:* = -16777216 | int(_loc7_) << 16 | int(_loc8_) << 8 | int(_loc9_);
         var _loc10_:ZPP_Body = param1.body;
         if(_loc10_ != null)
         {
            if(outer.colour == null)
            {
               _loc11_ = 16777215 * Math.exp(-(int(_loc10_.id % 500)) / 1500);
            }
            else
            {
               _loc11_ = outer.colour(_loc10_.id);
            }
            _loc7_ = ((_loc11_ & 16711680) >> 16) * 0.7;
            _loc8_ = ((_loc11_ & 65280) >> 8) * 0.7;
            _loc9_ = (_loc11_ & 255) * 0.7;
            if(_loc10_.space != null && _loc10_.outer.zpp_inner.component.sleeping)
            {
               _loc7_ = Number(0.4 * _loc7_ + 0.6 * bg_r);
               _loc8_ = Number(0.4 * _loc8_ + 0.6 * bg_g);
               _loc9_ = Number(0.4 * _loc9_ + 0.6 * bg_b);
            }
            _loc6_ = -16777216 | int(_loc7_) << 16 | int(_loc8_) << 8 | int(_loc9_);
            _loc11_ = _loc5_;
            _loc12_ = _loc6_;
            _loc7_ = 0.2;
            _loc13_ = Number((_loc11_ >> 16 & 255) * _loc7_ + (_loc12_ >> 16 & 255) * (1 - _loc7_));
            _loc14_ = Number((_loc11_ >> 8 & 255) * _loc7_ + (_loc12_ >> 8 & 255) * (1 - _loc7_));
            _loc15_ = Number((_loc11_ & 255) * _loc7_ + (_loc12_ & 255) * (1 - _loc7_));
            _loc5_ = -16777216 | _loc13_ << 16 | _loc14_ << 8 | _loc15_;
            graphics.lineStyle(outer_zn.thickness,_loc5_,1);
            if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
            {
               _loc16_ = param1.circle;
               if(_loc16_.zip_worldCOM)
               {
                  if(_loc16_.body != null)
                  {
                     _loc16_.zip_worldCOM = false;
                     if(_loc16_.zip_localCOM)
                     {
                        _loc16_.zip_localCOM = false;
                        if(_loc16_.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                           _loc17_ = _loc16_.polygon;
                           if(_loc17_.lverts.next.next == null)
                           {
                              _loc17_.localCOMx = _loc17_.lverts.next.x;
                              _loc17_.localCOMy = _loc17_.lverts.next.y;
                              null;
                           }
                           else if(_loc17_.lverts.next.next.next == null)
                           {
                              _loc17_.localCOMx = _loc17_.lverts.next.x;
                              _loc17_.localCOMy = _loc17_.lverts.next.y;
                              _loc7_ = 1;
                              _loc17_.localCOMx = Number(_loc17_.localCOMx + _loc17_.lverts.next.next.x * _loc7_);
                              _loc17_.localCOMy = Number(_loc17_.localCOMy + _loc17_.lverts.next.next.y * _loc7_);
                              _loc7_ = 0.5;
                              _loc17_.localCOMx = _loc17_.localCOMx * _loc7_;
                              _loc17_.localCOMy = _loc17_.localCOMy * _loc7_;
                           }
                           else
                           {
                              _loc17_.localCOMx = 0;
                              _loc17_.localCOMy = 0;
                              _loc7_ = 0;
                              _loc18_ = _loc17_.lverts.next;
                              _loc19_ = _loc18_;
                              _loc18_ = _loc18_.next;
                              _loc20_ = _loc18_;
                              _loc18_ = _loc18_.next;
                              while(_loc18_ != null)
                              {
                                 _loc21_ = _loc18_;
                                 _loc7_ = Number(_loc7_ + _loc20_.x * (_loc21_.y - _loc19_.y));
                                 _loc8_ = _loc21_.y * _loc20_.x - _loc21_.x * _loc20_.y;
                                 _loc17_.localCOMx = Number(_loc17_.localCOMx + (_loc20_.x + _loc21_.x) * _loc8_);
                                 _loc17_.localCOMy = Number(_loc17_.localCOMy + (_loc20_.y + _loc21_.y) * _loc8_);
                                 _loc19_ = _loc20_;
                                 _loc20_ = _loc21_;
                                 _loc18_ = _loc18_.next;
                              }
                              _loc18_ = _loc17_.lverts.next;
                              _loc21_ = _loc18_;
                              _loc7_ = Number(_loc7_ + _loc20_.x * (_loc21_.y - _loc19_.y));
                              _loc8_ = _loc21_.y * _loc20_.x - _loc21_.x * _loc20_.y;
                              _loc17_.localCOMx = Number(_loc17_.localCOMx + (_loc20_.x + _loc21_.x) * _loc8_);
                              _loc17_.localCOMy = Number(_loc17_.localCOMy + (_loc20_.y + _loc21_.y) * _loc8_);
                              _loc19_ = _loc20_;
                              _loc20_ = _loc21_;
                              _loc18_ = _loc18_.next;
                              _loc22_ = _loc18_;
                              _loc7_ = Number(_loc7_ + _loc20_.x * (_loc22_.y - _loc19_.y));
                              _loc8_ = _loc22_.y * _loc20_.x - _loc22_.x * _loc20_.y;
                              _loc17_.localCOMx = Number(_loc17_.localCOMx + (_loc20_.x + _loc22_.x) * _loc8_);
                              _loc17_.localCOMy = Number(_loc17_.localCOMy + (_loc20_.y + _loc22_.y) * _loc8_);
                              _loc7_ = 1 / (3 * _loc7_);
                              _loc8_ = _loc7_;
                              _loc17_.localCOMx = _loc17_.localCOMx * _loc8_;
                              _loc17_.localCOMy = _loc17_.localCOMy * _loc8_;
                           }
                        }
                        if(_loc16_.wrap_localCOM != null)
                        {
                           _loc16_.wrap_localCOM.zpp_inner.x = _loc16_.localCOMx;
                           _loc16_.wrap_localCOM.zpp_inner.y = _loc16_.localCOMy;
                        }
                     }
                     _loc23_ = _loc16_.body;
                     if(_loc23_.zip_axis)
                     {
                        _loc23_.zip_axis = false;
                        _loc23_.axisx = Number(Math.sin(_loc23_.rot));
                        _loc23_.axisy = Number(Math.cos(_loc23_.rot));
                        null;
                     }
                     _loc16_.worldCOMx = Number(_loc16_.body.posx + (_loc16_.body.axisy * _loc16_.localCOMx - _loc16_.body.axisx * _loc16_.localCOMy));
                     _loc16_.worldCOMy = Number(_loc16_.body.posy + (Number(_loc16_.localCOMx * _loc16_.body.axisx + _loc16_.localCOMy * _loc16_.body.axisy)));
                     if(_loc16_.wrap_worldCOM != null)
                     {
                        _loc16_.wrap_worldCOM.zpp_inner.x = _loc16_.worldCOMx;
                        _loc16_.wrap_worldCOM.zpp_inner.y = _loc16_.worldCOMy;
                     }
                  }
               }
               _loc7_ = _loc16_.worldCOMx;
               _loc8_ = _loc16_.worldCOMy;
               if(!param4)
               {
                  _loc9_ = Number(Number(param2.a * _loc7_ + param2.b * _loc8_) + param2.tx);
                  _loc8_ = Number(Number(param2.c * _loc7_ + param2.d * _loc8_) + param2.ty);
                  _loc7_ = _loc9_;
               }
               graphics.drawCircle(_loc7_,_loc8_,_loc16_.radius * param3);
               if(outer.drawShapeAngleIndicators)
               {
                  _loc9_ = Number(_loc16_.worldCOMx + 0.3 * _loc16_.radius * _loc10_.axisy);
                  _loc24_ = Number(_loc16_.worldCOMy + 0.3 * _loc16_.radius * _loc10_.axisx);
                  _loc25_ = Number(_loc16_.worldCOMx + _loc16_.radius * _loc10_.axisy);
                  _loc26_ = Number(_loc16_.worldCOMy + _loc16_.radius * _loc10_.axisx);
                  if(!param4)
                  {
                     _loc27_ = Number(Number(param2.a * _loc9_ + param2.b * _loc24_) + param2.tx);
                     _loc24_ = Number(Number(param2.c * _loc9_ + param2.d * _loc24_) + param2.ty);
                     _loc9_ = _loc27_;
                  }
                  if(!param4)
                  {
                     _loc27_ = Number(Number(param2.a * _loc25_ + param2.b * _loc26_) + param2.tx);
                     _loc26_ = Number(Number(param2.c * _loc25_ + param2.d * _loc26_) + param2.ty);
                     _loc25_ = _loc27_;
                  }
                  graphics.moveTo(_loc9_,_loc24_);
                  graphics.lineTo(_loc25_,_loc26_);
               }
            }
            else
            {
               _loc17_ = param1.polygon;
               if(_loc17_.zip_gverts)
               {
                  if(_loc17_.body != null)
                  {
                     _loc17_.zip_gverts = false;
                     _loc17_.validate_lverts();
                     _loc23_ = _loc17_.body;
                     if(_loc23_.zip_axis)
                     {
                        _loc23_.zip_axis = false;
                        _loc23_.axisx = Number(Math.sin(_loc23_.rot));
                        _loc23_.axisy = Number(Math.cos(_loc23_.rot));
                        null;
                     }
                     _loc18_ = _loc17_.lverts.next;
                     _loc19_ = _loc17_.gverts.next;
                     while(_loc19_ != null)
                     {
                        _loc20_ = _loc19_;
                        _loc21_ = _loc18_;
                        _loc18_ = _loc18_.next;
                        _loc20_.x = Number(_loc17_.body.posx + (_loc17_.body.axisy * _loc21_.x - _loc17_.body.axisx * _loc21_.y));
                        _loc20_.y = Number(_loc17_.body.posy + (Number(_loc21_.x * _loc17_.body.axisx + _loc21_.y * _loc17_.body.axisy)));
                        _loc19_ = _loc19_.next;
                     }
                  }
               }
               _loc18_ = _loc17_.gverts.next;
               _loc7_ = _loc18_.x;
               _loc8_ = _loc18_.y;
               if(!param4)
               {
                  _loc9_ = Number(Number(param2.a * _loc7_ + param2.b * _loc8_) + param2.tx);
                  _loc8_ = Number(Number(param2.c * _loc7_ + param2.d * _loc8_) + param2.ty);
                  _loc7_ = _loc9_;
               }
               graphics.moveTo(_loc7_,_loc8_);
               _loc9_ = _loc7_;
               _loc24_ = _loc8_;
               _loc19_ = _loc17_.gverts.next.next;
               while(_loc19_ != null)
               {
                  _loc20_ = _loc19_;
                  _loc7_ = _loc20_.x;
                  _loc8_ = _loc20_.y;
                  if(!param4)
                  {
                     _loc25_ = Number(Number(param2.a * _loc7_ + param2.b * _loc8_) + param2.tx);
                     _loc8_ = Number(Number(param2.c * _loc7_ + param2.d * _loc8_) + param2.ty);
                     _loc7_ = _loc25_;
                  }
                  graphics.lineTo(_loc7_,_loc8_);
                  _loc19_ = _loc19_.next;
               }
               graphics.lineTo(_loc9_,_loc24_);
               if(outer.drawShapeAngleIndicators)
               {
                  if(_loc17_.zip_worldCOM)
                  {
                     if(_loc17_.body != null)
                     {
                        _loc17_.zip_worldCOM = false;
                        if(_loc17_.zip_localCOM)
                        {
                           _loc17_.zip_localCOM = false;
                           if(_loc17_.type == ZPP_Flags.id_ShapeType_POLYGON)
                           {
                              _loc28_ = _loc17_.polygon;
                              if(_loc28_.lverts.next.next == null)
                              {
                                 _loc28_.localCOMx = _loc28_.lverts.next.x;
                                 _loc28_.localCOMy = _loc28_.lverts.next.y;
                                 null;
                              }
                              else if(_loc28_.lverts.next.next.next == null)
                              {
                                 _loc28_.localCOMx = _loc28_.lverts.next.x;
                                 _loc28_.localCOMy = _loc28_.lverts.next.y;
                                 _loc25_ = 1;
                                 _loc28_.localCOMx = Number(_loc28_.localCOMx + _loc28_.lverts.next.next.x * _loc25_);
                                 _loc28_.localCOMy = Number(_loc28_.localCOMy + _loc28_.lverts.next.next.y * _loc25_);
                                 _loc25_ = 0.5;
                                 _loc28_.localCOMx = _loc28_.localCOMx * _loc25_;
                                 _loc28_.localCOMy = _loc28_.localCOMy * _loc25_;
                              }
                              else
                              {
                                 _loc28_.localCOMx = 0;
                                 _loc28_.localCOMy = 0;
                                 _loc25_ = 0;
                                 _loc19_ = _loc28_.lverts.next;
                                 _loc20_ = _loc19_;
                                 _loc19_ = _loc19_.next;
                                 _loc21_ = _loc19_;
                                 _loc19_ = _loc19_.next;
                                 while(_loc19_ != null)
                                 {
                                    _loc22_ = _loc19_;
                                    _loc25_ = Number(_loc25_ + _loc21_.x * (_loc22_.y - _loc20_.y));
                                    _loc26_ = _loc22_.y * _loc21_.x - _loc22_.x * _loc21_.y;
                                    _loc28_.localCOMx = Number(_loc28_.localCOMx + (_loc21_.x + _loc22_.x) * _loc26_);
                                    _loc28_.localCOMy = Number(_loc28_.localCOMy + (_loc21_.y + _loc22_.y) * _loc26_);
                                    _loc20_ = _loc21_;
                                    _loc21_ = _loc22_;
                                    _loc19_ = _loc19_.next;
                                 }
                                 _loc19_ = _loc28_.lverts.next;
                                 _loc22_ = _loc19_;
                                 _loc25_ = Number(_loc25_ + _loc21_.x * (_loc22_.y - _loc20_.y));
                                 _loc26_ = _loc22_.y * _loc21_.x - _loc22_.x * _loc21_.y;
                                 _loc28_.localCOMx = Number(_loc28_.localCOMx + (_loc21_.x + _loc22_.x) * _loc26_);
                                 _loc28_.localCOMy = Number(_loc28_.localCOMy + (_loc21_.y + _loc22_.y) * _loc26_);
                                 _loc20_ = _loc21_;
                                 _loc21_ = _loc22_;
                                 _loc19_ = _loc19_.next;
                                 _loc29_ = _loc19_;
                                 _loc25_ = Number(_loc25_ + _loc21_.x * (_loc29_.y - _loc20_.y));
                                 _loc26_ = _loc29_.y * _loc21_.x - _loc29_.x * _loc21_.y;
                                 _loc28_.localCOMx = Number(_loc28_.localCOMx + (_loc21_.x + _loc29_.x) * _loc26_);
                                 _loc28_.localCOMy = Number(_loc28_.localCOMy + (_loc21_.y + _loc29_.y) * _loc26_);
                                 _loc25_ = 1 / (3 * _loc25_);
                                 _loc26_ = _loc25_;
                                 _loc28_.localCOMx = _loc28_.localCOMx * _loc26_;
                                 _loc28_.localCOMy = _loc28_.localCOMy * _loc26_;
                              }
                           }
                           if(_loc17_.wrap_localCOM != null)
                           {
                              _loc17_.wrap_localCOM.zpp_inner.x = _loc17_.localCOMx;
                              _loc17_.wrap_localCOM.zpp_inner.y = _loc17_.localCOMy;
                           }
                        }
                        _loc23_ = _loc17_.body;
                        if(_loc23_.zip_axis)
                        {
                           _loc23_.zip_axis = false;
                           _loc23_.axisx = Number(Math.sin(_loc23_.rot));
                           _loc23_.axisy = Number(Math.cos(_loc23_.rot));
                           null;
                        }
                        _loc17_.worldCOMx = Number(_loc17_.body.posx + (_loc17_.body.axisy * _loc17_.localCOMx - _loc17_.body.axisx * _loc17_.localCOMy));
                        _loc17_.worldCOMy = Number(_loc17_.body.posy + (Number(_loc17_.localCOMx * _loc17_.body.axisx + _loc17_.localCOMy * _loc17_.body.axisy)));
                        if(_loc17_.wrap_worldCOM != null)
                        {
                           _loc17_.wrap_worldCOM.zpp_inner.x = _loc17_.worldCOMx;
                           _loc17_.wrap_worldCOM.zpp_inner.y = _loc17_.worldCOMy;
                        }
                     }
                  }
                  if(param4)
                  {
                     _loc7_ = _loc17_.worldCOMx;
                     _loc8_ = _loc17_.worldCOMy;
                  }
                  else
                  {
                     _loc7_ = Number(Number(param2.a * _loc17_.worldCOMx + param2.b * _loc17_.worldCOMy) + param2.tx);
                     _loc8_ = Number(Number(param2.c * _loc17_.worldCOMx + param2.d * _loc17_.worldCOMy) + param2.ty);
                  }
                  graphics.moveTo(_loc7_,_loc8_);
                  graphics.lineTo(_loc9_,_loc24_);
               }
            }
            if(outer.drawShapeDetail)
            {
               if(param1.zip_worldCOM)
               {
                  if(param1.body != null)
                  {
                     param1.zip_worldCOM = false;
                     if(param1.zip_localCOM)
                     {
                        param1.zip_localCOM = false;
                        if(param1.type == ZPP_Flags.id_ShapeType_POLYGON)
                        {
                           _loc17_ = param1.polygon;
                           if(_loc17_.lverts.next.next == null)
                           {
                              _loc17_.localCOMx = _loc17_.lverts.next.x;
                              _loc17_.localCOMy = _loc17_.lverts.next.y;
                              null;
                           }
                           else if(_loc17_.lverts.next.next.next == null)
                           {
                              _loc17_.localCOMx = _loc17_.lverts.next.x;
                              _loc17_.localCOMy = _loc17_.lverts.next.y;
                              _loc7_ = 1;
                              _loc17_.localCOMx = Number(_loc17_.localCOMx + _loc17_.lverts.next.next.x * _loc7_);
                              _loc17_.localCOMy = Number(_loc17_.localCOMy + _loc17_.lverts.next.next.y * _loc7_);
                              _loc7_ = 0.5;
                              _loc17_.localCOMx = _loc17_.localCOMx * _loc7_;
                              _loc17_.localCOMy = _loc17_.localCOMy * _loc7_;
                           }
                           else
                           {
                              _loc17_.localCOMx = 0;
                              _loc17_.localCOMy = 0;
                              _loc7_ = 0;
                              _loc18_ = _loc17_.lverts.next;
                              _loc19_ = _loc18_;
                              _loc18_ = _loc18_.next;
                              _loc20_ = _loc18_;
                              _loc18_ = _loc18_.next;
                              while(_loc18_ != null)
                              {
                                 _loc21_ = _loc18_;
                                 _loc7_ = Number(_loc7_ + _loc20_.x * (_loc21_.y - _loc19_.y));
                                 _loc8_ = _loc21_.y * _loc20_.x - _loc21_.x * _loc20_.y;
                                 _loc17_.localCOMx = Number(_loc17_.localCOMx + (_loc20_.x + _loc21_.x) * _loc8_);
                                 _loc17_.localCOMy = Number(_loc17_.localCOMy + (_loc20_.y + _loc21_.y) * _loc8_);
                                 _loc19_ = _loc20_;
                                 _loc20_ = _loc21_;
                                 _loc18_ = _loc18_.next;
                              }
                              _loc18_ = _loc17_.lverts.next;
                              _loc21_ = _loc18_;
                              _loc7_ = Number(_loc7_ + _loc20_.x * (_loc21_.y - _loc19_.y));
                              _loc8_ = _loc21_.y * _loc20_.x - _loc21_.x * _loc20_.y;
                              _loc17_.localCOMx = Number(_loc17_.localCOMx + (_loc20_.x + _loc21_.x) * _loc8_);
                              _loc17_.localCOMy = Number(_loc17_.localCOMy + (_loc20_.y + _loc21_.y) * _loc8_);
                              _loc19_ = _loc20_;
                              _loc20_ = _loc21_;
                              _loc18_ = _loc18_.next;
                              _loc22_ = _loc18_;
                              _loc7_ = Number(_loc7_ + _loc20_.x * (_loc22_.y - _loc19_.y));
                              _loc8_ = _loc22_.y * _loc20_.x - _loc22_.x * _loc20_.y;
                              _loc17_.localCOMx = Number(_loc17_.localCOMx + (_loc20_.x + _loc22_.x) * _loc8_);
                              _loc17_.localCOMy = Number(_loc17_.localCOMy + (_loc20_.y + _loc22_.y) * _loc8_);
                              _loc7_ = 1 / (3 * _loc7_);
                              _loc8_ = _loc7_;
                              _loc17_.localCOMx = _loc17_.localCOMx * _loc8_;
                              _loc17_.localCOMy = _loc17_.localCOMy * _loc8_;
                           }
                        }
                        if(param1.wrap_localCOM != null)
                        {
                           param1.wrap_localCOM.zpp_inner.x = param1.localCOMx;
                           param1.wrap_localCOM.zpp_inner.y = param1.localCOMy;
                        }
                     }
                     _loc23_ = param1.body;
                     if(_loc23_.zip_axis)
                     {
                        _loc23_.zip_axis = false;
                        _loc23_.axisx = Number(Math.sin(_loc23_.rot));
                        _loc23_.axisy = Number(Math.cos(_loc23_.rot));
                        null;
                     }
                     param1.worldCOMx = Number(param1.body.posx + (param1.body.axisy * param1.localCOMx - param1.body.axisx * param1.localCOMy));
                     param1.worldCOMy = Number(param1.body.posy + (Number(param1.localCOMx * param1.body.axisx + param1.localCOMy * param1.body.axisy)));
                     if(param1.wrap_worldCOM != null)
                     {
                        param1.wrap_worldCOM.zpp_inner.x = param1.worldCOMx;
                        param1.wrap_worldCOM.zpp_inner.y = param1.worldCOMy;
                     }
                  }
               }
               _loc11_ = _loc5_;
               _loc12_ = 16711680;
               _loc7_ = 0.8;
               _loc13_ = Number((_loc11_ >> 16 & 255) * _loc7_ + (_loc12_ >> 16 & 255) * (1 - _loc7_));
               _loc14_ = Number((_loc11_ >> 8 & 255) * _loc7_ + (_loc12_ >> 8 & 255) * (1 - _loc7_));
               _loc15_ = Number((_loc11_ & 255) * _loc7_ + (_loc12_ & 255) * (1 - _loc7_));
               graphics.lineStyle(outer_zn.thickness,-16777216 | _loc13_ << 16 | _loc14_ << 8 | _loc15_,1);
               if(param4)
               {
                  _loc7_ = param1.worldCOMx;
                  _loc8_ = param1.worldCOMy;
               }
               else
               {
                  _loc7_ = Number(Number(param2.a * param1.worldCOMx + param2.b * param1.worldCOMy) + param2.tx);
                  _loc8_ = Number(Number(param2.c * param1.worldCOMx + param2.d * param1.worldCOMy) + param2.ty);
               }
               graphics.drawCircle(_loc7_,_loc8_,1);
               if(param1.zip_aabb)
               {
                  if(param1.body != null)
                  {
                     param1.zip_aabb = false;
                     if(param1.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        _loc16_ = param1.circle;
                        if(_loc16_.zip_worldCOM)
                        {
                           if(_loc16_.body != null)
                           {
                              _loc16_.zip_worldCOM = false;
                              if(_loc16_.zip_localCOM)
                              {
                                 _loc16_.zip_localCOM = false;
                                 if(_loc16_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                 {
                                    _loc17_ = _loc16_.polygon;
                                    if(_loc17_.lverts.next.next == null)
                                    {
                                       _loc17_.localCOMx = _loc17_.lverts.next.x;
                                       _loc17_.localCOMy = _loc17_.lverts.next.y;
                                       null;
                                    }
                                    else if(_loc17_.lverts.next.next.next == null)
                                    {
                                       _loc17_.localCOMx = _loc17_.lverts.next.x;
                                       _loc17_.localCOMy = _loc17_.lverts.next.y;
                                       _loc9_ = 1;
                                       _loc17_.localCOMx = Number(_loc17_.localCOMx + _loc17_.lverts.next.next.x * _loc9_);
                                       _loc17_.localCOMy = Number(_loc17_.localCOMy + _loc17_.lverts.next.next.y * _loc9_);
                                       _loc9_ = 0.5;
                                       _loc17_.localCOMx = _loc17_.localCOMx * _loc9_;
                                       _loc17_.localCOMy = _loc17_.localCOMy * _loc9_;
                                    }
                                    else
                                    {
                                       _loc17_.localCOMx = 0;
                                       _loc17_.localCOMy = 0;
                                       _loc9_ = 0;
                                       _loc18_ = _loc17_.lverts.next;
                                       _loc19_ = _loc18_;
                                       _loc18_ = _loc18_.next;
                                       _loc20_ = _loc18_;
                                       _loc18_ = _loc18_.next;
                                       while(_loc18_ != null)
                                       {
                                          _loc21_ = _loc18_;
                                          _loc9_ = Number(_loc9_ + _loc20_.x * (_loc21_.y - _loc19_.y));
                                          _loc24_ = _loc21_.y * _loc20_.x - _loc21_.x * _loc20_.y;
                                          _loc17_.localCOMx = Number(_loc17_.localCOMx + (_loc20_.x + _loc21_.x) * _loc24_);
                                          _loc17_.localCOMy = Number(_loc17_.localCOMy + (_loc20_.y + _loc21_.y) * _loc24_);
                                          _loc19_ = _loc20_;
                                          _loc20_ = _loc21_;
                                          _loc18_ = _loc18_.next;
                                       }
                                       _loc18_ = _loc17_.lverts.next;
                                       _loc21_ = _loc18_;
                                       _loc9_ = Number(_loc9_ + _loc20_.x * (_loc21_.y - _loc19_.y));
                                       _loc24_ = _loc21_.y * _loc20_.x - _loc21_.x * _loc20_.y;
                                       _loc17_.localCOMx = Number(_loc17_.localCOMx + (_loc20_.x + _loc21_.x) * _loc24_);
                                       _loc17_.localCOMy = Number(_loc17_.localCOMy + (_loc20_.y + _loc21_.y) * _loc24_);
                                       _loc19_ = _loc20_;
                                       _loc20_ = _loc21_;
                                       _loc18_ = _loc18_.next;
                                       _loc22_ = _loc18_;
                                       _loc9_ = Number(_loc9_ + _loc20_.x * (_loc22_.y - _loc19_.y));
                                       _loc24_ = _loc22_.y * _loc20_.x - _loc22_.x * _loc20_.y;
                                       _loc17_.localCOMx = Number(_loc17_.localCOMx + (_loc20_.x + _loc22_.x) * _loc24_);
                                       _loc17_.localCOMy = Number(_loc17_.localCOMy + (_loc20_.y + _loc22_.y) * _loc24_);
                                       _loc9_ = 1 / (3 * _loc9_);
                                       _loc24_ = _loc9_;
                                       _loc17_.localCOMx = _loc17_.localCOMx * _loc24_;
                                       _loc17_.localCOMy = _loc17_.localCOMy * _loc24_;
                                    }
                                 }
                                 if(_loc16_.wrap_localCOM != null)
                                 {
                                    _loc16_.wrap_localCOM.zpp_inner.x = _loc16_.localCOMx;
                                    _loc16_.wrap_localCOM.zpp_inner.y = _loc16_.localCOMy;
                                 }
                              }
                              _loc23_ = _loc16_.body;
                              if(_loc23_.zip_axis)
                              {
                                 _loc23_.zip_axis = false;
                                 _loc23_.axisx = Number(Math.sin(_loc23_.rot));
                                 _loc23_.axisy = Number(Math.cos(_loc23_.rot));
                                 null;
                              }
                              _loc16_.worldCOMx = Number(_loc16_.body.posx + (_loc16_.body.axisy * _loc16_.localCOMx - _loc16_.body.axisx * _loc16_.localCOMy));
                              _loc16_.worldCOMy = Number(_loc16_.body.posy + (Number(_loc16_.localCOMx * _loc16_.body.axisx + _loc16_.localCOMy * _loc16_.body.axisy)));
                              if(_loc16_.wrap_worldCOM != null)
                              {
                                 _loc16_.wrap_worldCOM.zpp_inner.x = _loc16_.worldCOMx;
                                 _loc16_.wrap_worldCOM.zpp_inner.y = _loc16_.worldCOMy;
                              }
                           }
                        }
                        _loc9_ = _loc16_.radius;
                        _loc24_ = _loc16_.radius;
                        _loc16_.aabb.minx = _loc16_.worldCOMx - _loc9_;
                        _loc16_.aabb.miny = _loc16_.worldCOMy - _loc24_;
                        _loc16_.aabb.maxx = Number(_loc16_.worldCOMx + _loc9_);
                        _loc16_.aabb.maxy = Number(_loc16_.worldCOMy + _loc24_);
                     }
                     else
                     {
                        _loc17_ = param1.polygon;
                        if(_loc17_.zip_gverts)
                        {
                           if(_loc17_.body != null)
                           {
                              _loc17_.zip_gverts = false;
                              _loc17_.validate_lverts();
                              _loc23_ = _loc17_.body;
                              if(_loc23_.zip_axis)
                              {
                                 _loc23_.zip_axis = false;
                                 _loc23_.axisx = Number(Math.sin(_loc23_.rot));
                                 _loc23_.axisy = Number(Math.cos(_loc23_.rot));
                                 null;
                              }
                              _loc18_ = _loc17_.lverts.next;
                              _loc19_ = _loc17_.gverts.next;
                              while(_loc19_ != null)
                              {
                                 _loc20_ = _loc19_;
                                 _loc21_ = _loc18_;
                                 _loc18_ = _loc18_.next;
                                 _loc20_.x = Number(_loc17_.body.posx + (_loc17_.body.axisy * _loc21_.x - _loc17_.body.axisx * _loc21_.y));
                                 _loc20_.y = Number(_loc17_.body.posy + (Number(_loc21_.x * _loc17_.body.axisx + _loc21_.y * _loc17_.body.axisy)));
                                 _loc19_ = _loc19_.next;
                              }
                           }
                        }
                        _loc18_ = _loc17_.gverts.next;
                        _loc17_.aabb.minx = _loc18_.x;
                        _loc17_.aabb.miny = _loc18_.y;
                        _loc17_.aabb.maxx = _loc18_.x;
                        _loc17_.aabb.maxy = _loc18_.y;
                        _loc19_ = _loc17_.gverts.next.next;
                        while(_loc19_ != null)
                        {
                           _loc20_ = _loc19_;
                           if(_loc20_.x < _loc17_.aabb.minx)
                           {
                              _loc17_.aabb.minx = _loc20_.x;
                           }
                           if(_loc20_.x > _loc17_.aabb.maxx)
                           {
                              _loc17_.aabb.maxx = _loc20_.x;
                           }
                           if(_loc20_.y < _loc17_.aabb.miny)
                           {
                              _loc17_.aabb.miny = _loc20_.y;
                           }
                           if(_loc20_.y > _loc17_.aabb.maxy)
                           {
                              _loc17_.aabb.maxy = _loc20_.y;
                           }
                           _loc19_ = _loc19_.next;
                        }
                     }
                  }
               }
               if(param4)
               {
                  _loc30_ = param1.aabb;
                  _loc30_ = param1.aabb;
                  graphics.drawRect(param1.aabb.minx,param1.aabb.miny,_loc30_.maxx - _loc30_.minx,_loc30_.maxy - _loc30_.miny);
               }
               else
               {
                  _loc9_ = Number(Number(param2.a * param1.aabb.minx + param2.b * param1.aabb.miny) + param2.tx);
                  _loc24_ = Number(Number(param2.c * param1.aabb.minx + param2.d * param1.aabb.miny) + param2.ty);
                  _loc30_ = param1.aabb;
                  _loc25_ = _loc30_.maxx - _loc30_.minx;
                  _loc26_ = 0;
                  _loc27_ = Number(param2.a * _loc25_ + param2.b * _loc26_);
                  _loc26_ = Number(param2.c * _loc25_ + param2.d * _loc26_);
                  _loc25_ = _loc27_;
                  _loc27_ = 0;
                  _loc30_ = param1.aabb;
                  _loc31_ = _loc30_.maxy - _loc30_.miny;
                  _loc32_ = Number(param2.a * _loc27_ + param2.b * _loc31_);
                  _loc31_ = Number(param2.c * _loc27_ + param2.d * _loc31_);
                  _loc27_ = _loc32_;
                  graphics.moveTo(_loc9_,_loc24_);
                  graphics.lineTo(Number(_loc9_ + _loc25_),Number(_loc24_ + _loc26_));
                  graphics.lineTo(Number(Number(_loc9_ + _loc25_) + _loc27_),Number(Number(_loc24_ + _loc26_) + _loc31_));
                  graphics.lineTo(Number(_loc9_ + _loc27_),Number(_loc24_ + _loc31_));
                  graphics.lineTo(_loc9_,_loc24_);
               }
            }
         }
      }
      
      public function draw_compound(param1:ZPP_Compound, param2:ZPP_Mat23, param3:Number, param4:Boolean) : void
      {
         var _loc6_:* = null as ZPP_Compound;
         var _loc8_:* = null as ZPP_Body;
         var _loc5_:ZNPNode_ZPP_Compound = param1.compounds.head;
         while(_loc5_ != null)
         {
            _loc6_ = _loc5_.elt;
            draw_compound(_loc6_,param2,param3,param4);
            _loc5_ = _loc5_.next;
         }
         var _loc7_:ZNPNode_ZPP_Body = param1.bodies.head;
         while(_loc7_ != null)
         {
            _loc8_ = _loc7_.elt;
            draw_body(_loc8_,param2,param3,param4);
            _loc7_ = _loc7_.next;
         }
      }
      
      public function draw_body(param1:ZPP_Body, param2:ZPP_Mat23, param3:Number, param4:Boolean) : void
      {
         var _loc5_:* = null as ZNPNode_ZPP_Shape;
         var _loc6_:* = null as ZPP_Shape;
         var _loc7_:* = 0;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:* = null as ZPP_Circle;
         var _loc17_:* = null as ZPP_Polygon;
         var _loc18_:* = null as ZPP_Vec2;
         var _loc19_:* = null as ZPP_Vec2;
         var _loc20_:* = null as ZPP_Vec2;
         var _loc21_:* = null as ZPP_Vec2;
         var _loc22_:Number = NaN;
         var _loc23_:* = null as ZPP_Vec2;
         var _loc24_:* = null as ZPP_Body;
         var _loc25_:* = null as ZPP_AABB;
         var _loc26_:* = null as ZPP_AABB;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         _loc5_ = param1.shapes.head;
         while(_loc5_ != null)
         {
            _loc6_ = _loc5_.elt;
            draw_shape(_loc6_,param2,param3,param4);
            _loc5_ = _loc5_.next;
         }
         if(outer.drawBodyDetail)
         {
            if(outer.colour == null)
            {
               _loc8_ = 16777215 * Math.exp(-(int(param1.id % 500)) / 1500);
            }
            else
            {
               _loc8_ = outer.colour(param1.id);
            }
            _loc9_ = ((_loc8_ & 16711680) >> 16) * 0.7;
            _loc10_ = ((_loc8_ & 65280) >> 8) * 0.7;
            _loc11_ = (_loc8_ & 255) * 0.7;
            if(param1.space != null && param1.outer.zpp_inner.component.sleeping)
            {
               _loc9_ = Number(0.4 * _loc9_ + 0.6 * bg_r);
               _loc10_ = Number(0.4 * _loc10_ + 0.6 * bg_g);
               _loc11_ = Number(0.4 * _loc11_ + 0.6 * bg_b);
            }
            _loc7_ = -16777216 | int(_loc9_) << 16 | int(_loc10_) << 8 | int(_loc11_);
            param1.validate_worldCOM();
            _loc8_ = _loc7_;
            _loc12_ = 16711680;
            _loc9_ = 0.8;
            _loc13_ = Number((_loc8_ >> 16 & 255) * _loc9_ + (_loc12_ >> 16 & 255) * (1 - _loc9_));
            _loc14_ = Number((_loc8_ >> 8 & 255) * _loc9_ + (_loc12_ >> 8 & 255) * (1 - _loc9_));
            _loc15_ = Number((_loc8_ & 255) * _loc9_ + (_loc12_ & 255) * (1 - _loc9_));
            graphics.lineStyle(outer_zn.thickness,-16777216 | _loc13_ << 16 | _loc14_ << 8 | _loc15_,1);
            if(param4)
            {
               _loc9_ = param1.worldCOMx;
               _loc10_ = param1.worldCOMy;
            }
            else
            {
               _loc9_ = Number(Number(param2.a * param1.worldCOMx + param2.b * param1.worldCOMy) + param2.tx);
               _loc10_ = Number(Number(param2.c * param1.worldCOMx + param2.d * param1.worldCOMy) + param2.ty);
            }
            graphics.drawCircle(_loc9_,_loc10_,1);
            if(param1.zip_aabb)
            {
               param1.zip_aabb = false;
               param1.aabb.minx = 1.79e308;
               param1.aabb.miny = 1.79e308;
               param1.aabb.maxx = -1.79e308;
               param1.aabb.maxy = -1.79e308;
               _loc5_ = param1.shapes.head;
               while(_loc5_ != null)
               {
                  _loc6_ = _loc5_.elt;
                  if(_loc6_.zip_aabb)
                  {
                     if(_loc6_.body != null)
                     {
                        _loc6_.zip_aabb = false;
                        if(_loc6_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                        {
                           _loc16_ = _loc6_.circle;
                           if(_loc16_.zip_worldCOM)
                           {
                              if(_loc16_.body != null)
                              {
                                 _loc16_.zip_worldCOM = false;
                                 if(_loc16_.zip_localCOM)
                                 {
                                    _loc16_.zip_localCOM = false;
                                    if(_loc16_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                    {
                                       _loc17_ = _loc16_.polygon;
                                       if(_loc17_.lverts.next.next == null)
                                       {
                                          _loc17_.localCOMx = _loc17_.lverts.next.x;
                                          _loc17_.localCOMy = _loc17_.lverts.next.y;
                                          null;
                                       }
                                       else if(_loc17_.lverts.next.next.next == null)
                                       {
                                          _loc17_.localCOMx = _loc17_.lverts.next.x;
                                          _loc17_.localCOMy = _loc17_.lverts.next.y;
                                          _loc11_ = 1;
                                          _loc17_.localCOMx = Number(_loc17_.localCOMx + _loc17_.lverts.next.next.x * _loc11_);
                                          _loc17_.localCOMy = Number(_loc17_.localCOMy + _loc17_.lverts.next.next.y * _loc11_);
                                          _loc11_ = 0.5;
                                          _loc17_.localCOMx = _loc17_.localCOMx * _loc11_;
                                          _loc17_.localCOMy = _loc17_.localCOMy * _loc11_;
                                       }
                                       else
                                       {
                                          _loc17_.localCOMx = 0;
                                          _loc17_.localCOMy = 0;
                                          _loc11_ = 0;
                                          _loc18_ = _loc17_.lverts.next;
                                          _loc19_ = _loc18_;
                                          _loc18_ = _loc18_.next;
                                          _loc20_ = _loc18_;
                                          _loc18_ = _loc18_.next;
                                          while(_loc18_ != null)
                                          {
                                             _loc21_ = _loc18_;
                                             _loc11_ = Number(_loc11_ + _loc20_.x * (_loc21_.y - _loc19_.y));
                                             _loc22_ = _loc21_.y * _loc20_.x - _loc21_.x * _loc20_.y;
                                             _loc17_.localCOMx = Number(_loc17_.localCOMx + (_loc20_.x + _loc21_.x) * _loc22_);
                                             _loc17_.localCOMy = Number(_loc17_.localCOMy + (_loc20_.y + _loc21_.y) * _loc22_);
                                             _loc19_ = _loc20_;
                                             _loc20_ = _loc21_;
                                             _loc18_ = _loc18_.next;
                                          }
                                          _loc18_ = _loc17_.lverts.next;
                                          _loc21_ = _loc18_;
                                          _loc11_ = Number(_loc11_ + _loc20_.x * (_loc21_.y - _loc19_.y));
                                          _loc22_ = _loc21_.y * _loc20_.x - _loc21_.x * _loc20_.y;
                                          _loc17_.localCOMx = Number(_loc17_.localCOMx + (_loc20_.x + _loc21_.x) * _loc22_);
                                          _loc17_.localCOMy = Number(_loc17_.localCOMy + (_loc20_.y + _loc21_.y) * _loc22_);
                                          _loc19_ = _loc20_;
                                          _loc20_ = _loc21_;
                                          _loc18_ = _loc18_.next;
                                          _loc23_ = _loc18_;
                                          _loc11_ = Number(_loc11_ + _loc20_.x * (_loc23_.y - _loc19_.y));
                                          _loc22_ = _loc23_.y * _loc20_.x - _loc23_.x * _loc20_.y;
                                          _loc17_.localCOMx = Number(_loc17_.localCOMx + (_loc20_.x + _loc23_.x) * _loc22_);
                                          _loc17_.localCOMy = Number(_loc17_.localCOMy + (_loc20_.y + _loc23_.y) * _loc22_);
                                          _loc11_ = 1 / (3 * _loc11_);
                                          _loc22_ = _loc11_;
                                          _loc17_.localCOMx = _loc17_.localCOMx * _loc22_;
                                          _loc17_.localCOMy = _loc17_.localCOMy * _loc22_;
                                       }
                                    }
                                    if(_loc16_.wrap_localCOM != null)
                                    {
                                       _loc16_.wrap_localCOM.zpp_inner.x = _loc16_.localCOMx;
                                       _loc16_.wrap_localCOM.zpp_inner.y = _loc16_.localCOMy;
                                    }
                                 }
                                 _loc24_ = _loc16_.body;
                                 if(_loc24_.zip_axis)
                                 {
                                    _loc24_.zip_axis = false;
                                    _loc24_.axisx = Number(Math.sin(_loc24_.rot));
                                    _loc24_.axisy = Number(Math.cos(_loc24_.rot));
                                    null;
                                 }
                                 _loc16_.worldCOMx = Number(_loc16_.body.posx + (_loc16_.body.axisy * _loc16_.localCOMx - _loc16_.body.axisx * _loc16_.localCOMy));
                                 _loc16_.worldCOMy = Number(_loc16_.body.posy + (Number(_loc16_.localCOMx * _loc16_.body.axisx + _loc16_.localCOMy * _loc16_.body.axisy)));
                                 if(_loc16_.wrap_worldCOM != null)
                                 {
                                    _loc16_.wrap_worldCOM.zpp_inner.x = _loc16_.worldCOMx;
                                    _loc16_.wrap_worldCOM.zpp_inner.y = _loc16_.worldCOMy;
                                 }
                              }
                           }
                           _loc11_ = _loc16_.radius;
                           _loc22_ = _loc16_.radius;
                           _loc16_.aabb.minx = _loc16_.worldCOMx - _loc11_;
                           _loc16_.aabb.miny = _loc16_.worldCOMy - _loc22_;
                           _loc16_.aabb.maxx = Number(_loc16_.worldCOMx + _loc11_);
                           _loc16_.aabb.maxy = Number(_loc16_.worldCOMy + _loc22_);
                        }
                        else
                        {
                           _loc17_ = _loc6_.polygon;
                           if(_loc17_.zip_gverts)
                           {
                              if(_loc17_.body != null)
                              {
                                 _loc17_.zip_gverts = false;
                                 _loc17_.validate_lverts();
                                 _loc24_ = _loc17_.body;
                                 if(_loc24_.zip_axis)
                                 {
                                    _loc24_.zip_axis = false;
                                    _loc24_.axisx = Number(Math.sin(_loc24_.rot));
                                    _loc24_.axisy = Number(Math.cos(_loc24_.rot));
                                    null;
                                 }
                                 _loc18_ = _loc17_.lverts.next;
                                 _loc19_ = _loc17_.gverts.next;
                                 while(_loc19_ != null)
                                 {
                                    _loc20_ = _loc19_;
                                    _loc21_ = _loc18_;
                                    _loc18_ = _loc18_.next;
                                    _loc20_.x = Number(_loc17_.body.posx + (_loc17_.body.axisy * _loc21_.x - _loc17_.body.axisx * _loc21_.y));
                                    _loc20_.y = Number(_loc17_.body.posy + (Number(_loc21_.x * _loc17_.body.axisx + _loc21_.y * _loc17_.body.axisy)));
                                    _loc19_ = _loc19_.next;
                                 }
                              }
                           }
                           _loc18_ = _loc17_.gverts.next;
                           _loc17_.aabb.minx = _loc18_.x;
                           _loc17_.aabb.miny = _loc18_.y;
                           _loc17_.aabb.maxx = _loc18_.x;
                           _loc17_.aabb.maxy = _loc18_.y;
                           _loc19_ = _loc17_.gverts.next.next;
                           while(_loc19_ != null)
                           {
                              _loc20_ = _loc19_;
                              if(_loc20_.x < _loc17_.aabb.minx)
                              {
                                 _loc17_.aabb.minx = _loc20_.x;
                              }
                              if(_loc20_.x > _loc17_.aabb.maxx)
                              {
                                 _loc17_.aabb.maxx = _loc20_.x;
                              }
                              if(_loc20_.y < _loc17_.aabb.miny)
                              {
                                 _loc17_.aabb.miny = _loc20_.y;
                              }
                              if(_loc20_.y > _loc17_.aabb.maxy)
                              {
                                 _loc17_.aabb.maxy = _loc20_.y;
                              }
                              _loc19_ = _loc19_.next;
                           }
                        }
                     }
                  }
                  _loc25_ = param1.aabb;
                  _loc26_ = _loc6_.aabb;
                  if(_loc26_.minx < _loc25_.minx)
                  {
                     _loc25_.minx = _loc26_.minx;
                  }
                  if(_loc26_.maxx > _loc25_.maxx)
                  {
                     _loc25_.maxx = _loc26_.maxx;
                  }
                  if(_loc26_.miny < _loc25_.miny)
                  {
                     _loc25_.miny = _loc26_.miny;
                  }
                  if(_loc26_.maxy > _loc25_.maxy)
                  {
                     _loc25_.maxy = _loc26_.maxy;
                  }
                  _loc5_ = _loc5_.next;
               }
            }
            if(param4)
            {
               _loc25_ = param1.aabb;
               _loc25_ = param1.aabb;
               graphics.drawRect(param1.aabb.minx,param1.aabb.miny,_loc25_.maxx - _loc25_.minx,_loc25_.maxy - _loc25_.miny);
            }
            else
            {
               _loc11_ = Number(Number(param2.a * param1.aabb.minx + param2.b * param1.aabb.miny) + param2.tx);
               _loc22_ = Number(Number(param2.c * param1.aabb.minx + param2.d * param1.aabb.miny) + param2.ty);
               _loc25_ = param1.aabb;
               _loc27_ = _loc25_.maxx - _loc25_.minx;
               _loc28_ = 0;
               _loc29_ = Number(param2.a * _loc27_ + param2.b * _loc28_);
               _loc28_ = Number(param2.c * _loc27_ + param2.d * _loc28_);
               _loc27_ = _loc29_;
               _loc29_ = 0;
               _loc25_ = param1.aabb;
               _loc30_ = _loc25_.maxy - _loc25_.miny;
               _loc31_ = Number(param2.a * _loc29_ + param2.b * _loc30_);
               _loc30_ = Number(param2.c * _loc29_ + param2.d * _loc30_);
               _loc29_ = _loc31_;
               graphics.moveTo(_loc11_,_loc22_);
               graphics.lineTo(Number(_loc11_ + _loc27_),Number(_loc22_ + _loc28_));
               graphics.lineTo(Number(Number(_loc11_ + _loc27_) + _loc29_),Number(Number(_loc22_ + _loc28_) + _loc30_));
               graphics.lineTo(Number(_loc11_ + _loc29_),Number(_loc22_ + _loc30_));
               graphics.lineTo(_loc11_,_loc22_);
            }
         }
      }
      
      public function draw_arbiter(param1:ZPP_Arbiter, param2:ZPP_Mat23, param3:Number, param4:Boolean) : void
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:* = null as Arbiter;
         var _loc8_:int = 0;
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:* = null as Vec2;
         var _loc15_:* = null as nape.shape.Shape;
         var _loc16_:* = null as ZPP_Vec2;
         var _loc17_:* = null as FluidArbiter;
         var _loc18_:* = null as CollisionArbiter;
         var _loc19_:Number = NaN;
         var _loc20_:* = null as ContactList;
         var _loc21_:* = null as ZPP_Contact;
         var _loc22_:* = null as ZPP_Contact;
         var _loc23_:* = null as Contact;
         var _loc24_:* = null as Vec2;
         var _loc25_:* = null as Vec2;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         if(param1.outer.isSensorArbiter())
         {
            if(outer.drawSensorArbiters)
            {
               _loc7_ = param1.outer;
               _loc8_ = 65280;
               _loc9_ = ~bg_col;
               _loc10_ = 0.7;
               _loc11_ = Number((_loc8_ >> 16 & 255) * _loc10_ + (_loc9_ >> 16 & 255) * (1 - _loc10_));
               _loc12_ = Number((_loc8_ >> 8 & 255) * _loc10_ + (_loc9_ >> 8 & 255) * (1 - _loc10_));
               _loc13_ = Number((_loc8_ & 255) * _loc10_ + (_loc9_ & 255) * (1 - _loc10_));
               graphics.lineStyle(outer_zn.thickness,-16777216 | _loc11_ << 16 | _loc12_ << 8 | _loc13_,1);
               if(param4)
               {
                  _loc15_ = _loc7_.zpp_inner.ws1.id > _loc7_.zpp_inner.ws2.id?_loc7_.zpp_inner.ws2.outer:_loc7_.zpp_inner.ws1.outer;
                  if(_loc15_.zpp_inner.wrap_worldCOM == null)
                  {
                     _loc15_.zpp_inner.wrap_worldCOM = Vec2.get(_loc15_.zpp_inner.worldCOMx,_loc15_.zpp_inner.worldCOMy);
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc15_.zpp_inner.getworldCOM;
                  }
                  _loc14_ = _loc15_.zpp_inner.wrap_worldCOM;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc5_ = _loc14_.zpp_inner.x;
                  _loc15_ = _loc7_.zpp_inner.ws1.id > _loc7_.zpp_inner.ws2.id?_loc7_.zpp_inner.ws2.outer:_loc7_.zpp_inner.ws1.outer;
                  if(_loc15_.zpp_inner.wrap_worldCOM == null)
                  {
                     _loc15_.zpp_inner.wrap_worldCOM = Vec2.get(_loc15_.zpp_inner.worldCOMx,_loc15_.zpp_inner.worldCOMy);
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc15_.zpp_inner.getworldCOM;
                  }
                  _loc14_ = _loc15_.zpp_inner.wrap_worldCOM;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc6_ = _loc14_.zpp_inner.y;
               }
               else
               {
                  _loc15_ = _loc7_.zpp_inner.ws1.id > _loc7_.zpp_inner.ws2.id?_loc7_.zpp_inner.ws2.outer:_loc7_.zpp_inner.ws1.outer;
                  §§push(param2.a);
                  if(_loc15_.zpp_inner.wrap_worldCOM == null)
                  {
                     _loc15_.zpp_inner.wrap_worldCOM = Vec2.get(_loc15_.zpp_inner.worldCOMx,_loc15_.zpp_inner.worldCOMy);
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc15_.zpp_inner.getworldCOM;
                  }
                  _loc14_ = _loc15_.zpp_inner.wrap_worldCOM;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc15_ = _loc7_.zpp_inner.ws1.id > _loc7_.zpp_inner.ws2.id?_loc7_.zpp_inner.ws2.outer:_loc7_.zpp_inner.ws1.outer;
                  §§push(§§pop() * _loc14_.zpp_inner.x);
                  §§push(param2.b);
                  if(_loc15_.zpp_inner.wrap_worldCOM == null)
                  {
                     _loc15_.zpp_inner.wrap_worldCOM = Vec2.get(_loc15_.zpp_inner.worldCOMx,_loc15_.zpp_inner.worldCOMy);
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc15_.zpp_inner.getworldCOM;
                  }
                  _loc14_ = _loc15_.zpp_inner.wrap_worldCOM;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc5_ = Number(Number(§§pop() + §§pop() * _loc14_.zpp_inner.y) + param2.tx);
                  _loc15_ = _loc7_.zpp_inner.ws1.id > _loc7_.zpp_inner.ws2.id?_loc7_.zpp_inner.ws2.outer:_loc7_.zpp_inner.ws1.outer;
                  §§push(param2.c);
                  if(_loc15_.zpp_inner.wrap_worldCOM == null)
                  {
                     _loc15_.zpp_inner.wrap_worldCOM = Vec2.get(_loc15_.zpp_inner.worldCOMx,_loc15_.zpp_inner.worldCOMy);
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc15_.zpp_inner.getworldCOM;
                  }
                  _loc14_ = _loc15_.zpp_inner.wrap_worldCOM;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc15_ = _loc7_.zpp_inner.ws1.id > _loc7_.zpp_inner.ws2.id?_loc7_.zpp_inner.ws2.outer:_loc7_.zpp_inner.ws1.outer;
                  §§push(§§pop() * _loc14_.zpp_inner.x);
                  §§push(param2.d);
                  if(_loc15_.zpp_inner.wrap_worldCOM == null)
                  {
                     _loc15_.zpp_inner.wrap_worldCOM = Vec2.get(_loc15_.zpp_inner.worldCOMx,_loc15_.zpp_inner.worldCOMy);
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc15_.zpp_inner.getworldCOM;
                  }
                  _loc14_ = _loc15_.zpp_inner.wrap_worldCOM;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc6_ = Number(Number(§§pop() + §§pop() * _loc14_.zpp_inner.y) + param2.ty);
               }
               graphics.moveTo(_loc5_,_loc6_);
               if(param4)
               {
                  _loc15_ = _loc7_.zpp_inner.ws1.id > _loc7_.zpp_inner.ws2.id?_loc7_.zpp_inner.ws1.outer:_loc7_.zpp_inner.ws2.outer;
                  if(_loc15_.zpp_inner.wrap_worldCOM == null)
                  {
                     _loc15_.zpp_inner.wrap_worldCOM = Vec2.get(_loc15_.zpp_inner.worldCOMx,_loc15_.zpp_inner.worldCOMy);
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc15_.zpp_inner.getworldCOM;
                  }
                  _loc14_ = _loc15_.zpp_inner.wrap_worldCOM;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc5_ = _loc14_.zpp_inner.x;
                  _loc15_ = _loc7_.zpp_inner.ws1.id > _loc7_.zpp_inner.ws2.id?_loc7_.zpp_inner.ws1.outer:_loc7_.zpp_inner.ws2.outer;
                  if(_loc15_.zpp_inner.wrap_worldCOM == null)
                  {
                     _loc15_.zpp_inner.wrap_worldCOM = Vec2.get(_loc15_.zpp_inner.worldCOMx,_loc15_.zpp_inner.worldCOMy);
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc15_.zpp_inner.getworldCOM;
                  }
                  _loc14_ = _loc15_.zpp_inner.wrap_worldCOM;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc6_ = _loc14_.zpp_inner.y;
               }
               else
               {
                  _loc15_ = _loc7_.zpp_inner.ws1.id > _loc7_.zpp_inner.ws2.id?_loc7_.zpp_inner.ws1.outer:_loc7_.zpp_inner.ws2.outer;
                  §§push(param2.a);
                  if(_loc15_.zpp_inner.wrap_worldCOM == null)
                  {
                     _loc15_.zpp_inner.wrap_worldCOM = Vec2.get(_loc15_.zpp_inner.worldCOMx,_loc15_.zpp_inner.worldCOMy);
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc15_.zpp_inner.getworldCOM;
                  }
                  _loc14_ = _loc15_.zpp_inner.wrap_worldCOM;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc15_ = _loc7_.zpp_inner.ws1.id > _loc7_.zpp_inner.ws2.id?_loc7_.zpp_inner.ws1.outer:_loc7_.zpp_inner.ws2.outer;
                  §§push(§§pop() * _loc14_.zpp_inner.x);
                  §§push(param2.b);
                  if(_loc15_.zpp_inner.wrap_worldCOM == null)
                  {
                     _loc15_.zpp_inner.wrap_worldCOM = Vec2.get(_loc15_.zpp_inner.worldCOMx,_loc15_.zpp_inner.worldCOMy);
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc15_.zpp_inner.getworldCOM;
                  }
                  _loc14_ = _loc15_.zpp_inner.wrap_worldCOM;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc5_ = Number(Number(§§pop() + §§pop() * _loc14_.zpp_inner.y) + param2.tx);
                  _loc15_ = _loc7_.zpp_inner.ws1.id > _loc7_.zpp_inner.ws2.id?_loc7_.zpp_inner.ws1.outer:_loc7_.zpp_inner.ws2.outer;
                  §§push(param2.c);
                  if(_loc15_.zpp_inner.wrap_worldCOM == null)
                  {
                     _loc15_.zpp_inner.wrap_worldCOM = Vec2.get(_loc15_.zpp_inner.worldCOMx,_loc15_.zpp_inner.worldCOMy);
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc15_.zpp_inner.getworldCOM;
                  }
                  _loc14_ = _loc15_.zpp_inner.wrap_worldCOM;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc15_ = _loc7_.zpp_inner.ws1.id > _loc7_.zpp_inner.ws2.id?_loc7_.zpp_inner.ws1.outer:_loc7_.zpp_inner.ws2.outer;
                  §§push(§§pop() * _loc14_.zpp_inner.x);
                  §§push(param2.d);
                  if(_loc15_.zpp_inner.wrap_worldCOM == null)
                  {
                     _loc15_.zpp_inner.wrap_worldCOM = Vec2.get(_loc15_.zpp_inner.worldCOMx,_loc15_.zpp_inner.worldCOMy);
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
                     _loc15_.zpp_inner.wrap_worldCOM.zpp_inner._validate = _loc15_.zpp_inner.getworldCOM;
                  }
                  _loc14_ = _loc15_.zpp_inner.wrap_worldCOM;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc6_ = Number(Number(§§pop() + §§pop() * _loc14_.zpp_inner.y) + param2.ty);
               }
               graphics.lineTo(_loc5_,_loc6_);
            }
         }
         else if(param1.outer.isFluidArbiter())
         {
            if(outer.drawFluidArbiters)
            {
               _loc7_ = param1.outer;
               _loc17_ = !!_loc7_.isFluidArbiter()?_loc7_.zpp_inner.fluidarb.outer_zn:null;
               _loc8_ = 255;
               _loc9_ = ~bg_col;
               _loc10_ = 0.7;
               _loc11_ = Number((_loc8_ >> 16 & 255) * _loc10_ + (_loc9_ >> 16 & 255) * (1 - _loc10_));
               _loc12_ = Number((_loc8_ >> 8 & 255) * _loc10_ + (_loc9_ >> 8 & 255) * (1 - _loc10_));
               _loc13_ = Number((_loc8_ & 255) * _loc10_ + (_loc9_ & 255) * (1 - _loc10_));
               graphics.lineStyle(outer_zn.thickness,-16777216 | _loc11_ << 16 | _loc12_ << 8 | _loc13_,1);
               if(param4)
               {
                  if(_loc17_.zpp_inner.fluidarb.wrap_position == null)
                  {
                     _loc17_.zpp_inner.fluidarb.getposition();
                  }
                  _loc14_ = _loc17_.zpp_inner.fluidarb.wrap_position;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc5_ = _loc14_.zpp_inner.x;
                  if(_loc17_.zpp_inner.fluidarb.wrap_position == null)
                  {
                     _loc17_.zpp_inner.fluidarb.getposition();
                  }
                  _loc14_ = _loc17_.zpp_inner.fluidarb.wrap_position;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc6_ = _loc14_.zpp_inner.y;
               }
               else
               {
                  §§push(param2.a);
                  if(_loc17_.zpp_inner.fluidarb.wrap_position == null)
                  {
                     _loc17_.zpp_inner.fluidarb.getposition();
                  }
                  _loc14_ = _loc17_.zpp_inner.fluidarb.wrap_position;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  §§push(§§pop() * _loc14_.zpp_inner.x);
                  §§push(param2.b);
                  if(_loc17_.zpp_inner.fluidarb.wrap_position == null)
                  {
                     _loc17_.zpp_inner.fluidarb.getposition();
                  }
                  _loc14_ = _loc17_.zpp_inner.fluidarb.wrap_position;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc5_ = Number(Number(§§pop() + §§pop() * _loc14_.zpp_inner.y) + param2.tx);
                  §§push(param2.c);
                  if(_loc17_.zpp_inner.fluidarb.wrap_position == null)
                  {
                     _loc17_.zpp_inner.fluidarb.getposition();
                  }
                  _loc14_ = _loc17_.zpp_inner.fluidarb.wrap_position;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  §§push(§§pop() * _loc14_.zpp_inner.x);
                  §§push(param2.d);
                  if(_loc17_.zpp_inner.fluidarb.wrap_position == null)
                  {
                     _loc17_.zpp_inner.fluidarb.getposition();
                  }
                  _loc14_ = _loc17_.zpp_inner.fluidarb.wrap_position;
                  _loc16_ = _loc14_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc6_ = Number(Number(§§pop() + §§pop() * _loc14_.zpp_inner.y) + param2.ty);
               }
               graphics.drawCircle(_loc5_,_loc6_,0.75);
            }
         }
         else if(outer.drawCollisionArbiters)
         {
            _loc7_ = param1.outer;
            _loc18_ = !!_loc7_.isCollisionArbiter()?_loc7_.zpp_inner.colarb.outer_zn:null;
            if(_loc18_.zpp_inner.colarb.wrap_contacts == null)
            {
               _loc18_.zpp_inner.colarb.setupcontacts();
            }
            _loc20_ = _loc18_.zpp_inner.colarb.wrap_contacts;
            _loc20_.zpp_inner.valmod();
            if(_loc20_.zpp_inner.zip_length)
            {
               _loc20_.zpp_inner.zip_length = false;
               _loc20_.zpp_inner.user_length = 0;
               _loc21_ = _loc20_.zpp_inner.inner.next;
               while(_loc21_ != null)
               {
                  _loc22_ = _loc21_;
                  if(!!_loc22_.active && _loc22_.arbiter.active)
                  {
                     _loc20_.zpp_inner.user_length = _loc20_.zpp_inner.user_length + 1;
                  }
                  _loc21_ = _loc21_.next;
               }
            }
            if(_loc20_.zpp_inner.user_length == 2)
            {
               if(_loc18_.zpp_inner.colarb.wrap_contacts == null)
               {
                  _loc18_.zpp_inner.colarb.setupcontacts();
               }
               _loc23_ = _loc18_.zpp_inner.colarb.wrap_contacts.at(0);
               if(_loc23_.zpp_inner.wrap_position == null)
               {
                  _loc23_.zpp_inner.getposition();
               }
               _loc14_ = _loc23_.zpp_inner.wrap_position;
               if(_loc18_.zpp_inner.colarb.wrap_contacts == null)
               {
                  _loc18_.zpp_inner.colarb.setupcontacts();
               }
               _loc23_ = _loc18_.zpp_inner.colarb.wrap_contacts.at(1);
               if(_loc23_.zpp_inner.wrap_position == null)
               {
                  _loc23_.zpp_inner.getposition();
               }
               _loc24_ = _loc23_.zpp_inner.wrap_position;
               if(_loc18_.zpp_inner.colarb.wrap_normal == null)
               {
                  _loc18_.zpp_inner.colarb.getnormal();
               }
               _loc25_ = _loc18_.zpp_inner.colarb.wrap_normal;
               _loc26_ = 0.661437828;
               _loc27_ = 0.75;
               _loc16_ = _loc25_.zpp_inner;
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc14_.zpp_inner;
               §§push(_loc25_.zpp_inner.y);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(§§pop() * _loc14_.zpp_inner.x);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc14_.zpp_inner;
               §§push(_loc25_.zpp_inner.x);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(§§pop() - §§pop() * _loc14_.zpp_inner.y);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc24_.zpp_inner;
               §§push(_loc25_.zpp_inner.y);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(§§pop() * _loc24_.zpp_inner.x);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc24_.zpp_inner;
               §§push(_loc25_.zpp_inner.x);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               if(§§pop() < §§pop() - §§pop() * _loc24_.zpp_inner.y)
               {
                  _loc26_ = -_loc26_;
                  _loc27_ = -_loc27_;
               }
               _loc8_ = 255;
               _loc9_ = ~bg_col;
               _loc28_ = 0.7;
               _loc11_ = Number((_loc8_ >> 16 & 255) * _loc28_ + (_loc9_ >> 16 & 255) * (1 - _loc28_));
               _loc12_ = Number((_loc8_ >> 8 & 255) * _loc28_ + (_loc9_ >> 8 & 255) * (1 - _loc28_));
               _loc13_ = Number((_loc8_ & 255) * _loc28_ + (_loc9_ & 255) * (1 - _loc28_));
               graphics.lineStyle(outer_zn.thickness,-16777216 | _loc11_ << 16 | _loc12_ << 8 | _loc13_,1);
               _loc16_ = _loc14_.zpp_inner;
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(_loc14_.zpp_inner.x);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(Number(§§pop() + _loc25_.zpp_inner.x * _loc27_));
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc5_ = §§pop() - _loc25_.zpp_inner.y * _loc26_;
               _loc16_ = _loc14_.zpp_inner;
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(_loc14_.zpp_inner.y);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(Number(§§pop() + _loc25_.zpp_inner.y * _loc27_));
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc6_ = Number(§§pop() + _loc25_.zpp_inner.x * _loc26_);
               if(!param4)
               {
                  _loc28_ = Number(Number(param2.a * _loc5_ + param2.b * _loc6_) + param2.tx);
                  _loc6_ = Number(Number(param2.c * _loc5_ + param2.d * _loc6_) + param2.ty);
                  _loc5_ = _loc28_;
               }
               graphics.moveTo(_loc5_,_loc6_);
               _loc16_ = _loc24_.zpp_inner;
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(_loc24_.zpp_inner.x);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(Number(§§pop() + _loc25_.zpp_inner.x * _loc27_));
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc5_ = Number(§§pop() + _loc25_.zpp_inner.y * _loc26_);
               _loc16_ = _loc24_.zpp_inner;
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(_loc24_.zpp_inner.y);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(Number(§§pop() + _loc25_.zpp_inner.y * _loc27_));
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc6_ = §§pop() - _loc25_.zpp_inner.x * _loc26_;
               if(!param4)
               {
                  _loc28_ = Number(Number(param2.a * _loc5_ + param2.b * _loc6_) + param2.tx);
                  _loc6_ = Number(Number(param2.c * _loc5_ + param2.d * _loc6_) + param2.ty);
                  _loc5_ = _loc28_;
               }
               graphics.lineTo(_loc5_,_loc6_);
               _loc8_ = 16711680;
               _loc9_ = ~bg_col;
               _loc28_ = 0.7;
               _loc11_ = Number((_loc8_ >> 16 & 255) * _loc28_ + (_loc9_ >> 16 & 255) * (1 - _loc28_));
               _loc12_ = Number((_loc8_ >> 8 & 255) * _loc28_ + (_loc9_ >> 8 & 255) * (1 - _loc28_));
               _loc13_ = Number((_loc8_ & 255) * _loc28_ + (_loc9_ & 255) * (1 - _loc28_));
               graphics.lineStyle(outer_zn.thickness,-16777216 | _loc11_ << 16 | _loc12_ << 8 | _loc13_,1);
               _loc16_ = _loc14_.zpp_inner;
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(_loc14_.zpp_inner.x);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(§§pop() - _loc25_.zpp_inner.x * _loc27_);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc5_ = §§pop() - _loc25_.zpp_inner.y * _loc26_;
               _loc16_ = _loc14_.zpp_inner;
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(_loc14_.zpp_inner.y);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(§§pop() - _loc25_.zpp_inner.y * _loc27_);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc6_ = Number(§§pop() + _loc25_.zpp_inner.x * _loc26_);
               if(!param4)
               {
                  _loc28_ = Number(Number(param2.a * _loc5_ + param2.b * _loc6_) + param2.tx);
                  _loc6_ = Number(Number(param2.c * _loc5_ + param2.d * _loc6_) + param2.ty);
                  _loc5_ = _loc28_;
               }
               graphics.moveTo(_loc5_,_loc6_);
               _loc16_ = _loc24_.zpp_inner;
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(_loc24_.zpp_inner.x);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(§§pop() - _loc25_.zpp_inner.x * _loc27_);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc5_ = Number(§§pop() + _loc25_.zpp_inner.y * _loc26_);
               _loc16_ = _loc24_.zpp_inner;
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(_loc24_.zpp_inner.y);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc25_.zpp_inner;
               §§push(§§pop() - _loc25_.zpp_inner.y * _loc27_);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc6_ = §§pop() - _loc25_.zpp_inner.x * _loc26_;
               if(!param4)
               {
                  _loc28_ = Number(Number(param2.a * _loc5_ + param2.b * _loc6_) + param2.tx);
                  _loc6_ = Number(Number(param2.c * _loc5_ + param2.d * _loc6_) + param2.ty);
                  _loc5_ = _loc28_;
               }
               graphics.lineTo(_loc5_,_loc6_);
               _loc16_ = _loc14_.zpp_inner;
               §§push(0.5);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc24_.zpp_inner;
               §§push(_loc14_.zpp_inner.x);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc10_ = §§pop() * (§§pop() + _loc24_.zpp_inner.x);
               _loc16_ = _loc14_.zpp_inner;
               §§push(0.5);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc24_.zpp_inner;
               §§push(_loc14_.zpp_inner.y);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc19_ = §§pop() * (§§pop() + _loc24_.zpp_inner.y);
               if(!param4)
               {
                  _loc28_ = Number(Number(param2.a * _loc10_ + param2.b * _loc19_) + param2.tx);
                  _loc19_ = Number(Number(param2.c * _loc10_ + param2.d * _loc19_) + param2.ty);
                  _loc10_ = _loc28_;
               }
            }
            else
            {
               if(_loc18_.zpp_inner.colarb.wrap_contacts == null)
               {
                  _loc18_.zpp_inner.colarb.setupcontacts();
               }
               _loc23_ = _loc18_.zpp_inner.colarb.wrap_contacts.at(0);
               if(_loc23_.zpp_inner.wrap_position == null)
               {
                  _loc23_.zpp_inner.getposition();
               }
               _loc14_ = _loc23_.zpp_inner.wrap_position;
               _loc16_ = _loc14_.zpp_inner;
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc10_ = _loc14_.zpp_inner.x;
               if(_loc18_.zpp_inner.colarb.wrap_contacts == null)
               {
                  _loc18_.zpp_inner.colarb.setupcontacts();
               }
               _loc23_ = _loc18_.zpp_inner.colarb.wrap_contacts.at(0);
               if(_loc23_.zpp_inner.wrap_position == null)
               {
                  _loc23_.zpp_inner.getposition();
               }
               _loc14_ = _loc23_.zpp_inner.wrap_position;
               _loc16_ = _loc14_.zpp_inner;
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc19_ = _loc14_.zpp_inner.y;
               if(!param4)
               {
                  _loc26_ = Number(Number(param2.a * _loc10_ + param2.b * _loc19_) + param2.tx);
                  _loc19_ = Number(Number(param2.c * _loc10_ + param2.d * _loc19_) + param2.ty);
                  _loc10_ = _loc26_;
               }
               _loc8_ = 16711935;
               _loc9_ = ~bg_col;
               _loc26_ = 0.7;
               _loc11_ = Number((_loc8_ >> 16 & 255) * _loc26_ + (_loc9_ >> 16 & 255) * (1 - _loc26_));
               _loc12_ = Number((_loc8_ >> 8 & 255) * _loc26_ + (_loc9_ >> 8 & 255) * (1 - _loc26_));
               _loc13_ = Number((_loc8_ & 255) * _loc26_ + (_loc9_ & 255) * (1 - _loc26_));
               graphics.lineStyle(outer_zn.thickness,-16777216 | _loc11_ << 16 | _loc12_ << 8 | _loc13_,1);
               graphics.drawCircle(_loc10_,_loc19_,1);
            }
            _loc8_ = ~bg_col;
            _loc9_ = bg_col;
            _loc26_ = 0.7;
            _loc11_ = Number((_loc8_ >> 16 & 255) * _loc26_ + (_loc9_ >> 16 & 255) * (1 - _loc26_));
            _loc12_ = Number((_loc8_ >> 8 & 255) * _loc26_ + (_loc9_ >> 8 & 255) * (1 - _loc26_));
            _loc13_ = Number((_loc8_ & 255) * _loc26_ + (_loc9_ & 255) * (1 - _loc26_));
            graphics.lineStyle(outer_zn.thickness,-16777216 | _loc11_ << 16 | _loc12_ << 8 | _loc13_,1);
            graphics.moveTo(_loc10_,_loc19_);
            if(_loc18_.zpp_inner.colarb.wrap_normal == null)
            {
               _loc18_.zpp_inner.colarb.getnormal();
            }
            _loc14_ = _loc18_.zpp_inner.colarb.wrap_normal;
            _loc16_ = _loc14_.zpp_inner;
            if(_loc16_._validate != null)
            {
               _loc16_._validate();
            }
            _loc5_ = _loc14_.zpp_inner.x * 5;
            if(_loc18_.zpp_inner.colarb.wrap_normal == null)
            {
               _loc18_.zpp_inner.colarb.getnormal();
            }
            _loc14_ = _loc18_.zpp_inner.colarb.wrap_normal;
            _loc16_ = _loc14_.zpp_inner;
            if(_loc16_._validate != null)
            {
               _loc16_._validate();
            }
            _loc6_ = _loc14_.zpp_inner.y * 5;
            if(!param4)
            {
               _loc26_ = Number(param2.a * _loc5_ + param2.b * _loc6_);
               _loc6_ = Number(param2.c * _loc5_ + param2.d * _loc6_);
               _loc5_ = _loc26_;
            }
            graphics.lineTo(Number(_loc10_ + _loc5_),Number(_loc19_ + _loc6_));
         }
      }
   }
}
