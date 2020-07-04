package nape.dynamics
{
   import zpp_nape.util.ZPP_ArbiterList;
   
   public class ArbiterIterator
   {
      
      public static var zpp_pool:ArbiterIterator;
       
      
      public var zpp_next:ArbiterIterator;
      
      public var zpp_inner:ArbiterList;
      
      public var zpp_i:int;
      
      public var zpp_critical:Boolean;
      
      public function ArbiterIterator()
      {
      }
      
      public static function get(param1:ArbiterList) : ArbiterIterator
      {
         var _loc3_:* = null as ArbiterIterator;
         if(ArbiterIterator.zpp_pool == null)
         {
            ZPP_ArbiterList.§internal§ = true;
            _loc3_ = new ArbiterIterator();
            ZPP_ArbiterList.§internal§ = false;
            §§push(_loc3_);
         }
         else
         {
            _loc3_ = ArbiterIterator.zpp_pool;
            ArbiterIterator.zpp_pool = _loc3_.zpp_next;
            §§push(_loc3_);
         }
         var _loc2_:ArbiterIterator = §§pop();
         _loc2_.zpp_i = 0;
         _loc2_.zpp_inner = param1;
         _loc2_.zpp_critical = false;
         param1.zpp_inner.iterators.add(_loc2_);
         return _loc2_;
      }
      
      public function next() : Arbiter
      {
         zpp_critical = false;
         var _loc1_:int = zpp_i;
         zpp_i = zpp_i + 1;
         return zpp_inner.at(_loc1_);
      }
      
      public function hasNext() : Boolean
      {
         zpp_inner.zpp_inner.valmod();
         var _loc1_:int = zpp_inner.zpp_gl();
         zpp_critical = true;
         if(zpp_i < _loc1_)
         {
            return true;
         }
         zpp_next = ArbiterIterator.zpp_pool;
         ArbiterIterator.zpp_pool = this;
         zpp_inner.zpp_inner.iterators.remove(this);
         zpp_inner = null;
         return false;
      }
   }
}
