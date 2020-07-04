package zpp_nape.util
{
   public class Hashable2_Bool
   {
      
      public static var zpp_pool:Hashable2_Bool;
       
      
      public var value:Boolean;
      
      public var next:Hashable2_Bool;
      
      public var id:int;
      
      public var hnext:Hashable2_Bool;
      
      public var di:int;
      
      public function Hashable2_Bool()
      {
      }
      
      public static function get(param1:int, param2:int, param3:Boolean) : Hashable2_Bool
      {
         var _loc4_:Hashable2_Bool = Hashable2_Bool.getpersist(param1,param2);
         _loc4_.value = param3;
         return _loc4_;
      }
      
      public static function getpersist(param1:int, param2:int) : Hashable2_Bool
      {
         var _loc3_:* = null as Hashable2_Bool;
         if(Hashable2_Bool.zpp_pool == null)
         {
            _loc3_ = new Hashable2_Bool();
         }
         else
         {
            _loc3_ = Hashable2_Bool.zpp_pool;
            Hashable2_Bool.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         _loc3_.alloc();
         _loc3_.id = param1;
         _loc3_.di = param2;
         return _loc3_;
      }
      
      public static function ordered_get(param1:int, param2:int, param3:Boolean) : Hashable2_Bool
      {
         return param1 <= param2?Hashable2_Bool.get(param1,param2,param3):Hashable2_Bool.get(param2,param1,param3);
      }
      
      public static function ordered_get_persist(param1:int, param2:int) : Hashable2_Bool
      {
         return param1 <= param2?Hashable2_Bool.getpersist(param1,param2):Hashable2_Bool.getpersist(param2,param1);
      }
      
      public function free() : void
      {
      }
      
      public function alloc() : void
      {
      }
   }
}
