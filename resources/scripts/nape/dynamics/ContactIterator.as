package nape.dynamics
{
   import zpp_nape.dynamics.ZPP_Contact;
   import zpp_nape.util.ZPP_ContactList;
   
   public class ContactIterator
   {
      
      public static var zpp_pool:ContactIterator;
       
      
      public var zpp_next:ContactIterator;
      
      public var zpp_inner:ContactList;
      
      public var zpp_i:int;
      
      public var zpp_critical:Boolean;
      
      public function ContactIterator()
      {
      }
      
      public static function get(param1:ContactList) : ContactIterator
      {
         var _loc3_:* = null as ContactIterator;
         if(ContactIterator.zpp_pool == null)
         {
            ZPP_ContactList.§internal§ = true;
            _loc3_ = new ContactIterator();
            ZPP_ContactList.§internal§ = false;
            §§push(_loc3_);
         }
         else
         {
            _loc3_ = ContactIterator.zpp_pool;
            ContactIterator.zpp_pool = _loc3_.zpp_next;
            §§push(_loc3_);
         }
         var _loc2_:ContactIterator = §§pop();
         _loc2_.zpp_i = 0;
         _loc2_.zpp_inner = param1;
         _loc2_.zpp_critical = false;
         param1.zpp_inner.iterators.add(_loc2_);
         return _loc2_;
      }
      
      public function next() : Contact
      {
         zpp_critical = false;
         var _loc1_:int = zpp_i;
         zpp_i = zpp_i + 1;
         return zpp_inner.at(_loc1_);
      }
      
      public function hasNext() : Boolean
      {
         var _loc3_:* = null as ZPP_Contact;
         var _loc4_:* = null as ZPP_Contact;
         zpp_inner.zpp_inner.valmod();
         var _loc2_:ContactList = zpp_inner;
         _loc2_.zpp_inner.valmod();
         if(_loc2_.zpp_inner.zip_length)
         {
            _loc2_.zpp_inner.zip_length = false;
            _loc2_.zpp_inner.user_length = 0;
            _loc3_ = _loc2_.zpp_inner.inner.next;
            while(_loc3_ != null)
            {
               _loc4_ = _loc3_;
               if(!!_loc4_.active && _loc4_.arbiter.active)
               {
                  _loc2_.zpp_inner.user_length = _loc2_.zpp_inner.user_length + 1;
               }
               _loc3_ = _loc3_.next;
            }
         }
         var _loc1_:int = _loc2_.zpp_inner.user_length;
         zpp_critical = true;
         if(zpp_i < _loc1_)
         {
            return true;
         }
         zpp_next = ContactIterator.zpp_pool;
         ContactIterator.zpp_pool = this;
         zpp_inner.zpp_inner.iterators.remove(this);
         zpp_inner = null;
         return false;
      }
   }
}
