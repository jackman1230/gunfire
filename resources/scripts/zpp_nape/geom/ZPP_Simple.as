package zpp_nape.geom
{
   import zpp_nape.util.FastHash2_Hashable2_Bool;
   import zpp_nape.util.Hashable2_Bool;
   import zpp_nape.util.ZNPList_ZPP_GeomVert;
   import zpp_nape.util.ZNPList_ZPP_SimpleEvent;
   import zpp_nape.util.ZNPList_ZPP_SimpleVert;
   import zpp_nape.util.ZNPNode_ZPP_SimpleEvent;
   import zpp_nape.util.ZNPNode_ZPP_SimpleVert;
   import zpp_nape.util.ZPP_Set_ZPP_SimpleEvent;
   import zpp_nape.util.ZPP_Set_ZPP_SimpleSeg;
   import zpp_nape.util.ZPP_Set_ZPP_SimpleVert;
   
   public class ZPP_Simple
   {
      
      public static var sweep:ZPP_SimpleSweep;
      
      public static var inthash:FastHash2_Hashable2_Bool;
       
      
      public function ZPP_Simple()
      {
      }
      
      public static function decompose(param1:ZPP_GeomVert) : ZNPList_ZPP_GeomVert
      {
         var _loc2_:* = null as ZPP_Set_ZPP_SimpleVert;
         var _loc3_:* = null as ZPP_Set_ZPP_SimpleEvent;
         var _loc8_:* = null as ZPP_GeomVert;
         var _loc9_:* = null as ZPP_GeomVert;
         var _loc10_:* = null as ZPP_SimpleVert;
         var _loc11_:* = null as ZPP_Set_ZPP_SimpleVert;
         var _loc12_:* = null as ZPP_Set_ZPP_SimpleVert;
         var _loc13_:* = null as ZPP_SimpleVert;
         var _loc14_:* = null as ZPP_SimpleEvent;
         var _loc15_:* = null as ZPP_SimpleEvent;
         var _loc16_:* = null as ZPP_SimpleSeg;
         var _loc17_:* = null as ZPP_SimpleSeg;
         var _loc18_:* = null as ZPP_Set_ZPP_SimpleEvent;
         var _loc19_:* = null as ZPP_Set_ZPP_SimpleEvent;
         var _loc20_:* = null as ZPP_Set_ZPP_SimpleEvent;
         var _loc21_:* = null as ZPP_Set_ZPP_SimpleEvent;
         var _loc22_:* = null as ZPP_SimpleEvent;
         var _loc23_:* = null as ZPP_SimpleEvent;
         var _loc24_:* = null as ZPP_SimpleSeg;
         var _loc25_:* = null as ZPP_SimpleSeg;
         var _loc26_:* = false;
         var _loc27_:* = false;
         var _loc28_:* = false;
         var _loc29_:* = null as ZPP_SimpleVert;
         var _loc30_:* = null as ZPP_Set_ZPP_SimpleSeg;
         var _loc31_:* = null as ZPP_Set_ZPP_SimpleSeg;
         var _loc34_:int = 0;
         var _loc35_:* = null as Hashable2_Bool;
         var _loc36_:* = null as Hashable2_Bool;
         if(ZPP_Simple.sweep == null)
         {
            ZPP_Simple.sweep = new ZPP_SimpleSweep();
            ZPP_Simple.inthash = new FastHash2_Hashable2_Bool();
         }
         if(ZPP_Set_ZPP_SimpleVert.zpp_pool == null)
         {
            _loc2_ = new ZPP_Set_ZPP_SimpleVert();
         }
         else
         {
            _loc2_ = ZPP_Set_ZPP_SimpleVert.zpp_pool;
            ZPP_Set_ZPP_SimpleVert.zpp_pool = _loc2_.next;
            _loc2_.next = null;
         }
         _loc2_.alloc();
         _loc2_.lt = ZPP_SimpleVert.less_xy;
         _loc2_.swapped = ZPP_SimpleVert.swap_nodes;
         if(ZPP_Set_ZPP_SimpleEvent.zpp_pool == null)
         {
            _loc3_ = new ZPP_Set_ZPP_SimpleEvent();
         }
         else
         {
            _loc3_ = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
            ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         _loc3_.alloc();
         _loc3_.lt = ZPP_SimpleEvent.less_xy;
         _loc3_.swapped = ZPP_SimpleEvent.swap_nodes;
         var _loc4_:ZPP_SimpleVert = null;
         var _loc5_:ZPP_SimpleVert = null;
         var _loc6_:ZPP_GeomVert = param1;
         var _loc7_:ZPP_GeomVert = param1;
         if(_loc6_ != null)
         {
            _loc8_ = _loc6_;
            do
            {
               _loc9_ = _loc8_;
               _loc10_ = ZPP_SimpleVert.get(_loc9_.x,_loc9_.y);
               _loc12_ = _loc2_.parent;
               while(_loc12_ != null)
               {
                  if(_loc2_.lt(_loc10_,_loc12_.data))
                  {
                     _loc12_ = _loc12_.prev;
                     continue;
                  }
                  if(_loc2_.lt(_loc12_.data,_loc10_))
                  {
                     _loc12_ = _loc12_.next;
                     continue;
                  }
                  break;
               }
               _loc11_ = _loc12_;
               if(_loc11_ != null)
               {
                  _loc13_ = _loc10_;
                  _loc13_.free();
                  _loc13_.next = ZPP_SimpleVert.zpp_pool;
                  ZPP_SimpleVert.zpp_pool = _loc13_;
                  _loc10_ = _loc11_.data;
               }
               else
               {
                  _loc10_.node = _loc2_.insert(_loc10_);
               }
               if(_loc5_ != null)
               {
                  _loc14_ = ZPP_SimpleEvent.get(_loc5_);
                  _loc15_ = ZPP_SimpleEvent.get(_loc10_);
                  if(ZPP_SimpleEvent.less_xy(_loc14_,_loc15_))
                  {
                     _loc14_.type = 1;
                     _loc15_.type = 2;
                     _loc16_ = ZPP_SimpleSeg.get(_loc5_,_loc10_);
                  }
                  else
                  {
                     _loc14_.type = 2;
                     _loc15_.type = 1;
                     _loc16_ = ZPP_SimpleSeg.get(_loc10_,_loc5_);
                  }
                  _loc17_ = _loc16_;
                  _loc15_.segment = _loc17_;
                  _loc14_.segment = _loc17_;
                  _loc3_.insert(_loc14_);
                  _loc3_.insert(_loc15_);
                  _loc5_.links.insert(_loc10_);
                  _loc10_.links.insert(_loc5_);
               }
               _loc5_ = _loc10_;
               if(_loc4_ == null)
               {
                  _loc4_ = _loc10_;
               }
               _loc8_ = _loc8_.next;
            }
            while(_loc8_ != _loc7_);
            
         }
         _loc14_ = ZPP_SimpleEvent.get(_loc5_);
         _loc15_ = ZPP_SimpleEvent.get(_loc4_);
         if(ZPP_SimpleEvent.less_xy(_loc14_,_loc15_))
         {
            _loc14_.type = 1;
            _loc15_.type = 2;
            _loc16_ = ZPP_SimpleSeg.get(_loc5_,_loc4_);
         }
         else
         {
            _loc14_.type = 2;
            _loc15_.type = 1;
            _loc16_ = ZPP_SimpleSeg.get(_loc4_,_loc5_);
         }
         _loc17_ = _loc16_;
         _loc15_.segment = _loc17_;
         _loc14_.segment = _loc17_;
         _loc3_.insert(_loc14_);
         _loc3_.insert(_loc15_);
         _loc5_.links.insert(_loc4_);
         _loc4_.links.insert(_loc5_);
         if(ZPP_Set_ZPP_SimpleEvent.zpp_pool == null)
         {
            _loc18_ = new ZPP_Set_ZPP_SimpleEvent();
         }
         else
         {
            _loc18_ = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
            ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc18_.next;
            _loc18_.next = null;
         }
         _loc18_.alloc();
         _loc18_.lt = ZPP_SimpleEvent.less_xy;
         while(!_loc3_.empty())
         {
            _loc14_ = _loc3_.pop_front();
            ZPP_Simple.sweep.sweepx = _loc14_.vertex.x;
            if(_loc14_.type == 1)
            {
               _loc16_ = _loc14_.segment;
               ZPP_Simple.sweep.add(_loc16_);
               if(_loc16_.next != null && _loc16_ != null && !(_loc16_.next.id < _loc16_.id?Boolean(ZPP_Simple.inthash.has(_loc16_.next.id,_loc16_.id)):Boolean(ZPP_Simple.inthash.has(_loc16_.id,_loc16_.next.id))))
               {
                  _loc15_ = ZPP_Simple.sweep.intersection(_loc16_.next,_loc16_);
                  if(_loc15_ != null)
                  {
                     if(_loc15_.vertex.x >= ZPP_Simple.sweep.sweepx)
                     {
                        _loc20_ = _loc3_.parent;
                        while(_loc20_ != null)
                        {
                           if(_loc3_.lt(_loc15_,_loc20_.data))
                           {
                              _loc20_ = _loc20_.prev;
                              continue;
                           }
                           if(_loc3_.lt(_loc20_.data,_loc15_))
                           {
                              _loc20_ = _loc20_.next;
                              continue;
                           }
                           break;
                        }
                        _loc19_ = _loc20_;
                        if(_loc19_ == null)
                        {
                           _loc21_ = _loc18_.parent;
                           while(_loc21_ != null)
                           {
                              if(_loc18_.lt(_loc15_,_loc21_.data))
                              {
                                 _loc21_ = _loc21_.prev;
                                 continue;
                              }
                              if(_loc18_.lt(_loc21_.data,_loc15_))
                              {
                                 _loc21_ = _loc21_.next;
                                 continue;
                              }
                              break;
                           }
                           _loc20_ = _loc21_;
                           if(_loc20_ != null)
                           {
                              _loc10_ = _loc15_.vertex;
                              _loc10_.free();
                              _loc10_.next = ZPP_SimpleVert.zpp_pool;
                              ZPP_SimpleVert.zpp_pool = _loc10_;
                              _loc15_.vertex = _loc20_.data.vertex;
                              _loc20_.data = _loc15_;
                              _loc3_.insert(_loc15_);
                           }
                           else
                           {
                              _loc3_.insert(_loc15_);
                              _loc18_.insert(_loc15_);
                           }
                           if(_loc16_.next.id < _loc16_.id)
                           {
                              ZPP_Simple.inthash.add(Hashable2_Bool.get(_loc16_.next.id,_loc16_.id,true));
                           }
                           else
                           {
                              ZPP_Simple.inthash.add(Hashable2_Bool.get(_loc16_.id,_loc16_.next.id,true));
                           }
                        }
                        else
                        {
                           _loc22_ = _loc19_.data;
                           _loc10_ = _loc15_.vertex;
                           _loc10_.free();
                           _loc10_.next = ZPP_SimpleVert.zpp_pool;
                           ZPP_SimpleVert.zpp_pool = _loc10_;
                           _loc23_ = _loc15_;
                           _loc23_.free();
                           _loc23_.next = ZPP_SimpleEvent.zpp_pool;
                           ZPP_SimpleEvent.zpp_pool = _loc23_;
                        }
                     }
                     else
                     {
                        _loc10_ = _loc15_.vertex;
                        _loc10_.free();
                        _loc10_.next = ZPP_SimpleVert.zpp_pool;
                        ZPP_SimpleVert.zpp_pool = _loc10_;
                        _loc22_ = _loc15_;
                        _loc22_.free();
                        _loc22_.next = ZPP_SimpleEvent.zpp_pool;
                        ZPP_SimpleEvent.zpp_pool = _loc22_;
                     }
                  }
               }
               if(_loc16_ != null && _loc16_.prev != null && !(_loc16_.id < _loc16_.prev.id?Boolean(ZPP_Simple.inthash.has(_loc16_.id,_loc16_.prev.id)):Boolean(ZPP_Simple.inthash.has(_loc16_.prev.id,_loc16_.id))))
               {
                  _loc15_ = ZPP_Simple.sweep.intersection(_loc16_,_loc16_.prev);
                  if(_loc15_ != null)
                  {
                     if(_loc15_.vertex.x >= ZPP_Simple.sweep.sweepx)
                     {
                        _loc20_ = _loc3_.parent;
                        while(_loc20_ != null)
                        {
                           if(_loc3_.lt(_loc15_,_loc20_.data))
                           {
                              _loc20_ = _loc20_.prev;
                              continue;
                           }
                           if(_loc3_.lt(_loc20_.data,_loc15_))
                           {
                              _loc20_ = _loc20_.next;
                              continue;
                           }
                           break;
                        }
                        _loc19_ = _loc20_;
                        if(_loc19_ == null)
                        {
                           _loc21_ = _loc18_.parent;
                           while(_loc21_ != null)
                           {
                              if(_loc18_.lt(_loc15_,_loc21_.data))
                              {
                                 _loc21_ = _loc21_.prev;
                                 continue;
                              }
                              if(_loc18_.lt(_loc21_.data,_loc15_))
                              {
                                 _loc21_ = _loc21_.next;
                                 continue;
                              }
                              break;
                           }
                           _loc20_ = _loc21_;
                           if(_loc20_ != null)
                           {
                              _loc10_ = _loc15_.vertex;
                              _loc10_.free();
                              _loc10_.next = ZPP_SimpleVert.zpp_pool;
                              ZPP_SimpleVert.zpp_pool = _loc10_;
                              _loc15_.vertex = _loc20_.data.vertex;
                              _loc20_.data = _loc15_;
                              _loc3_.insert(_loc15_);
                           }
                           else
                           {
                              _loc3_.insert(_loc15_);
                              _loc18_.insert(_loc15_);
                           }
                           if(_loc16_.id < _loc16_.prev.id)
                           {
                              ZPP_Simple.inthash.add(Hashable2_Bool.get(_loc16_.id,_loc16_.prev.id,true));
                           }
                           else
                           {
                              ZPP_Simple.inthash.add(Hashable2_Bool.get(_loc16_.prev.id,_loc16_.id,true));
                           }
                        }
                        else
                        {
                           _loc22_ = _loc19_.data;
                           _loc10_ = _loc15_.vertex;
                           _loc10_.free();
                           _loc10_.next = ZPP_SimpleVert.zpp_pool;
                           ZPP_SimpleVert.zpp_pool = _loc10_;
                           _loc23_ = _loc15_;
                           _loc23_.free();
                           _loc23_.next = ZPP_SimpleEvent.zpp_pool;
                           ZPP_SimpleEvent.zpp_pool = _loc23_;
                        }
                     }
                     else
                     {
                        _loc10_ = _loc15_.vertex;
                        _loc10_.free();
                        _loc10_.next = ZPP_SimpleVert.zpp_pool;
                        ZPP_SimpleVert.zpp_pool = _loc10_;
                        _loc22_ = _loc15_;
                        _loc22_.free();
                        _loc22_.next = ZPP_SimpleEvent.zpp_pool;
                        ZPP_SimpleEvent.zpp_pool = _loc22_;
                     }
                  }
               }
            }
            else if(_loc14_.type == 2)
            {
               _loc16_ = _loc14_.segment;
               if(_loc16_.node != null)
               {
                  _loc17_ = _loc16_.next;
                  _loc24_ = _loc16_.prev;
                  ZPP_Simple.sweep.remove(_loc16_);
                  _loc25_ = _loc16_;
                  _loc25_.free();
                  _loc25_.next = ZPP_SimpleSeg.zpp_pool;
                  ZPP_SimpleSeg.zpp_pool = _loc25_;
                  if(_loc17_ != null && _loc24_ != null && !(_loc17_.id < _loc24_.id?Boolean(ZPP_Simple.inthash.has(_loc17_.id,_loc24_.id)):Boolean(ZPP_Simple.inthash.has(_loc24_.id,_loc17_.id))))
                  {
                     _loc15_ = ZPP_Simple.sweep.intersection(_loc17_,_loc24_);
                     if(_loc15_ != null)
                     {
                        if(_loc15_.vertex.x >= ZPP_Simple.sweep.sweepx)
                        {
                           _loc20_ = _loc3_.parent;
                           while(_loc20_ != null)
                           {
                              if(_loc3_.lt(_loc15_,_loc20_.data))
                              {
                                 _loc20_ = _loc20_.prev;
                                 continue;
                              }
                              if(_loc3_.lt(_loc20_.data,_loc15_))
                              {
                                 _loc20_ = _loc20_.next;
                                 continue;
                              }
                              break;
                           }
                           _loc19_ = _loc20_;
                           if(_loc19_ == null)
                           {
                              _loc21_ = _loc18_.parent;
                              while(_loc21_ != null)
                              {
                                 if(_loc18_.lt(_loc15_,_loc21_.data))
                                 {
                                    _loc21_ = _loc21_.prev;
                                    continue;
                                 }
                                 if(_loc18_.lt(_loc21_.data,_loc15_))
                                 {
                                    _loc21_ = _loc21_.next;
                                    continue;
                                 }
                                 break;
                              }
                              _loc20_ = _loc21_;
                              if(_loc20_ != null)
                              {
                                 _loc10_ = _loc15_.vertex;
                                 _loc10_.free();
                                 _loc10_.next = ZPP_SimpleVert.zpp_pool;
                                 ZPP_SimpleVert.zpp_pool = _loc10_;
                                 _loc15_.vertex = _loc20_.data.vertex;
                                 _loc20_.data = _loc15_;
                                 _loc3_.insert(_loc15_);
                              }
                              else
                              {
                                 _loc3_.insert(_loc15_);
                                 _loc18_.insert(_loc15_);
                              }
                              if(_loc17_.id < _loc24_.id)
                              {
                                 ZPP_Simple.inthash.add(Hashable2_Bool.get(_loc17_.id,_loc24_.id,true));
                              }
                              else
                              {
                                 ZPP_Simple.inthash.add(Hashable2_Bool.get(_loc24_.id,_loc17_.id,true));
                              }
                           }
                           else
                           {
                              _loc22_ = _loc19_.data;
                              _loc10_ = _loc15_.vertex;
                              _loc10_.free();
                              _loc10_.next = ZPP_SimpleVert.zpp_pool;
                              ZPP_SimpleVert.zpp_pool = _loc10_;
                              _loc23_ = _loc15_;
                              _loc23_.free();
                              _loc23_.next = ZPP_SimpleEvent.zpp_pool;
                              ZPP_SimpleEvent.zpp_pool = _loc23_;
                           }
                        }
                        else
                        {
                           _loc10_ = _loc15_.vertex;
                           _loc10_.free();
                           _loc10_.next = ZPP_SimpleVert.zpp_pool;
                           ZPP_SimpleVert.zpp_pool = _loc10_;
                           _loc22_ = _loc15_;
                           _loc22_.free();
                           _loc22_.next = ZPP_SimpleEvent.zpp_pool;
                           ZPP_SimpleEvent.zpp_pool = _loc22_;
                        }
                     }
                  }
               }
            }
            else
            {
               _loc10_ = _loc14_.vertex;
               _loc26_ = _loc10_.node == null;
               _loc16_ = _loc14_.segment;
               _loc17_ = _loc14_.segment2;
               if(_loc17_.next != _loc16_)
               {
                  _loc24_ = _loc16_;
                  _loc16_ = _loc17_;
                  _loc17_ = _loc24_;
               }
               _loc11_ = _loc16_.vertices.parent;
               while(_loc11_ != null)
               {
                  if(_loc16_.vertices.lt(_loc10_,_loc11_.data))
                  {
                     _loc11_ = _loc11_.prev;
                     continue;
                  }
                  if(_loc16_.vertices.lt(_loc11_.data,_loc10_))
                  {
                     _loc11_ = _loc11_.next;
                     continue;
                  }
                  break;
               }
               _loc27_ = _loc11_ == null;
               _loc11_ = _loc17_.vertices.parent;
               while(_loc11_ != null)
               {
                  if(_loc17_.vertices.lt(_loc10_,_loc11_.data))
                  {
                     _loc11_ = _loc11_.prev;
                     continue;
                  }
                  if(_loc17_.vertices.lt(_loc11_.data,_loc10_))
                  {
                     _loc11_ = _loc11_.next;
                     continue;
                  }
                  break;
               }
               _loc28_ = _loc11_ == null;
               if(_loc27_)
               {
                  _loc11_ = _loc16_.vertices.insert(_loc10_);
                  _loc13_ = _loc10_ == _loc16_.left?_loc10_:_loc16_.vertices.predecessor_node(_loc11_).data;
                  _loc29_ = _loc10_ == _loc16_.right?_loc10_:_loc16_.vertices.successor_node(_loc11_).data;
                  _loc13_.links.remove(_loc29_);
                  if(_loc10_ != _loc13_)
                  {
                     _loc13_.links.insert(_loc10_);
                  }
                  _loc29_.links.remove(_loc13_);
                  if(_loc10_ != _loc29_)
                  {
                     _loc29_.links.insert(_loc10_);
                  }
                  if(_loc10_ != _loc13_)
                  {
                     _loc10_.links.insert(_loc13_);
                  }
                  if(_loc10_ != _loc29_)
                  {
                     _loc10_.links.insert(_loc29_);
                  }
               }
               if(_loc28_)
               {
                  _loc11_ = _loc17_.vertices.insert(_loc10_);
                  _loc13_ = _loc10_ == _loc17_.left?_loc10_:_loc17_.vertices.predecessor_node(_loc11_).data;
                  _loc29_ = _loc10_ == _loc17_.right?_loc10_:_loc17_.vertices.successor_node(_loc11_).data;
                  _loc13_.links.remove(_loc29_);
                  if(_loc10_ != _loc13_)
                  {
                     _loc13_.links.insert(_loc10_);
                  }
                  _loc29_.links.remove(_loc13_);
                  if(_loc10_ != _loc29_)
                  {
                     _loc29_.links.insert(_loc10_);
                  }
                  if(_loc10_ != _loc13_)
                  {
                     _loc10_.links.insert(_loc13_);
                  }
                  if(_loc10_ != _loc29_)
                  {
                     _loc10_.links.insert(_loc29_);
                  }
               }
               if(_loc26_)
               {
                  _loc10_.node = _loc2_.insert(_loc10_);
               }
               _loc10_.forced = true;
               if(_loc26_)
               {
                  _loc30_ = _loc16_.node;
                  _loc31_ = _loc17_.node;
                  _loc30_.data = _loc17_;
                  _loc31_.data = _loc16_;
                  _loc16_.node = _loc31_;
                  _loc17_.node = _loc30_;
                  _loc17_.next = _loc16_.next;
                  _loc16_.next = _loc17_;
                  _loc16_.prev = _loc17_.prev;
                  _loc17_.prev = _loc16_;
                  if(_loc16_.prev != null)
                  {
                     _loc16_.prev.next = _loc16_;
                  }
                  if(_loc17_.next != null)
                  {
                     _loc17_.next.prev = _loc17_;
                  }
               }
               if(_loc17_.next != null && _loc17_ != null && !(_loc17_.next.id < _loc17_.id?Boolean(ZPP_Simple.inthash.has(_loc17_.next.id,_loc17_.id)):Boolean(ZPP_Simple.inthash.has(_loc17_.id,_loc17_.next.id))))
               {
                  _loc15_ = ZPP_Simple.sweep.intersection(_loc17_.next,_loc17_);
                  if(_loc15_ != null)
                  {
                     if(_loc15_.vertex.x >= ZPP_Simple.sweep.sweepx)
                     {
                        _loc20_ = _loc3_.parent;
                        while(_loc20_ != null)
                        {
                           if(_loc3_.lt(_loc15_,_loc20_.data))
                           {
                              _loc20_ = _loc20_.prev;
                              continue;
                           }
                           if(_loc3_.lt(_loc20_.data,_loc15_))
                           {
                              _loc20_ = _loc20_.next;
                              continue;
                           }
                           break;
                        }
                        _loc19_ = _loc20_;
                        if(_loc19_ == null)
                        {
                           _loc21_ = _loc18_.parent;
                           while(_loc21_ != null)
                           {
                              if(_loc18_.lt(_loc15_,_loc21_.data))
                              {
                                 _loc21_ = _loc21_.prev;
                                 continue;
                              }
                              if(_loc18_.lt(_loc21_.data,_loc15_))
                              {
                                 _loc21_ = _loc21_.next;
                                 continue;
                              }
                              break;
                           }
                           _loc20_ = _loc21_;
                           if(_loc20_ != null)
                           {
                              _loc13_ = _loc15_.vertex;
                              _loc13_.free();
                              _loc13_.next = ZPP_SimpleVert.zpp_pool;
                              ZPP_SimpleVert.zpp_pool = _loc13_;
                              _loc15_.vertex = _loc20_.data.vertex;
                              _loc20_.data = _loc15_;
                              _loc3_.insert(_loc15_);
                           }
                           else
                           {
                              _loc3_.insert(_loc15_);
                              _loc18_.insert(_loc15_);
                           }
                           if(_loc17_.next.id < _loc17_.id)
                           {
                              ZPP_Simple.inthash.add(Hashable2_Bool.get(_loc17_.next.id,_loc17_.id,true));
                           }
                           else
                           {
                              ZPP_Simple.inthash.add(Hashable2_Bool.get(_loc17_.id,_loc17_.next.id,true));
                           }
                        }
                        else
                        {
                           _loc22_ = _loc19_.data;
                           _loc13_ = _loc15_.vertex;
                           _loc13_.free();
                           _loc13_.next = ZPP_SimpleVert.zpp_pool;
                           ZPP_SimpleVert.zpp_pool = _loc13_;
                           _loc23_ = _loc15_;
                           _loc23_.free();
                           _loc23_.next = ZPP_SimpleEvent.zpp_pool;
                           ZPP_SimpleEvent.zpp_pool = _loc23_;
                        }
                     }
                     else
                     {
                        _loc13_ = _loc15_.vertex;
                        _loc13_.free();
                        _loc13_.next = ZPP_SimpleVert.zpp_pool;
                        ZPP_SimpleVert.zpp_pool = _loc13_;
                        _loc22_ = _loc15_;
                        _loc22_.free();
                        _loc22_.next = ZPP_SimpleEvent.zpp_pool;
                        ZPP_SimpleEvent.zpp_pool = _loc22_;
                     }
                  }
               }
               if(_loc16_ != null && _loc16_.prev != null && !(_loc16_.id < _loc16_.prev.id?Boolean(ZPP_Simple.inthash.has(_loc16_.id,_loc16_.prev.id)):Boolean(ZPP_Simple.inthash.has(_loc16_.prev.id,_loc16_.id))))
               {
                  _loc15_ = ZPP_Simple.sweep.intersection(_loc16_,_loc16_.prev);
                  if(_loc15_ != null)
                  {
                     if(_loc15_.vertex.x >= ZPP_Simple.sweep.sweepx)
                     {
                        _loc20_ = _loc3_.parent;
                        while(_loc20_ != null)
                        {
                           if(_loc3_.lt(_loc15_,_loc20_.data))
                           {
                              _loc20_ = _loc20_.prev;
                              continue;
                           }
                           if(_loc3_.lt(_loc20_.data,_loc15_))
                           {
                              _loc20_ = _loc20_.next;
                              continue;
                           }
                           break;
                        }
                        _loc19_ = _loc20_;
                        if(_loc19_ == null)
                        {
                           _loc21_ = _loc18_.parent;
                           while(_loc21_ != null)
                           {
                              if(_loc18_.lt(_loc15_,_loc21_.data))
                              {
                                 _loc21_ = _loc21_.prev;
                                 continue;
                              }
                              if(_loc18_.lt(_loc21_.data,_loc15_))
                              {
                                 _loc21_ = _loc21_.next;
                                 continue;
                              }
                              break;
                           }
                           _loc20_ = _loc21_;
                           if(_loc20_ != null)
                           {
                              _loc13_ = _loc15_.vertex;
                              _loc13_.free();
                              _loc13_.next = ZPP_SimpleVert.zpp_pool;
                              ZPP_SimpleVert.zpp_pool = _loc13_;
                              _loc15_.vertex = _loc20_.data.vertex;
                              _loc20_.data = _loc15_;
                              _loc3_.insert(_loc15_);
                           }
                           else
                           {
                              _loc3_.insert(_loc15_);
                              _loc18_.insert(_loc15_);
                           }
                           if(_loc16_.id < _loc16_.prev.id)
                           {
                              ZPP_Simple.inthash.add(Hashable2_Bool.get(_loc16_.id,_loc16_.prev.id,true));
                           }
                           else
                           {
                              ZPP_Simple.inthash.add(Hashable2_Bool.get(_loc16_.prev.id,_loc16_.id,true));
                           }
                        }
                        else
                        {
                           _loc22_ = _loc19_.data;
                           _loc13_ = _loc15_.vertex;
                           _loc13_.free();
                           _loc13_.next = ZPP_SimpleVert.zpp_pool;
                           ZPP_SimpleVert.zpp_pool = _loc13_;
                           _loc23_ = _loc15_;
                           _loc23_.free();
                           _loc23_.next = ZPP_SimpleEvent.zpp_pool;
                           ZPP_SimpleEvent.zpp_pool = _loc23_;
                        }
                     }
                     else
                     {
                        _loc13_ = _loc15_.vertex;
                        _loc13_.free();
                        _loc13_.next = ZPP_SimpleVert.zpp_pool;
                        ZPP_SimpleVert.zpp_pool = _loc13_;
                        _loc22_ = _loc15_;
                        _loc22_.free();
                        _loc22_.next = ZPP_SimpleEvent.zpp_pool;
                        ZPP_SimpleEvent.zpp_pool = _loc22_;
                     }
                  }
               }
               _loc18_.remove(_loc14_);
            }
            _loc15_ = _loc14_;
            _loc15_.free();
            _loc15_.next = ZPP_SimpleEvent.zpp_pool;
            ZPP_SimpleEvent.zpp_pool = _loc15_;
         }
         _loc19_ = _loc3_;
         _loc19_.free();
         _loc19_.next = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
         ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc19_;
         _loc19_ = _loc18_;
         _loc19_.free();
         _loc19_.next = ZPP_Set_ZPP_SimpleEvent.zpp_pool;
         ZPP_Set_ZPP_SimpleEvent.zpp_pool = _loc19_;
         var _loc32_:int = 0;
         var _loc33_:int = ZPP_Simple.inthash.table.length;
         while(_loc32_ < _loc33_)
         {
            _loc32_++;
            _loc34_ = _loc32_;
            _loc35_ = ZPP_Simple.inthash.table[_loc34_];
            if(_loc35_ != null)
            {
               while(_loc35_ != null)
               {
                  _loc36_ = _loc35_.hnext;
                  _loc35_.hnext = null;
                  _loc35_;
                  _loc35_ = _loc36_;
               }
               ZPP_Simple.inthash.table[_loc34_] = null;
            }
         }
         var _loc37_:ZNPList_ZPP_GeomVert = new ZNPList_ZPP_GeomVert();
         while(!_loc2_.empty())
         {
            ZPP_Simple.clip_polygon(_loc2_,_loc37_);
         }
         _loc11_ = _loc2_;
         _loc11_.free();
         _loc11_.next = ZPP_Set_ZPP_SimpleVert.zpp_pool;
         ZPP_Set_ZPP_SimpleVert.zpp_pool = _loc11_;
         return _loc37_;
      }
      
      public static function clip_polygon(param1:ZPP_Set_ZPP_SimpleVert, param2:ZNPList_ZPP_GeomVert) : void
      {
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:* = null as ZPP_GeomVert;
         var _loc15_:* = null as ZPP_GeomVert;
         var _loc16_:* = null as ZPP_SimpleVert;
         var _loc17_:* = null as ZPP_Set_ZPP_SimpleVert;
         var _loc18_:* = null as ZPP_SimpleVert;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         var _loc3_:ZPP_GeomVert = null;
         var _loc4_:ZPP_SimpleVert = param1.first();
         var _loc5_:ZPP_SimpleVert = _loc4_;
         var _loc6_:ZPP_Set_ZPP_SimpleVert = _loc4_.links.parent;
         var _loc7_:ZPP_Set_ZPP_SimpleVert = _loc6_.prev == null?_loc6_.next:_loc6_.prev;
         var _loc8_:ZPP_SimpleVert = _loc6_.data;
         var _loc9_:ZPP_SimpleVert = _loc7_.data;
         _loc10_ = _loc4_.x - _loc8_.x;
         _loc11_ = _loc4_.y - _loc8_.y;
         _loc12_ = _loc9_.x - _loc4_.x;
         _loc13_ = _loc9_.y - _loc4_.y;
         if(_loc13_ * _loc10_ - _loc12_ * _loc11_ < 0)
         {
            _loc9_ = _loc8_;
         }
         _loc14_ = ZPP_GeomVert.get(_loc4_.x,_loc4_.y);
         if(_loc3_ == null)
         {
            _loc15_ = _loc14_;
            _loc14_.next = _loc15_;
            _loc15_ = _loc15_;
            _loc14_.prev = _loc15_;
            _loc3_ = _loc15_;
         }
         else
         {
            _loc14_.prev = _loc3_;
            _loc14_.next = _loc3_.next;
            _loc3_.next.prev = _loc14_;
            _loc3_.next = _loc14_;
         }
         _loc3_ = _loc14_;
         _loc3_.forced = _loc4_.forced;
         while(true)
         {
            _loc4_.links.remove(_loc9_);
            _loc9_.links.remove(_loc4_);
            if(_loc9_ == _loc5_)
            {
               break;
            }
            _loc14_ = ZPP_GeomVert.get(_loc9_.x,_loc9_.y);
            if(_loc3_ == null)
            {
               _loc15_ = _loc14_;
               _loc14_.next = _loc15_;
               _loc15_ = _loc15_;
               _loc14_.prev = _loc15_;
               _loc3_ = _loc15_;
            }
            else
            {
               _loc14_.prev = _loc3_;
               _loc14_.next = _loc3_.next;
               _loc3_.next.prev = _loc14_;
               _loc3_.next = _loc14_;
            }
            _loc3_ = _loc14_;
            _loc3_.forced = _loc9_.forced;
            if(_loc9_.links.singular())
            {
               if(_loc4_.links.empty())
               {
                  param1.remove(_loc4_);
                  _loc16_ = _loc4_;
                  _loc16_.free();
                  _loc16_.next = ZPP_SimpleVert.zpp_pool;
                  ZPP_SimpleVert.zpp_pool = _loc16_;
               }
               _loc4_ = _loc9_;
               _loc9_ = _loc9_.links.parent.data;
            }
            else
            {
               _loc16_ = null;
               _loc10_ = 0;
               if(!_loc9_.links.empty())
               {
                  _loc17_ = _loc9_.links.parent;
                  while(_loc17_.prev != null)
                  {
                     _loc17_ = _loc17_.prev;
                  }
                  while(_loc17_ != null)
                  {
                     _loc18_ = _loc17_.data;
                     if(_loc16_ == null)
                     {
                        _loc16_ = _loc18_;
                        _loc11_ = _loc9_.x - _loc4_.x;
                        _loc12_ = _loc9_.y - _loc4_.y;
                        _loc13_ = _loc18_.x - _loc9_.x;
                        _loc19_ = _loc18_.y - _loc9_.y;
                        _loc10_ = _loc19_ * _loc11_ - _loc13_ * _loc12_;
                     }
                     else
                     {
                        _loc12_ = _loc9_.x - _loc4_.x;
                        _loc13_ = _loc9_.y - _loc4_.y;
                        _loc19_ = _loc18_.x - _loc9_.x;
                        _loc20_ = _loc18_.y - _loc9_.y;
                        _loc11_ = _loc20_ * _loc12_ - _loc19_ * _loc13_;
                        if(_loc11_ > 0 && _loc10_ <= 0)
                        {
                           _loc16_ = _loc18_;
                           _loc10_ = _loc11_;
                        }
                        else if(_loc10_ * _loc11_ >= 0)
                        {
                           _loc13_ = _loc9_.x - _loc18_.x;
                           _loc19_ = _loc9_.y - _loc18_.y;
                           _loc20_ = _loc16_.x - _loc9_.x;
                           _loc21_ = _loc16_.y - _loc9_.y;
                           _loc12_ = _loc21_ * _loc13_ - _loc20_ * _loc19_;
                           if(_loc12_ > 0)
                           {
                              _loc16_ = _loc18_;
                              _loc10_ = _loc11_;
                           }
                        }
                     }
                     if(_loc17_.next != null)
                     {
                        _loc17_ = _loc17_.next;
                        while(_loc17_.prev != null)
                        {
                           _loc17_ = _loc17_.prev;
                        }
                     }
                     else
                     {
                        while(_loc17_.parent != null && _loc17_ == _loc17_.parent.next)
                        {
                           _loc17_ = _loc17_.parent;
                        }
                        _loc17_ = _loc17_.parent;
                     }
                  }
               }
               if(_loc4_.links.empty())
               {
                  param1.remove(_loc4_);
                  _loc18_ = _loc4_;
                  _loc18_.free();
                  _loc18_.next = ZPP_SimpleVert.zpp_pool;
                  ZPP_SimpleVert.zpp_pool = _loc18_;
               }
               _loc4_ = _loc9_;
               _loc9_ = _loc16_;
            }
         }
         if(_loc4_.links.empty())
         {
            param1.remove(_loc4_);
            _loc16_ = _loc4_;
            _loc16_.free();
            _loc16_.next = ZPP_SimpleVert.zpp_pool;
            ZPP_SimpleVert.zpp_pool = _loc16_;
         }
         param1.remove(_loc5_);
         _loc16_ = _loc5_;
         _loc16_.free();
         _loc16_.next = ZPP_SimpleVert.zpp_pool;
         ZPP_SimpleVert.zpp_pool = _loc16_;
         param2.add(_loc3_);
      }
      
      public static function isSimple(param1:ZPP_GeomVert) : Boolean
      {
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as ZPP_GeomVert;
         var _loc9_:* = null as ZPP_SimpleVert;
         var _loc10_:* = null as ZPP_SimpleVert;
         var _loc11_:* = null as ZPP_SimpleEvent;
         var _loc12_:* = null as ZPP_SimpleEvent;
         var _loc13_:* = null as ZPP_SimpleSeg;
         var _loc15_:* = null as ZNPNode_ZPP_SimpleEvent;
         var _loc16_:* = null as ZNPNode_ZPP_SimpleEvent;
         var _loc17_:* = null as ZNPNode_ZPP_SimpleEvent;
         var _loc18_:* = null as ZNPNode_ZPP_SimpleEvent;
         var _loc19_:* = null as ZNPNode_ZPP_SimpleEvent;
         var _loc20_:* = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:int = 0;
         var _loc25_:* = null as ZPP_SimpleSeg;
         if(ZPP_Simple.sweep == null)
         {
            ZPP_Simple.sweep = new ZPP_SimpleSweep();
            ZPP_Simple.inthash = new FastHash2_Hashable2_Bool();
         }
         var _loc2_:ZNPList_ZPP_SimpleVert = new ZNPList_ZPP_SimpleVert();
         var _loc3_:ZPP_GeomVert = param1;
         var _loc4_:ZPP_GeomVert = param1;
         if(_loc3_ != null)
         {
            _loc5_ = _loc3_;
            do
            {
               _loc6_ = _loc5_;
               _loc2_.add(ZPP_SimpleVert.get(_loc6_.x,_loc6_.y));
               _loc5_ = _loc5_.next;
            }
            while(_loc5_ != _loc4_);
            
         }
         var _loc7_:ZNPList_ZPP_SimpleEvent = new ZNPList_ZPP_SimpleEvent();
         var _loc8_:ZNPNode_ZPP_SimpleVert = _loc2_.head;
         _loc9_ = _loc8_.elt;
         _loc8_ = _loc8_.next;
         while(_loc8_ != null)
         {
            _loc10_ = _loc8_.elt;
            _loc11_ = _loc7_.add(ZPP_SimpleEvent.get(_loc9_));
            _loc12_ = _loc7_.add(ZPP_SimpleEvent.get(_loc10_));
            §§push(_loc11_);
            §§push(_loc12_);
            if(ZPP_SimpleEvent.less_xy(_loc11_,_loc12_))
            {
               _loc11_.type = 1;
               _loc12_.type = 2;
               §§push(ZPP_SimpleSeg.get(_loc9_,_loc10_));
            }
            else
            {
               _loc11_.type = 2;
               _loc12_.type = 1;
               §§push(ZPP_SimpleSeg.get(_loc10_,_loc9_));
            }
            _loc13_ = §§pop();
            §§pop().segment = _loc13_;
            §§pop().segment = _loc13_;
            _loc9_ = _loc10_;
            _loc8_ = _loc8_.next;
         }
         _loc10_ = _loc2_.head.elt;
         _loc11_ = _loc7_.add(ZPP_SimpleEvent.get(_loc9_));
         _loc12_ = _loc7_.add(ZPP_SimpleEvent.get(_loc10_));
         §§push(_loc11_);
         §§push(_loc12_);
         if(ZPP_SimpleEvent.less_xy(_loc11_,_loc12_))
         {
            _loc11_.type = 1;
            _loc12_.type = 2;
            §§push(ZPP_SimpleSeg.get(_loc9_,_loc10_));
         }
         else
         {
            _loc11_.type = 2;
            _loc12_.type = 1;
            §§push(ZPP_SimpleSeg.get(_loc10_,_loc9_));
         }
         _loc13_ = §§pop();
         §§pop().segment = _loc13_;
         §§pop().segment = _loc13_;
         var _loc14_:ZNPList_ZPP_SimpleEvent = _loc7_;
         if(_loc14_.head != null && _loc14_.head.next != null)
         {
            _loc15_ = _loc14_.head;
            _loc16_ = null;
            _loc17_ = null;
            _loc18_ = null;
            _loc19_ = null;
            _loc20_ = 1;
            do
            {
               _loc21_ = 0;
               _loc17_ = _loc15_;
               _loc15_ = null;
               _loc16_ = _loc15_;
               while(_loc17_ != null)
               {
                  _loc21_++;
                  _loc18_ = _loc17_;
                  _loc22_ = 0;
                  _loc23_ = _loc20_;
                  while(_loc18_ != null && _loc22_ < _loc20_)
                  {
                     _loc22_++;
                     _loc18_ = _loc18_.next;
                  }
                  while(_loc22_ > 0 || _loc23_ > 0 && _loc18_ != null)
                  {
                     if(_loc22_ == 0)
                     {
                        _loc19_ = _loc18_;
                        _loc18_ = _loc18_.next;
                        _loc23_--;
                     }
                     else if(_loc23_ == 0 || _loc18_ == null)
                     {
                        _loc19_ = _loc17_;
                        _loc17_ = _loc17_.next;
                        _loc22_--;
                     }
                     else if(ZPP_SimpleEvent.less_xy(_loc17_.elt,_loc18_.elt))
                     {
                        _loc19_ = _loc17_;
                        _loc17_ = _loc17_.next;
                        _loc22_--;
                     }
                     else
                     {
                        _loc19_ = _loc18_;
                        _loc18_ = _loc18_.next;
                        _loc23_--;
                     }
                     if(_loc16_ != null)
                     {
                        _loc16_.next = _loc19_;
                     }
                     else
                     {
                        _loc15_ = _loc19_;
                     }
                     _loc16_ = _loc19_;
                  }
                  _loc17_ = _loc18_;
               }
               _loc16_.next = null;
               _loc20_ = _loc20_ << 1;
            }
            while(_loc21_ > 1);
            
            _loc14_.head = _loc15_;
            _loc14_.modified = true;
            _loc14_.pushmod = true;
         }
         var _loc24_:Boolean = true;
         while(_loc7_.head != null)
         {
            _loc11_ = _loc7_.pop_unsafe();
            _loc13_ = _loc11_.segment;
            if(_loc11_.type == 1)
            {
               ZPP_Simple.sweep.add(_loc13_);
               if(ZPP_Simple.sweep.intersect(_loc13_,_loc13_.next) || ZPP_Simple.sweep.intersect(_loc13_,_loc13_.prev))
               {
                  _loc24_ = false;
                  break;
               }
            }
            else if(_loc11_.type == 2)
            {
               if(ZPP_Simple.sweep.intersect(_loc13_.prev,_loc13_.next))
               {
                  _loc24_ = false;
                  break;
               }
               ZPP_Simple.sweep.remove(_loc13_);
               _loc25_ = _loc13_;
               _loc25_.free();
               _loc25_.next = ZPP_SimpleSeg.zpp_pool;
               ZPP_SimpleSeg.zpp_pool = _loc25_;
            }
            _loc12_ = _loc11_;
            _loc12_.free();
            _loc12_.next = ZPP_SimpleEvent.zpp_pool;
            ZPP_SimpleEvent.zpp_pool = _loc12_;
         }
         while(_loc7_.head != null)
         {
            _loc11_ = _loc7_.pop_unsafe();
            if(_loc11_.type == 2)
            {
               _loc13_ = _loc11_.segment;
               _loc13_.free();
               _loc13_.next = ZPP_SimpleSeg.zpp_pool;
               ZPP_SimpleSeg.zpp_pool = _loc13_;
            }
            _loc12_ = _loc11_;
            _loc12_.free();
            _loc12_.next = ZPP_SimpleEvent.zpp_pool;
            ZPP_SimpleEvent.zpp_pool = _loc12_;
         }
         ZPP_Simple.sweep.clear();
         while(_loc2_.head != null)
         {
            _loc9_ = _loc2_.pop_unsafe();
            _loc9_.free();
            _loc9_.next = ZPP_SimpleVert.zpp_pool;
            ZPP_SimpleVert.zpp_pool = _loc9_;
         }
         return _loc24_;
      }
   }
}
