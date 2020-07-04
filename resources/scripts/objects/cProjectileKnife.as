package objects
{
   import flash.geom.Rectangle;
   
   public class cProjectileKnife extends cProjectile
   {
       
      
      public function cProjectileKnife(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
         bodyParts[0].gravMassScale = 0;
      }
      
      override public function getStats() : void
      {
         super.getStats();
         dealsTouchDamage = 240;
         touchDamageDelay = -1;
         projectile_speed = 0;
         lifetime = 1;
         hitRect = new Rectangle(0,0,100,100);
         projectile_collides = false;
      }
      
      override public function getSpread() : void
      {
         super.getSpread();
         random_y_spread = 0;
      }
      
      override public function getTypeStringLol() : String
      {
         return "KNIFE";
      }
   }
}
