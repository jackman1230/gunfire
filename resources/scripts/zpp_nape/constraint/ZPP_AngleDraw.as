package zpp_nape.constraint
{
   import nape.geom.Vec2;
   import nape.util.Debug;
   import zpp_nape.geom.ZPP_Vec2;
   
   public class ZPP_AngleDraw
   {
      
      public static var maxarc:Number = Math.PI / 4;
       
      
      public function ZPP_AngleDraw()
      {
      }
      
      public static function indicator(param1:Debug, param2:Vec2, param3:Number, param4:Number, param5:int) : void
      {
         var _loc6_:Vec2 = Vec2.get(Number(Math.cos(param3)),Number(Math.sin(param3)));
         param1.drawFilledCircle(param2.add(_loc6_.mul(param4,true),true),2,param5);
         _loc6_.dispose();
      }
      
      public static function drawSpiralSpring(param1:Debug, param2:Vec2, param3:Number, param4:Number, param5:Number, param6:Number, param7:int, param8:int = 4) : void
      {
         var _loc9_:Number = NaN;
         var _loc15_:* = 0;
         var _loc23_:* = null as ZPP_Vec2;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:Number = NaN;
         var _loc33_:Number = NaN;
         var _loc34_:Number = NaN;
         var _loc35_:Number = NaN;
         var _loc36_:Number = NaN;
         var _loc37_:Number = NaN;
         var _loc38_:* = null as Vec2;
         if(param3 > param4)
         {
            _loc9_ = param3;
            param3 = param4;
            param4 = _loc9_;
            _loc9_ = param5;
            param5 = param6;
            param6 = _loc9_;
         }
         if(param3 == param4)
         {
            return;
         }
         _loc9_ = param6 - param5;
         var _loc10_:Number = param4 - param3;
         var _loc12_:Number = 2 * Math.PI * _loc9_ / _loc10_;
         var _loc11_:Number = _loc12_ < 0?-_loc12_:_loc12_;
         var _loc14_:int = Math.ceil(_loc10_ / ZPP_AngleDraw.maxarc * 3);
         _loc15_ = 4 * param8;
         var _loc13_:int = _loc14_ > _loc15_?_loc14_:_loc15_;
         _loc12_ = _loc9_ / _loc13_;
         var _loc16_:Number = _loc10_ / _loc13_;
         var _loc17_:Number = 1 / _loc13_;
         var _loc18_:Number = Number(Math.cos(param3));
         var _loc19_:Number = Number(Math.sin(param3));
         var _loc21_:Number = Number(param5 + _loc9_ * 0);
         var _loc20_:Number = Number(_loc21_ + 0.75 * _loc11_ * Math.sin(2 * param8 * Math.PI * 0));
         _loc23_ = param2.zpp_inner;
         §§push(Vec2);
         if(_loc23_._validate != null)
         {
            _loc23_._validate();
         }
         _loc23_ = param2.zpp_inner;
         §§push(Number(param2.zpp_inner.x + _loc20_ * _loc18_));
         if(_loc23_._validate != null)
         {
            _loc23_._validate();
         }
         var _loc22_:Vec2 = §§pop().get(§§pop(),Number(param2.zpp_inner.y + _loc20_ * _loc19_));
         _loc21_ = Number(_loc9_ + 1.5 * param8 * _loc11_ * Math.PI * Math.cos(2 * param8 * Math.PI * 0));
         var _loc24_:Number = _loc21_ * _loc18_ - _loc20_ * _loc10_ * _loc19_;
         var _loc25_:Number = Number(_loc21_ * _loc19_ + _loc20_ * _loc10_ * _loc18_);
         var _loc26_:Vec2 = Vec2.get();
         var _loc27_:Vec2 = Vec2.get();
         _loc14_ = 0;
         while(_loc14_ < _loc13_)
         {
            _loc14_++;
            _loc15_ = int(_loc14_);
            _loc28_ = Number(param3 + _loc16_);
            _loc29_ = Number(Math.cos(_loc28_));
            _loc30_ = Number(Math.sin(_loc28_));
            _loc32_ = Number(param5 + _loc9_ * (_loc15_ + 1) * _loc17_);
            _loc31_ = Number(_loc32_ + 0.75 * _loc11_ * Math.sin(2 * param8 * Math.PI * (_loc15_ + 1) * _loc17_));
            _loc23_ = param2.zpp_inner;
            if(_loc23_._validate != null)
            {
               _loc23_._validate();
            }
            _loc32_ = Number(param2.zpp_inner.x + _loc31_ * _loc29_);
            _loc23_ = param2.zpp_inner;
            if(_loc23_._validate != null)
            {
               _loc23_._validate();
            }
            _loc33_ = Number(param2.zpp_inner.y + _loc31_ * _loc30_);
            _loc23_ = _loc26_.zpp_inner;
            §§push(false);
            if(_loc23_._validate != null)
            {
               _loc23_._validate();
            }
            if(_loc26_.zpp_inner.x == _loc32_)
            {
               §§pop();
               _loc23_ = _loc26_.zpp_inner;
               if(_loc23_._validate != null)
               {
                  _loc23_._validate();
               }
               §§push(_loc26_.zpp_inner.y == _loc33_);
            }
            if(!§§pop())
            {
               _loc26_.zpp_inner.x = _loc32_;
               _loc26_.zpp_inner.y = _loc33_;
               _loc23_ = _loc26_.zpp_inner;
               if(_loc23_._invalidate != null)
               {
                  _loc23_._invalidate(_loc23_);
               }
            }
            _loc26_;
            _loc32_ = Number(_loc9_ + 1.5 * param8 * _loc11_ * Math.PI * Math.cos(2 * param8 * Math.PI * (_loc15_ + 1) * _loc17_));
            _loc33_ = _loc32_ * _loc29_ - _loc31_ * _loc10_ * _loc30_;
            _loc34_ = Number(_loc32_ * _loc30_ + _loc31_ * _loc10_ * _loc29_);
            _loc35_ = _loc24_ * _loc34_ - _loc25_ * _loc33_;
            if(_loc35_ * _loc35_ < 1.0e-8 || Number(_loc24_ * _loc33_ + _loc25_ * _loc34_) <= 0 || Number(_loc24_ * _loc33_ + _loc25_ * _loc34_) > 0.999)
            {
               param1.drawLine(_loc22_,_loc26_,param7);
            }
            else
            {
               _loc23_ = _loc26_.zpp_inner;
               if(_loc23_._validate != null)
               {
                  _loc23_._validate();
               }
               _loc23_ = _loc22_.zpp_inner;
               §§push(_loc26_.zpp_inner.x);
               if(_loc23_._validate != null)
               {
                  _loc23_._validate();
               }
               _loc23_ = _loc22_.zpp_inner;
               §§push((§§pop() - _loc22_.zpp_inner.x) * _loc34_);
               if(_loc23_._validate != null)
               {
                  _loc23_._validate();
               }
               _loc23_ = _loc26_.zpp_inner;
               §§push(_loc22_.zpp_inner.y);
               if(_loc23_._validate != null)
               {
                  _loc23_._validate();
               }
               _loc36_ = (§§pop() + (§§pop() - _loc26_.zpp_inner.y) * _loc33_) / _loc35_;
               if(_loc36_ <= 0)
               {
                  param1.drawLine(_loc22_,_loc26_,param7);
               }
               else
               {
                  _loc23_ = _loc22_.zpp_inner;
                  if(_loc23_._validate != null)
                  {
                     _loc23_._validate();
                  }
                  _loc37_ = Number(_loc22_.zpp_inner.x + _loc24_ * _loc36_);
                  _loc23_ = _loc27_.zpp_inner;
                  if(_loc23_._validate != null)
                  {
                     _loc23_._validate();
                  }
                  if(_loc27_.zpp_inner.x != _loc37_)
                  {
                     _loc27_.zpp_inner.x = _loc37_;
                     _loc23_ = _loc27_.zpp_inner;
                     if(_loc23_._invalidate != null)
                     {
                        _loc23_._invalidate(_loc23_);
                     }
                  }
                  _loc23_ = _loc27_.zpp_inner;
                  if(_loc23_._validate != null)
                  {
                     _loc23_._validate();
                  }
                  _loc27_.zpp_inner.x;
                  _loc23_ = _loc22_.zpp_inner;
                  if(_loc23_._validate != null)
                  {
                     _loc23_._validate();
                  }
                  _loc37_ = Number(_loc22_.zpp_inner.y + _loc25_ * _loc36_);
                  _loc23_ = _loc27_.zpp_inner;
                  if(_loc23_._validate != null)
                  {
                     _loc23_._validate();
                  }
                  if(_loc27_.zpp_inner.y != _loc37_)
                  {
                     _loc27_.zpp_inner.y = _loc37_;
                     _loc23_ = _loc27_.zpp_inner;
                     if(_loc23_._invalidate != null)
                     {
                        _loc23_._invalidate(_loc23_);
                     }
                  }
                  _loc23_ = _loc27_.zpp_inner;
                  if(_loc23_._validate != null)
                  {
                     _loc23_._validate();
                  }
                  _loc27_.zpp_inner.y;
                  param1.drawCurve(_loc22_,_loc27_,_loc26_,param7);
               }
            }
            param3 = _loc28_;
            _loc18_ = _loc29_;
            _loc19_ = _loc30_;
            _loc24_ = _loc33_;
            _loc25_ = _loc34_;
            _loc23_ = _loc26_.zpp_inner;
            if(_loc23_._validate != null)
            {
               _loc23_._validate();
            }
            _loc36_ = _loc26_.zpp_inner.x;
            _loc23_ = _loc26_.zpp_inner;
            if(_loc23_._validate != null)
            {
               _loc23_._validate();
            }
            _loc37_ = _loc26_.zpp_inner.y;
            _loc23_ = _loc22_.zpp_inner;
            §§push(false);
            if(_loc23_._validate != null)
            {
               _loc23_._validate();
            }
            if(_loc22_.zpp_inner.x == _loc36_)
            {
               §§pop();
               _loc23_ = _loc22_.zpp_inner;
               if(_loc23_._validate != null)
               {
                  _loc23_._validate();
               }
               §§push(_loc22_.zpp_inner.y == _loc37_);
            }
            if(!§§pop())
            {
               _loc22_.zpp_inner.x = _loc36_;
               _loc22_.zpp_inner.y = _loc37_;
               _loc23_ = _loc22_.zpp_inner;
               if(_loc23_._invalidate != null)
               {
                  _loc23_._invalidate(_loc23_);
               }
            }
            _loc38_ = _loc22_;
            if(_loc26_.zpp_inner.weak)
            {
               _loc26_.dispose();
            }
            _loc38_;
         }
         _loc22_.dispose();
         _loc26_.dispose();
         _loc27_.dispose();
      }
      
      public static function drawSpiral(param1:Debug, param2:Vec2, param3:Number, param4:Number, param5:Number, param6:Number, param7:int) : void
      {
         var _loc8_:Number = NaN;
         var _loc16_:* = null as ZPP_Vec2;
         var _loc22_:int = 0;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Number = NaN;
         var _loc32_:* = null as Vec2;
         if(param3 > param4)
         {
            _loc8_ = param3;
            param3 = param4;
            param4 = _loc8_;
            _loc8_ = param5;
            param5 = param6;
            param6 = _loc8_;
         }
         if(param3 == param4)
         {
            return;
         }
         _loc8_ = param6 - param5;
         var _loc9_:Number = param4 - param3;
         var _loc10_:int = Math.ceil(_loc9_ / ZPP_AngleDraw.maxarc);
         var _loc11_:Number = _loc8_ / _loc10_;
         var _loc12_:Number = _loc9_ / _loc10_;
         var _loc13_:Number = Number(Math.cos(param3));
         var _loc14_:Number = Number(Math.sin(param3));
         _loc16_ = param2.zpp_inner;
         §§push(Vec2);
         if(_loc16_._validate != null)
         {
            _loc16_._validate();
         }
         _loc16_ = param2.zpp_inner;
         §§push(Number(param2.zpp_inner.x + param5 * _loc13_));
         if(_loc16_._validate != null)
         {
            _loc16_._validate();
         }
         var _loc15_:Vec2 = §§pop().get(§§pop(),Number(param2.zpp_inner.y + param5 * _loc14_));
         var _loc17_:Number = _loc8_ * _loc13_ - param5 * _loc9_ * _loc14_;
         var _loc18_:Number = Number(_loc8_ * _loc14_ + param5 * _loc9_ * _loc13_);
         var _loc19_:Vec2 = Vec2.get();
         var _loc20_:Vec2 = Vec2.get();
         var _loc21_:int = 0;
         while(_loc21_ < _loc10_)
         {
            _loc21_++;
            _loc22_ = _loc21_;
            _loc23_ = Number(param5 + _loc11_);
            _loc24_ = Number(param3 + _loc12_);
            _loc25_ = Number(Math.cos(_loc24_));
            _loc26_ = Number(Math.sin(_loc24_));
            _loc16_ = param2.zpp_inner;
            if(_loc16_._validate != null)
            {
               _loc16_._validate();
            }
            _loc27_ = Number(param2.zpp_inner.x + _loc23_ * _loc25_);
            _loc16_ = param2.zpp_inner;
            if(_loc16_._validate != null)
            {
               _loc16_._validate();
            }
            _loc28_ = Number(param2.zpp_inner.y + _loc23_ * _loc26_);
            _loc16_ = _loc19_.zpp_inner;
            §§push(false);
            if(_loc16_._validate != null)
            {
               _loc16_._validate();
            }
            if(_loc19_.zpp_inner.x == _loc27_)
            {
               §§pop();
               _loc16_ = _loc19_.zpp_inner;
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               §§push(_loc19_.zpp_inner.y == _loc28_);
            }
            if(!§§pop())
            {
               _loc19_.zpp_inner.x = _loc27_;
               _loc19_.zpp_inner.y = _loc28_;
               _loc16_ = _loc19_.zpp_inner;
               if(_loc16_._invalidate != null)
               {
                  _loc16_._invalidate(_loc16_);
               }
            }
            _loc19_;
            _loc27_ = _loc8_ * _loc25_ - _loc23_ * _loc9_ * _loc26_;
            _loc28_ = Number(_loc8_ * _loc26_ + _loc23_ * _loc9_ * _loc25_);
            _loc29_ = _loc17_ * _loc28_ - _loc18_ * _loc27_;
            if(_loc29_ * _loc29_ < 1.0e-8)
            {
               param1.drawLine(_loc15_,_loc19_,param7);
            }
            else
            {
               _loc16_ = _loc19_.zpp_inner;
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc15_.zpp_inner;
               §§push(_loc19_.zpp_inner.x);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc15_.zpp_inner;
               §§push((§§pop() - _loc15_.zpp_inner.x) * _loc28_);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc16_ = _loc19_.zpp_inner;
               §§push(_loc15_.zpp_inner.y);
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               _loc30_ = (§§pop() + (§§pop() - _loc19_.zpp_inner.y) * _loc27_) / _loc29_;
               if(_loc30_ <= 0)
               {
                  param1.drawLine(_loc15_,_loc19_,param7);
               }
               else
               {
                  _loc16_ = _loc15_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc31_ = Number(_loc15_.zpp_inner.x + _loc17_ * _loc30_);
                  _loc16_ = _loc20_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  if(_loc20_.zpp_inner.x != _loc31_)
                  {
                     _loc20_.zpp_inner.x = _loc31_;
                     _loc16_ = _loc20_.zpp_inner;
                     if(_loc16_._invalidate != null)
                     {
                        _loc16_._invalidate(_loc16_);
                     }
                  }
                  _loc16_ = _loc20_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc20_.zpp_inner.x;
                  _loc16_ = _loc15_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc31_ = Number(_loc15_.zpp_inner.y + _loc18_ * _loc30_);
                  _loc16_ = _loc20_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  if(_loc20_.zpp_inner.y != _loc31_)
                  {
                     _loc20_.zpp_inner.y = _loc31_;
                     _loc16_ = _loc20_.zpp_inner;
                     if(_loc16_._invalidate != null)
                     {
                        _loc16_._invalidate(_loc16_);
                     }
                  }
                  _loc16_ = _loc20_.zpp_inner;
                  if(_loc16_._validate != null)
                  {
                     _loc16_._validate();
                  }
                  _loc20_.zpp_inner.y;
                  param1.drawCurve(_loc15_,_loc20_,_loc19_,param7);
               }
            }
            param5 = _loc23_;
            param3 = _loc24_;
            _loc13_ = _loc25_;
            _loc14_ = _loc26_;
            _loc17_ = _loc27_;
            _loc18_ = _loc28_;
            _loc16_ = _loc19_.zpp_inner;
            if(_loc16_._validate != null)
            {
               _loc16_._validate();
            }
            _loc30_ = _loc19_.zpp_inner.x;
            _loc16_ = _loc19_.zpp_inner;
            if(_loc16_._validate != null)
            {
               _loc16_._validate();
            }
            _loc31_ = _loc19_.zpp_inner.y;
            _loc16_ = _loc15_.zpp_inner;
            §§push(false);
            if(_loc16_._validate != null)
            {
               _loc16_._validate();
            }
            if(_loc15_.zpp_inner.x == _loc30_)
            {
               §§pop();
               _loc16_ = _loc15_.zpp_inner;
               if(_loc16_._validate != null)
               {
                  _loc16_._validate();
               }
               §§push(_loc15_.zpp_inner.y == _loc31_);
            }
            if(!§§pop())
            {
               _loc15_.zpp_inner.x = _loc30_;
               _loc15_.zpp_inner.y = _loc31_;
               _loc16_ = _loc15_.zpp_inner;
               if(_loc16_._invalidate != null)
               {
                  _loc16_._invalidate(_loc16_);
               }
            }
            _loc32_ = _loc15_;
            if(_loc19_.zpp_inner.weak)
            {
               _loc19_.dispose();
            }
            _loc32_;
         }
         _loc15_.dispose();
         _loc19_.dispose();
         _loc20_.dispose();
      }
   }
}
