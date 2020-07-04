package zpp_nape.geom
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import nape.geom.Vec2;
   import zpp_nape.util.ZNPList_ZPP_PartitionVertex;
   import zpp_nape.util.ZNPNode_ZPP_PartitionVertex;
   import zpp_nape.util.ZPP_Set_ZPP_PartitionVertex;
   
   public class ZPP_Monotone
   {
       
      
      public function ZPP_Monotone()
      {
      }
      
      public static function bisector(param1:ZPP_PartitionVertex) : ZPP_Vec2
      {
         var _loc10_:* = null as ZPP_Vec2;
         var _loc2_:ZPP_PartitionVertex = param1.prev;
         var _loc3_:ZPP_PartitionVertex = param1.next;
         var _loc4_:Number = param1.x - _loc2_.x;
         var _loc5_:Number = param1.y - _loc2_.y;
         var _loc6_:Number = _loc3_.x - param1.x;
         var _loc7_:Number = _loc3_.y - param1.y;
         if(ZPP_Vec2.zpp_pool == null)
         {
            _loc10_ = new ZPP_Vec2();
         }
         else
         {
            _loc10_ = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc10_.next;
            _loc10_.next = null;
         }
         _loc10_.weak = false;
         _loc10_._immutable = false;
         _loc10_.x = -_loc5_ - _loc7_;
         _loc10_.y = Number(_loc4_ + _loc6_);
         var _loc8_:ZPP_Vec2 = _loc10_;
         var _loc11_:Number = Number(_loc8_.x * _loc8_.x + _loc8_.y * _loc8_.y);
         sf32(_loc11_,0);
         si32(1597463007 - (li32(0) >> 1),0);
         var _loc13_:Number = lf32(0);
         var _loc12_:Number = _loc13_ * (1.5 - 0.5 * _loc11_ * _loc13_ * _loc13_);
         _loc13_ = _loc12_;
         _loc8_.x = _loc8_.x * _loc13_;
         _loc8_.y = _loc8_.y * _loc13_;
         if(_loc7_ * _loc4_ - _loc6_ * _loc5_ < 0)
         {
            _loc8_.x = -_loc8_.x;
            _loc8_.y = -_loc8_.y;
         }
         return _loc8_;
      }
      
      public static function below(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
      {
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:Number = NaN;
         var _loc6_:Boolean = false;
         var _loc7_:* = null as ZPP_Vec2;
         if(param1.y < param2.y)
         {
            return true;
         }
         if(param1.y > param2.y)
         {
            return false;
         }
         if(param1.x < param2.x)
         {
            return true;
         }
         if(param1.x > param2.x)
         {
            return false;
         }
         _loc3_ = ZPP_Monotone.bisector(param1);
         _loc4_ = ZPP_Monotone.bisector(param2);
         _loc5_ = 1;
         _loc3_.x = Number(_loc3_.x + param1.x * _loc5_);
         _loc3_.y = Number(_loc3_.y + param1.y * _loc5_);
         _loc5_ = 1;
         _loc4_.x = Number(_loc4_.x + param2.x * _loc5_);
         _loc4_.y = Number(_loc4_.y + param2.y * _loc5_);
         _loc6_ = _loc3_.x < _loc4_.x || _loc3_.x == _loc4_.x && _loc3_.y < _loc4_.y;
         _loc7_ = _loc3_;
         if(_loc7_.outer != null)
         {
            _loc7_.outer.zpp_inner = null;
            _loc7_.outer = null;
         }
         _loc7_._isimmutable = null;
         _loc7_._validate = null;
         _loc7_._invalidate = null;
         _loc7_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc7_;
         _loc7_ = _loc4_;
         if(_loc7_.outer != null)
         {
            _loc7_.outer.zpp_inner = null;
            _loc7_.outer = null;
         }
         _loc7_._isimmutable = null;
         _loc7_._validate = null;
         _loc7_._invalidate = null;
         _loc7_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc7_;
         return _loc6_;
      }
      
      public static function above(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
      {
         return Boolean(ZPP_Monotone.below(param2,param1));
      }
      
      public static function left_vertex(param1:ZPP_PartitionVertex) : Boolean
      {
         var _loc2_:ZPP_PartitionVertex = param1.prev;
         return _loc2_.y > param1.y || _loc2_.y == param1.y && param1.next.y < param1.y;
      }
      
      public static function isMonotone(param1:ZPP_GeomVert) : Boolean
      {
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as ZPP_GeomVert;
         var _loc7_:* = null as ZPP_GeomVert;
         var _loc9_:* = null as ZPP_GeomVert;
         var _loc2_:ZPP_GeomVert = param1;
         var _loc3_:ZPP_GeomVert = param1;
         var _loc4_:ZPP_GeomVert = param1.next;
         _loc5_ = param1;
         if(_loc4_ != null)
         {
            _loc6_ = _loc4_;
            do
            {
               _loc7_ = _loc6_;
               if(_loc7_.y < _loc2_.y)
               {
                  _loc2_ = _loc7_;
               }
               if(_loc7_.y > _loc3_.y)
               {
                  _loc3_ = _loc7_;
               }
               _loc6_ = _loc6_.next;
            }
            while(_loc6_ != _loc5_);
            
         }
         var _loc8_:Boolean = true;
         _loc4_ = _loc2_;
         if(_loc3_ != _loc2_.next)
         {
            _loc5_ = _loc2_.next;
            _loc6_ = _loc3_;
            if(_loc5_ != null)
            {
               _loc7_ = _loc5_;
               do
               {
                  _loc9_ = _loc7_;
                  if(_loc9_.y < _loc4_.y)
                  {
                     _loc8_ = false;
                     break;
                  }
                  _loc4_ = _loc9_;
                  _loc7_ = _loc7_.next;
               }
               while(_loc7_ != _loc6_);
               
            }
         }
         if(!_loc8_)
         {
            return false;
         }
         _loc4_ = _loc2_;
         if(_loc3_ != _loc2_.prev)
         {
            _loc5_ = _loc2_.prev;
            _loc6_ = _loc3_;
            if(_loc5_ != null)
            {
               _loc7_ = _loc5_;
               do
               {
                  _loc9_ = _loc7_;
                  if(_loc9_.y < _loc4_.y)
                  {
                     _loc8_ = false;
                     break;
                  }
                  _loc4_ = _loc9_;
                  _loc7_ = _loc7_.prev;
               }
               while(_loc7_ != _loc6_);
               
            }
         }
         return _loc8_;
      }
      
      public static function decompose(param1:ZPP_GeomVert) : ZPP_PartitionedPoly
      {
         var _loc4_:* = null as ZPP_PartitionVertex;
         var _loc5_:* = null as ZPP_PartitionVertex;
         var _loc6_:* = null as ZPP_PartitionVertex;
         var _loc7_:* = null as ZPP_PartitionVertex;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:* = false;
         var _loc14_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc15_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc16_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc17_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc18_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc19_:* = 0;
         var _loc20_:int = 0;
         var _loc21_:int = 0;
         var _loc22_:int = 0;
         var _loc23_:* = null as ZPP_Set_ZPP_PartitionVertex;
         var _loc24_:* = null as ZPP_Set_ZPP_PartitionVertex;
         var _loc25_:* = null as ZPP_PartitionVertex;
         var _loc2_:ZPP_PartitionedPoly = new ZPP_PartitionedPoly(param1);
         var _loc3_:ZNPList_ZPP_PartitionVertex = new ZNPList_ZPP_PartitionVertex();
         _loc4_ = _loc2_.vertices;
         _loc5_ = _loc2_.vertices;
         if(_loc4_ != null)
         {
            _loc6_ = _loc4_;
            do
            {
               _loc7_ = _loc6_;
               _loc3_.add(_loc7_);
               _loc8_ = _loc7_.next.x - _loc7_.x;
               _loc9_ = _loc7_.next.y - _loc7_.y;
               _loc10_ = _loc7_.prev.x - _loc7_.x;
               _loc11_ = _loc7_.prev.y - _loc7_.y;
               _loc12_ = _loc11_ * _loc8_ - _loc10_ * _loc9_ > 0;
               _loc7_.type = !!ZPP_Monotone.below(_loc7_.prev,_loc7_)?!!ZPP_Monotone.below(_loc7_.next,_loc7_)?!!_loc12_?0:3:4:!!ZPP_Monotone.below(_loc7_,_loc7_.next)?!!_loc12_?1:2:4;
               _loc6_ = _loc6_.next;
            }
            while(_loc6_ != _loc5_);
            
         }
         var _loc13_:ZNPList_ZPP_PartitionVertex = _loc3_;
         if(_loc13_.head != null && _loc13_.head.next != null)
         {
            _loc14_ = _loc13_.head;
            _loc15_ = null;
            _loc16_ = null;
            _loc17_ = null;
            _loc18_ = null;
            _loc19_ = 1;
            do
            {
               _loc20_ = 0;
               _loc16_ = _loc14_;
               _loc14_ = null;
               _loc15_ = _loc14_;
               while(_loc16_ != null)
               {
                  _loc20_++;
                  _loc17_ = _loc16_;
                  _loc21_ = 0;
                  _loc22_ = _loc19_;
                  while(_loc17_ != null && _loc21_ < _loc19_)
                  {
                     _loc21_++;
                     _loc17_ = _loc17_.next;
                  }
                  while(_loc21_ > 0 || _loc22_ > 0 && _loc17_ != null)
                  {
                     if(_loc21_ == 0)
                     {
                        _loc18_ = _loc17_;
                        _loc17_ = _loc17_.next;
                        _loc22_--;
                     }
                     else if(_loc22_ == 0 || _loc17_ == null)
                     {
                        _loc18_ = _loc16_;
                        _loc16_ = _loc16_.next;
                        _loc21_--;
                     }
                     else if(ZPP_Monotone.above(_loc16_.elt,_loc17_.elt))
                     {
                        _loc18_ = _loc16_;
                        _loc16_ = _loc16_.next;
                        _loc21_--;
                     }
                     else
                     {
                        _loc18_ = _loc17_;
                        _loc17_ = _loc17_.next;
                        _loc22_--;
                     }
                     if(_loc15_ != null)
                     {
                        _loc15_.next = _loc18_;
                     }
                     else
                     {
                        _loc14_ = _loc18_;
                     }
                     _loc15_ = _loc18_;
                  }
                  _loc16_ = _loc17_;
               }
               _loc15_.next = null;
               _loc19_ = _loc19_ << 1;
            }
            while(_loc20_ > 1);
            
            _loc13_.head = _loc14_;
            _loc13_.modified = true;
            _loc13_.pushmod = true;
         }
         if(ZPP_Set_ZPP_PartitionVertex.zpp_pool == null)
         {
            _loc23_ = new ZPP_Set_ZPP_PartitionVertex();
         }
         else
         {
            _loc23_ = ZPP_Set_ZPP_PartitionVertex.zpp_pool;
            ZPP_Set_ZPP_PartitionVertex.zpp_pool = _loc23_.next;
            _loc23_.next = null;
         }
         _loc23_.alloc();
         _loc23_.lt = ZPP_PartitionVertex.edge_lt;
         _loc23_.swapped = ZPP_PartitionVertex.edge_swap;
         while(_loc3_.head != null)
         {
            _loc4_ = _loc3_.pop_unsafe();
            switch(_loc4_.type)
            {
               case 0:
                  _loc4_.helper = _loc4_;
                  _loc4_.node = _loc23_.insert(_loc4_);
                  continue;
               case 1:
                  _loc5_ = _loc4_.prev;
                  if(_loc5_.helper.type == 2)
                  {
                     _loc2_.add_diagonal(_loc4_,_loc5_.helper);
                  }
                  _loc23_.remove_node(_loc5_.node);
                  continue;
               case 2:
                  _loc5_ = _loc4_.prev;
                  if(_loc5_.helper.type == 2)
                  {
                     _loc2_.add_diagonal(_loc4_,_loc5_.helper);
                  }
                  _loc23_.remove_node(_loc5_.node);
                  _loc7_ = null;
                  if(!_loc23_.empty())
                  {
                     _loc24_ = _loc23_.parent;
                     while(_loc24_.prev != null)
                     {
                        _loc24_ = _loc24_.prev;
                     }
                     while(_loc24_ != null)
                     {
                        _loc25_ = _loc24_.data;
                        if(!ZPP_PartitionVertex.vert_lt(_loc25_,_loc4_))
                        {
                           _loc7_ = _loc25_;
                           break;
                        }
                        if(_loc24_.next != null)
                        {
                           _loc24_ = _loc24_.next;
                           while(_loc24_.prev != null)
                           {
                              _loc24_ = _loc24_.prev;
                           }
                        }
                        else
                        {
                           while(_loc24_.parent != null && _loc24_ == _loc24_.parent.next)
                           {
                              _loc24_ = _loc24_.parent;
                           }
                           _loc24_ = _loc24_.parent;
                        }
                     }
                  }
                  _loc6_ = _loc7_;
                  if(_loc6_ != null)
                  {
                     if(_loc6_.helper.type == 2)
                     {
                        _loc2_.add_diagonal(_loc4_,_loc6_.helper);
                     }
                     _loc6_.helper = _loc4_;
                  }
                  continue;
               case 3:
                  _loc6_ = null;
                  if(!_loc23_.empty())
                  {
                     _loc24_ = _loc23_.parent;
                     while(_loc24_.prev != null)
                     {
                        _loc24_ = _loc24_.prev;
                     }
                     while(_loc24_ != null)
                     {
                        _loc7_ = _loc24_.data;
                        if(!ZPP_PartitionVertex.vert_lt(_loc7_,_loc4_))
                        {
                           _loc6_ = _loc7_;
                           break;
                        }
                        if(_loc24_.next != null)
                        {
                           _loc24_ = _loc24_.next;
                           while(_loc24_.prev != null)
                           {
                              _loc24_ = _loc24_.prev;
                           }
                        }
                        else
                        {
                           while(_loc24_.parent != null && _loc24_ == _loc24_.parent.next)
                           {
                              _loc24_ = _loc24_.parent;
                           }
                           _loc24_ = _loc24_.parent;
                        }
                     }
                  }
                  _loc5_ = _loc6_;
                  if(_loc5_ != null)
                  {
                     _loc2_.add_diagonal(_loc4_,_loc5_.helper);
                     _loc5_.helper = _loc4_;
                  }
                  _loc4_.node = _loc23_.insert(_loc4_);
                  _loc4_.helper = _loc4_;
                  continue;
               case 4:
                  _loc5_ = _loc4_.prev;
                  if(ZPP_Monotone.left_vertex(_loc4_))
                  {
                     if(_loc5_.helper.type == 2)
                     {
                        _loc2_.add_diagonal(_loc4_,_loc5_.helper);
                     }
                     _loc23_.remove_node(_loc5_.node);
                     _loc4_.node = _loc23_.insert(_loc4_);
                     _loc4_.helper = _loc4_;
                  }
                  else
                  {
                     _loc7_ = null;
                     if(!_loc23_.empty())
                     {
                        _loc24_ = _loc23_.parent;
                        while(_loc24_.prev != null)
                        {
                           _loc24_ = _loc24_.prev;
                        }
                        while(_loc24_ != null)
                        {
                           _loc25_ = _loc24_.data;
                           if(!ZPP_PartitionVertex.vert_lt(_loc25_,_loc4_))
                           {
                              _loc7_ = _loc25_;
                              break;
                           }
                           if(_loc24_.next != null)
                           {
                              _loc24_ = _loc24_.next;
                              while(_loc24_.prev != null)
                              {
                                 _loc24_ = _loc24_.prev;
                              }
                           }
                           else
                           {
                              while(_loc24_.parent != null && _loc24_ == _loc24_.parent.next)
                              {
                                 _loc24_ = _loc24_.parent;
                              }
                              _loc24_ = _loc24_.parent;
                           }
                        }
                     }
                     _loc6_ = _loc7_;
                     if(_loc6_.helper.type == 2)
                     {
                        _loc2_.add_diagonal(_loc4_,_loc6_.helper);
                     }
                     _loc6_.helper = _loc4_;
                  }
                  continue;
            }
         }
         _loc24_ = _loc23_;
         _loc24_.free();
         _loc24_.next = ZPP_Set_ZPP_PartitionVertex.zpp_pool;
         ZPP_Set_ZPP_PartitionVertex.zpp_pool = _loc24_;
         return _loc2_;
      }
   }
}
