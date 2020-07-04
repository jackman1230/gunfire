package nape.phys
{
   import zpp_nape.util.ZPP_Flags;
   
   public class InertiaMode
   {
       
      
      public function InertiaMode()
      {
      }
      
      public static function get DEFAULT() : InertiaMode
      {
         if(ZPP_Flags.InertiaMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InertiaMode_DEFAULT = new InertiaMode();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.InertiaMode_DEFAULT;
      }
      
      public static function get FIXED() : InertiaMode
      {
         if(ZPP_Flags.InertiaMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InertiaMode_FIXED = new InertiaMode();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.InertiaMode_FIXED;
      }
      
      public function toString() : String
      {
         §§push(this);
         if(ZPP_Flags.InertiaMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InertiaMode_DEFAULT = new InertiaMode();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.InertiaMode_DEFAULT)
         {
            return "DEFAULT";
         }
         §§push(this);
         if(ZPP_Flags.InertiaMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.InertiaMode_FIXED = new InertiaMode();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.InertiaMode_FIXED)
         {
            return "FIXED";
         }
         return "";
      }
   }
}
