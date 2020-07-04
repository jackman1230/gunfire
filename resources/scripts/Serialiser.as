package
{
   import flash.net.SharedObject;
   
   public class Serialiser
   {
      
      public static var md:SharedObject;
      
      public static var loadString:String = "metalslug_1_10";
       
      
      public function Serialiser()
      {
         super();
      }
      
      public static function loadStats() : void
      {
         md = SharedObject.getLocal(loadString);
         if(md.data.soundOn == undefined)
         {
            saveStats();
         }
         SoundHandler.soundOn = md.data.soundOn;
         SoundHandler.musicOn = md.data.musicOn;
         ScoreHandler.levelsPassed = md.data.levelsPassed;
         ScoreHandler.levelScores = md.data.levelScores;
         ScoreHandler.levelTimes = md.data.levelTimes;
         GameMode.selectedCharacter = md.data.selectedCharacter;
         GameMode.totalCash = md.data.totalCash;
         GameMode.helpShown = md.data.helpShown;
         GameMode.secondVehicleUnlocked = md.data.luigiUnlocked;
         GameMode.thirdVehicleUnlocked = md.data.peachUnlocked;
      }
      
      public static function saveStats() : void
      {
         md = SharedObject.getLocal(loadString);
         md.data.soundOn = SoundHandler.soundOn;
         md.data.musicOn = SoundHandler.musicOn;
         md.data.levelsPassed = ScoreHandler.levelsPassed;
         md.data.levelScores = ScoreHandler.levelScores;
         md.data.levelTimes = ScoreHandler.levelTimes;
         md.data.selectedCharacter = GameMode.selectedCharacter;
         md.data.totalCash = GameMode.totalCash;
         md.data.helpShown = GameMode.helpShown;
         md.data.luigiUnlocked = GameMode.secondVehicleUnlocked;
         md.data.peachUnlocked = GameMode.thirdVehicleUnlocked;
         md.flush();
      }
   }
}
