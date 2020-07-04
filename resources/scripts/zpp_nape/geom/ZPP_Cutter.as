package zpp_nape.geom
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import nape.geom.GeomPoly;
   import nape.geom.GeomPolyList;
   import nape.geom.Vec2;
   import zpp_nape.util.ZNPList_ZPP_CutInt;
   import zpp_nape.util.ZNPList_ZPP_CutVert;
   import zpp_nape.util.ZNPNode_ZPP_CutInt;
   import zpp_nape.util.ZNPNode_ZPP_CutVert;
   
   public class ZPP_Cutter
   {
       
      
      public function ZPP_Cutter()
      {
      }
      
      public static function run(param1:ZPP_GeomVert, param2:Vec2, param3:Vec2, param4:Boolean, param5:Boolean) : GeomPolyList
      {
         var _loc17_:* = null as ZPP_CutVert;
         var _loc18_:* = null as ZPP_CutVert;
         var _loc19_:* = null as ZPP_CutVert;
         var _loc20_:* = null as ZPP_CutVert;
         var _loc21_:* = null as ZPP_CutVert;
         var _loc22_:Number = NaN;
         var _loc23_:Number = NaN;
         var _loc24_:Number = NaN;
         var _loc25_:Number = NaN;
         var _loc26_:Number = NaN;
         var _loc27_:Boolean = false;
         var _loc28_:Number = NaN;
         var _loc29_:Number = NaN;
         var _loc30_:* = false;
         var _loc31_:* = null as ZPP_GeomVert;
         var _loc32_:* = null as ZPP_GeomVert;
         var _loc33_:* = null as ZPP_GeomVert;
         var _loc34_:* = null as ZPP_GeomVert;
         var _loc35_:* = null as ZPP_GeomVert;
         var _loc36_:* = null as ZPP_CutVert;
         var _loc37_:* = null as ZPP_CutVert;
         var _loc38_:* = null as ZPP_CutVert;
         var _loc41_:* = null as ZPP_GeomVert;
         var _loc42_:Number = NaN;
         var _loc43_:Number = NaN;
         var _loc44_:Number = NaN;
         var _loc46_:* = null as ZNPNode_ZPP_CutInt;
         var _loc47_:* = null as ZNPNode_ZPP_CutInt;
         var _loc48_:* = null as ZNPNode_ZPP_CutInt;
         var _loc49_:* = null as ZNPNode_ZPP_CutInt;
         var _loc50_:* = null as ZNPNode_ZPP_CutInt;
         var _loc51_:* = 0;
         var _loc52_:int = 0;
         var _loc53_:int = 0;
         var _loc54_:int = 0;
         var _loc55_:* = null as ZPP_CutInt;
         var _loc56_:* = null as ZPP_CutInt;
         var _loc57_:* = null as ZPP_CutInt;
         var _loc60_:* = null as GeomPoly;
         var _loc8_:ZPP_Vec2 = param2.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         var _loc6_:Number = param2.zpp_inner.x;
         _loc8_ = param2.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         var _loc7_:Number = param2.zpp_inner.y;
         _loc8_ = param3.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         var _loc9_:Number = param3.zpp_inner.x - _loc6_;
         _loc8_ = param3.zpp_inner;
         if(_loc8_._validate != null)
         {
            _loc8_._validate();
         }
         var _loc10_:Number = param3.zpp_inner.y - _loc7_;
         var _loc11_:Number = !!param4?Number(0):-1.79e308;
         var _loc12_:Number = !!param5?Number(1):1.79e308;
         var _loc13_:Number = -(_loc7_ * _loc9_ - _loc6_ * _loc10_);
         var _loc14_:ZPP_CutVert = null;
         var _loc15_:Boolean = false;
         var _loc16_:ZPP_GeomVert = param1;
         do
         {
            if(ZPP_CutVert.zpp_pool == null)
            {
               _loc17_ = new ZPP_CutVert();
            }
            else
            {
               _loc17_ = ZPP_CutVert.zpp_pool;
               ZPP_CutVert.zpp_pool = _loc17_.next;
               _loc17_.next = null;
            }
            _loc17_.alloc();
            _loc17_.vert = _loc16_;
            _loc17_.posx = _loc17_.vert.x;
            _loc17_.posy = _loc17_.vert.y;
            _loc17_.value = Number(_loc17_.posy * _loc9_ - _loc17_.posx * _loc10_ + _loc13_);
            _loc17_.positive = _loc17_.value > 0;
            if(_loc17_.value == 0)
            {
               _loc15_ = true;
            }
            _loc18_ = _loc17_;
            if(_loc14_ == null)
            {
               _loc19_ = _loc18_;
               _loc18_.next = _loc19_;
               _loc19_ = _loc19_;
               _loc18_.prev = _loc19_;
               _loc14_ = _loc19_;
            }
            else
            {
               _loc18_.prev = _loc14_;
               _loc18_.next = _loc14_.next;
               _loc14_.next.prev = _loc18_;
               _loc14_.next = _loc18_;
            }
            _loc14_ = _loc18_;
            _loc16_ = _loc16_.next;
         }
         while(_loc16_ != param1);
         
         if(_loc15_)
         {
            _loc17_ = null;
            _loc18_ = _loc14_;
            _loc19_ = _loc14_;
            if(_loc18_ != null)
            {
               _loc20_ = _loc18_;
               do
               {
                  _loc21_ = _loc20_;
                  if(_loc21_.value != 0)
                  {
                     _loc17_ = _loc21_;
                     break;
                  }
                  _loc20_ = _loc20_.next;
               }
               while(_loc20_ != _loc19_);
               
            }
            _loc22_ = _loc9_;
            _loc23_ = _loc10_;
            _loc24_ = Number(_loc22_ * _loc22_ + _loc23_ * _loc23_);
            sf32(_loc24_,0);
            si32(1597463007 - (li32(0) >> 1),0);
            _loc26_ = lf32(0);
            _loc25_ = _loc26_ * (1.5 - 0.5 * _loc24_ * _loc26_ * _loc26_);
            _loc26_ = _loc25_;
            _loc22_ = _loc22_ * _loc26_;
            _loc23_ = _loc23_ * _loc26_;
            _loc24_ = _loc22_;
            _loc22_ = -_loc23_;
            _loc23_ = _loc24_;
            _loc18_ = null;
            _loc19_ = _loc17_;
            do
            {
               if(_loc19_.value != 0 && (_loc18_ == null || _loc19_ == _loc18_.next))
               {
                  _loc18_ = _loc19_;
                  _loc19_ = _loc19_.next;
               }
               else
               {
                  _loc24_ = _loc18_.value * _loc19_.value;
                  if(_loc24_ == 0)
                  {
                     _loc19_ = _loc19_.next;
                  }
                  else
                  {
                     _loc20_ = _loc18_.next;
                     if(_loc24_ > 0)
                     {
                        §§push(_loc18_.positive);
                     }
                     else
                     {
                        _loc21_ = _loc20_.next;
                        _loc25_ = Number(_loc20_.posx + _loc21_.posx);
                        _loc26_ = Number(_loc20_.posy + _loc21_.posy);
                        _loc28_ = 0.5;
                        _loc25_ = _loc25_ * _loc28_;
                        _loc26_ = _loc26_ * _loc28_;
                        _loc28_ = Number(_loc25_ + _loc22_ * 1.0e-8);
                        _loc29_ = Number(_loc26_ + _loc23_ * 1.0e-8);
                        _loc30_ = false;
                        _loc31_ = param1;
                        _loc32_ = param1;
                        if(_loc31_ != null)
                        {
                           _loc33_ = _loc31_;
                           do
                           {
                              _loc34_ = _loc33_;
                              _loc35_ = _loc34_.prev;
                              if((_loc34_.y < _loc29_ && _loc35_.y >= _loc29_ || _loc35_.y < _loc29_ && _loc34_.y >= _loc29_) && (_loc34_.x <= _loc28_ || _loc35_.x <= _loc28_))
                              {
                                 if(Number(_loc34_.x + (_loc29_ - _loc34_.y) / (_loc35_.y - _loc34_.y) * (_loc35_.x - _loc34_.x)) < _loc28_)
                                 {
                                    _loc30_ = !_loc30_;
                                 }
                              }
                              _loc33_ = _loc33_.next;
                           }
                           while(_loc33_ != _loc32_);
                           
                        }
                        §§push(_loc30_);
                     }
                     _loc27_ = §§pop();
                     _loc21_ = _loc20_;
                     _loc36_ = _loc19_;
                     if(_loc21_ != null)
                     {
                        _loc37_ = _loc21_;
                        do
                        {
                           _loc38_ = _loc37_;
                           _loc38_.positive = _loc27_;
                           _loc37_ = _loc37_.next;
                        }
                        while(_loc37_ != _loc36_);
                        
                     }
                     _loc18_ = _loc19_;
                     _loc19_ = _loc19_.next;
                  }
               }
            }
            while(_loc19_ != _loc17_);
            
            while(true)
            {
               if(_loc19_.value != 0 && (_loc18_ == null || _loc19_ == _loc18_.next))
               {
                  _loc18_ = _loc19_;
                  _loc19_ = _loc19_.next;
               }
               else
               {
                  _loc24_ = _loc18_.value * _loc19_.value;
                  if(_loc24_ == 0)
                  {
                     _loc19_ = _loc19_.next;
                  }
                  else
                  {
                     break;
                  }
               }
            }
            _loc20_ = _loc18_.next;
            if(_loc24_ > 0)
            {
               §§push(_loc18_.positive);
            }
            else
            {
               _loc21_ = _loc20_.next;
               _loc25_ = Number(_loc20_.posx + _loc21_.posx);
               _loc26_ = Number(_loc20_.posy + _loc21_.posy);
               _loc28_ = 0.5;
               _loc25_ = _loc25_ * _loc28_;
               _loc26_ = _loc26_ * _loc28_;
               _loc28_ = Number(_loc25_ + _loc22_ * 1.0e-8);
               _loc29_ = Number(_loc26_ + _loc23_ * 1.0e-8);
               _loc30_ = false;
               _loc31_ = param1;
               _loc32_ = param1;
               if(_loc31_ != null)
               {
                  _loc33_ = _loc31_;
                  do
                  {
                     _loc34_ = _loc33_;
                     _loc35_ = _loc34_.prev;
                     if((_loc34_.y < _loc29_ && _loc35_.y >= _loc29_ || _loc35_.y < _loc29_ && _loc34_.y >= _loc29_) && (_loc34_.x <= _loc28_ || _loc35_.x <= _loc28_))
                     {
                        if(Number(_loc34_.x + (_loc29_ - _loc34_.y) / (_loc35_.y - _loc34_.y) * (_loc35_.x - _loc34_.x)) < _loc28_)
                        {
                           _loc30_ = !_loc30_;
                        }
                     }
                     _loc33_ = _loc33_.next;
                  }
                  while(_loc33_ != _loc32_);
                  
               }
               §§push(_loc30_);
            }
            _loc27_ = §§pop();
            _loc21_ = _loc20_;
            _loc36_ = _loc19_;
            if(_loc21_ != null)
            {
               _loc37_ = _loc21_;
               do
               {
                  _loc38_ = _loc37_;
                  _loc38_.positive = _loc27_;
                  _loc37_ = _loc37_.next;
               }
               while(_loc37_ != _loc36_);
               
            }
            _loc18_ = _loc19_;
            _loc19_ = _loc19_.next;
         }
         var _loc39_:ZNPList_ZPP_CutInt = new ZNPList_ZPP_CutInt();
         var _loc40_:ZNPList_ZPP_CutVert = new ZNPList_ZPP_CutVert();
         _loc31_ = null;
         _loc32_ = ZPP_GeomVert.get(_loc14_.posx,_loc14_.posy);
         if(_loc31_ == null)
         {
            _loc33_ = _loc32_;
            _loc32_.next = _loc33_;
            _loc33_ = _loc33_;
            _loc32_.prev = _loc33_;
            _loc31_ = _loc33_;
         }
         else
         {
            _loc32_.next = _loc31_;
            _loc32_.prev = _loc31_.prev;
            _loc31_.prev.next = _loc32_;
            _loc31_.prev = _loc32_;
         }
         _loc32_;
         _loc32_ = _loc31_;
         _loc17_ = ZPP_CutVert.path(_loc31_);
         _loc40_.add(_loc17_);
         _loc18_ = _loc14_;
         do
         {
            _loc19_ = _loc18_.next;
            _loc33_ = ZPP_GeomVert.get(_loc19_.posx,_loc19_.posy);
            if(_loc18_.positive == _loc19_.positive)
            {
               _loc34_ = _loc33_;
               if(_loc31_ == null)
               {
                  _loc35_ = _loc34_;
                  _loc34_.next = _loc35_;
                  _loc35_ = _loc35_;
                  _loc34_.prev = _loc35_;
                  _loc31_ = _loc35_;
               }
               else
               {
                  _loc34_.next = _loc31_;
                  _loc34_.prev = _loc31_.prev;
                  _loc31_.prev.next = _loc34_;
                  _loc31_.prev = _loc34_;
               }
               _loc34_;
            }
            else
            {
               _loc22_ = _loc19_.posx - _loc18_.posx;
               _loc23_ = _loc19_.posy - _loc18_.posy;
               _loc24_ = _loc10_ * _loc22_ - _loc9_ * _loc23_;
               _loc24_ = 1 / _loc24_;
               _loc25_ = _loc6_ - _loc18_.posx;
               _loc26_ = _loc7_ - _loc18_.posy;
               _loc28_ = (_loc23_ * _loc25_ - _loc22_ * _loc26_) * _loc24_;
               if(_loc28_ < _loc11_ || _loc28_ > _loc12_)
               {
                  _loc39_.add(ZPP_CutInt.get(_loc28_,null,null,null,null,true));
                  _loc34_ = _loc33_;
                  if(_loc31_ == null)
                  {
                     _loc35_ = _loc34_;
                     _loc34_.next = _loc35_;
                     _loc35_ = _loc35_;
                     _loc34_.prev = _loc35_;
                     _loc31_ = _loc35_;
                  }
                  else
                  {
                     _loc34_.next = _loc31_;
                     _loc34_.prev = _loc31_.prev;
                     _loc31_.prev.next = _loc34_;
                     _loc31_.prev = _loc34_;
                  }
                  _loc34_;
               }
               else if(_loc18_.value == 0)
               {
                  _loc34_ = _loc31_.prev;
                  _loc31_ = null;
                  _loc35_ = ZPP_GeomVert.get(_loc34_.x,_loc34_.y);
                  if(_loc31_ == null)
                  {
                     _loc41_ = _loc35_;
                     _loc35_.next = _loc41_;
                     _loc41_ = _loc41_;
                     _loc35_.prev = _loc41_;
                     _loc31_ = _loc41_;
                  }
                  else
                  {
                     _loc35_.next = _loc31_;
                     _loc35_.prev = _loc31_.prev;
                     _loc31_.prev.next = _loc35_;
                     _loc31_.prev = _loc35_;
                  }
                  _loc35_;
                  _loc35_ = _loc33_;
                  if(_loc31_ == null)
                  {
                     _loc41_ = _loc35_;
                     _loc35_.next = _loc41_;
                     _loc41_ = _loc41_;
                     _loc35_.prev = _loc41_;
                     _loc31_ = _loc41_;
                  }
                  else
                  {
                     _loc35_.next = _loc31_;
                     _loc35_.prev = _loc31_.prev;
                     _loc31_.prev.next = _loc35_;
                     _loc31_.prev = _loc35_;
                  }
                  _loc35_;
                  _loc20_ = _loc40_.head.elt;
                  _loc40_.add(ZPP_CutVert.path(_loc31_));
                  _loc21_ = _loc40_.head.elt;
                  _loc39_.add(ZPP_CutInt.get(_loc28_,_loc34_,_loc31_,_loc20_,_loc21_,true));
               }
               else if(_loc19_.value == 0)
               {
                  _loc34_ = _loc33_;
                  if(_loc31_ == null)
                  {
                     _loc35_ = _loc34_;
                     _loc34_.next = _loc35_;
                     _loc35_ = _loc35_;
                     _loc34_.prev = _loc35_;
                     _loc31_ = _loc35_;
                  }
                  else
                  {
                     _loc34_.next = _loc31_;
                     _loc34_.prev = _loc31_.prev;
                     _loc31_.prev.next = _loc34_;
                     _loc31_.prev = _loc34_;
                  }
                  _loc34_;
                  _loc34_ = _loc31_.prev;
                  _loc31_ = null;
                  _loc35_ = ZPP_GeomVert.get(_loc19_.posx,_loc19_.posy);
                  if(_loc31_ == null)
                  {
                     _loc41_ = _loc35_;
                     _loc35_.next = _loc41_;
                     _loc41_ = _loc41_;
                     _loc35_.prev = _loc41_;
                     _loc31_ = _loc41_;
                  }
                  else
                  {
                     _loc35_.next = _loc31_;
                     _loc35_.prev = _loc31_.prev;
                     _loc31_.prev.next = _loc35_;
                     _loc31_.prev = _loc35_;
                  }
                  _loc35_;
                  _loc20_ = _loc40_.head.elt;
                  _loc40_.add(ZPP_CutVert.path(_loc31_));
                  _loc21_ = _loc40_.head.elt;
                  _loc39_.add(ZPP_CutInt.get(_loc28_,_loc34_,_loc31_,_loc20_,_loc21_,true));
               }
               else
               {
                  _loc29_ = (_loc10_ * _loc25_ - _loc9_ * _loc26_) * _loc24_;
                  _loc42_ = _loc18_.posx;
                  _loc43_ = _loc18_.posy;
                  _loc44_ = _loc29_;
                  _loc42_ = Number(_loc42_ + _loc22_ * _loc44_);
                  _loc43_ = Number(_loc43_ + _loc23_ * _loc44_);
                  _loc34_ = ZPP_GeomVert.get(_loc42_,_loc43_);
                  if(_loc31_ == null)
                  {
                     _loc35_ = _loc34_;
                     _loc34_.next = _loc35_;
                     _loc35_ = _loc35_;
                     _loc34_.prev = _loc35_;
                     _loc31_ = _loc35_;
                  }
                  else
                  {
                     _loc34_.next = _loc31_;
                     _loc34_.prev = _loc31_.prev;
                     _loc31_.prev.next = _loc34_;
                     _loc31_.prev = _loc34_;
                  }
                  _loc34_;
                  _loc34_ = _loc31_.prev;
                  _loc31_ = null;
                  _loc35_ = ZPP_GeomVert.get(_loc42_,_loc43_);
                  if(_loc31_ == null)
                  {
                     _loc41_ = _loc35_;
                     _loc35_.next = _loc41_;
                     _loc41_ = _loc41_;
                     _loc35_.prev = _loc41_;
                     _loc31_ = _loc41_;
                  }
                  else
                  {
                     _loc35_.next = _loc31_;
                     _loc35_.prev = _loc31_.prev;
                     _loc31_.prev.next = _loc35_;
                     _loc31_.prev = _loc35_;
                  }
                  _loc35_;
                  _loc35_ = _loc33_;
                  if(_loc31_ == null)
                  {
                     _loc41_ = _loc35_;
                     _loc35_.next = _loc41_;
                     _loc41_ = _loc41_;
                     _loc35_.prev = _loc41_;
                     _loc31_ = _loc41_;
                  }
                  else
                  {
                     _loc35_.next = _loc31_;
                     _loc35_.prev = _loc31_.prev;
                     _loc31_.prev.next = _loc35_;
                     _loc31_.prev = _loc35_;
                  }
                  _loc35_;
                  _loc20_ = _loc40_.head.elt;
                  _loc40_.add(ZPP_CutVert.path(_loc31_));
                  _loc21_ = _loc40_.head.elt;
                  _loc39_.add(ZPP_CutInt.get(_loc28_,_loc34_,_loc31_,_loc20_,_loc21_,false));
               }
            }
            _loc18_ = _loc18_.next;
         }
         while(_loc18_ != _loc14_);
         
         _loc33_ = _loc31_.prev;
         _loc33_.next.prev = _loc32_.prev;
         _loc32_.prev.next = _loc33_.next;
         _loc33_.next = _loc32_;
         _loc32_.prev = _loc33_;
         _loc19_ = _loc40_.head.elt;
         if(_loc17_ == _loc17_.parent)
         {
            §§push(_loc17_);
         }
         else
         {
            _loc21_ = _loc17_;
            _loc36_ = null;
            while(_loc21_ != _loc21_.parent)
            {
               _loc37_ = _loc21_.parent;
               _loc21_.parent = _loc36_;
               _loc36_ = _loc21_;
               _loc21_ = _loc37_;
            }
            while(_loc36_ != null)
            {
               _loc37_ = _loc36_.parent;
               _loc36_.parent = _loc21_;
               _loc36_ = _loc37_;
            }
            §§push(_loc21_);
         }
         _loc20_ = §§pop();
         if(_loc19_ == _loc19_.parent)
         {
            §§push(_loc19_);
         }
         else
         {
            _loc36_ = _loc19_;
            _loc37_ = null;
            while(_loc36_ != _loc36_.parent)
            {
               _loc38_ = _loc36_.parent;
               _loc36_.parent = _loc37_;
               _loc37_ = _loc36_;
               _loc36_ = _loc38_;
            }
            while(_loc37_ != null)
            {
               _loc38_ = _loc37_.parent;
               _loc37_.parent = _loc36_;
               _loc37_ = _loc38_;
            }
            §§push(_loc36_);
         }
         _loc21_ = §§pop();
         if(_loc20_ != _loc21_)
         {
            if(_loc20_.rank < _loc21_.rank)
            {
               _loc20_.parent = _loc21_;
            }
            else if(_loc20_.rank > _loc21_.rank)
            {
               _loc21_.parent = _loc20_;
            }
            else
            {
               _loc21_.parent = _loc20_;
               _loc20_.rank = _loc20_.rank + 1;
            }
         }
         var _loc45_:ZNPList_ZPP_CutInt = _loc39_;
         if(_loc45_.head != null && _loc45_.head.next != null)
         {
            _loc46_ = _loc45_.head;
            _loc47_ = null;
            _loc48_ = null;
            _loc49_ = null;
            _loc50_ = null;
            _loc51_ = 1;
            do
            {
               _loc52_ = 0;
               _loc48_ = _loc46_;
               _loc46_ = null;
               _loc47_ = _loc46_;
               while(_loc48_ != null)
               {
                  _loc52_++;
                  _loc49_ = _loc48_;
                  _loc53_ = 0;
                  _loc54_ = _loc51_;
                  while(_loc49_ != null && _loc53_ < _loc51_)
                  {
                     _loc53_++;
                     _loc49_ = _loc49_.next;
                  }
                  while(_loc53_ > 0 || _loc54_ > 0 && _loc49_ != null)
                  {
                     if(_loc53_ == 0)
                     {
                        _loc50_ = _loc49_;
                        _loc49_ = _loc49_.next;
                        _loc54_--;
                     }
                     else if(_loc54_ == 0 || _loc49_ == null)
                     {
                        _loc50_ = _loc48_;
                        _loc48_ = _loc48_.next;
                        _loc53_--;
                     }
                     else if(_loc48_.elt.time < _loc49_.elt.time)
                     {
                        _loc50_ = _loc48_;
                        _loc48_ = _loc48_.next;
                        _loc53_--;
                     }
                     else
                     {
                        _loc50_ = _loc49_;
                        _loc49_ = _loc49_.next;
                        _loc54_--;
                     }
                     if(_loc47_ != null)
                     {
                        _loc47_.next = _loc50_;
                     }
                     else
                     {
                        _loc46_ = _loc50_;
                     }
                     _loc47_ = _loc50_;
                  }
                  _loc48_ = _loc49_;
               }
               _loc47_.next = null;
               _loc51_ = _loc51_ << 1;
            }
            while(_loc52_ > 1);
            
            _loc45_.head = _loc46_;
            _loc45_.modified = true;
            _loc45_.pushmod = true;
         }
         while(_loc39_.head != null)
         {
            _loc55_ = _loc39_.pop_unsafe();
            _loc56_ = _loc39_.pop_unsafe();
            if(!_loc55_.virtualint && !_loc56_.virtualint)
            {
               _loc55_.end.next.prev = _loc56_.start.prev;
               _loc56_.start.prev.next = _loc55_.end.next;
               _loc55_.end.next = _loc56_.start;
               _loc56_.start.prev = _loc55_.end;
               _loc56_.end.next.prev = _loc55_.start.prev;
               _loc55_.start.prev.next = _loc56_.end.next;
               _loc56_.end.next = _loc55_.start;
               _loc55_.start.prev = _loc56_.end;
               if(_loc55_.path0 == _loc55_.path0.parent)
               {
                  §§push(_loc55_.path0);
               }
               else
               {
                  _loc21_ = _loc55_.path0;
                  _loc36_ = null;
                  while(_loc21_ != _loc21_.parent)
                  {
                     _loc37_ = _loc21_.parent;
                     _loc21_.parent = _loc36_;
                     _loc36_ = _loc21_;
                     _loc21_ = _loc37_;
                  }
                  while(_loc36_ != null)
                  {
                     _loc37_ = _loc36_.parent;
                     _loc36_.parent = _loc21_;
                     _loc36_ = _loc37_;
                  }
                  §§push(_loc21_);
               }
               _loc20_ = §§pop();
               if(_loc56_.path1 == _loc56_.path1.parent)
               {
                  §§push(_loc56_.path1);
               }
               else
               {
                  _loc36_ = _loc56_.path1;
                  _loc37_ = null;
                  while(_loc36_ != _loc36_.parent)
                  {
                     _loc38_ = _loc36_.parent;
                     _loc36_.parent = _loc37_;
                     _loc37_ = _loc36_;
                     _loc36_ = _loc38_;
                  }
                  while(_loc37_ != null)
                  {
                     _loc38_ = _loc37_.parent;
                     _loc37_.parent = _loc36_;
                     _loc37_ = _loc38_;
                  }
                  §§push(_loc36_);
               }
               _loc21_ = §§pop();
               if(_loc20_ != _loc21_)
               {
                  if(_loc20_.rank < _loc21_.rank)
                  {
                     _loc20_.parent = _loc21_;
                  }
                  else if(_loc20_.rank > _loc21_.rank)
                  {
                     _loc21_.parent = _loc20_;
                  }
                  else
                  {
                     _loc21_.parent = _loc20_;
                     _loc20_.rank = _loc20_.rank + 1;
                  }
               }
               if(_loc55_.path1 == _loc55_.path1.parent)
               {
                  §§push(_loc55_.path1);
               }
               else
               {
                  _loc21_ = _loc55_.path1;
                  _loc36_ = null;
                  while(_loc21_ != _loc21_.parent)
                  {
                     _loc37_ = _loc21_.parent;
                     _loc21_.parent = _loc36_;
                     _loc36_ = _loc21_;
                     _loc21_ = _loc37_;
                  }
                  while(_loc36_ != null)
                  {
                     _loc37_ = _loc36_.parent;
                     _loc36_.parent = _loc21_;
                     _loc36_ = _loc37_;
                  }
                  §§push(_loc21_);
               }
               _loc20_ = §§pop();
               if(_loc56_.path0 == _loc56_.path0.parent)
               {
                  §§push(_loc56_.path0);
               }
               else
               {
                  _loc36_ = _loc56_.path0;
                  _loc37_ = null;
                  while(_loc36_ != _loc36_.parent)
                  {
                     _loc38_ = _loc36_.parent;
                     _loc36_.parent = _loc37_;
                     _loc37_ = _loc36_;
                     _loc36_ = _loc38_;
                  }
                  while(_loc37_ != null)
                  {
                     _loc38_ = _loc37_.parent;
                     _loc37_.parent = _loc36_;
                     _loc37_ = _loc38_;
                  }
                  §§push(_loc36_);
               }
               _loc21_ = §§pop();
               if(_loc20_ != _loc21_)
               {
                  if(_loc20_.rank < _loc21_.rank)
                  {
                     _loc20_.parent = _loc21_;
                  }
                  else if(_loc20_.rank > _loc21_.rank)
                  {
                     _loc21_.parent = _loc20_;
                  }
                  else
                  {
                     _loc21_.parent = _loc20_;
                     _loc20_.rank = _loc20_.rank + 1;
                  }
               }
            }
            else if(!!_loc55_.virtualint && !_loc56_.virtualint)
            {
               §§push(_loc56_);
               if(_loc56_.end != null && _loc56_.end.prev == _loc56_.end)
               {
                  _loc34_ = null;
                  _loc56_.end.prev = _loc34_;
                  _loc56_.end.next = _loc34_;
                  _loc34_ = _loc56_.end;
                  _loc34_.free();
                  _loc34_.next = ZPP_GeomVert.zpp_pool;
                  ZPP_GeomVert.zpp_pool = _loc34_;
                  §§push(null);
               }
               else
               {
                  _loc34_ = _loc56_.end.prev;
                  _loc56_.end.prev.next = _loc56_.end.next;
                  _loc56_.end.next.prev = _loc56_.end.prev;
                  _loc35_ = null;
                  _loc56_.end.prev = _loc35_;
                  _loc56_.end.next = _loc35_;
                  _loc35_ = _loc56_.end;
                  _loc35_.free();
                  _loc35_.next = ZPP_GeomVert.zpp_pool;
                  ZPP_GeomVert.zpp_pool = _loc35_;
                  _loc56_.end = null;
                  §§push(_loc34_);
               }
               §§pop().end = §§pop();
               if(!_loc56_.vertex)
               {
                  if(_loc56_.end != _loc56_.path0.vert)
                  {
                     _loc56_.start.x = _loc56_.end.x;
                     _loc56_.start.y = _loc56_.end.y;
                     §§push(_loc56_);
                     if(_loc56_.end != null && _loc56_.end.prev == _loc56_.end)
                     {
                        _loc34_ = null;
                        _loc56_.end.prev = _loc34_;
                        _loc56_.end.next = _loc34_;
                        _loc34_ = _loc56_.end;
                        _loc34_.free();
                        _loc34_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc34_;
                        §§push(null);
                     }
                     else
                     {
                        _loc34_ = _loc56_.end.prev;
                        _loc56_.end.prev.next = _loc56_.end.next;
                        _loc56_.end.next.prev = _loc56_.end.prev;
                        _loc35_ = null;
                        _loc56_.end.prev = _loc35_;
                        _loc56_.end.next = _loc35_;
                        _loc35_ = _loc56_.end;
                        _loc35_.free();
                        _loc35_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc35_;
                        _loc56_.end = null;
                        §§push(_loc34_);
                     }
                     §§pop().end = §§pop();
                  }
                  else
                  {
                     _loc34_ = _loc56_.start.next;
                     _loc56_.start.x = _loc34_.x;
                     _loc56_.start.y = _loc34_.y;
                     if(_loc34_ != null && _loc34_.prev == _loc34_)
                     {
                        _loc35_ = null;
                        _loc34_.prev = _loc35_;
                        _loc34_.next = _loc35_;
                        _loc35_ = _loc34_;
                        _loc35_.free();
                        _loc35_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc35_;
                        _loc34_ = null;
                     }
                     else
                     {
                        _loc34_.prev.next = _loc34_.next;
                        _loc34_.next.prev = _loc34_.prev;
                        _loc35_ = null;
                        _loc34_.prev = _loc35_;
                        _loc34_.next = _loc35_;
                        _loc35_ = _loc34_;
                        _loc35_.free();
                        _loc35_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc35_;
                     }
                  }
               }
               _loc56_.end.next.prev = _loc56_.start.prev;
               _loc56_.start.prev.next = _loc56_.end.next;
               _loc56_.end.next = _loc56_.start;
               _loc56_.start.prev = _loc56_.end;
               if(_loc56_.path0 == _loc56_.path0.parent)
               {
                  §§push(_loc56_.path0);
               }
               else
               {
                  _loc21_ = _loc56_.path0;
                  _loc36_ = null;
                  while(_loc21_ != _loc21_.parent)
                  {
                     _loc37_ = _loc21_.parent;
                     _loc21_.parent = _loc36_;
                     _loc36_ = _loc21_;
                     _loc21_ = _loc37_;
                  }
                  while(_loc36_ != null)
                  {
                     _loc37_ = _loc36_.parent;
                     _loc36_.parent = _loc21_;
                     _loc36_ = _loc37_;
                  }
                  §§push(_loc21_);
               }
               _loc20_ = §§pop();
               if(_loc56_.path1 == _loc56_.path1.parent)
               {
                  §§push(_loc56_.path1);
               }
               else
               {
                  _loc36_ = _loc56_.path1;
                  _loc37_ = null;
                  while(_loc36_ != _loc36_.parent)
                  {
                     _loc38_ = _loc36_.parent;
                     _loc36_.parent = _loc37_;
                     _loc37_ = _loc36_;
                     _loc36_ = _loc38_;
                  }
                  while(_loc37_ != null)
                  {
                     _loc38_ = _loc37_.parent;
                     _loc37_.parent = _loc36_;
                     _loc37_ = _loc38_;
                  }
                  §§push(_loc36_);
               }
               _loc21_ = §§pop();
               if(_loc20_ != _loc21_)
               {
                  if(_loc20_.rank < _loc21_.rank)
                  {
                     _loc20_.parent = _loc21_;
                  }
                  else if(_loc20_.rank > _loc21_.rank)
                  {
                     _loc21_.parent = _loc20_;
                  }
                  else
                  {
                     _loc21_.parent = _loc20_;
                     _loc20_.rank = _loc20_.rank + 1;
                  }
               }
            }
            else if(!!_loc56_.virtualint && !_loc55_.virtualint)
            {
               §§push(_loc55_);
               if(_loc55_.end != null && _loc55_.end.prev == _loc55_.end)
               {
                  _loc34_ = null;
                  _loc55_.end.prev = _loc34_;
                  _loc55_.end.next = _loc34_;
                  _loc34_ = _loc55_.end;
                  _loc34_.free();
                  _loc34_.next = ZPP_GeomVert.zpp_pool;
                  ZPP_GeomVert.zpp_pool = _loc34_;
                  §§push(null);
               }
               else
               {
                  _loc34_ = _loc55_.end.prev;
                  _loc55_.end.prev.next = _loc55_.end.next;
                  _loc55_.end.next.prev = _loc55_.end.prev;
                  _loc35_ = null;
                  _loc55_.end.prev = _loc35_;
                  _loc55_.end.next = _loc35_;
                  _loc35_ = _loc55_.end;
                  _loc35_.free();
                  _loc35_.next = ZPP_GeomVert.zpp_pool;
                  ZPP_GeomVert.zpp_pool = _loc35_;
                  _loc55_.end = null;
                  §§push(_loc34_);
               }
               §§pop().end = §§pop();
               if(!_loc55_.vertex)
               {
                  if(_loc55_.end != _loc55_.path0.vert)
                  {
                     _loc55_.start.x = _loc55_.end.x;
                     _loc55_.start.y = _loc55_.end.y;
                     §§push(_loc55_);
                     if(_loc55_.end != null && _loc55_.end.prev == _loc55_.end)
                     {
                        _loc34_ = null;
                        _loc55_.end.prev = _loc34_;
                        _loc55_.end.next = _loc34_;
                        _loc34_ = _loc55_.end;
                        _loc34_.free();
                        _loc34_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc34_;
                        §§push(null);
                     }
                     else
                     {
                        _loc34_ = _loc55_.end.prev;
                        _loc55_.end.prev.next = _loc55_.end.next;
                        _loc55_.end.next.prev = _loc55_.end.prev;
                        _loc35_ = null;
                        _loc55_.end.prev = _loc35_;
                        _loc55_.end.next = _loc35_;
                        _loc35_ = _loc55_.end;
                        _loc35_.free();
                        _loc35_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc35_;
                        _loc55_.end = null;
                        §§push(_loc34_);
                     }
                     §§pop().end = §§pop();
                  }
                  else
                  {
                     _loc34_ = _loc55_.start.next;
                     _loc55_.start.x = _loc34_.x;
                     _loc55_.start.y = _loc34_.y;
                     if(_loc34_ != null && _loc34_.prev == _loc34_)
                     {
                        _loc35_ = null;
                        _loc34_.prev = _loc35_;
                        _loc34_.next = _loc35_;
                        _loc35_ = _loc34_;
                        _loc35_.free();
                        _loc35_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc35_;
                        _loc34_ = null;
                     }
                     else
                     {
                        _loc34_.prev.next = _loc34_.next;
                        _loc34_.next.prev = _loc34_.prev;
                        _loc35_ = null;
                        _loc34_.prev = _loc35_;
                        _loc34_.next = _loc35_;
                        _loc35_ = _loc34_;
                        _loc35_.free();
                        _loc35_.next = ZPP_GeomVert.zpp_pool;
                        ZPP_GeomVert.zpp_pool = _loc35_;
                     }
                  }
               }
               _loc55_.end.next.prev = _loc55_.start.prev;
               _loc55_.start.prev.next = _loc55_.end.next;
               _loc55_.end.next = _loc55_.start;
               _loc55_.start.prev = _loc55_.end;
               if(_loc55_.path0 == _loc55_.path0.parent)
               {
                  §§push(_loc55_.path0);
               }
               else
               {
                  _loc21_ = _loc55_.path0;
                  _loc36_ = null;
                  while(_loc21_ != _loc21_.parent)
                  {
                     _loc37_ = _loc21_.parent;
                     _loc21_.parent = _loc36_;
                     _loc36_ = _loc21_;
                     _loc21_ = _loc37_;
                  }
                  while(_loc36_ != null)
                  {
                     _loc37_ = _loc36_.parent;
                     _loc36_.parent = _loc21_;
                     _loc36_ = _loc37_;
                  }
                  §§push(_loc21_);
               }
               _loc20_ = §§pop();
               if(_loc55_.path1 == _loc55_.path1.parent)
               {
                  §§push(_loc55_.path1);
               }
               else
               {
                  _loc36_ = _loc55_.path1;
                  _loc37_ = null;
                  while(_loc36_ != _loc36_.parent)
                  {
                     _loc38_ = _loc36_.parent;
                     _loc36_.parent = _loc37_;
                     _loc37_ = _loc36_;
                     _loc36_ = _loc38_;
                  }
                  while(_loc37_ != null)
                  {
                     _loc38_ = _loc37_.parent;
                     _loc37_.parent = _loc36_;
                     _loc37_ = _loc38_;
                  }
                  §§push(_loc36_);
               }
               _loc21_ = §§pop();
               if(_loc20_ != _loc21_)
               {
                  if(_loc20_.rank < _loc21_.rank)
                  {
                     _loc20_.parent = _loc21_;
                  }
                  else if(_loc20_.rank > _loc21_.rank)
                  {
                     _loc21_.parent = _loc20_;
                  }
                  else
                  {
                     _loc21_.parent = _loc20_;
                     _loc20_.rank = _loc20_.rank + 1;
                  }
               }
            }
            _loc57_ = _loc55_;
            _loc57_.free();
            _loc57_.next = ZPP_CutInt.zpp_pool;
            ZPP_CutInt.zpp_pool = _loc57_;
            _loc57_ = _loc56_;
            _loc57_.free();
            _loc57_.next = ZPP_CutInt.zpp_pool;
            ZPP_CutInt.zpp_pool = _loc57_;
         }
         var _loc58_:GeomPolyList = new GeomPolyList();
         var _loc59_:ZNPNode_ZPP_CutVert = _loc40_.head;
         while(_loc59_ != null)
         {
            _loc20_ = _loc59_.elt;
            if(_loc20_ == _loc20_.parent)
            {
               §§push(_loc20_);
            }
            else
            {
               _loc36_ = _loc20_;
               _loc37_ = null;
               while(_loc36_ != _loc36_.parent)
               {
                  _loc38_ = _loc36_.parent;
                  _loc36_.parent = _loc37_;
                  _loc37_ = _loc36_;
                  _loc36_ = _loc38_;
               }
               while(_loc37_ != null)
               {
                  _loc38_ = _loc37_.parent;
                  _loc37_.parent = _loc36_;
                  _loc37_ = _loc38_;
               }
               §§push(_loc36_);
            }
            _loc21_ = §§pop();
            if(_loc21_.used)
            {
               _loc59_ = _loc59_.next;
            }
            else
            {
               _loc21_.used = true;
               _loc34_ = _loc21_.vert;
               _loc27_ = true;
               while(_loc21_.vert != null && (_loc27_ || _loc34_ != _loc21_.vert))
               {
                  _loc27_ = false;
                  if(_loc34_.x == _loc34_.next.x && _loc34_.y == _loc34_.next.y)
                  {
                     if(_loc34_ == _loc21_.vert)
                     {
                        _loc21_.vert = _loc34_.next == _loc34_?null:_loc34_.next;
                        _loc27_ = true;
                     }
                     if(_loc34_ != null && _loc34_.prev == _loc34_)
                     {
                        _loc35_ = null;
                        _loc34_.prev = _loc35_;
                        _loc34_.next = _loc35_;
                        _loc34_ = null;
                        §§push(_loc34_);
                     }
                     else
                     {
                        _loc35_ = _loc34_.next;
                        _loc34_.prev.next = _loc34_.next;
                        _loc34_.next.prev = _loc34_.prev;
                        _loc41_ = null;
                        _loc34_.prev = _loc41_;
                        _loc34_.next = _loc41_;
                        _loc34_ = null;
                        §§push(_loc35_);
                     }
                     _loc34_ = §§pop();
                  }
                  else
                  {
                     _loc34_ = _loc34_.next;
                  }
               }
               if(_loc21_.vert != null)
               {
                  _loc60_ = new GeomPoly();
                  _loc60_.zpp_inner.vertices = _loc21_.vert;
                  _loc58_.add(_loc60_);
               }
               _loc59_ = _loc59_.next;
            }
         }
         while(_loc40_.head != null)
         {
            _loc20_ = _loc40_.pop_unsafe();
            _loc21_ = _loc20_;
            _loc21_.free();
            _loc21_.next = ZPP_CutVert.zpp_pool;
            ZPP_CutVert.zpp_pool = _loc21_;
         }
         while(_loc14_ != null)
         {
            if(_loc14_ != null && _loc14_.prev == _loc14_)
            {
               _loc20_ = null;
               _loc14_.prev = _loc20_;
               _loc14_.next = _loc20_;
               _loc20_ = _loc14_;
               _loc20_.free();
               _loc20_.next = ZPP_CutVert.zpp_pool;
               ZPP_CutVert.zpp_pool = _loc20_;
               _loc14_ = null;
               §§push(_loc14_);
            }
            else
            {
               _loc20_ = _loc14_.next;
               _loc14_.prev.next = _loc14_.next;
               _loc14_.next.prev = _loc14_.prev;
               _loc21_ = null;
               _loc14_.prev = _loc21_;
               _loc14_.next = _loc21_;
               _loc21_ = _loc14_;
               _loc21_.free();
               _loc21_.next = ZPP_CutVert.zpp_pool;
               ZPP_CutVert.zpp_pool = _loc21_;
               _loc14_ = null;
               §§push(_loc20_);
            }
            _loc14_ = §§pop();
         }
         return _loc58_;
      }
   }
}
