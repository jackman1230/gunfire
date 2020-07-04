package objects
{
   import flash.display.MovieClip;
   
   public class cTank2 extends cTank
   {
       
      
      public function cTank2(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:int = -1)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         slug_health = 500 / 10;
         slug_health = getDefaultEnemyHealth() * 2;
      }
      
      override public function getGraphicsClip() : MovieClip
      {
         return new droptank_sloped();
      }
   }
}
