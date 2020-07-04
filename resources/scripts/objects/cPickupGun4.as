package objects
{
   public class cPickupGun4 extends cPickup
   {
       
      
      public function cPickupGun4(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function getTypeStringLol() : String
      {
         return "Gun4";
      }
      
      override public function getPickupString() : String
      {
         return "s";
      }
      
      override public function getStats() : void
      {
         super.getStats();
      }
      
      override public function gotPickedUp(param1:slugObject) : void
      {
         super.gotPickedUp(param1);
         if(!(World.followObj as cBiped).hasWeapons[cProjectileGun.TYPE_SHOTGUN])
         {
            (World.followObj as cBiped).setWeapon(cProjectileGun.TYPE_SHOTGUN,true);
         }
         SlugScore.addBullets(cProjectileGun.TYPE_SHOTGUN);
      }
   }
}
