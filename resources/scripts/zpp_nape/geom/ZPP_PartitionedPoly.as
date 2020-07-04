package zpp_nape.geom
{
   import flash.Boot;
   import zpp_nape.util.ZNPList_ZPP_GeomVert;
   import zpp_nape.util.ZNPList_ZPP_PartitionedPoly;
   import zpp_nape.util.ZNPNode_ZPP_PartitionVertex;
   import zpp_nape.util.ZNPNode_ZPP_PartitionedPoly;
   
   public class ZPP_PartitionedPoly
   {
       
      
      public var vertices:ZPP_PartitionVertex;
      
      public function ZPP_PartitionedPoly(param1:ZPP_GeomVert = undefined)
      {
         var _loc6_:* = null as ZPP_GeomVert;
         var _loc7_:* = null as ZPP_GeomVert;
         var _loc8_:* = null as ZPP_PartitionVertex;
         var _loc9_:* = null as ZPP_PartitionVertex;
         if(Boot.skip_constructor)
         {
            return;
         }
         if(param1 == null)
         {
            return;
         }
         var _loc3_:Number = 0;
         var _loc4_:ZPP_GeomVert = param1;
         var _loc5_:ZPP_GeomVert = param1;
         if(_loc4_ != null)
         {
            _loc6_ = _loc4_;
            do
            {
               _loc7_ = _loc6_;
               _loc3_ = Number(_loc3_ + _loc7_.x * (_loc7_.next.y - _loc7_.prev.y));
               _loc6_ = _loc6_.next;
            }
            while(_loc6_ != _loc5_);
            
         }
         var _loc2_:* = _loc3_ > 0;
         _loc4_ = param1;
         do
         {
            §§push();
            if(_loc2_)
            {
               if(ZPP_PartitionVertex.zpp_pool == null)
               {
                  _loc9_ = new ZPP_PartitionVertex();
               }
               else
               {
                  _loc9_ = ZPP_PartitionVertex.zpp_pool;
                  ZPP_PartitionVertex.zpp_pool = _loc9_.next;
                  _loc9_.next = null;
               }
               null;
               _loc9_.x = _loc4_.x;
               _loc9_.y = _loc4_.y;
               _loc8_ = _loc9_;
               if(vertices == null)
               {
                  _loc9_ = _loc8_;
                  _loc8_.next = _loc9_;
                  _loc9_ = _loc9_;
                  _loc8_.prev = _loc9_;
                  vertices = _loc9_;
               }
               else
               {
                  _loc8_.prev = vertices;
                  _loc8_.next = vertices.next;
                  vertices.next.prev = _loc8_;
                  vertices.next = _loc8_;
               }
               §§push(_loc8_);
            }
            else
            {
               if(ZPP_PartitionVertex.zpp_pool == null)
               {
                  _loc9_ = new ZPP_PartitionVertex();
               }
               else
               {
                  _loc9_ = ZPP_PartitionVertex.zpp_pool;
                  ZPP_PartitionVertex.zpp_pool = _loc9_.next;
                  _loc9_.next = null;
               }
               null;
               _loc9_.x = _loc4_.x;
               _loc9_.y = _loc4_.y;
               _loc8_ = _loc9_;
               if(vertices == null)
               {
                  _loc9_ = _loc8_;
                  _loc8_.next = _loc9_;
                  _loc9_ = _loc9_;
                  _loc8_.prev = _loc9_;
                  vertices = _loc9_;
               }
               else
               {
                  _loc8_.next = vertices;
                  _loc8_.prev = vertices.prev;
                  vertices.prev.next = _loc8_;
                  vertices.prev = _loc8_;
               }
               §§push(_loc8_);
            }
            §§pop().vertices = §§pop();
            vertices.forced = _loc4_.forced;
            _loc4_ = _loc4_.next;
         }
         while(_loc4_ != param1);
         
         remove_collinear_vertices();
      }
      
      public function remove_collinear_vertices() : void
      {
         var _loc3_:* = null as ZPP_PartitionVertex;
         var _loc4_:* = null as ZPP_PartitionVertex;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:* = null as ZPP_PartitionVertex;
         var _loc1_:ZPP_PartitionVertex = vertices;
         var _loc2_:Boolean = true;
         while(_loc2_ || _loc1_ != vertices)
         {
            _loc2_ = false;
            if(eq(_loc1_,_loc1_.next))
            {
               if(_loc1_ == vertices)
               {
                  vertices = _loc1_.next;
                  _loc2_ = true;
               }
               if(_loc1_.forced)
               {
                  _loc1_.next.forced = true;
               }
               if(_loc1_ != null && _loc1_.prev == _loc1_)
               {
                  _loc3_ = null;
                  _loc1_.prev = _loc3_;
                  _loc1_.next = _loc3_;
                  _loc3_ = _loc1_;
                  _loc3_.helper = null;
                  null;
                  _loc3_.next = ZPP_PartitionVertex.zpp_pool;
                  ZPP_PartitionVertex.zpp_pool = _loc3_;
                  _loc1_ = null;
                  §§push(_loc1_);
               }
               else
               {
                  _loc3_ = _loc1_.next;
                  _loc1_.prev.next = _loc1_.next;
                  _loc1_.next.prev = _loc1_.prev;
                  _loc4_ = null;
                  _loc1_.prev = _loc4_;
                  _loc1_.next = _loc4_;
                  _loc4_ = _loc1_;
                  _loc4_.helper = null;
                  null;
                  _loc4_.next = ZPP_PartitionVertex.zpp_pool;
                  ZPP_PartitionVertex.zpp_pool = _loc4_;
                  _loc1_ = null;
                  §§push(_loc3_);
               }
               _loc1_ = §§pop();
            }
            else
            {
               _loc3_ = _loc1_.prev;
               while(eq(_loc1_,_loc3_))
               {
                  if(_loc1_.forced)
                  {
                     _loc3_.forced = true;
                  }
                  _loc3_ = _loc3_.prev;
               }
               _loc5_ = _loc1_.x - _loc3_.x;
               _loc6_ = _loc1_.y - _loc3_.y;
               _loc7_ = _loc1_.next.x - _loc1_.x;
               _loc8_ = _loc1_.next.y - _loc1_.y;
               if(_loc8_ * _loc5_ - _loc7_ * _loc6_ != 0)
               {
                  _loc1_ = _loc1_.next;
               }
               else
               {
                  if(_loc1_ == vertices)
                  {
                     vertices = _loc1_.next;
                     _loc2_ = true;
                  }
                  if(_loc1_ != null && _loc1_.prev == _loc1_)
                  {
                     _loc4_ = null;
                     _loc1_.prev = _loc4_;
                     _loc1_.next = _loc4_;
                     _loc4_ = _loc1_;
                     _loc4_.helper = null;
                     null;
                     _loc4_.next = ZPP_PartitionVertex.zpp_pool;
                     ZPP_PartitionVertex.zpp_pool = _loc4_;
                     _loc1_ = null;
                     §§push(_loc1_);
                  }
                  else
                  {
                     _loc4_ = _loc1_.next;
                     _loc1_.prev.next = _loc1_.next;
                     _loc1_.next.prev = _loc1_.prev;
                     _loc9_ = null;
                     _loc1_.prev = _loc9_;
                     _loc1_.next = _loc9_;
                     _loc9_ = _loc1_;
                     _loc9_.helper = null;
                     null;
                     _loc9_.next = ZPP_PartitionVertex.zpp_pool;
                     ZPP_PartitionVertex.zpp_pool = _loc9_;
                     _loc1_ = null;
                     §§push(_loc4_);
                  }
                  _loc1_ = §§pop();
               }
            }
         }
      }
      
      public function pull_partitions(param1:ZPP_PartitionVertex, param2:ZNPList_ZPP_PartitionedPoly) : ZPP_PartitionVertex
      {
         var _loc5_:* = null as ZPP_PartitionVertex;
         var _loc6_:* = null as ZPP_PartitionVertex;
         var _loc8_:* = null as ZPP_PartitionVertex;
         var _loc9_:* = null as ZPP_PartitionVertex;
         var _loc3_:ZPP_PartitionedPoly = new ZPP_PartitionedPoly();
         var _loc4_:ZPP_PartitionVertex = param1;
         do
         {
            _loc5_ = _loc4_.copy();
            §§push(_loc3_);
            if(_loc3_.vertices == null)
            {
               _loc6_ = _loc5_;
               _loc5_.next = _loc6_;
               _loc6_ = _loc6_;
               _loc5_.prev = _loc6_;
               _loc3_.vertices = _loc6_;
            }
            else
            {
               _loc5_.prev = _loc3_.vertices;
               _loc5_.next = _loc3_.vertices.next;
               _loc3_.vertices.next.prev = _loc5_;
               _loc3_.vertices.next = _loc5_;
            }
            §§pop().vertices = _loc5_;
            _loc3_.vertices.forced = _loc4_.forced;
            if(_loc4_.diagonals.head != null)
            {
               _loc5_ = _loc4_.diagonals.pop_unsafe();
               if(_loc5_ != param1)
               {
                  _loc4_ = pull_partitions(_loc4_,param2);
               }
               break;
            }
            _loc4_ = _loc4_.next;
         }
         while(_loc4_ != param1);
         
         var _loc7_:Number = 0;
         _loc5_ = _loc3_.vertices;
         _loc6_ = _loc3_.vertices;
         if(_loc5_ != null)
         {
            _loc8_ = _loc5_;
            do
            {
               _loc9_ = _loc8_;
               _loc7_ = Number(_loc7_ + _loc9_.x * (_loc9_.next.y - _loc9_.prev.y));
               _loc8_ = _loc8_.next;
            }
            while(_loc8_ != _loc6_);
            
         }
         if(_loc7_ != 0)
         {
            param2.add(_loc3_);
         }
         return _loc4_;
      }
      
      public function pull(param1:ZPP_PartitionVertex, param2:ZNPList_ZPP_GeomVert) : ZPP_PartitionVertex
      {
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as ZPP_GeomVert;
         var _loc7_:* = null as ZPP_PartitionVertex;
         var _loc9_:* = null as ZPP_GeomVert;
         var _loc10_:* = null as ZPP_GeomVert;
         var _loc3_:ZPP_GeomVert = null;
         var _loc4_:ZPP_PartitionVertex = param1;
         do
         {
            _loc5_ = ZPP_GeomVert.get(_loc4_.x,_loc4_.y);
            if(_loc3_ == null)
            {
               _loc6_ = _loc5_;
               _loc5_.next = _loc6_;
               _loc6_ = _loc6_;
               _loc5_.prev = _loc6_;
               _loc3_ = _loc6_;
            }
            else
            {
               _loc5_.prev = _loc3_;
               _loc5_.next = _loc3_.next;
               _loc3_.next.prev = _loc5_;
               _loc3_.next = _loc5_;
            }
            _loc3_ = _loc5_;
            _loc3_.forced = _loc4_.forced;
            if(_loc4_.diagonals.head != null)
            {
               _loc7_ = _loc4_.diagonals.pop_unsafe();
               if(_loc7_ != param1)
               {
                  _loc4_ = pull(_loc4_,param2);
               }
               break;
            }
            _loc4_ = _loc4_.next;
         }
         while(_loc4_ != param1);
         
         var _loc8_:Number = 0;
         _loc5_ = _loc3_;
         _loc6_ = _loc3_;
         if(_loc5_ != null)
         {
            _loc9_ = _loc5_;
            do
            {
               _loc10_ = _loc9_;
               _loc8_ = Number(_loc8_ + _loc10_.x * (_loc10_.next.y - _loc10_.prev.y));
               _loc9_ = _loc9_.next;
            }
            while(_loc9_ != _loc6_);
            
         }
         if(_loc8_ != 0)
         {
            param2.add(_loc3_);
         }
         return _loc4_;
      }
      
      public function extract_partitions() : ZNPList_ZPP_PartitionedPoly
      {
         var _loc2_:* = null as ZPP_PartitionVertex;
         var _loc3_:* = null as ZPP_PartitionVertex;
         var _loc4_:* = null as ZPP_PartitionVertex;
         var _loc5_:* = null as ZPP_PartitionVertex;
         var _loc7_:* = null as ZPP_PartitionedPoly;
         var _loc1_:ZNPList_ZPP_PartitionedPoly = new ZNPList_ZPP_PartitionedPoly();
         _loc2_ = vertices;
         _loc3_ = vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               _loc5_.sort();
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         pull_partitions(vertices,_loc1_);
         while(vertices != null)
         {
            §§push();
            if(vertices != null && vertices.prev == vertices)
            {
               _loc2_ = null;
               vertices.prev = _loc2_;
               vertices.next = _loc2_;
               _loc2_ = vertices;
               _loc2_.helper = null;
               null;
               _loc2_.next = ZPP_PartitionVertex.zpp_pool;
               ZPP_PartitionVertex.zpp_pool = _loc2_;
               _loc2_ = null;
               vertices = _loc2_;
               §§push(_loc2_);
            }
            else
            {
               _loc2_ = vertices.next;
               vertices.prev.next = vertices.next;
               vertices.next.prev = vertices.prev;
               _loc3_ = null;
               vertices.prev = _loc3_;
               vertices.next = _loc3_;
               _loc3_ = vertices;
               _loc3_.helper = null;
               null;
               _loc3_.next = ZPP_PartitionVertex.zpp_pool;
               ZPP_PartitionVertex.zpp_pool = _loc3_;
               vertices = null;
               §§push(_loc2_);
            }
            §§pop().vertices = §§pop();
         }
         var _loc6_:ZNPNode_ZPP_PartitionedPoly = _loc1_.head;
         while(_loc6_ != null)
         {
            _loc7_ = _loc6_.elt;
            _loc7_.remove_collinear_vertices();
            _loc6_ = _loc6_.next;
         }
         return _loc1_;
      }
      
      public function extract() : ZNPList_ZPP_GeomVert
      {
         var _loc2_:* = null as ZPP_PartitionVertex;
         var _loc3_:* = null as ZPP_PartitionVertex;
         var _loc4_:* = null as ZPP_PartitionVertex;
         var _loc5_:* = null as ZPP_PartitionVertex;
         var _loc1_:ZNPList_ZPP_GeomVert = new ZNPList_ZPP_GeomVert();
         _loc2_ = vertices;
         _loc3_ = vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               _loc5_.sort();
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         pull(vertices,_loc1_);
         while(vertices != null)
         {
            §§push();
            if(vertices != null && vertices.prev == vertices)
            {
               _loc2_ = null;
               vertices.prev = _loc2_;
               vertices.next = _loc2_;
               _loc2_ = vertices;
               _loc2_.helper = null;
               null;
               _loc2_.next = ZPP_PartitionVertex.zpp_pool;
               ZPP_PartitionVertex.zpp_pool = _loc2_;
               _loc2_ = null;
               vertices = _loc2_;
               §§push(_loc2_);
            }
            else
            {
               _loc2_ = vertices.next;
               vertices.prev.next = vertices.next;
               vertices.next.prev = vertices.prev;
               _loc3_ = null;
               vertices.prev = _loc3_;
               vertices.next = _loc3_;
               _loc3_ = vertices;
               _loc3_.helper = null;
               null;
               _loc3_.next = ZPP_PartitionVertex.zpp_pool;
               ZPP_PartitionVertex.zpp_pool = _loc3_;
               vertices = null;
               §§push(_loc2_);
            }
            §§pop().vertices = §§pop();
         }
         return _loc1_;
      }
      
      public function eq(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : Boolean
      {
         var _loc3_:Number = param1.x - param2.x;
         var _loc4_:Number = param1.y - param2.y;
         return Number(_loc3_ * _loc3_ + _loc4_ * _loc4_) < 1.0e-8;
      }
      
      public function add_diagonal(param1:ZPP_PartitionVertex, param2:ZPP_PartitionVertex) : void
      {
         param1.diagonals.add(param2);
         param2.diagonals.add(param1);
         param2.forced = true;
         param1.forced = true;
      }
   }
}
