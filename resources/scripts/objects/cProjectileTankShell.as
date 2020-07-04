package objects
{
   public class cProjectileTankShell extends cProjectileGroundShell
   {
       
      
      public function cProjectileTankShell(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:int = 0, param6:Boolean = false)
      {
         super(param1,param2,param3,param4);
         lastPart.gravMassScale = 0.1;
      }
      
      override public function getStats() : void
      {
         super.getStats();
         projectile_speed = 320;
         dealsTouchDamage = 50;
      }
      
      override public function getTypeStringLol() : String
      {
         return "TankShell";
      }
   }
}
