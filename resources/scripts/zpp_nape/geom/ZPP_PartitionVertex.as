package zpp_nape.geom
{
   import flash.Boot;
   import zpp_nape.util.ZNPList_ZPP_PartitionVertex;
   import zpp_nape.util.ZNPNode_ZPP_PartitionVertex;
   import zpp_nape.util.ZPP_Set_ZPP_PartitionVertex;
   
   public class ZPP_PartitionVertex
   {
      
      public static var zpp_pool:ZPP_PartitionVertex;
       
      
      public var y:Number;
      
      public var x:Number;
      
      public var type:int;
      
      public var rightchain:Boolean;
      
      public var prev:ZPP_PartitionVertex;
      
      public var node:ZPP_Set_ZPP_PartitionVertex;
      
      public var next:ZPP_PartitionVertex;
      
      public var helper:ZPP_PartitionVertex;
      
      public var forced:Boolean;
      
      public var diagonals:ZNPList_ZPP_PartitionVertex;
      
      public function ZPP_PartitionVertex()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         diagonals = new ZNPList_ZPP_PartitionVertex();
      }
      
      public static function get(param1:ZPP_GeomVert) : ZPP_PartitionVertex
      {
         var _loc2_:* = null as ZPP_PartitionVertex;
         if(ZPP_PartitionVertex.zpp_pool == null)
         {
            _loc2_ = new ZPP_PartitionVertex();
         }
         else
         {
            _loc2_ = ZPP_PartitionVertex.zpp_pool;
            ZPP_PartitionVertex.zpp_pool = _loc2_.next;
            _loc2_.next = null;
         }
         null;
         _loc2_.x = param1.x;
         _loc2_.y = param1.y;
         return _loc2_;
      }
      
      public static function rightdistance(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Number
      {
         var _loc3_:* = param1.next.y > param1.y;
         var _loc4_:Number = param1.next.x - param1.x;
         var _loc5_:Number = param1.next.y - param1.y;
         var _loc6_:Number = param2.x - param1.x;
         var _loc7_:Number = param2.y - param1.y;
         return (!!_loc3_?-1:1) * (_loc7_ * _loc4_ - _loc6_ * _loc5_);
      }
      
      public static function vert_lt(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         if(param2 == param1 || param2 == param1.next)
         {
            §§push(true);
         }
         else if(param1.y == param1.next.y)
         {
            _loc3_ = param1.x;
            _loc4_ = param1.next.x;
            §§push((_loc3_ < _loc4_?_loc3_:_loc4_) <= param2.x);
         }
         else
         {
            §§push(Number(ZPP_PartitionVertex.rightdistance(param1,param2)) <= 0);
         }
         return §§pop();
      }
      
      public static function edge_swap(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : void
      {
         var _loc3_:ZPP_Set_ZPP_PartitionVertex = param1.node;
         param1.node = param2.node;
         param2.node = _loc3_;
      }
      
      public static function edge_lt(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
      {
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:* = false;
         var _loc6_:* = false;
         if(param1 == param2 && param1.next == param2.next)
         {
            return false;
         }
         if(param1 == param2.next)
         {
            return !ZPP_PartitionVertex.vert_lt(param1,param2);
         }
         if(param2 == param1.next)
         {
            return Boolean(ZPP_PartitionVertex.vert_lt(param2,param1));
         }
         if(param1.y == param1.next.y)
         {
            if(param2.y == param2.next.y)
            {
               _loc3_ = param1.x;
               _loc4_ = param1.next.x;
               _loc3_ = param2.x;
               _loc4_ = param2.next.x;
               return (_loc3_ > _loc4_?_loc3_:_loc4_) > (_loc3_ > _loc4_?_loc3_:_loc4_);
            }
            else
            {
               return Number(ZPP_PartitionVertex.rightdistance(param2,param1)) > 0;
            }
         }
         _loc3_ = Number(ZPP_PartitionVertex.rightdistance(param1,param2));
         _loc5_ = _loc3_ < 0;
         _loc6_ = Number(ZPP_PartitionVertex.rightdistance(param1,param2.next)) < 0;
         return _loc5_ == _loc6_?_loc5_:param2.y == param2.next.y?_loc3_ > 0:Number(ZPP_PartitionVertex.rightdistance(param2,param1)) >= 0;
      }
      
      public function sort() : void
      {
         var _loc6_:Number = NaN;
         var _loc8_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc9_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc10_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc11_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc12_:* = null as ZNPNode_ZPP_PartitionVertex;
         var _loc13_:* = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:int = 0;
         var _loc18_:int = 0;
         var _loc1_:Number = prev.x - x;
         var _loc2_:Number = prev.y - y;
         var _loc3_:Number = next.x - x;
         var _loc4_:Number = next.y - y;
         _loc6_ = _loc4_ * _loc1_ - _loc3_ * _loc2_;
         var _loc5_:int = _loc6_ > 0?-1:_loc6_ == 0?0:1;
         var _loc7_:ZNPList_ZPP_PartitionVertex = diagonals;
         if(_loc7_.head != null && _loc7_.head.next != null)
         {
            _loc8_ = _loc7_.head;
            _loc9_ = null;
            _loc10_ = null;
            _loc11_ = null;
            _loc12_ = null;
            _loc13_ = 1;
            do
            {
               _loc14_ = 0;
               _loc10_ = _loc8_;
               _loc8_ = null;
               _loc9_ = _loc8_;
               while(_loc10_ != null)
               {
                  _loc14_++;
                  _loc11_ = _loc10_;
                  _loc15_ = 0;
                  _loc16_ = _loc13_;
                  while(_loc11_ != null && _loc15_ < _loc13_)
                  {
                     _loc15_++;
                     _loc11_ = _loc11_.next;
                  }
                  while(_loc15_ > 0 || _loc16_ > 0 && _loc11_ != null)
                  {
                     if(_loc15_ == 0)
                     {
                        _loc12_ = _loc11_;
                        _loc11_ = _loc11_.next;
                        _loc16_--;
                     }
                     else if(_loc16_ == 0 || _loc11_ == null)
                     {
                        _loc12_ = _loc10_;
                        _loc10_ = _loc10_.next;
                        _loc15_--;
                     }
                     else
                     {
                        _loc1_ = prev.x - x;
                        _loc2_ = prev.y - y;
                        _loc3_ = _loc10_.elt.x - x;
                        _loc4_ = _loc10_.elt.y - y;
                        _loc6_ = _loc4_ * _loc1_ - _loc3_ * _loc2_;
                        _loc17_ = _loc6_ > 0?-1:_loc6_ == 0?0:1;
                        _loc1_ = prev.x - x;
                        _loc2_ = prev.y - y;
                        _loc3_ = _loc11_.elt.x - x;
                        _loc4_ = _loc11_.elt.y - y;
                        _loc6_ = _loc4_ * _loc1_ - _loc3_ * _loc2_;
                        _loc18_ = _loc6_ > 0?-1:_loc6_ == 0?0:1;
                        if(_loc17_ == _loc18_)
                        {
                           _loc1_ = _loc10_.elt.x - x;
                           _loc2_ = _loc10_.elt.y - y;
                           _loc3_ = _loc11_.elt.x - x;
                           _loc4_ = _loc11_.elt.y - y;
                           _loc6_ = _loc4_ * _loc1_ - _loc3_ * _loc2_;
                           §§push((_loc6_ > 0?-1:_loc6_ == 0?0:1) == 1);
                        }
                        else if(_loc17_ == 0)
                        {
                           §§push(_loc18_ == _loc5_);
                        }
                        _loc12_ = _loc11_;
                        _loc11_ = _loc11_.next;
                        _loc16_--;
                     }
                     if(_loc9_ != null)
                     {
                        _loc9_.next = _loc12_;
                     }
                     else
                     {
                        _loc8_ = _loc12_;
                     }
                     _loc9_ = _loc12_;
                  }
                  _loc10_ = _loc11_;
               }
               _loc9_.next = null;
               _loc13_ = _loc13_ << 1;
            }
            while(_loc14_ > 1);
            
            _loc7_.head = _loc8_;
            _loc7_.modified = true;
            _loc7_.pushmod = true;
         }
      }
      
      public function free() : void
      {
         helper = null;
      }
      
      public function copy() : ZPP_PartitionVertex
      {
         var _loc1_:* = null as ZPP_PartitionVertex;
         if(ZPP_PartitionVertex.zpp_pool == null)
         {
            _loc1_ = new ZPP_PartitionVertex();
         }
         else
         {
            _loc1_ = ZPP_PartitionVertex.zpp_pool;
            ZPP_PartitionVertex.zpp_pool = _loc1_.next;
            _loc1_.next = null;
         }
         null;
         _loc1_.x = x;
         _loc1_.y = y;
         _loc1_.forced = forced;
         return _loc1_;
      }
      
      public function alloc() : void
      {
      }
   }
}
