package
{
   import flash.Boot;
   
   public class Std
   {
       
      
      public function Std()
      {
      }
      
      public static function §is§(param1:*, param2:*) : Boolean
      {
         return Boolean(Boot.__instanceof(param1,param2));
      }
      
      public static function string(param1:*) : String
      {
         return Boot.__string_rec(param1,"");
      }
   }
}
