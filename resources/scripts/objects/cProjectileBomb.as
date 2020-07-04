package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class cProjectileBomb extends cProjectileGrenade
   {
       
      
      public function cProjectileBomb(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
         bodyParts[0].gravMassScale = 1;
      }
      
      override public function getTypeStringLol() : String
      {
         return "B";
      }
      
      override public function getStats() : void
      {
         super.getStats();
         projectile_speed = 5;
         hitRect = new Rectangle(0,0,20,20);
      }
      
      override public function getMyClip() : MovieClip
      {
         return new projectile_dropbomb();
      }
      
      override public function doAni() : void
      {
         bombClip.rotation = 0;
         bombClip.gotoAndPlay("explode");
      }
      
      override public function subLoad() : void
      {
         manual_flag = 60;
      }
   }
}
