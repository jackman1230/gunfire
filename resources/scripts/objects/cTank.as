package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class cTank extends cSoldier
   {
       
      
      public function cTank(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:int = -1)
      {
         isTank = true;
         spawned_death_stuff_already = true;
         super(param1,param2,param3,param4);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         slug_health = getDefaultEnemyHealth() * 3;
         can_notlook = false;
         dealsTouchDamage = 30;
         touchDamageDelay = 2;
         time_to_stay_flagged = 80;
         hitRect = new Rectangle(0,0,128,60);
         hitRectOffsetY = -30;
      }
      
      override public function playDeathSound() : void
      {
         SoundHandler.playSoundClass(sound_asplosion);
      }
      
      override public function getGraphicsClip() : MovieClip
      {
         return new droptank_gray();
      }
      
      override public function getProjectileClass() : Class
      {
         return cProjectileTankShell;
      }
   }
}
