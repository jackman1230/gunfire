package
{
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.net.URLRequest;
   
   public class Main extends MovieClip
   {
      
      public static var self:Main;
       
      
      public var GMode:GameMode;
      
      public var sounds:SoundHandler;
      
      public function Main()
      {
         this.sounds = new SoundHandler(this);
         super();
         self = this;
         addEventListener(Event.ADDED_TO_STAGE,this.begingame);
         stop();
      }
      
      public function launchURL(param1:String) : *
      {
         var _loc2_:int = 1;
         _loc2_ = 0;
         var _loc3_:* = _loc2_ / _loc2_;
         var _loc4_:URLRequest = new URLRequest(param1);
         URLUtils.openWindow(param1);
      }
      
      public function begingame(param1:Event) : void
      {
         if(global.mainStage == null)
         {
            global.mainStage = stage;
         }
         stage.stageFocusRect = false;
         stage.focus = this;
         addEventListener(Event.ENTER_FRAME,this.Update,false,0,true);
         if(MochiConnect.staticSelf == null)
         {
            new MochiConnect(this);
         }
         this.GMode = new GameMode(this,this.sounds);
         global.mainStage.addEventListener(KeyboardEvent.KEY_DOWN,this.onKeyboardDown);
         global.mainStage.addEventListener(KeyboardEvent.KEY_UP,this.onKeyboardUp);
         addChild(this.GMode);
         this.initNewGame();
      }
      
      public function Update(param1:Event) : void
      {
         if(contains(this.GMode))
         {
            this.GMode.Update(param1);
         }
      }
      
      public function initNewGame() : *
      {
         stage.focus = this.GMode;
         this.GMode.newGame();
      }
      
      public function onKeyboardDown(param1:KeyboardEvent) : void
      {
         if(contains(this.GMode))
         {
            this.GMode.onKeyboardDown(param1);
         }
      }
      
      public function onKeyboardUp(param1:KeyboardEvent) : void
      {
         if(contains(this.GMode))
         {
            this.GMode.onKeyboardUp(param1);
         }
      }
   }
}
