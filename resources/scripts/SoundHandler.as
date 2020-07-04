package
{
   import flash.events.*;
   import flash.media.Sound;
   import flash.media.SoundChannel;
   import flash.net.URLRequest;
   import flash.utils.ByteArray;
   
   public class SoundHandler
   {
      
      public static var soundOn:Boolean = true;
      
      public static var musicOn:Boolean = true;
      
      public static var soundArray:Vector.<Class>;
      
      public static var fxChannel:SoundChannel;
      
      public static var fxSound:Sound;
       
      
      public var playing:Boolean = false;
      
      var parent;
      
      public var parentClass:GameMode;
      
      var musicChannel:SoundChannel;
      
      var musicTrack:Sound;
      
      public var engineChannel:SoundChannel;
      
      public var engineSound:Sound;
      
      public var enginePlaying:Boolean = false;
      
      public var ePitch:Number = 1;
      
      public var oSound:Sound;
      
      private var _mp3:Sound;
      
      private var _loadedMP3Samples:ByteArray;
      
      private var _dynamicSound:Sound;
      
      private var _phase:Number;
      
      private var _numSamples:int;
      
      private var _playbackSpeed:Number = 1;
      
      public function SoundHandler(param1:*)
      {
         super();
         this.parent = param1;
      }
      
      public static function createSounds() : void
      {
         soundArray = new Vector.<Class>();
      }
      
      public static function playSound(param1:int) : *
      {
      }
      
      public static function playSoundClass(param1:Class) : *
      {
         if(soundOn)
         {
            fxChannel = new SoundChannel();
            fxSound = new param1();
            fxChannel = fxSound.play();
         }
      }
      
      public function setSounds(param1:Boolean, param2:Boolean, param3:Boolean = true) : *
      {
         soundOn = param1;
         musicOn = param2;
         this.stopEngine();
         Serialiser.saveStats();
      }
      
      public function toggleSound() : *
      {
         soundOn = !soundOn;
         GameMode.gameMode.slide("Sound " + (!!soundOn?"On":"Off"));
         Serialiser.saveStats();
      }
      
      public function toggleMusic() : *
      {
         if(musicOn)
         {
            musicOn = false;
            this.stopMusic();
         }
         else
         {
            musicOn = true;
            this.playMusic();
         }
         GameMode.gameMode.slide("Music " + (!!musicOn?"On":"Off"));
         Serialiser.saveStats();
      }
      
      public function restartMusic(param1:Event) : void
      {
         if(musicOn)
         {
            this.stopMusic();
            this.playMusic();
         }
      }
      
      public function stopMusic() : *
      {
         if(this.musicChannel != null)
         {
            this.musicChannel.stop();
            this.musicChannel.removeEventListener(Event.SOUND_COMPLETE,this.restartMusic);
         }
         if(fxChannel != null)
         {
            fxChannel.stop();
         }
         this.playing = false;
      }
      
      public function playMusic() : *
      {
         this.stopMusic();
         if(musicOn)
         {
            this.playing = true;
            if(World.currentLevel != null && World.currentLevel.myID >= Level.LEVEL_1 && !PopupHandler.menuActive())
            {
               this.musicTrack = new sound_musictrack();
            }
            else
            {
               this.musicTrack = new sound_musictrack();
            }
            this.musicChannel = new SoundChannel();
            this.musicChannel = this.musicTrack.play();
            this.musicChannel.addEventListener(Event.SOUND_COMPLETE,this.restartMusic);
         }
      }
      
      public function set playbackSpeed(param1:Number) : void
      {
         this._playbackSpeed = param1;
      }
      
      public function loadAndPlay(param1:URLRequest = null) : void
      {
         this._mp3 = new sound_pickup_life();
         this.playLoadedSound(this._mp3);
      }
      
      public function playLoadedSound(param1:Sound) : void
      {
         var _loc2_:ByteArray = new ByteArray();
         param1.extract(_loc2_,int(param1.length * 44.1));
         this.play(_loc2_);
      }
      
      public function stop() : void
      {
         if(this._dynamicSound)
         {
            this._dynamicSound.removeEventListener(SampleDataEvent.SAMPLE_DATA,this.onSampleData);
            this._dynamicSound = null;
         }
      }
      
      private function mp3Complete(param1:Event) : void
      {
         this.playLoadedSound(this._mp3);
      }
      
      private function play(param1:ByteArray) : void
      {
         this.stop();
         this._dynamicSound = new Sound();
         this._dynamicSound.addEventListener(SampleDataEvent.SAMPLE_DATA,this.onSampleData);
         this._loadedMP3Samples = param1;
         this._numSamples = param1.length / 8;
         this._phase = 0;
         this._dynamicSound.play();
      }
      
      private function onSampleData(param1:SampleDataEvent) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:int = 0;
         while(_loc4_ < 2048 && soundOn)
         {
            this._loadedMP3Samples.position = int(this._phase) * 8;
            _loc2_ = this._loadedMP3Samples.readFloat();
            _loc3_ = this._loadedMP3Samples.readFloat();
            param1.data.writeFloat(_loc2_ * 0.65);
            param1.data.writeFloat(_loc3_ * 0.65);
            _loc4_++;
            this._phase = this._phase + this._playbackSpeed;
            if(this._phase < 0)
            {
               this._phase = this._phase + this._numSamples;
            }
            else if(this._phase >= this._numSamples)
            {
               this._phase = this._phase - this._numSamples;
            }
         }
         if(!soundOn)
         {
            this.stop();
         }
      }
      
      public function setPitch(param1:Number) : *
      {
         this.ePitch = param1;
         this._playbackSpeed = param1;
      }
      
      public function playEngine() : *
      {
         this.enginePlaying = true;
         if(soundOn)
         {
            this.loadAndPlay();
         }
      }
      
      public function restartEngine(param1:Event) : void
      {
         if(soundOn)
         {
            this.playEngine();
         }
      }
      
      public function stopEngine() : *
      {
         this.enginePlaying = false;
         this.stop();
      }
   }
}
