package
{
   public class TTSettings
   {
      
      public static var MODE_BODY:int = 0;
      
      public static var MODE_WHEELS:int = 1;
      
      public static var MODE_ENGINE:int = 2;
      
      public static var MODE_FUEL:int = 3;
      
      public static var bestOverrides:Array = [0,0,0,0];
      
      public static var overrideMax:Array = [7,3,3,3];
      
      public static var bestUpgrades:Array = [0,0,0,0];
      
      public static var upMax:Array = [7,7,7,7];
      
      public static var stat_totalCash:int = 0;
      
      public static var stat_totalDistance:int = 0;
      
      public static var stat_totalBobsKilled:int = 0;
      
      public static var stat_bestFlip:Number = 0;
      
      public static var stat_bestJump:Number = 0;
      
      public static var stat_bestWheelie:Number = 0;
      
      public static var stat_bestGrind:Number = 0;
      
      public static var stat_bestDistance:int = 0;
      
      public static var stat_bestCloudHops:int = 0;
      
      public static var stat_bestBusHop:int = 0;
      
      public static var stat_bestMeteorHop:int = 0;
      
      public static var stat_bestBobsKilled:int = 0;
       
      
      public function TTSettings()
      {
         super();
      }
      
      public static function sanitizeArrays() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < 4)
         {
            if(bestOverrides[_loc1_] < 0)
            {
               bestOverrides[_loc1_] = 0;
            }
            if(bestOverrides[_loc1_] > overrideMax[_loc1_])
            {
               bestOverrides[_loc1_] = overrideMax[_loc1_];
            }
            if(bestUpgrades[_loc1_] < 0)
            {
               bestUpgrades[_loc1_] = 0;
            }
            if(bestUpgrades[_loc1_] > upMax[_loc1_])
            {
               bestUpgrades[_loc1_] = upMax[_loc1_];
            }
            _loc1_++;
         }
      }
   }
}
