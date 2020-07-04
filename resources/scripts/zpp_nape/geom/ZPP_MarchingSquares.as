package zpp_nape.geom
{
   import nape.geom.GeomPoly;
   import nape.geom.GeomPolyList;
   import nape.geom.Vec2;
   import zpp_nape.util.Array2;
   
   public class ZPP_MarchingSquares
   {
      
      public static var me:ZPP_MarchingSquares = new ZPP_MarchingSquares();
      
      public static var look_march:Array = [-1,224,56,216,14,-1,54,214,131,99,-1,91,141,109,181,85];
       
      
      public function ZPP_MarchingSquares()
      {
      }
      
      public static function run(param1:Function, param2:Number, param3:Number, param4:Number, param5:Number, param6:Vec2, param7:int, param8:Boolean, param9:GeomPolyList) : void
      {
         var _loc11_:* = null as ZPP_Vec2;
         var _loc18_:* = 0;
         var _loc19_:int = 0;
         var _loc20_:Number = NaN;
         var _loc21_:int = 0;
         var _loc22_:* = 0;
         var _loc23_:int = 0;
         var _loc24_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Number = NaN;
         var _loc28_:* = null as ZPP_MarchPair;
         var _loc29_:Number = NaN;
         var _loc30_:Number = NaN;
         var _loc31_:Boolean = false;
         var _loc32_:Boolean = false;
         var _loc33_:Boolean = false;
         var _loc34_:Boolean = false;
         var _loc35_:* = null as ZPP_MarchPair;
         var _loc36_:* = null as ZPP_GeomVert;
         var _loc37_:* = null as ZPP_MarchSpan;
         var _loc38_:* = null as ZPP_MarchSpan;
         var _loc39_:* = null as ZPP_MarchSpan;
         var _loc40_:* = null as ZPP_MarchSpan;
         var _loc41_:* = null as ZPP_MarchSpan;
         var _loc42_:* = null as ZPP_MarchSpan;
         var _loc43_:* = null as ZPP_MarchSpan;
         var _loc44_:* = null as ZPP_MarchSpan;
         var _loc45_:int = 0;
         _loc11_ = param6.zpp_inner;
         §§push(param4 - param2);
         if(_loc11_._validate != null)
         {
            _loc11_._validate();
         }
         var _loc10_:Number = §§pop() / param6.zpp_inner.x;
         var _loc12_:int = _loc10_;
         _loc11_ = param6.zpp_inner;
         §§push(param5 - param3);
         if(_loc11_._validate != null)
         {
            _loc11_._validate();
         }
         var _loc13_:Number = §§pop() / param6.zpp_inner.y;
         var _loc14_:int = _loc13_;
         if(_loc10_ != _loc12_)
         {
            _loc12_++;
         }
         if(_loc13_ != _loc14_)
         {
            _loc14_++;
         }
         var _loc15_:Array2 = null;
         if(param8)
         {
            _loc15_ = new Array2(_loc12_,_loc14_);
         }
         var _loc16_:Array2 = new Array2(_loc12_ + 1,_loc14_ + 1);
         var _loc17_:int = 0;
         _loc18_ = _loc14_ + 1;
         while(_loc17_ < _loc18_)
         {
            _loc17_++;
            _loc19_ = _loc17_;
            if(_loc19_ == 0)
            {
               §§push(param3);
            }
            else if(_loc19_ <= _loc14_)
            {
               _loc11_ = param6.zpp_inner;
               §§push(param3);
               if(_loc11_._validate != null)
               {
                  _loc11_._validate();
               }
               §§push(Number(§§pop() + param6.zpp_inner.y * _loc19_));
            }
            else
            {
               §§push(param5);
            }
            _loc20_ = §§pop();
            _loc21_ = 0;
            _loc22_ = _loc12_ + 1;
            while(_loc21_ < _loc22_)
            {
               _loc21_++;
               _loc23_ = _loc21_;
               if(_loc23_ == 0)
               {
                  §§push(param2);
               }
               else if(_loc23_ <= _loc12_)
               {
                  _loc11_ = param6.zpp_inner;
                  §§push(param2);
                  if(_loc11_._validate != null)
                  {
                     _loc11_._validate();
                  }
                  §§push(Number(§§pop() + param6.zpp_inner.x * _loc23_));
               }
               else
               {
                  §§push(param4);
               }
               _loc24_ = §§pop();
               _loc16_.set(_loc23_,_loc19_,Number(param1(_loc24_,_loc20_)));
            }
         }
         var _loc25_:Array2 = new Array2(_loc12_ + 1,(_loc14_ << 1) + 1);
         _loc20_ = param3;
         _loc17_ = 0;
         while(_loc17_ < _loc14_)
         {
            _loc17_++;
            _loc18_ = int(_loc17_);
            _loc24_ = _loc20_;
            if(_loc18_ == _loc14_ - 1)
            {
               §§push(param5);
            }
            else
            {
               _loc11_ = param6.zpp_inner;
               §§push(param3);
               if(_loc11_._validate != null)
               {
                  _loc11_._validate();
               }
               §§push(Number(§§pop() + param6.zpp_inner.y * (_loc18_ + 1)));
            }
            _loc26_ = §§pop();
            _loc20_ = _loc26_;
            _loc27_ = param2;
            _loc28_ = null;
            _loc19_ = 0;
            while(_loc19_ < _loc12_)
            {
               _loc19_++;
               _loc21_ = _loc19_;
               _loc29_ = _loc27_;
               if(_loc21_ == _loc12_ - 1)
               {
                  §§push(param4);
               }
               else
               {
                  _loc11_ = param6.zpp_inner;
                  §§push(param2);
                  if(_loc11_._validate != null)
                  {
                     _loc11_._validate();
                  }
                  §§push(Number(§§pop() + param6.zpp_inner.x * (_loc21_ + 1)));
               }
               _loc30_ = §§pop();
               _loc27_ = _loc30_;
               _loc31_ = _loc21_ == 0 || !param8;
               _loc32_ = _loc18_ == 0 || !param8;
               _loc33_ = _loc21_ == _loc12_ - 1 || !param8;
               _loc34_ = _loc18_ == _loc14_ - 1 || !param8;
               _loc35_ = ZPP_MarchingSquares.me.marchSquare(param1,_loc16_,_loc25_,_loc29_,_loc24_,_loc30_,_loc26_,_loc21_,_loc18_,_loc31_,_loc32_,_loc33_,_loc34_,param7);
               if(_loc35_ == null)
               {
                  _loc28_ = null;
               }
               else if(param8)
               {
                  _loc36_ = _loc35_.p2 != null && _loc35_.okey2 != 14?_loc35_.p2:_loc35_.p1;
                  _loc35_.pd = ZPP_MarchingSquares.me.linkdown(_loc36_,_loc36_ == _loc35_.p2?_loc35_.okey2:_loc35_.okey1);
                  _loc15_.set(_loc21_,_loc18_,_loc35_);
                  if(_loc28_ != null && ZPP_MarchingSquares.me.combLeft(_loc35_.key1))
                  {
                     ZPP_MarchingSquares.me.combLR(_loc28_,_loc35_);
                     _loc35_.span1 = _loc28_.spanr;
                  }
                  else
                  {
                     if(ZPP_MarchSpan.zpp_pool == null)
                     {
                        _loc35_.span1 = new ZPP_MarchSpan();
                     }
                     else
                     {
                        _loc35_.span1 = ZPP_MarchSpan.zpp_pool;
                        ZPP_MarchSpan.zpp_pool = _loc35_.span1.next;
                        _loc35_.span1.next = null;
                     }
                     _loc35_.span1.alloc();
                  }
                  if(_loc35_.p2 != null)
                  {
                     if(ZPP_MarchSpan.zpp_pool == null)
                     {
                        _loc35_.span2 = new ZPP_MarchSpan();
                     }
                     else
                     {
                        _loc35_.span2 = ZPP_MarchSpan.zpp_pool;
                        ZPP_MarchSpan.zpp_pool = _loc35_.span2.next;
                        _loc35_.span2.next = null;
                     }
                     _loc35_.span2.alloc();
                     _loc35_.spanr = _loc35_.span2;
                  }
                  else
                  {
                     _loc35_.spanr = _loc35_.span1;
                  }
                  if(ZPP_MarchingSquares.me.combRight(_loc35_.keyr))
                  {
                     _loc28_ = _loc35_;
                  }
                  else
                  {
                     _loc28_ = null;
                  }
               }
               else
               {
                  ZPP_MarchingSquares.me.output(param9,_loc35_.p1);
                  if(_loc35_.p2 != null)
                  {
                     ZPP_MarchingSquares.me.output(param9,_loc35_.p2);
                  }
               }
            }
         }
         if(!param8)
         {
            return;
         }
         _loc17_ = 1;
         while(_loc17_ < _loc14_)
         {
            _loc17_++;
            _loc18_ = int(_loc17_);
            _loc37_ = null;
            _loc19_ = 0;
            while(_loc19_ < _loc12_)
            {
               _loc19_++;
               _loc21_ = _loc19_;
               _loc28_ = _loc15_.get(_loc21_,_loc18_);
               if(_loc28_ == null)
               {
                  _loc37_ = null;
               }
               else
               {
                  _loc22_ = int(_loc28_.p2 != null && _loc28_.okey2 == 14?_loc28_.okey2:_loc28_.okey1);
                  if(!ZPP_MarchingSquares.me.combUp(_loc22_))
                  {
                     _loc37_ = null;
                  }
                  else
                  {
                     _loc35_ = _loc15_.get(_loc21_,_loc18_ - 1);
                     if(_loc35_ == null)
                     {
                        _loc37_ = null;
                     }
                     else
                     {
                        _loc23_ = _loc35_.p2 != null && _loc35_.okey2 == 56?_loc35_.okey2:_loc35_.okey1;
                        if(!ZPP_MarchingSquares.me.combDown(_loc23_))
                        {
                           _loc37_ = null;
                        }
                        else
                        {
                           _loc38_ = _loc35_.p2 != null && _loc35_.okey2 == 56?_loc35_.span2:_loc35_.span1;
                           _loc39_ = _loc28_.p2 != null && _loc28_.okey2 == 14?_loc28_.span2:_loc28_.span1;
                           if(_loc38_ == _loc38_.parent)
                           {
                              §§push(_loc38_);
                           }
                           else
                           {
                              _loc40_ = _loc38_;
                              _loc41_ = null;
                              while(_loc40_ != _loc40_.parent)
                              {
                                 _loc42_ = _loc40_.parent;
                                 _loc40_.parent = _loc41_;
                                 _loc41_ = _loc40_;
                                 _loc40_ = _loc42_;
                              }
                              while(_loc41_ != null)
                              {
                                 _loc42_ = _loc41_.parent;
                                 _loc41_.parent = _loc40_;
                                 _loc41_ = _loc42_;
                              }
                              §§push(_loc40_);
                           }
                           if(_loc39_ == _loc39_.parent)
                           {
                              §§push(_loc39_);
                           }
                           else
                           {
                              _loc40_ = _loc39_;
                              _loc41_ = null;
                              while(_loc40_ != _loc40_.parent)
                              {
                                 _loc42_ = _loc40_.parent;
                                 _loc40_.parent = _loc41_;
                                 _loc41_ = _loc40_;
                                 _loc40_ = _loc42_;
                              }
                              while(_loc41_ != null)
                              {
                                 _loc42_ = _loc41_.parent;
                                 _loc41_.parent = _loc40_;
                                 _loc41_ = _loc42_;
                              }
                              §§push(_loc40_);
                           }
                           if(§§pop() == §§pop())
                           {
                              if(_loc37_ != _loc39_)
                              {
                                 ZPP_MarchingSquares.me.combUD_virtual(_loc35_,_loc28_);
                              }
                           }
                           else
                           {
                              if(_loc38_ == _loc38_.parent)
                              {
                                 §§push(_loc38_);
                              }
                              else
                              {
                                 _loc41_ = _loc38_;
                                 _loc42_ = null;
                                 while(_loc41_ != _loc41_.parent)
                                 {
                                    _loc43_ = _loc41_.parent;
                                    _loc41_.parent = _loc42_;
                                    _loc42_ = _loc41_;
                                    _loc41_ = _loc43_;
                                 }
                                 while(_loc42_ != null)
                                 {
                                    _loc43_ = _loc42_.parent;
                                    _loc42_.parent = _loc41_;
                                    _loc42_ = _loc43_;
                                 }
                                 §§push(_loc41_);
                              }
                              _loc40_ = §§pop();
                              if(_loc39_ == _loc39_.parent)
                              {
                                 §§push(_loc39_);
                              }
                              else
                              {
                                 _loc42_ = _loc39_;
                                 _loc43_ = null;
                                 while(_loc42_ != _loc42_.parent)
                                 {
                                    _loc44_ = _loc42_.parent;
                                    _loc42_.parent = _loc43_;
                                    _loc43_ = _loc42_;
                                    _loc42_ = _loc44_;
                                 }
                                 while(_loc43_ != null)
                                 {
                                    _loc44_ = _loc43_.parent;
                                    _loc43_.parent = _loc42_;
                                    _loc43_ = _loc44_;
                                 }
                                 §§push(_loc42_);
                              }
                              _loc41_ = §§pop();
                              if(_loc40_ != _loc41_)
                              {
                                 if(_loc40_.rank < _loc41_.rank)
                                 {
                                    _loc40_.parent = _loc41_;
                                 }
                                 else if(_loc40_.rank > _loc41_.rank)
                                 {
                                    _loc41_.parent = _loc40_;
                                 }
                                 else
                                 {
                                    _loc41_.parent = _loc40_;
                                    _loc40_.rank = _loc40_.rank + 1;
                                 }
                              }
                              ZPP_MarchingSquares.me.combUD(_loc35_,_loc28_);
                           }
                           _loc45_ = _loc39_ == _loc28_.span2?_loc28_.okey2:_loc28_.okey1;
                           _loc37_ = (_loc45_ & 4) != 0?_loc39_:null;
                        }
                     }
                  }
               }
            }
         }
         _loc17_ = 0;
         while(_loc17_ < _loc14_)
         {
            _loc17_++;
            _loc18_ = int(_loc17_);
            _loc19_ = 0;
            while(_loc19_ < _loc12_)
            {
               _loc19_++;
               _loc21_ = _loc19_;
               _loc28_ = _loc15_.get(_loc21_,_loc18_);
               if(_loc28_ != null)
               {
                  if(_loc28_.span1 == _loc28_.span1.parent)
                  {
                     §§push(_loc28_.span1);
                  }
                  else
                  {
                     _loc38_ = _loc28_.span1;
                     _loc39_ = null;
                     while(_loc38_ != _loc38_.parent)
                     {
                        _loc40_ = _loc38_.parent;
                        _loc38_.parent = _loc39_;
                        _loc39_ = _loc38_;
                        _loc38_ = _loc40_;
                     }
                     while(_loc39_ != null)
                     {
                        _loc40_ = _loc39_.parent;
                        _loc39_.parent = _loc38_;
                        _loc39_ = _loc40_;
                     }
                     §§push(_loc38_);
                  }
                  _loc37_ = §§pop();
                  if(!_loc37_.out)
                  {
                     _loc37_.out = true;
                     ZPP_MarchingSquares.me.output(param9,_loc28_.p1);
                  }
                  if(_loc28_.p2 != null)
                  {
                     if(_loc28_.span2 == _loc28_.span2.parent)
                     {
                        §§push(_loc28_.span2);
                     }
                     else
                     {
                        _loc38_ = _loc28_.span2;
                        _loc39_ = null;
                        while(_loc38_ != _loc38_.parent)
                        {
                           _loc40_ = _loc38_.parent;
                           _loc38_.parent = _loc39_;
                           _loc39_ = _loc38_;
                           _loc38_ = _loc40_;
                        }
                        while(_loc39_ != null)
                        {
                           _loc40_ = _loc39_.parent;
                           _loc39_.parent = _loc38_;
                           _loc39_ = _loc40_;
                        }
                        §§push(_loc38_);
                     }
                     _loc37_ = §§pop();
                     if(!_loc37_.out)
                     {
                        _loc37_.out = true;
                        ZPP_MarchingSquares.me.output(param9,_loc28_.p2);
                     }
                  }
                  _loc35_ = _loc28_;
                  _loc35_.free();
                  _loc35_.next = ZPP_MarchPair.zpp_pool;
                  ZPP_MarchPair.zpp_pool = _loc35_;
                  _loc15_.set(_loc21_,_loc18_,null);
               }
            }
         }
      }
      
      public function ylerp(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Function, param7:int) : Number
      {
         var _loc9_:Number = NaN;
         var _loc8_:Number = Number(lerp(param1,param2,param4,param5));
         while(true)
         {
            param7--;
            if(param7 != 0 && param1 < _loc8_ && _loc8_ < param2)
            {
               _loc9_ = Number(param6(param3,_loc8_));
               if(_loc9_ != 0)
               {
                  if(param4 * _loc9_ < 0)
                  {
                     param2 = _loc8_;
                     param5 = _loc9_;
                  }
                  else
                  {
                     param1 = _loc8_;
                     param4 = _loc9_;
                  }
                  _loc8_ = Number(lerp(param1,param2,param4,param5));
                  continue;
               }
               break;
            }
            break;
         }
         return _loc8_;
      }
      
      public function xlerp(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Function, param7:int) : Number
      {
         var _loc9_:Number = NaN;
         var _loc8_:Number = Number(lerp(param1,param2,param4,param5));
         while(true)
         {
            param7--;
            if(param7 != 0 && param1 < _loc8_ && _loc8_ < param2)
            {
               _loc9_ = Number(param6(_loc8_,param3));
               if(_loc9_ != 0)
               {
                  if(param4 * _loc9_ < 0)
                  {
                     param2 = _loc8_;
                     param5 = _loc9_;
                  }
                  else
                  {
                     param1 = _loc8_;
                     param4 = _loc9_;
                  }
                  _loc8_ = Number(lerp(param1,param2,param4,param5));
                  continue;
               }
               break;
            }
            break;
         }
         return _loc8_;
      }
      
      public function output(param1:GeomPolyList, param2:ZPP_GeomVert) : void
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:Boolean = false;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:* = null as ZPP_GeomVert;
         var _loc10_:* = null as ZPP_GeomVert;
         var _loc3_:ZPP_GeomVert = param2;
         while(true)
         {
            _loc4_ = _loc3_.prev;
            if(_loc4_ == _loc3_)
            {
               break;
            }
            if(_loc4_.x == _loc3_.x && _loc4_.y == _loc3_.y)
            {
               _loc6_ = _loc3_.forced || _loc4_.forced;
               if(_loc4_ == param2)
               {
                  param2 = param2.prev;
               }
               if(_loc4_ != null && _loc4_.prev == _loc4_)
               {
                  _loc5_ = null;
                  _loc4_.prev = _loc5_;
                  _loc4_.next = _loc5_;
                  _loc4_ = null;
               }
               else
               {
                  _loc4_.prev.next = _loc4_.next;
                  _loc4_.next.prev = _loc4_.prev;
                  _loc5_ = null;
                  _loc4_.prev = _loc5_;
                  _loc4_.next = _loc5_;
               }
               _loc3_.forced = true;
            }
            _loc3_ = _loc3_.next;
            if(_loc3_ == param2)
            {
               if(param2 == null || param2.next == param2 || param2.next == param2.prev)
               {
                  §§push(true);
               }
               else
               {
                  _loc8_ = 0;
                  _loc4_ = param2;
                  _loc5_ = param2;
                  if(_loc4_ != null)
                  {
                     _loc9_ = _loc4_;
                     do
                     {
                        _loc10_ = _loc9_;
                        _loc8_ = Number(_loc8_ + _loc10_.x * (_loc10_.next.y - _loc10_.prev.y));
                        _loc9_ = _loc9_.next;
                     }
                     while(_loc9_ != _loc5_);
                     
                  }
                  _loc7_ = _loc8_;
                  §§push(_loc7_ * _loc7_ < 1.0e-8 * 1.0e-8);
               }
               while(param2 != null)
               {
                  if(param2 != null && param2.prev == param2)
                  {
                     _loc4_ = null;
                     param2.prev = _loc4_;
                     param2.next = _loc4_;
                     param2 = null;
                     §§push(param2);
                  }
                  else
                  {
                     _loc4_ = param2.next;
                     param2.prev.next = param2.next;
                     param2.next.prev = param2.prev;
                     _loc5_ = null;
                     param2.prev = _loc5_;
                     param2.next = _loc5_;
                     param2 = null;
                     §§push(_loc4_);
                  }
                  param2 = §§pop();
               }
               return;
            }
         }
         if(_loc3_ != null && _loc3_.prev == _loc3_)
         {
            _loc5_ = null;
            _loc3_.prev = _loc5_;
            _loc3_.next = _loc5_;
            _loc3_ = null;
         }
         else
         {
            _loc3_.prev.next = _loc3_.next;
            _loc3_.next.prev = _loc3_.prev;
            _loc5_ = null;
            _loc3_.prev = _loc5_;
            _loc3_.next = _loc5_;
         }
      }
      
      public function marchSquare(param1:Function, param2:Array2, param3:Array2, param4:Number, param5:Number, param6:Number, param7:Number, param8:int, param9:int, param10:Boolean, param11:Boolean, param12:Boolean, param13:Boolean, param14:int) : ZPP_MarchPair
      {
         var _loc20_:* = null as ZPP_MarchPair;
         var _loc21_:* = 0;
         var _loc22_:* = 0;
         var _loc23_:int = 0;
         var _loc24_:* = null as ZPP_GeomVert;
         var _loc25_:* = null as ZPP_GeomVert;
         var _loc26_:* = null as ZPP_GeomVert;
         var _loc27_:* = false;
         var _loc28_:int = 0;
         var _loc15_:* = 0;
         var _loc16_:Number = Number(param2.get(param8,param9));
         if(_loc16_ < 0)
         {
            _loc15_ = _loc15_ | 8;
         }
         var _loc17_:Number = Number(param2.get(param8 + 1,param9));
         if(_loc17_ < 0)
         {
            _loc15_ = _loc15_ | 4;
         }
         var _loc18_:Number = Number(param2.get(param8 + 1,param9 + 1));
         if(_loc18_ < 0)
         {
            _loc15_ = _loc15_ | 2;
         }
         var _loc19_:Number = Number(param2.get(param8,param9 + 1));
         if(_loc19_ < 0)
         {
            _loc15_ = _loc15_ | 1;
         }
         if(_loc15_ == 0)
         {
            return null;
         }
         if(ZPP_MarchPair.zpp_pool == null)
         {
            _loc20_ = new ZPP_MarchPair();
         }
         else
         {
            _loc20_ = ZPP_MarchPair.zpp_pool;
            ZPP_MarchPair.zpp_pool = _loc20_.next;
            _loc20_.next = null;
         }
         _loc20_.alloc();
         if(_loc15_ != 10 && _loc15_ != 5)
         {
            _loc21_ = int(ZPP_MarchingSquares.look_march[_loc15_]);
            _loc20_.okey1 = _loc21_;
            _loc22_ = 0;
            while(_loc22_ < 8)
            {
               _loc22_++;
               _loc23_ = _loc22_;
               if((_loc21_ & 1 << _loc23_) != 0)
               {
                  _loc24_ = null;
                  if(_loc23_ == 0)
                  {
                     _loc24_ = ZPP_GeomVert.get(param4,param5);
                     if(param10 || param11)
                     {
                        _loc24_.forced = true;
                     }
                  }
                  else if(_loc23_ == 2)
                  {
                     _loc24_ = ZPP_GeomVert.get(param6,param5);
                     if(param12 || param11)
                     {
                        _loc24_.forced = true;
                     }
                  }
                  else if(_loc23_ == 4)
                  {
                     _loc24_ = ZPP_GeomVert.get(param6,param7);
                     if(param12 || param13)
                     {
                        _loc24_.forced = true;
                     }
                  }
                  else if(_loc23_ == 6)
                  {
                     _loc24_ = ZPP_GeomVert.get(param4,param7);
                     if(param10 || param13)
                     {
                        _loc24_.forced = true;
                     }
                  }
                  else if(_loc23_ == 1)
                  {
                     _loc24_ = param3.get(param8,param9 << 1);
                     if(_loc24_ == null)
                     {
                        _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param5,_loc16_,_loc17_,param1,param14)),param5);
                        param3.set(param8,param9 << 1,_loc24_);
                     }
                     else
                     {
                        _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                     }
                     if(param11)
                     {
                        _loc24_.forced = true;
                     }
                     if(_loc24_.x == param4 || _loc24_.x == param6)
                     {
                        if(_loc24_.x == param4 && (_loc21_ & 1) != 0 || _loc24_.x == param6 && (_loc21_ & 4) != 0)
                        {
                           _loc21_ = _loc21_ ^ 2;
                        }
                     }
                  }
                  else if(_loc23_ == 5)
                  {
                     _loc24_ = param3.get(param8,(param9 << 1) + 2);
                     if(_loc24_ == null)
                     {
                        _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param7,_loc19_,_loc18_,param1,param14)),param7);
                        param3.set(param8,(param9 << 1) + 2,_loc24_);
                     }
                     else
                     {
                        _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                     }
                     if(param13)
                     {
                        _loc24_.forced = true;
                     }
                     if(_loc24_.x == param4 || _loc24_.x == param6)
                     {
                        if(_loc24_.x == param4 && (_loc21_ & 64) != 0 || _loc24_.x == param6 && (_loc21_ & 16) != 0)
                        {
                           _loc21_ = _loc21_ ^ 32;
                        }
                     }
                  }
                  else if(_loc23_ == 3)
                  {
                     _loc24_ = param3.get(param8 + 1,(param9 << 1) + 1);
                     if(_loc24_ == null)
                     {
                        _loc24_ = ZPP_GeomVert.get(param6,Number(ylerp(param5,param7,param6,_loc17_,_loc18_,param1,param14)));
                        param3.set(param8 + 1,(param9 << 1) + 1,_loc24_);
                     }
                     else
                     {
                        _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                     }
                     if(param12)
                     {
                        _loc24_.forced = true;
                     }
                     if(_loc24_.y == param5 || _loc24_.y == param7)
                     {
                        if(_loc24_.y == param5 && (_loc21_ & 4) != 0 || _loc24_.y == param7 && (_loc21_ & 16) != 0)
                        {
                           _loc21_ = _loc21_ ^ 8;
                        }
                     }
                  }
                  else
                  {
                     _loc24_ = param3.get(param8,(param9 << 1) + 1);
                     if(_loc24_ == null)
                     {
                        _loc24_ = ZPP_GeomVert.get(param4,Number(ylerp(param5,param7,param4,_loc16_,_loc19_,param1,param14)));
                        param3.set(param8,(param9 << 1) + 1,_loc24_);
                     }
                     else
                     {
                        _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                     }
                     if(param10)
                     {
                        _loc24_.forced = true;
                     }
                     if(_loc24_.y == param5 || _loc24_.y == param7)
                     {
                        if(_loc24_.y == param5 && (_loc21_ & 1) != 0 || _loc24_.y == param7 && (_loc21_ & 64) != 0)
                        {
                           _loc21_ = _loc21_ ^ 128;
                        }
                     }
                  }
                  _loc25_ = _loc24_;
                  §§push(_loc20_);
                  if(_loc20_.p1 == null)
                  {
                     _loc26_ = _loc25_;
                     _loc25_.next = _loc26_;
                     _loc26_ = _loc26_;
                     _loc25_.prev = _loc26_;
                     _loc20_.p1 = _loc26_;
                  }
                  else
                  {
                     _loc25_.prev = _loc20_.p1;
                     _loc25_.next = _loc20_.p1.next;
                     _loc20_.p1.next.prev = _loc25_;
                     _loc20_.p1.next = _loc25_;
                  }
                  §§pop().p1 = _loc25_;
               }
            }
            _loc20_.p1 = _loc20_.p1.next;
            _loc20_.key1 = _loc21_;
            if(_loc21_ == 1 || _loc21_ == 4 || _loc21_ == 16 || _loc21_ == 64 || _loc21_ == 3 || _loc21_ == 12 || _loc21_ == 48 || _loc21_ == 192 || _loc21_ == 129 || _loc21_ == 6 || _loc21_ == 24 || _loc21_ == 96 || _loc21_ == 5 || _loc21_ == 20 || _loc21_ == 80 || _loc21_ == 65 || _loc21_ == 17 || _loc21_ == 68)
            {
               _loc21_ = 0;
               _loc20_.key1 = 0;
               _loc20_.p1 = null;
            }
            if(_loc21_ == 0)
            {
               _loc20_ = null;
            }
            else
            {
               _loc20_.pr = _loc20_.p1;
               _loc20_.okeyr = _loc20_.okey1;
               _loc20_.keyr = _loc20_.key1;
            }
         }
         else
         {
            _loc27_ = Number(param1(0.5 * (param4 + param6),0.5 * (param5 + param7))) < 0;
            if(_loc15_ == 10)
            {
               if(_loc27_)
               {
                  _loc21_ = 187;
                  _loc20_.okey1 = _loc21_;
                  _loc22_ = 0;
                  while(_loc22_ < 8)
                  {
                     _loc22_++;
                     _loc23_ = _loc22_;
                     if((_loc21_ & 1 << _loc23_) != 0)
                     {
                        _loc24_ = null;
                        if(_loc23_ == 0)
                        {
                           _loc24_ = ZPP_GeomVert.get(param4,param5);
                           if(param10 || param11)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc23_ == 2)
                        {
                           _loc24_ = ZPP_GeomVert.get(param6,param5);
                           if(param12 || param11)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc23_ == 4)
                        {
                           _loc24_ = ZPP_GeomVert.get(param6,param7);
                           if(param12 || param13)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc23_ == 6)
                        {
                           _loc24_ = ZPP_GeomVert.get(param4,param7);
                           if(param10 || param13)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc23_ == 1)
                        {
                           _loc24_ = param3.get(param8,param9 << 1);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param5,_loc16_,_loc17_,param1,param14)),param5);
                              param3.set(param8,param9 << 1,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param11)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.x == param4 || _loc24_.x == param6)
                           {
                              if(_loc24_.x == param4 && (_loc21_ & 1) != 0 || _loc24_.x == param6 && (_loc21_ & 4) != 0)
                              {
                                 _loc21_ = _loc21_ ^ 2;
                              }
                           }
                        }
                        else if(_loc23_ == 5)
                        {
                           _loc24_ = param3.get(param8,(param9 << 1) + 2);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param7,_loc19_,_loc18_,param1,param14)),param7);
                              param3.set(param8,(param9 << 1) + 2,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param13)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.x == param4 || _loc24_.x == param6)
                           {
                              if(_loc24_.x == param4 && (_loc21_ & 64) != 0 || _loc24_.x == param6 && (_loc21_ & 16) != 0)
                              {
                                 _loc21_ = _loc21_ ^ 32;
                              }
                           }
                        }
                        else if(_loc23_ == 3)
                        {
                           _loc24_ = param3.get(param8 + 1,(param9 << 1) + 1);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(param6,Number(ylerp(param5,param7,param6,_loc17_,_loc18_,param1,param14)));
                              param3.set(param8 + 1,(param9 << 1) + 1,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param12)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.y == param5 || _loc24_.y == param7)
                           {
                              if(_loc24_.y == param5 && (_loc21_ & 4) != 0 || _loc24_.y == param7 && (_loc21_ & 16) != 0)
                              {
                                 _loc21_ = _loc21_ ^ 8;
                              }
                           }
                        }
                        else
                        {
                           _loc24_ = param3.get(param8,(param9 << 1) + 1);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(param4,Number(ylerp(param5,param7,param4,_loc16_,_loc19_,param1,param14)));
                              param3.set(param8,(param9 << 1) + 1,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param10)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.y == param5 || _loc24_.y == param7)
                           {
                              if(_loc24_.y == param5 && (_loc21_ & 1) != 0 || _loc24_.y == param7 && (_loc21_ & 64) != 0)
                              {
                                 _loc21_ = _loc21_ ^ 128;
                              }
                           }
                        }
                        _loc25_ = _loc24_;
                        §§push(_loc20_);
                        if(_loc20_.p1 == null)
                        {
                           _loc26_ = _loc25_;
                           _loc25_.next = _loc26_;
                           _loc26_ = _loc26_;
                           _loc25_.prev = _loc26_;
                           _loc20_.p1 = _loc26_;
                        }
                        else
                        {
                           _loc25_.prev = _loc20_.p1;
                           _loc25_.next = _loc20_.p1.next;
                           _loc20_.p1.next.prev = _loc25_;
                           _loc20_.p1.next = _loc25_;
                        }
                        §§pop().p1 = _loc25_;
                     }
                  }
                  _loc20_.p1 = _loc20_.p1.next;
                  _loc20_.key1 = _loc21_;
                  if(_loc21_ == 1 || _loc21_ == 4 || _loc21_ == 16 || _loc21_ == 64 || _loc21_ == 3 || _loc21_ == 12 || _loc21_ == 48 || _loc21_ == 192 || _loc21_ == 129 || _loc21_ == 6 || _loc21_ == 24 || _loc21_ == 96 || _loc21_ == 5 || _loc21_ == 20 || _loc21_ == 80 || _loc21_ == 65 || _loc21_ == 17 || _loc21_ == 68)
                  {
                     _loc21_ = 0;
                     _loc20_.key1 = 0;
                     _loc20_.p1 = null;
                  }
                  if(_loc21_ == 0)
                  {
                     _loc20_ = null;
                  }
                  else
                  {
                     _loc20_.pr = _loc20_.p1;
                     _loc20_.okeyr = _loc20_.okey1;
                     _loc20_.keyr = _loc20_.key1;
                  }
               }
               else
               {
                  _loc21_ = 131;
                  _loc20_.okey1 = _loc21_;
                  _loc22_ = 0;
                  while(_loc22_ < 8)
                  {
                     _loc22_++;
                     _loc23_ = _loc22_;
                     if((_loc21_ & 1 << _loc23_) != 0)
                     {
                        _loc24_ = null;
                        if(_loc23_ == 0)
                        {
                           _loc24_ = ZPP_GeomVert.get(param4,param5);
                           if(param10 || param11)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc23_ == 2)
                        {
                           _loc24_ = ZPP_GeomVert.get(param6,param5);
                           if(param12 || param11)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc23_ == 4)
                        {
                           _loc24_ = ZPP_GeomVert.get(param6,param7);
                           if(param12 || param13)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc23_ == 6)
                        {
                           _loc24_ = ZPP_GeomVert.get(param4,param7);
                           if(param10 || param13)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc23_ == 1)
                        {
                           _loc24_ = param3.get(param8,param9 << 1);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param5,_loc16_,_loc17_,param1,param14)),param5);
                              param3.set(param8,param9 << 1,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param11)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.x == param4 || _loc24_.x == param6)
                           {
                              if(_loc24_.x == param4 && (_loc21_ & 1) != 0 || _loc24_.x == param6 && (_loc21_ & 4) != 0)
                              {
                                 _loc21_ = _loc21_ ^ 2;
                              }
                           }
                        }
                        else if(_loc23_ == 5)
                        {
                           _loc24_ = param3.get(param8,(param9 << 1) + 2);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param7,_loc19_,_loc18_,param1,param14)),param7);
                              param3.set(param8,(param9 << 1) + 2,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param13)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.x == param4 || _loc24_.x == param6)
                           {
                              if(_loc24_.x == param4 && (_loc21_ & 64) != 0 || _loc24_.x == param6 && (_loc21_ & 16) != 0)
                              {
                                 _loc21_ = _loc21_ ^ 32;
                              }
                           }
                        }
                        else if(_loc23_ == 3)
                        {
                           _loc24_ = param3.get(param8 + 1,(param9 << 1) + 1);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(param6,Number(ylerp(param5,param7,param6,_loc17_,_loc18_,param1,param14)));
                              param3.set(param8 + 1,(param9 << 1) + 1,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param12)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.y == param5 || _loc24_.y == param7)
                           {
                              if(_loc24_.y == param5 && (_loc21_ & 4) != 0 || _loc24_.y == param7 && (_loc21_ & 16) != 0)
                              {
                                 _loc21_ = _loc21_ ^ 8;
                              }
                           }
                        }
                        else
                        {
                           _loc24_ = param3.get(param8,(param9 << 1) + 1);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(param4,Number(ylerp(param5,param7,param4,_loc16_,_loc19_,param1,param14)));
                              param3.set(param8,(param9 << 1) + 1,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param10)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.y == param5 || _loc24_.y == param7)
                           {
                              if(_loc24_.y == param5 && (_loc21_ & 1) != 0 || _loc24_.y == param7 && (_loc21_ & 64) != 0)
                              {
                                 _loc21_ = _loc21_ ^ 128;
                              }
                           }
                        }
                        _loc25_ = _loc24_;
                        §§push(_loc20_);
                        if(_loc20_.p1 == null)
                        {
                           _loc26_ = _loc25_;
                           _loc25_.next = _loc26_;
                           _loc26_ = _loc26_;
                           _loc25_.prev = _loc26_;
                           _loc20_.p1 = _loc26_;
                        }
                        else
                        {
                           _loc25_.prev = _loc20_.p1;
                           _loc25_.next = _loc20_.p1.next;
                           _loc20_.p1.next.prev = _loc25_;
                           _loc20_.p1.next = _loc25_;
                        }
                        §§pop().p1 = _loc25_;
                     }
                  }
                  _loc20_.p1 = _loc20_.p1.next;
                  _loc20_.key1 = _loc21_;
                  if(_loc21_ == 1 || _loc21_ == 4 || _loc21_ == 16 || _loc21_ == 64 || _loc21_ == 3 || _loc21_ == 12 || _loc21_ == 48 || _loc21_ == 192 || _loc21_ == 129 || _loc21_ == 6 || _loc21_ == 24 || _loc21_ == 96 || _loc21_ == 5 || _loc21_ == 20 || _loc21_ == 80 || _loc21_ == 65 || _loc21_ == 17 || _loc21_ == 68)
                  {
                     _loc21_ = 0;
                     _loc20_.key1 = 0;
                     _loc20_.p1 = null;
                  }
                  if(_loc21_ != 0)
                  {
                     _loc22_ = 56;
                     _loc20_.okey2 = _loc22_;
                     _loc23_ = 0;
                     while(_loc23_ < 8)
                     {
                        _loc23_++;
                        _loc28_ = _loc23_;
                        if((_loc22_ & 1 << _loc28_) != 0)
                        {
                           _loc24_ = null;
                           if(_loc28_ == 0)
                           {
                              _loc24_ = ZPP_GeomVert.get(param4,param5);
                              if(param10 || param11)
                              {
                                 _loc24_.forced = true;
                              }
                           }
                           else if(_loc28_ == 2)
                           {
                              _loc24_ = ZPP_GeomVert.get(param6,param5);
                              if(param12 || param11)
                              {
                                 _loc24_.forced = true;
                              }
                           }
                           else if(_loc28_ == 4)
                           {
                              _loc24_ = ZPP_GeomVert.get(param6,param7);
                              if(param12 || param13)
                              {
                                 _loc24_.forced = true;
                              }
                           }
                           else if(_loc28_ == 6)
                           {
                              _loc24_ = ZPP_GeomVert.get(param4,param7);
                              if(param10 || param13)
                              {
                                 _loc24_.forced = true;
                              }
                           }
                           else if(_loc28_ == 1)
                           {
                              _loc24_ = param3.get(param8,param9 << 1);
                              if(_loc24_ == null)
                              {
                                 _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param5,_loc16_,_loc17_,param1,param14)),param5);
                                 param3.set(param8,param9 << 1,_loc24_);
                              }
                              else
                              {
                                 _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                              }
                              if(param11)
                              {
                                 _loc24_.forced = true;
                              }
                              if(_loc24_.x == param4 || _loc24_.x == param6)
                              {
                                 if(_loc24_.x == param4 && (_loc22_ & 1) != 0 || _loc24_.x == param6 && (_loc22_ & 4) != 0)
                                 {
                                    _loc22_ = _loc22_ ^ 2;
                                 }
                              }
                           }
                           else if(_loc28_ == 5)
                           {
                              _loc24_ = param3.get(param8,(param9 << 1) + 2);
                              if(_loc24_ == null)
                              {
                                 _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param7,_loc19_,_loc18_,param1,param14)),param7);
                                 param3.set(param8,(param9 << 1) + 2,_loc24_);
                              }
                              else
                              {
                                 _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                              }
                              if(param13)
                              {
                                 _loc24_.forced = true;
                              }
                              if(_loc24_.x == param4 || _loc24_.x == param6)
                              {
                                 if(_loc24_.x == param4 && (_loc22_ & 64) != 0 || _loc24_.x == param6 && (_loc22_ & 16) != 0)
                                 {
                                    _loc22_ = _loc22_ ^ 32;
                                 }
                              }
                           }
                           else if(_loc28_ == 3)
                           {
                              _loc24_ = param3.get(param8 + 1,(param9 << 1) + 1);
                              if(_loc24_ == null)
                              {
                                 _loc24_ = ZPP_GeomVert.get(param6,Number(ylerp(param5,param7,param6,_loc17_,_loc18_,param1,param14)));
                                 param3.set(param8 + 1,(param9 << 1) + 1,_loc24_);
                              }
                              else
                              {
                                 _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                              }
                              if(param12)
                              {
                                 _loc24_.forced = true;
                              }
                              if(_loc24_.y == param5 || _loc24_.y == param7)
                              {
                                 if(_loc24_.y == param5 && (_loc22_ & 4) != 0 || _loc24_.y == param7 && (_loc22_ & 16) != 0)
                                 {
                                    _loc22_ = _loc22_ ^ 8;
                                 }
                              }
                           }
                           else
                           {
                              _loc24_ = param3.get(param8,(param9 << 1) + 1);
                              if(_loc24_ == null)
                              {
                                 _loc24_ = ZPP_GeomVert.get(param4,Number(ylerp(param5,param7,param4,_loc16_,_loc19_,param1,param14)));
                                 param3.set(param8,(param9 << 1) + 1,_loc24_);
                              }
                              else
                              {
                                 _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                              }
                              if(param10)
                              {
                                 _loc24_.forced = true;
                              }
                              if(_loc24_.y == param5 || _loc24_.y == param7)
                              {
                                 if(_loc24_.y == param5 && (_loc22_ & 1) != 0 || _loc24_.y == param7 && (_loc22_ & 64) != 0)
                                 {
                                    _loc22_ = _loc22_ ^ 128;
                                 }
                              }
                           }
                           _loc25_ = _loc24_;
                           §§push(_loc20_);
                           if(_loc20_.p2 == null)
                           {
                              _loc26_ = _loc25_;
                              _loc25_.next = _loc26_;
                              _loc26_ = _loc26_;
                              _loc25_.prev = _loc26_;
                              _loc20_.p2 = _loc26_;
                           }
                           else
                           {
                              _loc25_.prev = _loc20_.p2;
                              _loc25_.next = _loc20_.p2.next;
                              _loc20_.p2.next.prev = _loc25_;
                              _loc20_.p2.next = _loc25_;
                           }
                           §§pop().p2 = _loc25_;
                        }
                     }
                     _loc20_.p2 = _loc20_.p2.next;
                     _loc20_.key2 = _loc22_;
                     if(_loc22_ == 1 || _loc22_ == 4 || _loc22_ == 16 || _loc22_ == 64 || _loc22_ == 3 || _loc22_ == 12 || _loc22_ == 48 || _loc22_ == 192 || _loc22_ == 129 || _loc22_ == 6 || _loc22_ == 24 || _loc22_ == 96 || _loc22_ == 5 || _loc22_ == 20 || _loc22_ == 80 || _loc22_ == 65 || _loc22_ == 17 || _loc22_ == 68)
                     {
                        _loc22_ = 0;
                        _loc20_.key2 = 0;
                        _loc20_.p2 = null;
                     }
                     if(_loc22_ == 0)
                     {
                        _loc20_.pr = _loc20_.p1;
                        _loc20_.okeyr = _loc20_.okey1;
                        _loc20_.keyr = _loc20_.key1;
                     }
                     else
                     {
                        _loc20_.pr = _loc20_.p2;
                        _loc20_.okeyr = _loc20_.okey2;
                        _loc20_.keyr = _loc20_.key2;
                     }
                  }
                  else
                  {
                     _loc22_ = 56;
                     _loc20_.okey1 = _loc22_;
                     _loc23_ = 0;
                     while(_loc23_ < 8)
                     {
                        _loc23_++;
                        _loc28_ = _loc23_;
                        if((_loc22_ & 1 << _loc28_) != 0)
                        {
                           _loc24_ = null;
                           if(_loc28_ == 0)
                           {
                              _loc24_ = ZPP_GeomVert.get(param4,param5);
                              if(param10 || param11)
                              {
                                 _loc24_.forced = true;
                              }
                           }
                           else if(_loc28_ == 2)
                           {
                              _loc24_ = ZPP_GeomVert.get(param6,param5);
                              if(param12 || param11)
                              {
                                 _loc24_.forced = true;
                              }
                           }
                           else if(_loc28_ == 4)
                           {
                              _loc24_ = ZPP_GeomVert.get(param6,param7);
                              if(param12 || param13)
                              {
                                 _loc24_.forced = true;
                              }
                           }
                           else if(_loc28_ == 6)
                           {
                              _loc24_ = ZPP_GeomVert.get(param4,param7);
                              if(param10 || param13)
                              {
                                 _loc24_.forced = true;
                              }
                           }
                           else if(_loc28_ == 1)
                           {
                              _loc24_ = param3.get(param8,param9 << 1);
                              if(_loc24_ == null)
                              {
                                 _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param5,_loc16_,_loc17_,param1,param14)),param5);
                                 param3.set(param8,param9 << 1,_loc24_);
                              }
                              else
                              {
                                 _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                              }
                              if(param11)
                              {
                                 _loc24_.forced = true;
                              }
                              if(_loc24_.x == param4 || _loc24_.x == param6)
                              {
                                 if(_loc24_.x == param4 && (_loc22_ & 1) != 0 || _loc24_.x == param6 && (_loc22_ & 4) != 0)
                                 {
                                    _loc22_ = _loc22_ ^ 2;
                                 }
                              }
                           }
                           else if(_loc28_ == 5)
                           {
                              _loc24_ = param3.get(param8,(param9 << 1) + 2);
                              if(_loc24_ == null)
                              {
                                 _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param7,_loc19_,_loc18_,param1,param14)),param7);
                                 param3.set(param8,(param9 << 1) + 2,_loc24_);
                              }
                              else
                              {
                                 _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                              }
                              if(param13)
                              {
                                 _loc24_.forced = true;
                              }
                              if(_loc24_.x == param4 || _loc24_.x == param6)
                              {
                                 if(_loc24_.x == param4 && (_loc22_ & 64) != 0 || _loc24_.x == param6 && (_loc22_ & 16) != 0)
                                 {
                                    _loc22_ = _loc22_ ^ 32;
                                 }
                              }
                           }
                           else if(_loc28_ == 3)
                           {
                              _loc24_ = param3.get(param8 + 1,(param9 << 1) + 1);
                              if(_loc24_ == null)
                              {
                                 _loc24_ = ZPP_GeomVert.get(param6,Number(ylerp(param5,param7,param6,_loc17_,_loc18_,param1,param14)));
                                 param3.set(param8 + 1,(param9 << 1) + 1,_loc24_);
                              }
                              else
                              {
                                 _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                              }
                              if(param12)
                              {
                                 _loc24_.forced = true;
                              }
                              if(_loc24_.y == param5 || _loc24_.y == param7)
                              {
                                 if(_loc24_.y == param5 && (_loc22_ & 4) != 0 || _loc24_.y == param7 && (_loc22_ & 16) != 0)
                                 {
                                    _loc22_ = _loc22_ ^ 8;
                                 }
                              }
                           }
                           else
                           {
                              _loc24_ = param3.get(param8,(param9 << 1) + 1);
                              if(_loc24_ == null)
                              {
                                 _loc24_ = ZPP_GeomVert.get(param4,Number(ylerp(param5,param7,param4,_loc16_,_loc19_,param1,param14)));
                                 param3.set(param8,(param9 << 1) + 1,_loc24_);
                              }
                              else
                              {
                                 _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                              }
                              if(param10)
                              {
                                 _loc24_.forced = true;
                              }
                              if(_loc24_.y == param5 || _loc24_.y == param7)
                              {
                                 if(_loc24_.y == param5 && (_loc22_ & 1) != 0 || _loc24_.y == param7 && (_loc22_ & 64) != 0)
                                 {
                                    _loc22_ = _loc22_ ^ 128;
                                 }
                              }
                           }
                           _loc25_ = _loc24_;
                           §§push(_loc20_);
                           if(_loc20_.p1 == null)
                           {
                              _loc26_ = _loc25_;
                              _loc25_.next = _loc26_;
                              _loc26_ = _loc26_;
                              _loc25_.prev = _loc26_;
                              _loc20_.p1 = _loc26_;
                           }
                           else
                           {
                              _loc25_.prev = _loc20_.p1;
                              _loc25_.next = _loc20_.p1.next;
                              _loc20_.p1.next.prev = _loc25_;
                              _loc20_.p1.next = _loc25_;
                           }
                           §§pop().p1 = _loc25_;
                        }
                     }
                     _loc20_.p1 = _loc20_.p1.next;
                     _loc20_.key1 = _loc22_;
                     if(_loc22_ == 1 || _loc22_ == 4 || _loc22_ == 16 || _loc22_ == 64 || _loc22_ == 3 || _loc22_ == 12 || _loc22_ == 48 || _loc22_ == 192 || _loc22_ == 129 || _loc22_ == 6 || _loc22_ == 24 || _loc22_ == 96 || _loc22_ == 5 || _loc22_ == 20 || _loc22_ == 80 || _loc22_ == 65 || _loc22_ == 17 || _loc22_ == 68)
                     {
                        _loc22_ = 0;
                        _loc20_.key1 = 0;
                        _loc20_.p1 = null;
                     }
                     if(_loc22_ == 0)
                     {
                        _loc20_ = null;
                     }
                     else
                     {
                        _loc20_.pr = _loc20_.p1;
                        _loc20_.okeyr = _loc20_.okey1;
                        _loc20_.keyr = _loc20_.key1;
                     }
                  }
               }
            }
            else if(_loc27_)
            {
               _loc21_ = 238;
               _loc20_.okey1 = _loc21_;
               _loc22_ = 0;
               while(_loc22_ < 8)
               {
                  _loc22_++;
                  _loc23_ = _loc22_;
                  if((_loc21_ & 1 << _loc23_) != 0)
                  {
                     _loc24_ = null;
                     if(_loc23_ == 0)
                     {
                        _loc24_ = ZPP_GeomVert.get(param4,param5);
                        if(param10 || param11)
                        {
                           _loc24_.forced = true;
                        }
                     }
                     else if(_loc23_ == 2)
                     {
                        _loc24_ = ZPP_GeomVert.get(param6,param5);
                        if(param12 || param11)
                        {
                           _loc24_.forced = true;
                        }
                     }
                     else if(_loc23_ == 4)
                     {
                        _loc24_ = ZPP_GeomVert.get(param6,param7);
                        if(param12 || param13)
                        {
                           _loc24_.forced = true;
                        }
                     }
                     else if(_loc23_ == 6)
                     {
                        _loc24_ = ZPP_GeomVert.get(param4,param7);
                        if(param10 || param13)
                        {
                           _loc24_.forced = true;
                        }
                     }
                     else if(_loc23_ == 1)
                     {
                        _loc24_ = param3.get(param8,param9 << 1);
                        if(_loc24_ == null)
                        {
                           _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param5,_loc16_,_loc17_,param1,param14)),param5);
                           param3.set(param8,param9 << 1,_loc24_);
                        }
                        else
                        {
                           _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                        }
                        if(param11)
                        {
                           _loc24_.forced = true;
                        }
                        if(_loc24_.x == param4 || _loc24_.x == param6)
                        {
                           if(_loc24_.x == param4 && (_loc21_ & 1) != 0 || _loc24_.x == param6 && (_loc21_ & 4) != 0)
                           {
                              _loc21_ = _loc21_ ^ 2;
                           }
                        }
                     }
                     else if(_loc23_ == 5)
                     {
                        _loc24_ = param3.get(param8,(param9 << 1) + 2);
                        if(_loc24_ == null)
                        {
                           _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param7,_loc19_,_loc18_,param1,param14)),param7);
                           param3.set(param8,(param9 << 1) + 2,_loc24_);
                        }
                        else
                        {
                           _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                        }
                        if(param13)
                        {
                           _loc24_.forced = true;
                        }
                        if(_loc24_.x == param4 || _loc24_.x == param6)
                        {
                           if(_loc24_.x == param4 && (_loc21_ & 64) != 0 || _loc24_.x == param6 && (_loc21_ & 16) != 0)
                           {
                              _loc21_ = _loc21_ ^ 32;
                           }
                        }
                     }
                     else if(_loc23_ == 3)
                     {
                        _loc24_ = param3.get(param8 + 1,(param9 << 1) + 1);
                        if(_loc24_ == null)
                        {
                           _loc24_ = ZPP_GeomVert.get(param6,Number(ylerp(param5,param7,param6,_loc17_,_loc18_,param1,param14)));
                           param3.set(param8 + 1,(param9 << 1) + 1,_loc24_);
                        }
                        else
                        {
                           _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                        }
                        if(param12)
                        {
                           _loc24_.forced = true;
                        }
                        if(_loc24_.y == param5 || _loc24_.y == param7)
                        {
                           if(_loc24_.y == param5 && (_loc21_ & 4) != 0 || _loc24_.y == param7 && (_loc21_ & 16) != 0)
                           {
                              _loc21_ = _loc21_ ^ 8;
                           }
                        }
                     }
                     else
                     {
                        _loc24_ = param3.get(param8,(param9 << 1) + 1);
                        if(_loc24_ == null)
                        {
                           _loc24_ = ZPP_GeomVert.get(param4,Number(ylerp(param5,param7,param4,_loc16_,_loc19_,param1,param14)));
                           param3.set(param8,(param9 << 1) + 1,_loc24_);
                        }
                        else
                        {
                           _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                        }
                        if(param10)
                        {
                           _loc24_.forced = true;
                        }
                        if(_loc24_.y == param5 || _loc24_.y == param7)
                        {
                           if(_loc24_.y == param5 && (_loc21_ & 1) != 0 || _loc24_.y == param7 && (_loc21_ & 64) != 0)
                           {
                              _loc21_ = _loc21_ ^ 128;
                           }
                        }
                     }
                     _loc25_ = _loc24_;
                     §§push(_loc20_);
                     if(_loc20_.p1 == null)
                     {
                        _loc26_ = _loc25_;
                        _loc25_.next = _loc26_;
                        _loc26_ = _loc26_;
                        _loc25_.prev = _loc26_;
                        _loc20_.p1 = _loc26_;
                     }
                     else
                     {
                        _loc25_.prev = _loc20_.p1;
                        _loc25_.next = _loc20_.p1.next;
                        _loc20_.p1.next.prev = _loc25_;
                        _loc20_.p1.next = _loc25_;
                     }
                     §§pop().p1 = _loc25_;
                  }
               }
               _loc20_.p1 = _loc20_.p1.next;
               _loc20_.key1 = _loc21_;
               if(_loc21_ == 1 || _loc21_ == 4 || _loc21_ == 16 || _loc21_ == 64 || _loc21_ == 3 || _loc21_ == 12 || _loc21_ == 48 || _loc21_ == 192 || _loc21_ == 129 || _loc21_ == 6 || _loc21_ == 24 || _loc21_ == 96 || _loc21_ == 5 || _loc21_ == 20 || _loc21_ == 80 || _loc21_ == 65 || _loc21_ == 17 || _loc21_ == 68)
               {
                  _loc21_ = 0;
                  _loc20_.key1 = 0;
                  _loc20_.p1 = null;
               }
               if(_loc21_ == 0)
               {
                  _loc20_ = null;
               }
               else
               {
                  _loc20_.pr = _loc20_.p1;
                  _loc20_.okeyr = _loc20_.okey1;
                  _loc20_.keyr = _loc20_.key1;
               }
            }
            else
            {
               _loc21_ = 224;
               _loc20_.okey1 = _loc21_;
               _loc22_ = 0;
               while(_loc22_ < 8)
               {
                  _loc22_++;
                  _loc23_ = _loc22_;
                  if((_loc21_ & 1 << _loc23_) != 0)
                  {
                     _loc24_ = null;
                     if(_loc23_ == 0)
                     {
                        _loc24_ = ZPP_GeomVert.get(param4,param5);
                        if(param10 || param11)
                        {
                           _loc24_.forced = true;
                        }
                     }
                     else if(_loc23_ == 2)
                     {
                        _loc24_ = ZPP_GeomVert.get(param6,param5);
                        if(param12 || param11)
                        {
                           _loc24_.forced = true;
                        }
                     }
                     else if(_loc23_ == 4)
                     {
                        _loc24_ = ZPP_GeomVert.get(param6,param7);
                        if(param12 || param13)
                        {
                           _loc24_.forced = true;
                        }
                     }
                     else if(_loc23_ == 6)
                     {
                        _loc24_ = ZPP_GeomVert.get(param4,param7);
                        if(param10 || param13)
                        {
                           _loc24_.forced = true;
                        }
                     }
                     else if(_loc23_ == 1)
                     {
                        _loc24_ = param3.get(param8,param9 << 1);
                        if(_loc24_ == null)
                        {
                           _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param5,_loc16_,_loc17_,param1,param14)),param5);
                           param3.set(param8,param9 << 1,_loc24_);
                        }
                        else
                        {
                           _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                        }
                        if(param11)
                        {
                           _loc24_.forced = true;
                        }
                        if(_loc24_.x == param4 || _loc24_.x == param6)
                        {
                           if(_loc24_.x == param4 && (_loc21_ & 1) != 0 || _loc24_.x == param6 && (_loc21_ & 4) != 0)
                           {
                              _loc21_ = _loc21_ ^ 2;
                           }
                        }
                     }
                     else if(_loc23_ == 5)
                     {
                        _loc24_ = param3.get(param8,(param9 << 1) + 2);
                        if(_loc24_ == null)
                        {
                           _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param7,_loc19_,_loc18_,param1,param14)),param7);
                           param3.set(param8,(param9 << 1) + 2,_loc24_);
                        }
                        else
                        {
                           _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                        }
                        if(param13)
                        {
                           _loc24_.forced = true;
                        }
                        if(_loc24_.x == param4 || _loc24_.x == param6)
                        {
                           if(_loc24_.x == param4 && (_loc21_ & 64) != 0 || _loc24_.x == param6 && (_loc21_ & 16) != 0)
                           {
                              _loc21_ = _loc21_ ^ 32;
                           }
                        }
                     }
                     else if(_loc23_ == 3)
                     {
                        _loc24_ = param3.get(param8 + 1,(param9 << 1) + 1);
                        if(_loc24_ == null)
                        {
                           _loc24_ = ZPP_GeomVert.get(param6,Number(ylerp(param5,param7,param6,_loc17_,_loc18_,param1,param14)));
                           param3.set(param8 + 1,(param9 << 1) + 1,_loc24_);
                        }
                        else
                        {
                           _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                        }
                        if(param12)
                        {
                           _loc24_.forced = true;
                        }
                        if(_loc24_.y == param5 || _loc24_.y == param7)
                        {
                           if(_loc24_.y == param5 && (_loc21_ & 4) != 0 || _loc24_.y == param7 && (_loc21_ & 16) != 0)
                           {
                              _loc21_ = _loc21_ ^ 8;
                           }
                        }
                     }
                     else
                     {
                        _loc24_ = param3.get(param8,(param9 << 1) + 1);
                        if(_loc24_ == null)
                        {
                           _loc24_ = ZPP_GeomVert.get(param4,Number(ylerp(param5,param7,param4,_loc16_,_loc19_,param1,param14)));
                           param3.set(param8,(param9 << 1) + 1,_loc24_);
                        }
                        else
                        {
                           _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                        }
                        if(param10)
                        {
                           _loc24_.forced = true;
                        }
                        if(_loc24_.y == param5 || _loc24_.y == param7)
                        {
                           if(_loc24_.y == param5 && (_loc21_ & 1) != 0 || _loc24_.y == param7 && (_loc21_ & 64) != 0)
                           {
                              _loc21_ = _loc21_ ^ 128;
                           }
                        }
                     }
                     _loc25_ = _loc24_;
                     §§push(_loc20_);
                     if(_loc20_.p1 == null)
                     {
                        _loc26_ = _loc25_;
                        _loc25_.next = _loc26_;
                        _loc26_ = _loc26_;
                        _loc25_.prev = _loc26_;
                        _loc20_.p1 = _loc26_;
                     }
                     else
                     {
                        _loc25_.prev = _loc20_.p1;
                        _loc25_.next = _loc20_.p1.next;
                        _loc20_.p1.next.prev = _loc25_;
                        _loc20_.p1.next = _loc25_;
                     }
                     §§pop().p1 = _loc25_;
                  }
               }
               _loc20_.p1 = _loc20_.p1.next;
               _loc20_.key1 = _loc21_;
               if(_loc21_ == 1 || _loc21_ == 4 || _loc21_ == 16 || _loc21_ == 64 || _loc21_ == 3 || _loc21_ == 12 || _loc21_ == 48 || _loc21_ == 192 || _loc21_ == 129 || _loc21_ == 6 || _loc21_ == 24 || _loc21_ == 96 || _loc21_ == 5 || _loc21_ == 20 || _loc21_ == 80 || _loc21_ == 65 || _loc21_ == 17 || _loc21_ == 68)
               {
                  _loc21_ = 0;
                  _loc20_.key1 = 0;
                  _loc20_.p1 = null;
               }
               if(_loc21_ != 0)
               {
                  _loc22_ = 14;
                  _loc20_.okey2 = _loc22_;
                  _loc23_ = 0;
                  while(_loc23_ < 8)
                  {
                     _loc23_++;
                     _loc28_ = _loc23_;
                     if((_loc22_ & 1 << _loc28_) != 0)
                     {
                        _loc24_ = null;
                        if(_loc28_ == 0)
                        {
                           _loc24_ = ZPP_GeomVert.get(param4,param5);
                           if(param10 || param11)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc28_ == 2)
                        {
                           _loc24_ = ZPP_GeomVert.get(param6,param5);
                           if(param12 || param11)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc28_ == 4)
                        {
                           _loc24_ = ZPP_GeomVert.get(param6,param7);
                           if(param12 || param13)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc28_ == 6)
                        {
                           _loc24_ = ZPP_GeomVert.get(param4,param7);
                           if(param10 || param13)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc28_ == 1)
                        {
                           _loc24_ = param3.get(param8,param9 << 1);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param5,_loc16_,_loc17_,param1,param14)),param5);
                              param3.set(param8,param9 << 1,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param11)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.x == param4 || _loc24_.x == param6)
                           {
                              if(_loc24_.x == param4 && (_loc22_ & 1) != 0 || _loc24_.x == param6 && (_loc22_ & 4) != 0)
                              {
                                 _loc22_ = _loc22_ ^ 2;
                              }
                           }
                        }
                        else if(_loc28_ == 5)
                        {
                           _loc24_ = param3.get(param8,(param9 << 1) + 2);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param7,_loc19_,_loc18_,param1,param14)),param7);
                              param3.set(param8,(param9 << 1) + 2,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param13)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.x == param4 || _loc24_.x == param6)
                           {
                              if(_loc24_.x == param4 && (_loc22_ & 64) != 0 || _loc24_.x == param6 && (_loc22_ & 16) != 0)
                              {
                                 _loc22_ = _loc22_ ^ 32;
                              }
                           }
                        }
                        else if(_loc28_ == 3)
                        {
                           _loc24_ = param3.get(param8 + 1,(param9 << 1) + 1);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(param6,Number(ylerp(param5,param7,param6,_loc17_,_loc18_,param1,param14)));
                              param3.set(param8 + 1,(param9 << 1) + 1,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param12)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.y == param5 || _loc24_.y == param7)
                           {
                              if(_loc24_.y == param5 && (_loc22_ & 4) != 0 || _loc24_.y == param7 && (_loc22_ & 16) != 0)
                              {
                                 _loc22_ = _loc22_ ^ 8;
                              }
                           }
                        }
                        else
                        {
                           _loc24_ = param3.get(param8,(param9 << 1) + 1);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(param4,Number(ylerp(param5,param7,param4,_loc16_,_loc19_,param1,param14)));
                              param3.set(param8,(param9 << 1) + 1,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param10)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.y == param5 || _loc24_.y == param7)
                           {
                              if(_loc24_.y == param5 && (_loc22_ & 1) != 0 || _loc24_.y == param7 && (_loc22_ & 64) != 0)
                              {
                                 _loc22_ = _loc22_ ^ 128;
                              }
                           }
                        }
                        _loc25_ = _loc24_;
                        §§push(_loc20_);
                        if(_loc20_.p2 == null)
                        {
                           _loc26_ = _loc25_;
                           _loc25_.next = _loc26_;
                           _loc26_ = _loc26_;
                           _loc25_.prev = _loc26_;
                           _loc20_.p2 = _loc26_;
                        }
                        else
                        {
                           _loc25_.prev = _loc20_.p2;
                           _loc25_.next = _loc20_.p2.next;
                           _loc20_.p2.next.prev = _loc25_;
                           _loc20_.p2.next = _loc25_;
                        }
                        §§pop().p2 = _loc25_;
                     }
                  }
                  _loc20_.p2 = _loc20_.p2.next;
                  _loc20_.key2 = _loc22_;
                  if(_loc22_ == 1 || _loc22_ == 4 || _loc22_ == 16 || _loc22_ == 64 || _loc22_ == 3 || _loc22_ == 12 || _loc22_ == 48 || _loc22_ == 192 || _loc22_ == 129 || _loc22_ == 6 || _loc22_ == 24 || _loc22_ == 96 || _loc22_ == 5 || _loc22_ == 20 || _loc22_ == 80 || _loc22_ == 65 || _loc22_ == 17 || _loc22_ == 68)
                  {
                     _loc22_ = 0;
                     _loc20_.key2 = 0;
                     _loc20_.p2 = null;
                  }
                  if(_loc22_ == 0)
                  {
                     _loc20_.pr = _loc20_.p1;
                     _loc20_.okeyr = _loc20_.okey1;
                     _loc20_.keyr = _loc20_.key1;
                  }
                  else
                  {
                     _loc20_.pr = _loc20_.p2;
                     _loc20_.okeyr = _loc20_.okey2;
                     _loc20_.keyr = _loc20_.key2;
                  }
               }
               else
               {
                  _loc22_ = 14;
                  _loc20_.okey1 = _loc22_;
                  _loc23_ = 0;
                  while(_loc23_ < 8)
                  {
                     _loc23_++;
                     _loc28_ = _loc23_;
                     if((_loc22_ & 1 << _loc28_) != 0)
                     {
                        _loc24_ = null;
                        if(_loc28_ == 0)
                        {
                           _loc24_ = ZPP_GeomVert.get(param4,param5);
                           if(param10 || param11)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc28_ == 2)
                        {
                           _loc24_ = ZPP_GeomVert.get(param6,param5);
                           if(param12 || param11)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc28_ == 4)
                        {
                           _loc24_ = ZPP_GeomVert.get(param6,param7);
                           if(param12 || param13)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc28_ == 6)
                        {
                           _loc24_ = ZPP_GeomVert.get(param4,param7);
                           if(param10 || param13)
                           {
                              _loc24_.forced = true;
                           }
                        }
                        else if(_loc28_ == 1)
                        {
                           _loc24_ = param3.get(param8,param9 << 1);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param5,_loc16_,_loc17_,param1,param14)),param5);
                              param3.set(param8,param9 << 1,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param11)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.x == param4 || _loc24_.x == param6)
                           {
                              if(_loc24_.x == param4 && (_loc22_ & 1) != 0 || _loc24_.x == param6 && (_loc22_ & 4) != 0)
                              {
                                 _loc22_ = _loc22_ ^ 2;
                              }
                           }
                        }
                        else if(_loc28_ == 5)
                        {
                           _loc24_ = param3.get(param8,(param9 << 1) + 2);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(Number(xlerp(param4,param6,param7,_loc19_,_loc18_,param1,param14)),param7);
                              param3.set(param8,(param9 << 1) + 2,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param13)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.x == param4 || _loc24_.x == param6)
                           {
                              if(_loc24_.x == param4 && (_loc22_ & 64) != 0 || _loc24_.x == param6 && (_loc22_ & 16) != 0)
                              {
                                 _loc22_ = _loc22_ ^ 32;
                              }
                           }
                        }
                        else if(_loc28_ == 3)
                        {
                           _loc24_ = param3.get(param8 + 1,(param9 << 1) + 1);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(param6,Number(ylerp(param5,param7,param6,_loc17_,_loc18_,param1,param14)));
                              param3.set(param8 + 1,(param9 << 1) + 1,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param12)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.y == param5 || _loc24_.y == param7)
                           {
                              if(_loc24_.y == param5 && (_loc22_ & 4) != 0 || _loc24_.y == param7 && (_loc22_ & 16) != 0)
                              {
                                 _loc22_ = _loc22_ ^ 8;
                              }
                           }
                        }
                        else
                        {
                           _loc24_ = param3.get(param8,(param9 << 1) + 1);
                           if(_loc24_ == null)
                           {
                              _loc24_ = ZPP_GeomVert.get(param4,Number(ylerp(param5,param7,param4,_loc16_,_loc19_,param1,param14)));
                              param3.set(param8,(param9 << 1) + 1,_loc24_);
                           }
                           else
                           {
                              _loc24_ = ZPP_GeomVert.get(_loc24_.x,_loc24_.y);
                           }
                           if(param10)
                           {
                              _loc24_.forced = true;
                           }
                           if(_loc24_.y == param5 || _loc24_.y == param7)
                           {
                              if(_loc24_.y == param5 && (_loc22_ & 1) != 0 || _loc24_.y == param7 && (_loc22_ & 64) != 0)
                              {
                                 _loc22_ = _loc22_ ^ 128;
                              }
                           }
                        }
                        _loc25_ = _loc24_;
                        §§push(_loc20_);
                        if(_loc20_.p1 == null)
                        {
                           _loc26_ = _loc25_;
                           _loc25_.next = _loc26_;
                           _loc26_ = _loc26_;
                           _loc25_.prev = _loc26_;
                           _loc20_.p1 = _loc26_;
                        }
                        else
                        {
                           _loc25_.prev = _loc20_.p1;
                           _loc25_.next = _loc20_.p1.next;
                           _loc20_.p1.next.prev = _loc25_;
                           _loc20_.p1.next = _loc25_;
                        }
                        §§pop().p1 = _loc25_;
                     }
                  }
                  _loc20_.p1 = _loc20_.p1.next;
                  _loc20_.key1 = _loc22_;
                  if(_loc22_ == 1 || _loc22_ == 4 || _loc22_ == 16 || _loc22_ == 64 || _loc22_ == 3 || _loc22_ == 12 || _loc22_ == 48 || _loc22_ == 192 || _loc22_ == 129 || _loc22_ == 6 || _loc22_ == 24 || _loc22_ == 96 || _loc22_ == 5 || _loc22_ == 20 || _loc22_ == 80 || _loc22_ == 65 || _loc22_ == 17 || _loc22_ == 68)
                  {
                     _loc22_ = 0;
                     _loc20_.key1 = 0;
                     _loc20_.p1 = null;
                  }
                  if(_loc22_ == 0)
                  {
                     _loc20_ = null;
                  }
                  else
                  {
                     _loc20_.pr = _loc20_.p1;
                     _loc20_.okeyr = _loc20_.okey1;
                     _loc20_.keyr = _loc20_.key1;
                  }
               }
            }
         }
         return _loc20_;
      }
      
      public function linkup(param1:ZPP_GeomVert, param2:int) : ZPP_GeomVert
      {
         return param1;
      }
      
      public function linkright(param1:ZPP_GeomVert, param2:int) : ZPP_GeomVert
      {
         var _loc3_:* = param2 & 7;
         if(_loc3_ == 0)
         {
            return param1;
         }
         if(_loc3_ == 3)
         {
            return param1.next.next;
         }
         return param1.next;
      }
      
      public function linkleft(param1:ZPP_GeomVert, param2:int) : ZPP_GeomVert
      {
         return (param2 & 1) == 0?param1.prev:param1;
      }
      
      public function linkdown(param1:ZPP_GeomVert, param2:int) : ZPP_GeomVert
      {
         return (param2 & 128) == 0?param1.prev:param1.prev.prev;
      }
      
      public function lerp(param1:Number, param2:Number, param3:Number, param4:Number) : Number
      {
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(param3 == 0)
         {
            return param1;
         }
         if(param4 == 0)
         {
            return param2;
         }
         _loc5_ = param3 - param4;
         _loc6_ = _loc5_ * _loc5_ < 1.0e-8?0.5:param3 / _loc5_;
         if(_loc6_ < 0)
         {
            _loc6_ = 0;
         }
         else if(_loc6_ > 1)
         {
            _loc6_ = 1;
         }
         return Number(param1 + _loc6_ * (param2 - param1));
      }
      
      public function combUp(param1:int) : Boolean
      {
         var _loc2_:* = param1 & 7;
         return Boolean(comb(_loc2_));
      }
      
      public function combUD_virtual(param1:ZPP_MarchPair, param2:ZPP_MarchPair) : void
      {
         var _loc3_:ZPP_GeomVert = param1.p2 != null && param1.key2 == 56?param1.p2:param1.p1;
         var _loc4_:ZPP_GeomVert = param2.p2 != null && param2.key2 == 14?param2.p2:param2.p1;
         var _loc5_:ZPP_GeomVert = param1.pd;
         var _loc6_:ZPP_GeomVert = linkup(_loc4_,_loc4_ == param2.p2?param2.key2:param2.key1);
         var _loc7_:ZPP_GeomVert = _loc5_.prev;
         var _loc8_:ZPP_GeomVert = _loc6_.next;
         var _loc9_:Boolean = true;
         _loc8_.forced = _loc9_;
         _loc9_ = _loc9_;
         _loc7_.forced = _loc9_;
         _loc9_ = _loc9_;
         _loc6_.forced = _loc9_;
         _loc5_.forced = _loc9_;
      }
      
      public function combUD(param1:ZPP_MarchPair, param2:ZPP_MarchPair) : void
      {
         var _loc3_:ZPP_GeomVert = param1.p2 != null && param1.key2 == 56?param1.p2:param1.p1;
         var _loc4_:ZPP_GeomVert = param2.p2 != null && param2.key2 == 14?param2.p2:param2.p1;
         var _loc5_:ZPP_GeomVert = param1.pd;
         var _loc6_:ZPP_GeomVert = linkup(_loc4_,_loc4_ == param2.p2?param2.okey2:param2.okey1);
         var _loc7_:ZPP_GeomVert = _loc5_.prev;
         var _loc8_:ZPP_GeomVert = _loc6_.next;
         _loc6_.next = _loc5_.next;
         _loc5_.next.prev = _loc6_;
         var _loc9_:ZPP_GeomVert = _loc5_;
         _loc9_.free();
         _loc9_.next = ZPP_GeomVert.zpp_pool;
         ZPP_GeomVert.zpp_pool = _loc9_;
         _loc8_.prev = _loc7_.prev;
         _loc7_.prev.next = _loc8_;
         if(_loc7_ == param1.p1)
         {
            param1.p1 = _loc8_;
         }
         _loc9_ = _loc7_;
         _loc9_.free();
         _loc9_.next = ZPP_GeomVert.zpp_pool;
         ZPP_GeomVert.zpp_pool = _loc9_;
      }
      
      public function combRight(param1:int) : Boolean
      {
         var _loc2_:* = (param1 & 28) >> 2;
         return Boolean(comb(_loc2_));
      }
      
      public function combLeft(param1:int) : Boolean
      {
         var _loc2_:* = param1 & 1 | (param1 & 192) >> 5;
         return Boolean(comb(_loc2_));
      }
      
      public function combLR(param1:ZPP_MarchPair, param2:ZPP_MarchPair) : void
      {
         var _loc7_:* = null as ZPP_GeomVert;
         var _loc3_:ZPP_GeomVert = linkright(param1.pr,param1.okeyr);
         var _loc4_:ZPP_GeomVert = linkleft(param2.p1,param2.okey1);
         var _loc5_:ZPP_GeomVert = _loc3_.next;
         var _loc6_:ZPP_GeomVert = _loc4_.prev;
         if((param1.keyr & 4) != 0)
         {
            if(param2.pr == param2.p1)
            {
               param2.pr = _loc3_.prev;
            }
            param2.p1 = _loc3_.prev;
            _loc3_.prev.next = _loc4_.next;
            _loc4_.next.prev = _loc3_.prev;
            _loc7_ = _loc3_;
            _loc7_.free();
            _loc7_.next = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc7_;
         }
         else
         {
            _loc3_.next = _loc4_.next;
            _loc4_.next.prev = _loc3_;
         }
         _loc7_ = _loc4_;
         _loc7_.free();
         _loc7_.next = ZPP_GeomVert.zpp_pool;
         ZPP_GeomVert.zpp_pool = _loc7_;
         if((param1.keyr & 16) != 0)
         {
            param2.pd = _loc5_.next;
            _loc5_.next.prev = _loc6_.prev;
            _loc6_.prev.next = _loc5_.next;
            _loc7_ = _loc5_;
            _loc7_.free();
            _loc7_.next = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc7_;
         }
         else
         {
            _loc5_.prev = _loc6_.prev;
            _loc6_.prev.next = _loc5_;
         }
         _loc7_ = _loc6_;
         _loc7_.free();
         _loc7_.next = ZPP_GeomVert.zpp_pool;
         ZPP_GeomVert.zpp_pool = _loc7_;
      }
      
      public function combDown(param1:int) : Boolean
      {
         var _loc2_:* = (param1 & 112) >> 4;
         return Boolean(comb(_loc2_));
      }
      
      public function comb(param1:int) : Boolean
      {
         var _loc2_:int = 0;
         if((param1 & 1) != 0)
         {
            _loc2_++;
         }
         if((param1 & 2) != 0)
         {
            _loc2_++;
         }
         if((param1 & 4) != 0)
         {
            _loc2_++;
         }
         return _loc2_ >= 2;
      }
   }
}
