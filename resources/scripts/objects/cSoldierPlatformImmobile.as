package objects
{
   public class cSoldierPlatformImmobile extends cSoldierPlatform
   {
       
      
      public function cSoldierPlatformImmobile(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:int = -1)
      {
         super(param1,param2,param3,param4,param5);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         wanderDistance = 1;
      }
   }
}
