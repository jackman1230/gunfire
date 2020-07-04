package objects
{
   import flash.display.MovieClip;
   
   public class cTank3 extends cTank
   {
       
      
      public function cTank3(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:int = -1)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         slug_health = 700;
         slug_health = getDefaultEnemyHealth() * 5;
      }
      
      override public function getGraphicsClip() : MovieClip
      {
         return new droptank_spikes();
      }
   }
}
