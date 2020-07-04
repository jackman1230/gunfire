package objects
{
   public class cPickupGun3 extends cPickup
   {
       
      
      public function cPickupGun3(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
         bodyParts[0].userData.clipRotationSource = GroundUtils.ground;
      }
      
      override public function getTypeStringLol() : String
      {
         return "Gun3 (G)";
      }
      
      override public function getPickupString() : String
      {
         return "b";
      }
      
      override public function getStats() : void
      {
         super.getStats();
      }
      
      override public function gotPickedUp(param1:slugObject) : void
      {
         super.gotPickedUp(param1);
         SlugScore.addBullets(cProjectileGun.TYPE_GRENADE);
      }
   }
}
