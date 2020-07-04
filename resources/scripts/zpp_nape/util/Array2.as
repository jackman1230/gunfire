package zpp_nape.util
{
   import flash.Boot;
   
   public class Array2
   {
       
      
      public var width:int;
      
      public var list:Vector.<Object>;
      
      public function Array2(param1:int = 0, param2:int = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         width = param1;
         list = new Vector.<Object>(param1 * param2,true);
      }
      
      public function set(param1:int, param2:int, param3:Object) : Object
      {
         var _loc4_:Object = param3;
         list[param2 * width + param1] = _loc4_;
         return _loc4_;
      }
      
      public function get(param1:int, param2:int) : Object
      {
         return list[param2 * width + param1];
      }
   }
}
