package zpp_nape.geom
{
   import zpp_nape.util.ZNPList_ZPP_PartitionVertex;
   import zpp_nape.util.ZNPNode_ZPP_PartitionVertex;
   
   public class ZPP_Triangular
   {
       
      
      public function ZPP_Triangular()
      {
      }
      
      public static function lt(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
      {
         return param1.y < param2.y || param1.y == param2.y && param1.x < param2.x;
      }
      
      public static function right_turn(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex, param3:ZPP_PartitionVertex) : Number
      {
         var _loc4_:Number = param3.x - param2.x;
         var _loc5_:Number = param3.y - param2.y;
         var _loc6_:Number = param2.x - param1.x;
         var _loc7_:Number = param2.y - param1.y;
         return _loc7_ * _loc4_ - _loc6_ * _loc5_;
      }
      
      public static function triangulate(param1:ZPP_PartitionedPoly) : ZPP_PartitionedPoly
      {
         var _loc6_:* = null as ZPP_PartitionVertex;
         var _loc7_:* = null as ZPP_PartitionVertex;
         var _loc10_:* = null as ZPP_PartitionVertex;
         var _loc11_:* = null as ZPP_PartitionVertex;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc2_:ZPP_PartitionVertex = param1.vertices;
         var _loc3_:ZPP_PartitionVertex = param1.vertices;
         var _loc4_:ZPP_PartitionVertex = param1.vertices.next;
         var _loc5_:ZPP_PartitionVertex = param1.vertices;
         if(_loc4_ != null)
         {
            _loc6_ = _loc4_;
            do
            {
               _loc7_ = _loc6_;
               if(_loc7_.y < _loc2_.y || _loc7_.y == _loc2_.y && _loc7_.x < _loc2_.x)
               {
                  _loc2_ = _loc7_;
               }
               if(_loc3_.y < _loc7_.y || _loc3_.y == _loc7_.y && _loc3_.x < _loc7_.x)
               {
                  _loc3_ = _loc7_;
               }
               _loc6_ = _loc6_.next;
            }
            while(_loc6_ != _loc5_);
            
         }
         var _loc8_:ZNPList_ZPP_PartitionVertex = new ZNPList_ZPP_PartitionVertex();
         _loc4_ = _loc3_.prev;
         _loc5_ = _loc3_.next;
         _loc8_.add(_loc3_);
         while(_loc4_ != _loc2_ || _loc5_ != _loc2_)
         {
            if(_loc4_ == _loc2_ || _loc5_ != _loc2_ && (_loc4_.y < _loc5_.y || _loc4_.y == _loc5_.y && _loc4_.x < _loc5_.x))
            {
               _loc8_.add(_loc5_);
               _loc5_.rightchain = false;
               _loc5_ = _loc5_.next;
            }
            else
            {
               _loc8_.add(_loc4_);
               _loc4_.rightchain = true;
               _loc4_ = _loc4_.prev;
            }
         }
         _loc8_.add(_loc2_);
         var _loc9_:ZNPList_ZPP_PartitionVertex = new ZNPList_ZPP_PartitionVertex();
         _loc9_.add(_loc8_.pop_unsafe());
         _loc6_ = _loc8_.pop_unsafe();
         _loc9_.add(_loc6_);
         while(true)
         {
            _loc7_ = _loc8_.pop_unsafe();
            if(_loc8_.head != null)
            {
               if(_loc7_.rightchain != _loc9_.head.elt.rightchain)
               {
                  while(true)
                  {
                     _loc10_ = _loc9_.pop_unsafe();
                     if(_loc9_.head != null)
                     {
                        param1.add_diagonal(_loc10_,_loc7_);
                        continue;
                     }
                     break;
                  }
                  _loc9_.add(_loc6_);
               }
               else
               {
                  _loc10_ = _loc9_.pop_unsafe();
                  while(_loc9_.head != null)
                  {
                     _loc11_ = _loc9_.head.elt;
                     _loc13_ = _loc7_.x - _loc10_.x;
                     _loc14_ = _loc7_.y - _loc10_.y;
                     _loc15_ = _loc10_.x - _loc11_.x;
                     _loc16_ = _loc10_.y - _loc11_.y;
                     _loc12_ = _loc16_ * _loc13_ - _loc15_ * _loc14_;
                     if(!(!!_loc7_.rightchain && _loc12_ >= 0 || !_loc7_.rightchain && _loc12_ <= 0))
                     {
                        param1.add_diagonal(_loc11_,_loc7_);
                        _loc10_ = _loc11_;
                        _loc9_.pop();
                        continue;
                     }
                     break;
                  }
                  _loc9_.add(_loc10_);
               }
               _loc9_.add(_loc7_);
               _loc6_ = _loc7_;
               continue;
            }
            break;
         }
         if(_loc9_.head != null)
         {
            _loc9_.pop();
            while(_loc9_.head != null)
            {
               _loc7_ = _loc9_.pop_unsafe();
               if(_loc9_.head != null)
               {
                  param1.add_diagonal(_loc3_,_loc7_);
                  continue;
               }
               break;
            }
         }
         return param1;
      }
   }
}
