package objects
{
   public class cPickupLife extends cPickup
   {
       
      
      public function cPickupLife(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function getTypeStringLol() : String
      {
         return "LIFE";
      }
      
      override public function getPickupString() : String
      {
         return "r";
      }
      
      override public function getStats() : void
      {
         super.getStats();
      }
      
      override public function playPickupSound() : void
      {
         super.playPickupSound();
         SoundHandler.playSoundClass(sound_pickup_life);
      }
      
      override public function gotPickedUp(param1:slugObject) : void
      {
         super.gotPickedUp(param1);
         if(World.followObj.slugCast.getLives() < 9)
         {
            World.followObj.slugCast.setLives(World.followObj.slugCast.getLives() + 1);
         }
      }
   }
}
