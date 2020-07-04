package objects
{
   import flash.display.MovieClip;
   
   public class cSwordsMan extends cSoldier
   {
       
      
      public function cSwordsMan(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:int = -1)
      {
         isSwordsMan = true;
         spawned_death_stuff_already = true;
         super(param1,param2,param3,param4);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         slug_health = 500000;
         can_notlook = false;
         dealsTouchDamage = 30;
         touchDamageDelay = 20;
      }
      
      override public function takeDamage(param1:slugObject, param2:int) : void
      {
         super.takeDamage(param1,param2);
         if(slug_health < 500000 - 30)
         {
            (myHandler as AISwordHandler).swordHit();
         }
      }
      
      override public function getGraphicsClip() : MovieClip
      {
         return new enemy09();
      }
   }
}
