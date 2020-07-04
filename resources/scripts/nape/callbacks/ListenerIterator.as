package nape.callbacks
{
   import zpp_nape.util.ZPP_ListenerList;
   
   public class ListenerIterator
   {
      
      public static var zpp_pool:ListenerIterator;
       
      
      public var zpp_next:ListenerIterator;
      
      public var zpp_inner:ListenerList;
      
      public var zpp_i:int;
      
      public var zpp_critical:Boolean;
      
      public function ListenerIterator()
      {
      }
      
      public static function get(param1:ListenerList) : ListenerIterator
      {
         var _loc3_:* = null as ListenerIterator;
         if(ListenerIterator.zpp_pool == null)
         {
            ZPP_ListenerList.§internal§ = true;
            _loc3_ = new ListenerIterator();
            ZPP_ListenerList.§internal§ = false;
            §§push(_loc3_);
         }
         else
         {
            _loc3_ = ListenerIterator.zpp_pool;
            ListenerIterator.zpp_pool = _loc3_.zpp_next;
            §§push(_loc3_);
         }
         var _loc2_:ListenerIterator = §§pop();
         _loc2_.zpp_i = 0;
         _loc2_.zpp_inner = param1;
         _loc2_.zpp_critical = false;
         param1.zpp_inner.iterators.add(_loc2_);
         return _loc2_;
      }
      
      public function next() : Listener
      {
         zpp_critical = false;
         var _loc1_:int = zpp_i;
         zpp_i = zpp_i + 1;
         return zpp_inner.at(_loc1_);
      }
      
      public function hasNext() : Boolean
      {
         zpp_inner.zpp_inner.valmod();
         var _loc2_:ListenerList = zpp_inner;
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
         zpp_next = ListenerIterator.zpp_pool;
         ListenerIterator.zpp_pool = this;
         zpp_inner.zpp_inner.iterators.remove(this);
         zpp_inner = null;
         return false;
      }
   }
}
