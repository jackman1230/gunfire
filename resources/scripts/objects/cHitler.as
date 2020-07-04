package objects
{
   import flash.display.MovieClip;
   
   public class cHitler extends cSoldierPlatformImmobile
   {
       
      
      public var goalTimer:int = -1;
      
      var toldCar:Boolean = false;
      
      public function cHitler(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:int = -1)
      {
         isHitler = true;
         spawned_death_stuff_already = true;
         super(param1,param2,param3,param4);
         setWeapon(cProjectileGun.TYPE_PISTOL);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         slug_health = 1000;
         can_notlook = false;
         dealsTouchDamage = -1;
         touchDamageDelay = -1;
         wanderDistance = 2;
      }
      
      override public function subTick() : void
      {
         super.subTick();
      }
      
      override public function death() : void
      {
         super.death();
         if(!this.toldCar)
         {
            this.toldCar = true;
            (World.followObj as cCar).goaltimer = 50;
         }
      }
      
      override public function getGraphicsClip() : MovieClip
      {
         return new hitler();
      }
   }
}
