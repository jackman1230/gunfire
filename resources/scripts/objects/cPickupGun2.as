package objects
{
   public class cPickupGun2 extends cPickup
   {
       
      
      public function cPickupGun2(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function getTypeStringLol() : String
      {
         return "Gun2";
      }
      
      override public function getPickupString() : String
      {
         return "h";
      }
      
      override public function getStats() : void
      {
         super.getStats();
      }
      
      override public function gotPickedUp(param1:slugObject) : void
      {
         super.gotPickedUp(param1);
         if(!(World.followObj as cBiped).hasWeapons[cProjectileGun.TYPE_MACHINEGUN])
         {
            (World.followObj as cBiped).setWeapon(cProjectileGun.TYPE_MACHINEGUN,true);
         }
         SlugScore.addBullets(cProjectileGun.TYPE_MACHINEGUN);
      }
   }
}
