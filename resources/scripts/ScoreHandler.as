package
{
   public class ScoreHandler
   {
      
      public static var levelScores:Array;
      
      public static var levelsPassed:Array;
      
      public static var levelTimes:Array;
      
      public static var totalScore:int = 0;
      
      public static var runningScore:int = 0;
      
      public static var catchupScore:Number = 0;
      
      public static var stuntsCollected:int = 0;
      
      public static var stuntBonus:int = 0;
      
      public static var coinsCollected:int = 0;
      
      public static var coinBonus:Number = 0;
      
      public static var killsCollected:int = 0;
      
      public static var killBonus:int = 0;
      
      public static var bonusTimeLeft:int = 0;
      
      public static var bonusTimeLeftBonus:int = 0;
      
      public static var allotedTime:int = 99000;
      
      public static var startDate:int;
      
      public static var currentDate:int;
      
      public static var systemTimePassed:int = 0;
       
      
      public function ScoreHandler()
      {
         super();
      }
      
      public static function debugScore() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < levelTimes.length)
         {
            _loc1_++;
         }
      }
      
      public static function cleanup() : void
      {
         catchupScore = 0;
         runningScore = 0;
         stuntsCollected = 0;
         stuntBonus = 0;
         coinsCollected = 0;
         coinBonus = 0;
         killsCollected = 0;
         killBonus = 0;
         bonusTimeLeft = 0;
         bonusTimeLeftBonus = 0;
      }
      
      public static function levelPassed() : void
      {
         addLevelTime(systemTimePassed);
         setLevelScore(calculateLevelScore());
         levelsPassed[Level.getLevelIndex()] = true;
      }
      
      public static function cleanupEverything() : void
      {
         cleanup();
         levelScores = [];
         levelsPassed = [];
         levelTimes = [];
         var _loc1_:int = 0;
         while(_loc1_ < Level.numPlayableLevels)
         {
            levelScores.push(0);
            levelsPassed.push(false);
            levelTimes.push(0);
            _loc1_++;
         }
         totalScore = 0;
         GameMode.selectedCharacter = 0;
         GameMode.totalCash = 0;
         GameMode.helpShown = false;
      }
      
      public static function addLevelTime(param1:int) : *
      {
         var _loc2_:int = levelTimes[Level.getLevelIndex()];
         if(_loc2_ == 0 || param1 < _loc2_)
         {
            levelTimes[Level.getLevelIndex()] = param1;
         }
      }
      
      public static function setLevelTime(param1:int) : *
      {
         levelTimes[Level.getLevelIndex()] = param1;
      }
      
      public static function setLevelScore(param1:int) : void
      {
         levelScores[Level.getLevelIndex()] = param1;
      }
      
      public static function getLevelScore() : int
      {
         return levelScores[Level.getLevelIndex()];
      }
      
      public static function calculateTimeBonus() : int
      {
         bonusTimeLeftBonus = Math.floor(bonusTimeLeft / 1000);
         return bonusTimeLeftBonus;
      }
      
      public static function calculateTotalScore(param1:Boolean = false) : int
      {
         if(param1)
         {
            setLevelScore(calculateLevelScore());
         }
         var _loc2_:int = 0;
         var _loc3_:int = 0;
         while(_loc3_ < levelScores.length)
         {
            _loc2_ = _loc2_ + levelScores[_loc3_];
            _loc3_++;
         }
         totalScore = _loc2_;
         return totalScore;
      }
      
      public static function calculateLevelScore(param1:Boolean = true) : int
      {
         var _loc2_:int = 0;
         _loc2_ = _loc2_ + stuntBonus;
         _loc2_ = _loc2_ + coinBonus;
         _loc2_ = _loc2_ + killBonus;
         if(param1)
         {
            _loc2_ = _loc2_ + calculateTimeBonus();
         }
         return _loc2_;
      }
      
      public static function startTicking() : void
      {
         startDate = new Date().getTime();
      }
      
      public static function tick() : void
      {
         if(World.currentLevel.useSystemTime && GameMode.control)
         {
            currentDate = new Date().getTime();
            systemTimePassed = currentDate - startDate;
            bonusTimeLeft = allotedTime - systemTimePassed;
         }
         runningScore = calculateLevelScore(false);
         catchupScore = catchupScore + Math.ceil((runningScore - catchupScore) / 10);
      }
      
      public static function addStunt(param1:int, param2:String) : void
      {
         if(GameMode.control && World.currentLevel.allowStunts)
         {
            stuntsCollected++;
            stuntBonus = stuntBonus + param1;
         }
      }
      
      public static function addKill(param1:int) : void
      {
         addKills(1,param1);
      }
      
      public static function addKills(param1:int, param2:int) : void
      {
         if(GameMode.control && World.currentLevel.allowKills)
         {
            killsCollected = killsCollected + param1;
            killBonus = killBonus + param2;
         }
      }
      
      public static function addCoin(param1:Number) : void
      {
         addCoins(1,param1);
      }
      
      public static function addCoins(param1:int, param2:Number, param3:Boolean = false) : void
      {
         if(GameMode.control || param3)
         {
            coinsCollected = coinsCollected + param1;
            coinBonus = coinBonus + param2;
            GameMode.totalCash = GameMode.totalCash + param2;
            StatusHandler.labelMiddle.scaleX = 0.2;
            StatusHandler.labelMiddle.scaleY = 0.2;
            GameMode.gameMode.collection2(" ",param2);
         }
      }
   }
}
