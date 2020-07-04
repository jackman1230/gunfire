package nape.util
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.constraint.Constraint;
   import nape.geom.AABB;
   import nape.geom.GeomPoly;
   import nape.geom.Vec2;
   import nape.geom.Vec2List;
   import nape.phys.Body;
   import nape.phys.Compound;
   import nape.shape.Shape;
   import nape.space.Space;
   import zpp_nape.ZPP_Const;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_GeomVert;
   import zpp_nape.geom.ZPP_Mat23;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.util.ZNPList_ZPP_Vec2;
   import zpp_nape.util.ZNPNode_ZPP_Vec2;
   import zpp_nape.util.ZPP_BitmapDebug;
   
   public class BitmapDebug extends Debug
   {
       
      
      public var zpp_inner_zn:ZPP_BitmapDebug;
      
      public function BitmapDebug(param1:int, param2:int, param3:int = 3355443, param4:Boolean = false)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         zpp_inner_zn = new ZPP_BitmapDebug(param1,param2,param3,param4);
         zpp_inner_zn.outer_zn = this;
         zpp_inner = zpp_inner_zn;
         zpp_inner.outer = this;
      }
      
      public function prepare() : void
      {
         zpp_inner_zn.prepare();
      }
      
      override public function flush() : void
      {
         zpp_inner_zn.flush();
      }
      
      override public function drawSpring(param1:Vec2, param2:Vec2, param3:int, param4:int = 3, param5:Number = 3.0) : void
      {
         var _loc6_:Number = NaN;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:* = null as Vec2;
         var _loc15_:* = null as Vec2;
         var _loc16_:* = null as Vec2;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         if(param4 == 0)
         {
            drawLine(param1,param2,param3);
         }
         else
         {
            _loc7_ = param2.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc7_ = param1.zpp_inner;
            §§push(param2.zpp_inner.x);
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc6_ = §§pop() - param1.zpp_inner.x;
            _loc7_ = param2.zpp_inner;
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc7_ = param1.zpp_inner;
            §§push(param2.zpp_inner.y);
            if(_loc7_._validate != null)
            {
               _loc7_._validate();
            }
            _loc8_ = §§pop() - param1.zpp_inner.y;
            _loc9_ = 1 / (param4 * 4);
            _loc6_ = _loc6_ * _loc9_;
            _loc8_ = _loc8_ * _loc9_;
            _loc9_ = _loc6_;
            _loc10_ = _loc8_;
            if(Number(_loc9_ * _loc9_ + _loc10_ * _loc10_) < 0.1)
            {
               return;
            }
            _loc11_ = Number(_loc9_ * _loc9_ + _loc10_ * _loc10_);
            sf32(_loc11_,0);
            si32(1597463007 - (li32(0) >> 1),0);
            _loc13_ = lf32(0);
            _loc12_ = _loc13_ * (1.5 - 0.5 * _loc11_ * _loc13_ * _loc13_);
            _loc13_ = _loc12_;
            _loc9_ = _loc9_ * _loc13_;
            _loc10_ = _loc10_ * _loc13_;
            _loc11_ = _loc9_;
            _loc9_ = -_loc10_;
            _loc10_ = _loc11_;
            _loc11_ = param5 * 2;
            _loc9_ = _loc9_ * _loc11_;
            _loc10_ = _loc10_ * _loc11_;
            _loc14_ = param1.copy();
            _loc15_ = Vec2.get();
            _loc16_ = Vec2.get();
            _loc17_ = 0;
            while(_loc17_ < param4)
            {
               _loc17_++;
               _loc18_ = _loc17_;
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = Number(Number(_loc14_.zpp_inner.x + _loc6_) + _loc9_);
               _loc7_ = _loc15_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc15_.zpp_inner.x != _loc11_)
               {
                  _loc15_.zpp_inner.x = _loc11_;
                  _loc7_ = _loc15_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc7_ = _loc15_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc15_.zpp_inner.x;
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = Number(Number(_loc14_.zpp_inner.y + _loc8_) + _loc10_);
               _loc7_ = _loc15_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc15_.zpp_inner.y != _loc11_)
               {
                  _loc15_.zpp_inner.y = _loc11_;
                  _loc7_ = _loc15_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc7_ = _loc15_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc15_.zpp_inner.y;
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = Number(_loc14_.zpp_inner.x + _loc6_ * 2);
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc16_.zpp_inner.x != _loc11_)
               {
                  _loc16_.zpp_inner.x = _loc11_;
                  _loc7_ = _loc16_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc16_.zpp_inner.x;
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = Number(_loc14_.zpp_inner.y + _loc8_ * 2);
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc16_.zpp_inner.y != _loc11_)
               {
                  _loc16_.zpp_inner.y = _loc11_;
                  _loc7_ = _loc16_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc16_.zpp_inner.y;
               drawCurve(_loc14_,_loc15_,_loc16_,param3);
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc16_.zpp_inner.x;
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc14_.zpp_inner.x != _loc11_)
               {
                  _loc14_.zpp_inner.x = _loc11_;
                  _loc7_ = _loc14_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc14_.zpp_inner.x;
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc16_.zpp_inner.y;
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc14_.zpp_inner.y != _loc11_)
               {
                  _loc14_.zpp_inner.y = _loc11_;
                  _loc7_ = _loc14_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc14_.zpp_inner.y;
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc14_.zpp_inner.x + _loc6_ - _loc9_;
               _loc7_ = _loc15_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc15_.zpp_inner.x != _loc11_)
               {
                  _loc15_.zpp_inner.x = _loc11_;
                  _loc7_ = _loc15_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc7_ = _loc15_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc15_.zpp_inner.x;
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc14_.zpp_inner.y + _loc8_ - _loc10_;
               _loc7_ = _loc15_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc15_.zpp_inner.y != _loc11_)
               {
                  _loc15_.zpp_inner.y = _loc11_;
                  _loc7_ = _loc15_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc7_ = _loc15_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc15_.zpp_inner.y;
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = Number(_loc14_.zpp_inner.x + _loc6_ * 2);
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc16_.zpp_inner.x != _loc11_)
               {
                  _loc16_.zpp_inner.x = _loc11_;
                  _loc7_ = _loc16_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc16_.zpp_inner.x;
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = Number(_loc14_.zpp_inner.y + _loc8_ * 2);
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc16_.zpp_inner.y != _loc11_)
               {
                  _loc16_.zpp_inner.y = _loc11_;
                  _loc7_ = _loc16_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc16_.zpp_inner.y;
               drawCurve(_loc14_,_loc15_,_loc16_,param3);
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc16_.zpp_inner.x;
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc14_.zpp_inner.x != _loc11_)
               {
                  _loc14_.zpp_inner.x = _loc11_;
                  _loc7_ = _loc14_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc14_.zpp_inner.x;
               _loc7_ = _loc16_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc11_ = _loc16_.zpp_inner.y;
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               if(_loc14_.zpp_inner.y != _loc11_)
               {
                  _loc14_.zpp_inner.y = _loc11_;
                  _loc7_ = _loc14_.zpp_inner;
                  if(_loc7_._invalidate != null)
                  {
                     _loc7_._invalidate(_loc7_);
                  }
               }
               _loc7_ = _loc14_.zpp_inner;
               if(_loc7_._validate != null)
               {
                  _loc7_._validate();
               }
               _loc14_.zpp_inner.y;
            }
            _loc14_.dispose();
            _loc15_.dispose();
            _loc16_.dispose();
         }
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         if(param2.zpp_inner.weak)
         {
            param2.dispose();
         }
      }
      
      override public function drawPolygon(param1:*, param2:int) : void
      {
         var _loc9_:* = null as Array;
         var _loc10_:int = 0;
         var _loc11_:* = null;
         var _loc12_:* = null as Vec2;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:* = false;
         var _loc16_:* = null as ZPP_Vec2;
         var _loc17_:* = null as Vec2;
         var _loc18_:* = null as Vector.<Vec2>;
         var _loc19_:* = null as Vec2;
         var _loc20_:* = null as Vec2List;
         var _loc21_:* = null as GeomPoly;
         var _loc22_:* = null as ZPP_GeomVert;
         var _loc23_:* = null as ZPP_GeomVert;
         var _loc24_:uint = 0;
         var _loc25_:* = null as ZNPList_ZPP_Vec2;
         var _loc26_:* = null as ZNPNode_ZPP_Vec2;
         var _loc27_:* = null as ZNPNode_ZPP_Vec2;
         var _loc3_:* = param2 | -16777216;
         var _loc6_:Vec2 = null;
         var _loc8_:int = 0;
         var _loc7_:int = _loc8_;
         var _loc5_:int = _loc7_;
         var _loc4_:int = _loc5_;
         if(Std.§is§(param1,Array))
         {
            _loc9_ = param1;
            _loc10_ = 0;
            while(_loc10_ < int(_loc9_.length))
            {
               _loc11_ = _loc9_[_loc10_];
               _loc10_++;
               _loc12_ = _loc11_;
               _loc15_ = _loc6_ == null;
               if(zpp_inner.xnull)
               {
                  _loc16_ = _loc12_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc13_ = Number(_loc12_.zpp_inner.x + 0.5);
                  _loc16_ = _loc12_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc14_ = Number(_loc12_.zpp_inner.y + 0.5);
                  if(_loc15_)
                  {
                     _loc6_ = _loc12_.copy();
                  }
               }
               else
               {
                  _loc17_ = zpp_inner.xform.outer.transform(_loc12_);
                  _loc16_ = _loc17_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc13_ = Number(_loc17_.zpp_inner.x + 0.5);
                  _loc16_ = _loc17_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc14_ = Number(_loc17_.zpp_inner.y + 0.5);
                  if(_loc15_)
                  {
                     _loc6_ = _loc17_;
                  }
                  else
                  {
                     _loc17_.dispose();
                  }
               }
               if(_loc15_)
               {
                  _loc7_ = _loc13_;
                  _loc4_ = _loc7_;
                  _loc8_ = _loc14_;
                  _loc5_ = _loc8_;
               }
               else
               {
                  zpp_inner_zn.__line(_loc7_,_loc8_,_loc13_,_loc14_,_loc3_);
                  _loc7_ = _loc13_;
                  _loc8_ = _loc14_;
               }
            }
         }
         else if(Std.§is§(param1,ZPP_Const.vec2vector))
         {
            _loc18_ = param1;
            _loc10_ = 0;
            while(_loc10_ < _loc18_.length)
            {
               _loc12_ = _loc18_[_loc10_];
               _loc10_++;
               _loc17_ = _loc12_;
               _loc15_ = _loc6_ == null;
               if(zpp_inner.xnull)
               {
                  _loc16_ = _loc17_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc13_ = Number(_loc17_.zpp_inner.x + 0.5);
                  _loc16_ = _loc17_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc14_ = Number(_loc17_.zpp_inner.y + 0.5);
                  if(_loc15_)
                  {
                     _loc6_ = _loc17_.copy();
                  }
               }
               else
               {
                  _loc19_ = zpp_inner.xform.outer.transform(_loc17_);
                  _loc16_ = _loc19_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc13_ = Number(_loc19_.zpp_inner.x + 0.5);
                  _loc16_ = _loc19_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc14_ = Number(_loc19_.zpp_inner.y + 0.5);
                  if(_loc15_)
                  {
                     _loc6_ = _loc19_;
                  }
                  else
                  {
                     _loc19_.dispose();
                  }
               }
               if(_loc15_)
               {
                  _loc7_ = _loc13_;
                  _loc4_ = _loc7_;
                  _loc8_ = _loc14_;
                  _loc5_ = _loc8_;
               }
               else
               {
                  zpp_inner_zn.__line(_loc7_,_loc8_,_loc13_,_loc14_,_loc3_);
                  _loc7_ = _loc13_;
                  _loc8_ = _loc14_;
               }
            }
         }
         else if(Std.§is§(param1,Vec2List))
         {
            _loc20_ = param1;
            _loc11_ = _loc20_.iterator();
            while(true)
            {
               if(_loc11_.hasNext())
               {
                  _loc12_ = _loc11_.next();
                  _loc15_ = _loc6_ == null;
                  if(zpp_inner.xnull)
                  {
                     _loc16_ = _loc12_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc10_ = Number(_loc12_.zpp_inner.x + 0.5);
                     _loc16_ = _loc12_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc13_ = Number(_loc12_.zpp_inner.y + 0.5);
                     if(_loc15_)
                     {
                        _loc6_ = _loc12_.copy();
                     }
                  }
                  else
                  {
                     _loc17_ = zpp_inner.xform.outer.transform(_loc12_);
                     _loc16_ = _loc17_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc10_ = Number(_loc17_.zpp_inner.x + 0.5);
                     _loc16_ = _loc17_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc13_ = Number(_loc17_.zpp_inner.y + 0.5);
                     if(_loc15_)
                     {
                        _loc6_ = _loc17_;
                     }
                     else
                     {
                        _loc17_.dispose();
                     }
                  }
                  if(_loc15_)
                  {
                     _loc7_ = _loc10_;
                     _loc4_ = _loc7_;
                     _loc8_ = _loc13_;
                     _loc5_ = _loc8_;
                  }
                  else
                  {
                     zpp_inner_zn.__line(_loc7_,_loc8_,_loc10_,_loc13_,_loc3_);
                     _loc7_ = _loc10_;
                     _loc8_ = _loc13_;
                  }
                  continue;
               }
            }
         }
         else if(Std.§is§(param1,GeomPoly))
         {
            _loc21_ = param1;
            _loc22_ = _loc21_.zpp_inner.vertices;
            if(_loc22_ != null)
            {
               _loc23_ = _loc22_;
               do
               {
                  _loc12_ = Vec2.get(_loc23_.x,_loc23_.y);
                  _loc23_ = _loc23_.next;
                  _loc15_ = _loc6_ == null;
                  if(zpp_inner.xnull)
                  {
                     _loc16_ = _loc12_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc10_ = Number(_loc12_.zpp_inner.x + 0.5);
                     _loc16_ = _loc12_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc13_ = Number(_loc12_.zpp_inner.y + 0.5);
                     if(_loc15_)
                     {
                        _loc6_ = _loc12_.copy();
                     }
                  }
                  else
                  {
                     _loc17_ = zpp_inner.xform.outer.transform(_loc12_);
                     _loc16_ = _loc17_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc10_ = Number(_loc17_.zpp_inner.x + 0.5);
                     _loc16_ = _loc17_.zpp_inner;
                     if(_loc16_._validate != null)
                     {
                        _loc16_._validate();
                     }
                     _loc13_ = Number(_loc17_.zpp_inner.y + 0.5);
                     if(_loc15_)
                     {
                        _loc6_ = _loc17_;
                     }
                     else
                     {
                        _loc17_.dispose();
                     }
                  }
                  if(_loc15_)
                  {
                     _loc7_ = _loc10_;
                     _loc4_ = _loc7_;
                     _loc8_ = _loc13_;
                     _loc5_ = _loc8_;
                  }
                  else
                  {
                     zpp_inner_zn.__line(_loc7_,_loc8_,_loc10_,_loc13_,_loc3_);
                     _loc7_ = _loc10_;
                     _loc8_ = _loc13_;
                  }
                  _loc12_.dispose();
               }
               while(_loc23_ != _loc22_);
               
            }
         }
         zpp_inner_zn.__line(_loc7_,_loc8_,_loc4_,_loc5_,_loc3_);
         _loc6_.dispose();
         if(Std.§is§(param1,Array))
         {
            _loc9_ = param1;
            _loc10_ = 0;
            while(_loc10_ < int(_loc9_.length))
            {
               _loc12_ = _loc9_[_loc10_];
               if(_loc12_.zpp_inner.weak)
               {
                  _loc12_.dispose();
                  §§push(true);
               }
               else
               {
                  §§push(false);
               }
               _loc9_.splice(_loc10_,1);
            }
         }
         else if(Std.§is§(param1,ZPP_Const.vec2vector))
         {
            _loc18_ = param1;
            if(!_loc18_.fixed)
            {
               _loc24_ = 0;
               while(_loc24_ < _loc18_.length)
               {
                  _loc12_ = _loc18_[_loc24_];
                  if(_loc12_.zpp_inner.weak)
                  {
                     _loc12_.dispose();
                     §§push(true);
                  }
                  else
                  {
                     §§push(false);
                  }
                  _loc18_.splice(_loc24_,1);
               }
            }
         }
         else if(Std.§is§(param1,Vec2List))
         {
            _loc20_ = param1;
            if(_loc20_.zpp_inner._validate != null)
            {
               _loc20_.zpp_inner._validate();
            }
            _loc25_ = _loc20_.zpp_inner.inner;
            _loc26_ = null;
            _loc27_ = _loc25_.head;
            while(_loc27_ != null)
            {
               _loc16_ = _loc27_.elt;
               if(_loc16_.outer.zpp_inner.weak)
               {
                  _loc27_ = _loc25_.erase(_loc26_);
                  if(_loc16_.outer.zpp_inner.weak)
                  {
                     _loc16_.outer.dispose();
                  }
               }
               else
               {
                  _loc26_ = _loc27_;
                  _loc27_ = _loc27_.next;
               }
            }
         }
      }
      
      override public function drawLine(param1:Vec2, param2:Vec2, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:* = null as Vec2;
         if(zpp_inner.xnull)
         {
            _loc5_ = param1.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc4_ = Number(param1.zpp_inner.x + 0.5);
            _loc5_ = param1.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc6_ = Number(param1.zpp_inner.y + 0.5);
            _loc5_ = param2.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc7_ = Number(param2.zpp_inner.x + 0.5);
            _loc5_ = param2.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc8_ = Number(param2.zpp_inner.y + 0.5);
            zpp_inner_zn.__line(_loc4_,_loc6_,_loc7_,_loc8_,param3 | -16777216);
            if(param1.zpp_inner.weak)
            {
               param1.dispose();
            }
            if(param2.zpp_inner.weak)
            {
               param2.dispose();
            }
         }
         else
         {
            _loc9_ = zpp_inner.xform.outer.transform(param1);
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc4_ = Number(_loc9_.zpp_inner.x + 0.5);
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc6_ = Number(_loc9_.zpp_inner.y + 0.5);
            _loc9_.dispose();
            _loc9_ = zpp_inner.xform.outer.transform(param2);
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc7_ = Number(_loc9_.zpp_inner.x + 0.5);
            _loc5_ = _loc9_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc8_ = Number(_loc9_.zpp_inner.y + 0.5);
            _loc9_.dispose();
            zpp_inner_zn.__line(_loc4_,_loc6_,_loc7_,_loc8_,param3 | -16777216);
         }
      }
      
      override public function drawFilledTriangle(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
      {
         zpp_inner_zn.__tri(param1,param2,param3,param4);
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         if(param2.zpp_inner.weak)
         {
            param2.dispose();
         }
         if(param3.zpp_inner.weak)
         {
            param3.dispose();
         }
      }
      
      override public function drawFilledPolygon(param1:*, param2:int) : void
      {
         var _loc7_:* = null as Array;
         var _loc8_:int = 0;
         var _loc9_:* = null;
         var _loc10_:* = null as Vec2;
         var _loc11_:* = null as Vec2;
         var _loc12_:* = null as ZPP_Vec2;
         var _loc13_:* = null as Vector.<Vec2>;
         var _loc14_:* = null as Vec2;
         var _loc15_:* = null as Vec2List;
         var _loc16_:* = null as GeomPoly;
         var _loc17_:* = null as ZPP_GeomVert;
         var _loc18_:* = null as ZPP_GeomVert;
         var _loc19_:uint = 0;
         var _loc20_:* = null as ZNPList_ZPP_Vec2;
         var _loc21_:* = null as ZNPNode_ZPP_Vec2;
         var _loc22_:* = null as ZNPNode_ZPP_Vec2;
         var _loc26_:int = 0;
         var _loc27_:int = 0;
         var _loc28_:int = 0;
         var _loc29_:* = 0;
         var _loc30_:Number = NaN;
         var _loc31_:* = 0;
         var _loc32_:int = 0;
         var _loc33_:* = 0;
         var _loc34_:int = 0;
         var _loc3_:* = param2 | -16777216;
         var _loc4_:Number = Number(Math.POSITIVE_INFINITY);
         var _loc5_:Number = Number(Math.NEGATIVE_INFINITY);
         var _loc6_:Array = [];
         if(Std.§is§(param1,Array))
         {
            _loc7_ = param1;
            _loc8_ = 0;
            while(_loc8_ < int(_loc7_.length))
            {
               _loc9_ = _loc7_[_loc8_];
               _loc8_++;
               _loc10_ = _loc9_;
               if(zpp_inner.xnull)
               {
                  _loc11_ = _loc10_.copy();
                  _loc6_.push(_loc11_);
               }
               else
               {
                  _loc11_ = zpp_inner.xform.outer.transform(_loc10_);
                  _loc6_.push(_loc11_);
               }
               _loc12_ = _loc11_.zpp_inner;
               if(_loc12_._validate != null)
               {
                  _loc12_._validate();
               }
               if(_loc11_.zpp_inner.y < _loc4_)
               {
                  _loc12_ = _loc11_.zpp_inner;
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  _loc4_ = _loc11_.zpp_inner.y;
               }
               _loc12_ = _loc11_.zpp_inner;
               if(_loc12_._validate != null)
               {
                  _loc12_._validate();
               }
               if(_loc11_.zpp_inner.y > _loc5_)
               {
                  _loc12_ = _loc11_.zpp_inner;
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  _loc5_ = _loc11_.zpp_inner.y;
               }
            }
         }
         else if(Std.§is§(param1,ZPP_Const.vec2vector))
         {
            _loc13_ = param1;
            _loc8_ = 0;
            while(_loc8_ < _loc13_.length)
            {
               _loc10_ = _loc13_[_loc8_];
               _loc8_++;
               _loc11_ = _loc10_;
               if(zpp_inner.xnull)
               {
                  _loc14_ = _loc11_.copy();
                  _loc6_.push(_loc14_);
               }
               else
               {
                  _loc14_ = zpp_inner.xform.outer.transform(_loc11_);
                  _loc6_.push(_loc14_);
               }
               _loc12_ = _loc14_.zpp_inner;
               if(_loc12_._validate != null)
               {
                  _loc12_._validate();
               }
               if(_loc14_.zpp_inner.y < _loc4_)
               {
                  _loc12_ = _loc14_.zpp_inner;
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  _loc4_ = _loc14_.zpp_inner.y;
               }
               _loc12_ = _loc14_.zpp_inner;
               if(_loc12_._validate != null)
               {
                  _loc12_._validate();
               }
               if(_loc14_.zpp_inner.y > _loc5_)
               {
                  _loc12_ = _loc14_.zpp_inner;
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  _loc5_ = _loc14_.zpp_inner.y;
               }
            }
         }
         else if(Std.§is§(param1,Vec2List))
         {
            _loc15_ = param1;
            _loc9_ = _loc15_.iterator();
            while(true)
            {
               if(_loc9_.hasNext())
               {
                  _loc10_ = _loc9_.next();
                  if(zpp_inner.xnull)
                  {
                     _loc11_ = _loc10_.copy();
                     _loc6_.push(_loc11_);
                  }
                  else
                  {
                     _loc11_ = zpp_inner.xform.outer.transform(_loc10_);
                     _loc6_.push(_loc11_);
                  }
                  _loc12_ = _loc11_.zpp_inner;
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  if(_loc11_.zpp_inner.y < _loc4_)
                  {
                     _loc12_ = _loc11_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc4_ = _loc11_.zpp_inner.y;
                  }
                  _loc12_ = _loc11_.zpp_inner;
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  if(_loc11_.zpp_inner.y > _loc5_)
                  {
                     _loc12_ = _loc11_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc5_ = _loc11_.zpp_inner.y;
                  }
                  continue;
               }
            }
         }
         else if(Std.§is§(param1,GeomPoly))
         {
            _loc16_ = param1;
            _loc17_ = _loc16_.zpp_inner.vertices;
            if(_loc17_ != null)
            {
               _loc18_ = _loc17_;
               do
               {
                  _loc10_ = Vec2.get(_loc18_.x,_loc18_.y);
                  _loc18_ = _loc18_.next;
                  if(zpp_inner.xnull)
                  {
                     _loc11_ = _loc10_.copy();
                     _loc6_.push(_loc11_);
                  }
                  else
                  {
                     _loc11_ = zpp_inner.xform.outer.transform(_loc10_);
                     _loc6_.push(_loc11_);
                  }
                  _loc12_ = _loc11_.zpp_inner;
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  if(_loc11_.zpp_inner.y < _loc4_)
                  {
                     _loc12_ = _loc11_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc4_ = _loc11_.zpp_inner.y;
                  }
                  _loc12_ = _loc11_.zpp_inner;
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  if(_loc11_.zpp_inner.y > _loc5_)
                  {
                     _loc12_ = _loc11_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     _loc5_ = _loc11_.zpp_inner.y;
                  }
                  _loc10_.dispose();
               }
               while(_loc18_ != _loc17_);
               
            }
         }
         if(Std.§is§(param1,Array))
         {
            _loc7_ = param1;
            _loc8_ = 0;
            while(_loc8_ < int(_loc7_.length))
            {
               _loc10_ = _loc7_[_loc8_];
               if(_loc10_.zpp_inner.weak)
               {
                  _loc10_.dispose();
                  §§push(true);
               }
               else
               {
                  §§push(false);
               }
               _loc7_.splice(_loc8_,1);
            }
         }
         else if(Std.§is§(param1,ZPP_Const.vec2vector))
         {
            _loc13_ = param1;
            if(!_loc13_.fixed)
            {
               _loc19_ = 0;
               while(_loc19_ < _loc13_.length)
               {
                  _loc10_ = _loc13_[_loc19_];
                  if(_loc10_.zpp_inner.weak)
                  {
                     _loc10_.dispose();
                     §§push(true);
                  }
                  else
                  {
                     §§push(false);
                  }
                  _loc13_.splice(_loc19_,1);
               }
            }
         }
         else if(Std.§is§(param1,Vec2List))
         {
            _loc15_ = param1;
            if(_loc15_.zpp_inner._validate != null)
            {
               _loc15_.zpp_inner._validate();
            }
            _loc20_ = _loc15_.zpp_inner.inner;
            _loc21_ = null;
            _loc22_ = _loc20_.head;
            while(_loc22_ != null)
            {
               _loc12_ = _loc22_.elt;
               if(_loc12_.outer.zpp_inner.weak)
               {
                  _loc22_ = _loc20_.erase(_loc21_);
                  if(_loc12_.outer.zpp_inner.weak)
                  {
                     _loc12_.outer.dispose();
                  }
               }
               else
               {
                  _loc21_ = _loc22_;
                  _loc22_ = _loc22_.next;
               }
            }
         }
         _loc8_ = Number(_loc4_ + 0.5);
         var _loc23_:* = int(Number(_loc5_ + 0.5));
         if(_loc23_ < 0 || _loc8_ >= zpp_inner.height)
         {
            return;
         }
         if(_loc8_ < 0)
         {
            _loc8_ = 0;
         }
         if(_loc23_ >= zpp_inner.height)
         {
            _loc23_ = zpp_inner.height - 1;
         }
         var _loc24_:int = _loc8_;
         var _loc25_:* = _loc23_ + 1;
         while(_loc24_ < _loc25_)
         {
            _loc24_++;
            _loc26_ = _loc24_;
            _loc7_ = [];
            _loc27_ = 0;
            _loc28_ = _loc6_.length;
            while(_loc27_ < _loc28_)
            {
               _loc27_++;
               _loc29_ = int(_loc27_);
               _loc10_ = _loc6_[_loc29_];
               _loc11_ = _loc6_[int((_loc29_ + 1) % int(_loc6_.length))];
               _loc12_ = _loc11_.zpp_inner;
               §§push(true);
               §§push(false);
               if(_loc12_._validate != null)
               {
                  _loc12_._validate();
               }
               if(_loc11_.zpp_inner.y < _loc26_)
               {
                  §§pop();
                  _loc12_ = _loc10_.zpp_inner;
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  §§push(_loc10_.zpp_inner.y >= _loc26_);
               }
               if(!§§pop())
               {
                  §§pop();
                  _loc12_ = _loc10_.zpp_inner;
                  §§push(false);
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  if(_loc10_.zpp_inner.y < _loc26_)
                  {
                     §§pop();
                     _loc12_ = _loc11_.zpp_inner;
                     if(_loc12_._validate != null)
                     {
                        _loc12_._validate();
                     }
                     §§push(_loc11_.zpp_inner.y >= _loc26_);
                  }
                  §§push(Boolean(§§pop()));
               }
               if(§§pop())
               {
                  _loc12_ = _loc11_.zpp_inner;
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  _loc12_ = _loc11_.zpp_inner;
                  §§push(_loc11_.zpp_inner.x);
                  §§push(_loc26_);
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  _loc12_ = _loc10_.zpp_inner;
                  §§push(§§pop() - _loc11_.zpp_inner.y);
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  _loc12_ = _loc11_.zpp_inner;
                  §§push(_loc10_.zpp_inner.y);
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  _loc12_ = _loc10_.zpp_inner;
                  §§push(§§pop() / (§§pop() - _loc11_.zpp_inner.y));
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  _loc12_ = _loc11_.zpp_inner;
                  §§push(_loc10_.zpp_inner.x);
                  if(_loc12_._validate != null)
                  {
                     _loc12_._validate();
                  }
                  _loc30_ = Number(§§pop() + §§pop() * (§§pop() - _loc11_.zpp_inner.x));
                  _loc7_.push(int(Number(_loc30_ + 0.5)));
               }
            }
            _loc7_.sort(function(param1:int, param2:int):int
            {
               return param1 - param2;
            });
            _loc27_ = 0;
            while(_loc27_ + 1 < int(_loc7_.length))
            {
               _loc27_++;
               _loc28_ = _loc7_[_loc27_];
               _loc27_++;
               _loc29_ = int(_loc7_[_loc27_]);
               if(_loc29_ >= 0)
               {
                  if(_loc28_ < zpp_inner.width)
                  {
                     if(_loc28_ < 0)
                     {
                        _loc28_ = 0;
                     }
                     if(_loc29_ >= zpp_inner.width)
                     {
                        _loc29_ = zpp_inner.width - 1;
                     }
                     _loc31_ = _loc26_ * zpp_inner_zn.width + _loc28_;
                     _loc32_ = _loc28_;
                     _loc33_ = _loc29_ + 1;
                     while(_loc32_ < _loc33_)
                     {
                        _loc32_++;
                        _loc34_ = _loc32_;
                        _loc31_++;
                        si32(_loc3_,_loc31_ << 2);
                     }
                     continue;
                  }
                  break;
               }
            }
         }
         while(int(_loc6_.length) > 0)
         {
            _loc6_.pop().dispose();
         }
      }
      
      override public function drawFilledCircle(param1:Vec2, param2:Number, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null as Vec2;
         if(zpp_inner.xnull)
         {
            _loc5_ = param1.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc4_ = Number(param1.zpp_inner.x + 0.5);
            _loc5_ = param1.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc6_ = Number(param1.zpp_inner.y + 0.5);
            _loc7_ = Number(param2 + 0.5);
            zpp_inner_zn.__fcircle(_loc4_,_loc6_,_loc7_,param3 | -16777216);
            if(param1.zpp_inner.weak)
            {
               param1.dispose();
            }
         }
         else
         {
            _loc8_ = zpp_inner.xform.outer.transform(param1);
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc4_ = Number(_loc8_.zpp_inner.x + 0.5);
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc6_ = Number(_loc8_.zpp_inner.y + 0.5);
            _loc8_.dispose();
            _loc7_ = Number(param2 * zpp_inner.xdet + 0.5);
            zpp_inner_zn.__fcircle(_loc4_,_loc6_,_loc7_,param3 | -16777216);
         }
      }
      
      override public function drawCurve(param1:Vec2, param2:Vec2, param3:Vec2, param4:int) : void
      {
         var _loc5_:* = null as Vec2;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as Vec2;
         if(zpp_inner.xnull)
         {
            zpp_inner_zn.__curve(param1,param2,param3,param4);
            if(param1.zpp_inner.weak)
            {
               param1.dispose();
            }
            if(param2.zpp_inner.weak)
            {
               param2.dispose();
            }
            if(param3.zpp_inner.weak)
            {
               param3.dispose();
            }
         }
         else
         {
            _loc5_ = zpp_inner.xform.outer.transform(param1);
            _loc6_ = zpp_inner.xform.outer.transform(param2);
            _loc7_ = zpp_inner.xform.outer.transform(param3);
            zpp_inner_zn.__curve(_loc5_,_loc6_,_loc7_,param4);
            _loc5_.dispose();
            _loc6_.dispose();
            _loc7_.dispose();
         }
      }
      
      override public function drawCircle(param1:Vec2, param2:Number, param3:int) : void
      {
         var _loc4_:int = 0;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:* = null as Vec2;
         if(zpp_inner.xnull)
         {
            _loc5_ = param1.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc4_ = Number(param1.zpp_inner.x + 0.5);
            _loc5_ = param1.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc6_ = Number(param1.zpp_inner.y + 0.5);
            _loc7_ = Number(param2 + 0.5);
            zpp_inner_zn.__circle(_loc4_,_loc6_,_loc7_,param3 | -16777216);
            if(param1.zpp_inner.weak)
            {
               param1.dispose();
            }
         }
         else
         {
            _loc8_ = zpp_inner.xform.outer.transform(param1);
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc4_ = Number(_loc8_.zpp_inner.x + 0.5);
            _loc5_ = _loc8_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc6_ = Number(_loc8_.zpp_inner.y + 0.5);
            _loc8_.dispose();
            _loc7_ = Number(param2 * zpp_inner.xdet + 0.5);
            zpp_inner_zn.__circle(_loc4_,_loc6_,_loc7_,param3 | -16777216);
         }
      }
      
      override public function drawAABB(param1:AABB, param2:int) : void
      {
         var _loc3_:* = null as Vec2;
         var _loc4_:* = null as Vec2;
         var _loc5_:* = null as ZPP_AABB;
         var _loc6_:* = null as Vec2;
         var _loc7_:* = null as Vec2;
         var _loc8_:* = null as Vec2;
         var _loc9_:int = 0;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:* = 0;
         if(zpp_inner.xnull)
         {
            zpp_inner_zn.__aabb(param1.zpp_inner,param2);
         }
         else
         {
            _loc3_ = zpp_inner.xform.outer.transform(param1.zpp_inner.getmin());
            _loc5_ = param1.zpp_inner;
            §§push(Vec2);
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc5_ = param1.zpp_inner;
            _loc4_ = §§pop().get(_loc5_.maxx - _loc5_.minx,0);
            _loc6_ = zpp_inner.xform.outer.transform(_loc4_,true);
            _loc5_ = param1.zpp_inner;
            §§push(Vec2);
            §§push(0);
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            _loc5_ = param1.zpp_inner;
            _loc7_ = §§pop().get(§§pop(),_loc5_.maxy - _loc5_.miny);
            _loc8_ = zpp_inner.xform.outer.transform(_loc7_,true);
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc9_ = Number(_loc3_.zpp_inner.x + 0.5);
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc11_ = Number(_loc3_.zpp_inner.y + 0.5);
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc10_ = _loc6_.zpp_inner;
            §§push(_loc3_.zpp_inner.x);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc12_ = Number(Number(§§pop() + _loc6_.zpp_inner.x) + 0.5);
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc10_ = _loc6_.zpp_inner;
            §§push(_loc3_.zpp_inner.y);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc13_ = Number(Number(§§pop() + _loc6_.zpp_inner.y) + 0.5);
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc10_ = _loc6_.zpp_inner;
            §§push(_loc3_.zpp_inner.x);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc10_ = _loc8_.zpp_inner;
            §§push(Number(§§pop() + _loc6_.zpp_inner.x));
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc14_ = Number(Number(§§pop() + _loc8_.zpp_inner.x) + 0.5);
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc10_ = _loc6_.zpp_inner;
            §§push(_loc3_.zpp_inner.y);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc10_ = _loc8_.zpp_inner;
            §§push(Number(§§pop() + _loc6_.zpp_inner.y));
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc15_ = Number(Number(§§pop() + _loc8_.zpp_inner.y) + 0.5);
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc10_ = _loc8_.zpp_inner;
            §§push(_loc3_.zpp_inner.x);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc16_ = Number(Number(§§pop() + _loc8_.zpp_inner.x) + 0.5);
            _loc10_ = _loc3_.zpp_inner;
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc10_ = _loc8_.zpp_inner;
            §§push(_loc3_.zpp_inner.y);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc17_ = Number(Number(§§pop() + _loc8_.zpp_inner.y) + 0.5);
            _loc3_.dispose();
            _loc4_.dispose();
            _loc6_.dispose();
            _loc7_.dispose();
            _loc8_.dispose();
            _loc18_ = param2 | -16777216;
            zpp_inner_zn.__line(_loc9_,_loc11_,_loc12_,_loc13_,_loc18_);
            zpp_inner_zn.__line(_loc12_,_loc13_,_loc14_,_loc15_,_loc18_);
            zpp_inner_zn.__line(_loc14_,_loc15_,_loc16_,_loc17_,_loc18_);
            zpp_inner_zn.__line(_loc16_,_loc17_,_loc9_,_loc11_,_loc18_);
         }
      }
      
      override public function draw(param1:*) : void
      {
         if(zpp_inner.xnull)
         {
            if(Std.§is§(param1,Space))
            {
               zpp_inner_zn.draw_space(param1.zpp_inner,null,1,true);
            }
            else if(Std.§is§(param1,Compound))
            {
               zpp_inner_zn.draw_compound(param1.zpp_inner,null,1,true);
            }
            else if(Std.§is§(param1,Body))
            {
               zpp_inner_zn.draw_body(param1.zpp_inner,null,1,true);
            }
            else if(Std.§is§(param1,Shape))
            {
               zpp_inner_zn.draw_shape(param1.zpp_inner,null,1,true);
            }
            else if(Std.§is§(param1,Constraint))
            {
               param1.zpp_inner.draw(this);
            }
         }
         else if(Std.§is§(param1,Space))
         {
            zpp_inner_zn.draw_space(param1.zpp_inner,zpp_inner.xform,zpp_inner.xdet,false);
         }
         else if(Std.§is§(param1,Body))
         {
            zpp_inner_zn.draw_body(param1.zpp_inner,zpp_inner.xform,zpp_inner.xdet,false);
         }
         else if(Std.§is§(param1,Shape))
         {
            zpp_inner_zn.draw_shape(param1.zpp_inner,zpp_inner.xform,zpp_inner.xdet,false);
         }
         else if(Std.§is§(param1,Constraint))
         {
            param1.zpp_inner.draw(this);
         }
      }
      
      override public function clear() : void
      {
         zpp_inner_zn.clear();
      }
   }
}
