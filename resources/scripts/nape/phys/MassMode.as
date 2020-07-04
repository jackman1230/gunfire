package nape.phys
{
   import zpp_nape.util.ZPP_Flags;
   
   public class MassMode
   {
       
      
      public function MassMode()
      {
      }
      
      public static function get DEFAULT() : MassMode
      {
         if(ZPP_Flags.MassMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.MassMode_DEFAULT = new MassMode();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.MassMode_DEFAULT;
      }
      
      public static function get FIXED() : MassMode
      {
         if(ZPP_Flags.MassMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.MassMode_FIXED = new MassMode();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.MassMode_FIXED;
      }
      
      public function toString() : String
      {
         §§push(this);
         if(ZPP_Flags.MassMode_DEFAULT == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.MassMode_DEFAULT = new MassMode();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.MassMode_DEFAULT)
         {
            return "DEFAULT";
         }
         §§push(this);
         if(ZPP_Flags.MassMode_FIXED == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.MassMode_FIXED = new MassMode();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.MassMode_FIXED)
         {
            return "FIXED";
         }
         return "";
      }
   }
}
