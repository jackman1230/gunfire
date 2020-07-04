package zpp_nape
{
   public class ZPP_Const
   {
      
      public static var EPSILON:Number = 1.0e-8;
      
      public static var FMAX:Number = 1.0e100;
      
      public static var vec2vector:Class = Type.getClass(new Vector.<Vec2>());
      
      public static var cbtypevector:Class = Type.getClass(new Vector.<CbType>());
      
      public static var optiontypevector:Class = Type.getClass(new Vector.<OptionType>());
       
      
      public function ZPP_Const()
      {
      }
      
      public static function POSINF() : Number
      {
         return 1.79e308;
      }
      
      public static function NEGINF() : Number
      {
         return -1.79e308;
      }
   }
}
