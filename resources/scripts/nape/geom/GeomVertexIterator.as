package nape.geom
{
   import zpp_nape.geom.ZPP_GeomVert;
   import zpp_nape.geom.ZPP_GeomVertexIterator;
   
   public class GeomVertexIterator
   {
       
      
      public var zpp_inner:ZPP_GeomVertexIterator;
      
      public function GeomVertexIterator()
      {
      }
      
      public function next() : Vec2
      {
         var _loc1_:Vec2 = zpp_inner.ptr.wrapper();
         zpp_inner.ptr = !!zpp_inner.forward?zpp_inner.ptr.next:zpp_inner.ptr.prev;
         return _loc1_;
      }
      
      public function hasNext() : Boolean
      {
         var _loc2_:* = null as ZPP_GeomVertexIterator;
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc1_:Boolean = zpp_inner.ptr != zpp_inner.start || zpp_inner.first;
         zpp_inner.first = false;
         if(!_loc1_)
         {
            _loc2_ = zpp_inner;
            _loc2_.outer.zpp_inner = null;
            _loc3_ = null;
            _loc2_.start = _loc3_;
            _loc2_.ptr = _loc3_;
            _loc2_.next = ZPP_GeomVertexIterator.zpp_pool;
            ZPP_GeomVertexIterator.zpp_pool = _loc2_;
         }
         return _loc1_;
      }
   }
}
