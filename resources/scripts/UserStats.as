package
{
   public class UserStats
   {
      
      public static var arrayCreated:Boolean = false;
      
      public static var achievementsArray:Array;
      
      public static const ACH_MENUFOUND:int = 0;
      
      public static const ACH_WHEELIE20:int = 1;
      
      public static const ACH_JUMP20:int = 2;
      
      public static const ACH_ROOFGRIND10:int = 3;
      
      public static const ACH_FLIP100:int = 4;
      
      public static const ACH_SCORE25K:int = 5;
      
      public static const ACH_DISTANCE5K:int = 6;
      
      public static const ACH_WHEELIE50:int = 7;
      
      public static const ACH_JUMP100:int = 8;
      
      public static const ACH_ROOFGRIND20:int = 9;
      
      public static const ACH_FLIP400:int = 10;
      
      public static const ACH_SCORE50K:int = 11;
      
      public static const ACH_DISTANCE10K:int = 12;
      
      public static const ACH_WHEELIE75:int = 13;
      
      public static const ACH_JUMP150:int = 14;
      
      public static const ACH_ROOFGRIND40:int = 15;
      
      public static const ACH_FLIP600:int = 16;
      
      public static const ACH_SCORE75K:int = 17;
      
      public static const ACH_DISTANCE14K:int = 18;
      
      public static const ACH_WHEELIE100:int = 19;
      
      public static const ACH_JUMP200:int = 20;
      
      public static const ACH_ROOFGRIND50:int = 21;
      
      public static const ACH_FLIP1000:int = 22;
      
      public static const ACH_SCORE100K:int = 23;
      
      public static const ACH_DISTANCE17K:int = 24;
      
      public static const ACH_WHEELIE200:int = 25;
      
      public static const ACH_JUMP400:int = 26;
      
      public static const ACH_ROOFGRIND60:int = 27;
      
      public static const ACH_FLIP1200:int = 28;
      
      public static const ACH_SCORE150K:int = 29;
      
      public static const ACH_DISTANCE20K:int = 30;
      
      public static const ACH_OUTRUNMISSILE:int = 31;
      
      public static const ACH_KILLDUMMIES5:int = 32;
      
      public static const ACH_LEAVEDUMMIES5:int = 33;
      
      public static const ACH_JUMPCARS3:int = 34;
      
      public static const ACH_JUMPBUSSES5:int = 35;
      
      public static const ACH_CLOUDHOP:int = 36;
      
      public static const ACH_METEOR1:int = 37;
      
      public static const ACH_METEOR2:int = 38;
      
      public static const ACH_ALLSTATUS:int = 39;
      
      public static const ACH_ALLSTATUS2:int = 40;
       
      
      public function UserStats()
      {
         super();
      }
      
      public static function createAchievements() : void
      {
         achievementsArray = new Array();
         h(ACH_MENUFOUND,"Found Achievements Menu","Earn \'em all to unlock the last vehicle!");
         h(1,"20m Wheelie","Wheelie for 20 metres");
         h(2,"20m Jump","Jump 20 metres");
         h(3,"10m Roof Grind","Slide on the roof for 10 metres");
         h(4,"100° Flip","Perform a 100° Flip");
         h(5,"Score 25,000","Score 25k in one run");
         h(6,"5km Trip","Travel 5 km in one shot");
         h(7,"50m Wheelie","Wheelie for 50 metres");
         h(8,"100m Jump","Jump 100 metres");
         h(9,"20m Roof Grind","Slide on the roof for 20 metres");
         h(10,"400° Flip","Perform a 400° Flip");
         h(11,"Score 50,000","Score 50k in one run");
         h(12,"10km Trip","Travel 10 km in one shot");
         h(13,"75m Wheelie","Wheelie for 75 metres");
         h(14,"150m Jump","Jump 150 metres");
         h(15,"40m Roof Grind","Slide on the roof for 40 metres");
         h(16,"600° Flip","Perform a 600° Flip");
         h(17,"Score 75,000","Score 75k in one run");
         h(18,"14km Trip","Travel 14 km in one shot");
         h(19,"100m Wheelie","Wheelie for 100 metres");
         h(20,"200m Jump","Jump 200 metres");
         h(21,"50m Roof Grind","Slide on the roof for 50 metres");
         h(22,"1000° Flip","Perform a 1000° Flip");
         h(23,"Score 100,000","Score 100k in one run");
         h(24,"17km Trip","Travel 17 km in one shot");
         h(25,"200m Wheelie","Wheelie for 200 metres");
         h(26,"400m Jump","Jump 400 metres");
         h(27,"60m Roof Grind","Slide on the roof for 60 metres");
         h(28,"1200° Flip","Perform a 1200° Flip");
         h(29,"Score 150,000","Score 150k in one run");
         h(30,"20km Trip","Travel 20 km in one shot");
         h(31,"Runnin\' Free","Outrun a guided missile");
         h(32,"Bounty Hunter","Hit 5 Dummies!");
         h(33,"Pacifist","Let 5 Dummies live!");
         h(34,"Evil Knevil","Clear 3 Cars");
         h(35,"Eviler Kneivler","Clear 5 Busses");
         h(36,"Cloud Hopper","Jump between 3 clouds without hitting the ground");
         h(37,"Meteor Hopper","Hit 2 meteors before landing");
         h(38,"Meteorer Hopperer","Hit 3 meteors before landing");
         h(39,"Collector","Collect all effects in one level");
         h(40,"Collector 2","Collect 3 effects at the same time");
         arrayCreated = true;
         achievementComplete(ACH_MENUFOUND);
      }
      
      public static function h(param1:int, param2:String, param3:String, param4:Boolean = false) : *
      {
         achievementsArray.push(new Achievement(param1,param2,param3,param4));
      }
      
      public static function numAchievements() : int
      {
         if(!arrayCreated)
         {
            createAchievements();
         }
         return achievementsArray.length;
      }
      
      public static function numCompleteAchievements() : int
      {
         if(!arrayCreated)
         {
            createAchievements();
         }
         var _loc1_:int = 0;
         var _loc2_:int = 0;
         while(_loc2_ < numAchievements())
         {
            _loc1_ = _loc1_ + (!!isAchievementComplete(_loc2_)?1:0);
            _loc2_++;
         }
         return _loc1_;
      }
      
      public static function allAchievementsComplete() : Boolean
      {
         return numCompleteAchievements() == numAchievements();
      }
      
      public static function debugWriteAchievements() : void
      {
         var _loc1_:int = 0;
         while(_loc1_ < numAchievements())
         {
            achievementComplete(_loc1_);
            _loc1_++;
         }
      }
      
      public static function getAchievmentName(param1:int) : String
      {
         if(!arrayCreated)
         {
            createAchievements();
         }
         return achievementsArray[param1].name;
      }
      
      public static function getAchievmentDescription(param1:int) : String
      {
         if(!arrayCreated)
         {
            createAchievements();
         }
         return achievementsArray[param1].description;
      }
      
      public static function achievementComplete(param1:int) : void
      {
         if(!arrayCreated)
         {
            createAchievements();
         }
         achievementsArray[param1].complete = true;
      }
      
      public static function resetAchievements() : void
      {
         var _loc1_:int = 1;
         while(_loc1_ < numAchievements())
         {
            resetAchievement(_loc1_);
            _loc1_++;
         }
         Serialiser.saveStats();
      }
      
      public static function resetAchievement(param1:int) : void
      {
         if(!arrayCreated)
         {
            createAchievements();
         }
         achievementsArray[param1].complete = false;
      }
      
      public static function isAchievementComplete(param1:int) : Boolean
      {
         if(!arrayCreated)
         {
            createAchievements();
         }
         return achievementsArray[param1].complete;
      }
   }
}
