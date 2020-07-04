package nape.dynamics
{
   import zpp_nape.util.ZPP_Flags;
   
   public class ArbiterType
   {
       
      
      public function ArbiterType()
      {
      }
      
      public static function get COLLISION() : ArbiterType
      {
         if(ZPP_Flags.ArbiterType_COLLISION == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ArbiterType_COLLISION = new ArbiterType();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.ArbiterType_COLLISION;
      }
      
      public static function get SENSOR() : ArbiterType
      {
         if(ZPP_Flags.ArbiterType_SENSOR == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ArbiterType_SENSOR = new ArbiterType();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.ArbiterType_SENSOR;
      }
      
      public static function get FLUID() : ArbiterType
      {
         if(ZPP_Flags.ArbiterType_FLUID == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ArbiterType_FLUID = new ArbiterType();
            ZPP_Flags.§internal§ = false;
         }
         return ZPP_Flags.ArbiterType_FLUID;
      }
      
      public function toString() : String
      {
         §§push(this);
         if(ZPP_Flags.ArbiterType_COLLISION == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ArbiterType_COLLISION = new ArbiterType();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.ArbiterType_COLLISION)
         {
            return "COLLISION";
         }
         §§push(this);
         if(ZPP_Flags.ArbiterType_SENSOR == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ArbiterType_SENSOR = new ArbiterType();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.ArbiterType_SENSOR)
         {
            return "SENSOR";
         }
         §§push(this);
         if(ZPP_Flags.ArbiterType_FLUID == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.ArbiterType_FLUID = new ArbiterType();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.ArbiterType_FLUID)
         {
            return "FLUID";
         }
         return "";
      }
   }
}
