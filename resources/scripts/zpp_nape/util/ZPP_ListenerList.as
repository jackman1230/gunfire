package zpp_nape.util
{
   import flash.Boot;
   import nape.callbacks.ListenerList;
   
   public class ZPP_ListenerList
   {
      
      public static var §internal§:Boolean = false;
       
      
      public var zip_length:Boolean;
      
      public var user_length:int;
      
      public var subber:Function;
      
      public var reverse_flag:Boolean;
      
      public var push_ite:ZNPNode_ZPP_Listener;
      
      public var post_adder:Function;
      
      public var outer:ListenerList;
      
      public var iterators:ZNPList_ListenerIterator;
      
      public var inner:ZNPList_ZPP_Listener;
      
      public var immutable:Boolean;
      
      public var dontremove:Boolean;
      
      public var at_ite:ZNPNode_ZPP_Listener;
      
      public var at_index:int;
      
      public var adder:Function;
      
      public var _validate:Function;
      
      public var _modifiable:Function;
      
      public var _invalidated:Boolean;
      
      public var _invalidate:Function;
      
      public function ZPP_ListenerList()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         inner = new ZNPList_ZPP_Listener();
         _invalidated = true;
      }
      
      public static function get(param1:ZNPList_ZPP_Listener, param2:Boolean = false) : ListenerList
      {
         var _loc3_:ListenerList = new ListenerList();
         _loc3_.zpp_inner.inner = param1;
         if(param2)
         {
            _loc3_.zpp_inner.immutable = true;
         }
         _loc3_.zpp_inner.zip_length = true;
         return _loc3_;
      }
      
      public function valmod() : void
      {
         validate();
         if(inner.modified)
         {
            if(inner.pushmod)
            {
               push_ite = null;
            }
            at_ite = null;
            inner.modified = false;
            inner.pushmod = false;
            zip_length = true;
         }
      }
      
      public function validate() : void
      {
         if(_invalidated)
         {
            _invalidated = false;
            if(_validate != null)
            {
               _validate();
            }
         }
      }
      
      public function modify_test() : void
      {
      }
      
      public function modified() : void
      {
         zip_length = true;
         at_ite = null;
         push_ite = null;
      }
      
      public function invalidate() : void
      {
         _invalidated = true;
         if(_invalidate != null)
         {
            _invalidate(this);
         }
      }
   }
}