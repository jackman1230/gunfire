package nape.geom
{
   import zpp_nape.util.ZPP_GeomPolyList;
   
   public class GeomPolyIterator
   {
      
      public static var zpp_pool:GeomPolyIterator;
       
      
      public var zpp_next:GeomPolyIterator;
      
      public var zpp_inner:GeomPolyList;
      
      public var zpp_i:int;
      
      public var zpp_critical:Boolean;
      
      public function GeomPolyIterator()
      {
      }
      
      public static function get(param1:GeomPolyList) : GeomPolyIterator
      {
         var _loc3_:* = null as GeomPolyIterator;
         if(GeomPolyIterator.zpp_pool == null)
         {
            ZPP_GeomPolyList.§internal§ = true;
            _loc3_ = new GeomPolyIterator();
            ZPP_GeomPolyList.§internal§ = false;
            §§push(_loc3_);
         }
         else
         {
            _loc3_ = GeomPolyIterator.zpp_pool;
            GeomPolyIterator.zpp_pool = _loc3_.zpp_next;
            §§push(_loc3_);
         }
         var _loc2_:GeomPolyIterator = §§pop();
         _loc2_.zpp_i = 0;
         _loc2_.zpp_inner = param1;
         _loc2_.zpp_critical = false;
         param1.zpp_inner.iterators.add(_loc2_);
         return _loc2_;
      }
      
      public function next() : GeomPoly
      {
         zpp_critical = false;
         var _loc1_:int = zpp_i;
         zpp_i = zpp_i + 1;
         return zpp_inner.at(_loc1_);
      }
      
      public function hasNext() : Boolean
      {
         zpp_inner.zpp_inner.valmod();
         var _loc2_:GeomPolyList = zpp_inner;
         _loc2_.zpp_inner.valmod();
         if(_loc2_.zpp_inner.zip_length)
         {
            _loc2_.zpp_inner.zip_length = false;
            _loc2_.zpp_inner.user_length = _loc2_.zpp_inner.inner.length;
         }
         var _loc1_:int = _loc2_.zpp_inner.user_length;
         zpp_critical = true;
         if(zpp_i < _loc1_)
         {
            return true;
         }
         zpp_next = GeomPolyIterator.zpp_pool;
         GeomPolyIterator.zpp_pool = this;
         zpp_inner.zpp_inner.iterators.remove(this);
         zpp_inner = null;
         return false;
      }
   }
}
