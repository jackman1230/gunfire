package
{
   import objects.cProjectileGun;
   
   public class SlugScore
   {
      
      public static var has_weapons:Array = [true,false,false,false,false,false];
      
      public static var numBullets:Array = [0,0,0,0,0,0,0,0,0,0];
      
      public static var numGrenades:Number = 3;
      
      public static var last_weapon:int = 0;
      
      public static var lastLives:int = 0;
       
      
      public function SlugScore()
      {
         super();
      }
      
      public static function newGame() : void
      {
         numBullets = [0,0,0,0,0,0,0,0,0,0];
         numBullets[cProjectileGun.TYPE_GRENADE] = cProjectileGun.getDefaultBulletsForType(cProjectileGun.TYPE_GRENADE);
         numBullets[cProjectileGun.TYPE_PISTOL] = 500;
         has_weapons = [true,false,false,false,false,false];
         last_weapon = 0;
         lastLives = 0;
      }
      
      public static function hasEnoughBullets(param1:int) : Boolean
      {
         return numBullets[param1] > 0 || param1 == cProjectileGun.TYPE_PISTOL || param1 == cProjectileGun.TYPE_RIFLE || param1 == cProjectileGun.TYPE_BAZOOKA;
      }
      
      public static function getBulletString(param1:int) : String
      {
         if(param1 == cProjectileGun.TYPE_PISTOL || param1 == cProjectileGun.TYPE_RIFLE || param1 == cProjectileGun.TYPE_BAZOOKA)
         {
            return "I";
         }
         return GameMode.pad3(numBullets[param1]) + "/" + cProjectileGun.getMaxBulletsForType(param1);
      }
      
      public static function addBullets(param1:int) : *
      {
         numBullets[param1] = numBullets[param1] + cProjectileGun.getDefaultBulletsForType(param1);
         if(numBullets[param1] > cProjectileGun.getMaxBulletsForType(param1))
         {
            numBullets[param1] = cProjectileGun.getMaxBulletsForType(param1);
         }
      }
   }
}
