package
{
   public class AchievementChecker
   {
      
      public static var gMode:GameMode;
       
      
      public function AchievementChecker()
      {
         super();
      }
      
      public static function jumpAchieve(param1:int) : void
      {
         if(param1 >= 400)
         {
            tryVal(UserStats.ACH_JUMP400);
            setVal(UserStats.ACH_JUMP200);
            setVal(UserStats.ACH_JUMP150);
            setVal(UserStats.ACH_JUMP100);
            setVal(UserStats.ACH_JUMP20);
         }
         if(param1 >= 200)
         {
            tryVal(UserStats.ACH_JUMP200);
            setVal(UserStats.ACH_JUMP150);
            setVal(UserStats.ACH_JUMP100);
            setVal(UserStats.ACH_JUMP20);
         }
         if(param1 >= 150)
         {
            tryVal(UserStats.ACH_JUMP150);
            setVal(UserStats.ACH_JUMP100);
            setVal(UserStats.ACH_JUMP20);
         }
         if(param1 >= 100)
         {
            tryVal(UserStats.ACH_JUMP100);
            setVal(UserStats.ACH_JUMP20);
         }
         if(param1 >= 20)
         {
            tryVal(UserStats.ACH_JUMP20);
         }
      }
      
      public static function wheelieAchieve(param1:int) : void
      {
         if(param1 >= 200)
         {
            tryVal(UserStats.ACH_WHEELIE200);
            setVal(UserStats.ACH_WHEELIE100);
            setVal(UserStats.ACH_WHEELIE75);
            setVal(UserStats.ACH_WHEELIE50);
            setVal(UserStats.ACH_WHEELIE20);
         }
         if(param1 >= 100)
         {
            tryVal(UserStats.ACH_WHEELIE100);
            setVal(UserStats.ACH_WHEELIE75);
            setVal(UserStats.ACH_WHEELIE50);
            setVal(UserStats.ACH_WHEELIE20);
         }
         if(param1 >= 75)
         {
            tryVal(UserStats.ACH_WHEELIE75);
            setVal(UserStats.ACH_WHEELIE50);
            setVal(UserStats.ACH_WHEELIE20);
         }
         if(param1 >= 50)
         {
            tryVal(UserStats.ACH_WHEELIE50);
            setVal(UserStats.ACH_WHEELIE20);
         }
         if(param1 >= 20)
         {
            tryVal(UserStats.ACH_WHEELIE20);
         }
      }
      
      public static function flipAchieve(param1:int) : void
      {
         if(param1 >= 1200)
         {
            tryVal(UserStats.ACH_FLIP1200);
            setVal(UserStats.ACH_FLIP1000);
            setVal(UserStats.ACH_FLIP600);
            setVal(UserStats.ACH_FLIP400);
            setVal(UserStats.ACH_FLIP100);
         }
         if(param1 >= 1000)
         {
            tryVal(UserStats.ACH_FLIP1000);
            tryVal(UserStats.ACH_FLIP1000);
            setVal(UserStats.ACH_FLIP600);
            setVal(UserStats.ACH_FLIP400);
            setVal(UserStats.ACH_FLIP100);
         }
         if(param1 >= 600)
         {
            tryVal(UserStats.ACH_FLIP600);
            setVal(UserStats.ACH_FLIP400);
            setVal(UserStats.ACH_FLIP100);
         }
         if(param1 >= 400)
         {
            tryVal(UserStats.ACH_FLIP400);
            setVal(UserStats.ACH_FLIP100);
         }
         if(param1 >= 100)
         {
            tryVal(UserStats.ACH_FLIP100);
         }
      }
      
      public static function roofGrindAchieve(param1:int) : void
      {
         if(param1 >= 60)
         {
            tryVal(UserStats.ACH_ROOFGRIND60);
            setVal(UserStats.ACH_ROOFGRIND50);
            setVal(UserStats.ACH_ROOFGRIND40);
            setVal(UserStats.ACH_ROOFGRIND20);
            setVal(UserStats.ACH_ROOFGRIND10);
         }
         if(param1 >= 50)
         {
            tryVal(UserStats.ACH_ROOFGRIND50);
            setVal(UserStats.ACH_ROOFGRIND40);
            setVal(UserStats.ACH_ROOFGRIND20);
            setVal(UserStats.ACH_ROOFGRIND10);
         }
         if(param1 >= 40)
         {
            tryVal(UserStats.ACH_ROOFGRIND40);
            setVal(UserStats.ACH_ROOFGRIND20);
            setVal(UserStats.ACH_ROOFGRIND10);
         }
         if(param1 >= 20)
         {
            tryVal(UserStats.ACH_ROOFGRIND20);
            setVal(UserStats.ACH_ROOFGRIND10);
         }
         if(param1 >= 10)
         {
            tryVal(UserStats.ACH_ROOFGRIND10);
         }
      }
      
      public static function distanceAchieve(param1:int) : void
      {
         if(param1 >= 20000)
         {
            tryVal(UserStats.ACH_DISTANCE20K);
            setVal(UserStats.ACH_DISTANCE17K);
            setVal(UserStats.ACH_DISTANCE14K);
            setVal(UserStats.ACH_DISTANCE10K);
            setVal(UserStats.ACH_DISTANCE5K);
         }
         if(param1 >= 17000)
         {
            tryVal(UserStats.ACH_DISTANCE17K);
            setVal(UserStats.ACH_DISTANCE14K);
            setVal(UserStats.ACH_DISTANCE10K);
            setVal(UserStats.ACH_DISTANCE5K);
         }
         if(param1 >= 14000)
         {
            tryVal(UserStats.ACH_DISTANCE14K);
            setVal(UserStats.ACH_DISTANCE10K);
            setVal(UserStats.ACH_DISTANCE5K);
         }
         if(param1 >= 10000)
         {
            tryVal(UserStats.ACH_DISTANCE10K);
            setVal(UserStats.ACH_DISTANCE5K);
         }
         if(param1 >= 5000)
         {
            tryVal(UserStats.ACH_DISTANCE5K);
         }
      }
      
      public static function scoreAchieve(param1:int) : void
      {
         if(param1 >= 150000)
         {
            tryVal(UserStats.ACH_SCORE150K);
            setVal(UserStats.ACH_SCORE100K);
            setVal(UserStats.ACH_SCORE75K);
            setVal(UserStats.ACH_SCORE50K);
            setVal(UserStats.ACH_SCORE25K);
         }
         if(param1 >= 100000)
         {
            tryVal(UserStats.ACH_SCORE100K);
            setVal(UserStats.ACH_SCORE75K);
            setVal(UserStats.ACH_SCORE50K);
            setVal(UserStats.ACH_SCORE25K);
         }
         if(param1 >= 75000)
         {
            tryVal(UserStats.ACH_SCORE75K);
            setVal(UserStats.ACH_SCORE50K);
            setVal(UserStats.ACH_SCORE25K);
         }
         if(param1 >= 50000)
         {
            tryVal(UserStats.ACH_SCORE50K);
            setVal(UserStats.ACH_SCORE25K);
         }
         if(param1 >= 25000)
         {
            tryVal(UserStats.ACH_SCORE25K);
         }
      }
      
      public static function meteor1Achieve() : void
      {
         tryVal(UserStats.ACH_METEOR1);
      }
      
      public static function meteor2Achieve() : void
      {
         tryVal(UserStats.ACH_METEOR2);
      }
      
      public static function allStatusAchieve() : void
      {
         tryVal(UserStats.ACH_ALLSTATUS);
      }
      
      public static function allStatusAchieve2() : void
      {
         tryVal(UserStats.ACH_ALLSTATUS2);
      }
      
      public static function outrunAchieve() : void
      {
         tryVal(UserStats.ACH_OUTRUNMISSILE);
      }
      
      public static function cloudAchieve() : void
      {
         tryVal(UserStats.ACH_CLOUDHOP);
      }
      
      public static function bobsKilledAchieve() : void
      {
         tryVal(UserStats.ACH_KILLDUMMIES5);
      }
      
      public static function bobsSavedAchieve() : void
      {
         tryVal(UserStats.ACH_LEAVEDUMMIES5);
      }
      
      public static function bussesAchieve() : void
      {
         tryVal(UserStats.ACH_JUMPBUSSES5);
      }
      
      public static function carsAchieve() : void
      {
         tryVal(UserStats.ACH_JUMPCARS3);
      }
      
      public static function setVal(param1:int) : *
      {
         UserStats.achievementComplete(param1);
      }
      
      public static function tryVal(param1:int) : *
      {
         if(World.currentLevel.allowCheevies && !UserStats.isAchievementComplete(param1))
         {
            ToastHandler.enqueue(new Toast(param1));
            UserStats.achievementComplete(param1);
         }
      }
      
      public static function checkVal(param1:int) : Boolean
      {
         return UserStats.isAchievementComplete(param1);
      }
   }
}
