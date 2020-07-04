package
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class PreloaderToongames extends MovieClip
   {
       
      
      public var parentLoader:Preloader;
      
      private var STATE_LOADING:int = 0;
      
      private var STATE_SHOWING_BUTTON:int = 1;
      
      private var STATE_PLAYING_OUTRO:int = 2;
      
      private var STATE_FINISHED:int = 4;
      
      private var state:int = 0;
      
      private var frameCount:int = 0;
      
      public var game:DisplayObject;
      
      public var clip:mainClipToongames;
      
      public var outroAnim:outroClip;
      
      public var secondClickChecker:button_overlay;
      
      private var added_button_listener:Boolean = false;
      
      public function PreloaderToongames(param1:Preloader)
      {
         this.clip = new mainClipToongames();
         this.secondClickChecker = new button_overlay();
         super();
         this.parentLoader = param1;
         addChild(this.clip);
         this.clip.x = global.gameWidth / 2;
         this.clip.y = global.gameHeight / 2;
         this.makeItSnow();
         addEventListener(Event.ENTER_FRAME,this.loading);
      }
      
      private function randRange(param1:Number, param2:Number) : Number
      {
         return Math.floor(Math.random() * (param2 - param1 + 1)) + param1;
      }
      
      private function makeItSnow() : void
      {
         var _loc2_:Snowflake = null;
         var _loc1_:int = 0;
         while(_loc1_ < 50)
         {
            _loc2_ = new Snowflake();
            this.clip.emp.addChild(_loc2_);
            _loc2_.SetInitialProperties();
            _loc1_++;
         }
      }
      
      private function loading(param1:Event) : void
      {
         this.frameCount++;
         var _loc2_:Number = loaderInfo.bytesLoaded;
         var _loc3_:Number = loaderInfo.bytesTotal;
         var _loc4_:Number = 0;
         if(_loc3_ == 0 || _loc3_ < _loc2_)
         {
            _loc4_ = 100;
         }
         else
         {
            _loc4_ = _loc2_ / _loc3_ * 100;
         }
         var _loc5_:Number = this.frameCount / 250 * 100;
         var _loc6_:Number = _loc4_ < _loc5_?Number(_loc4_):Number(_loc5_);
         this.clip.websitebuttoninstance.addEventListener(MouseEvent.CLICK,this.gotoWebsite);
         if(this.state == this.STATE_LOADING)
         {
            this.clip.lbar.gotoAndStop(int(_loc6_));
            if(_loc4_ >= 100 && _loc5_ >= 100)
            {
               this.clip.butply.play();
               this.state = this.STATE_SHOWING_BUTTON;
               if(loaderInfo.url.indexOf("file:") > -1)
               {
                  global.DK = true;
                  if(!global.disable_auto_launch)
                  {
                     this.launchGame();
                  }
               }
               else
               {
                  global.DK = false;
               }
            }
         }
         if(this.state == this.STATE_SHOWING_BUTTON && !this.added_button_listener)
         {
            this.clip.butply.addEventListener(MouseEvent.CLICK,this.playClicked);
            this.added_button_listener = true;
         }
         if(this.state == this.STATE_PLAYING_OUTRO)
         {
            if(this.frameCount > 100 && this.game == null)
            {
               this.launchGame();
            }
         }
         if(this.state == this.STATE_FINISHED)
         {
            removeEventListener(Event.ENTER_FRAME,this.loading);
         }
      }
      
      private function playClicked(param1:Event = null) : void
      {
         this.clip.butply.removeEventListener(MouseEvent.CLICK,this.playClicked);
         this.clip.websitebuttoninstance.removeEventListener(MouseEvent.CLICK,this.gotoWebsite);
         this.clip.butply.visible = false;
         this.clip.lbar.visible = false;
         this.clip.title.visible = false;
         this.clip.sonic.visible = false;
         this.clip.mario.visible = false;
         this.outroAnim = new outroClip();
         this.outroAnim.x = 320;
         this.outroAnim.y = 200;
         addChild(this.outroAnim);
         addChild(this.secondClickChecker);
         this.secondClickChecker.addEventListener(MouseEvent.CLICK,this.gotoWebsite);
         this.state = this.STATE_PLAYING_OUTRO;
         this.frameCount = 0;
      }
      
      private function rc(param1:DisplayObject) : void
      {
         if(param1 != null && contains(param1))
         {
            removeChild(param1);
         }
      }
      
      public function launchGame(param1:Event = null) : void
      {
         this.rc(this.clip);
         this.rc(this.outroAnim);
         this.rc(this.secondClickChecker);
         this.state = this.STATE_FINISHED;
         this.parentLoader.launchGame(this);
      }
      
      private function gotoWebsite(param1:MouseEvent) : void
      {
         var _loc2_:URLRequest = new URLRequest(global.url_preloader + (this.state == this.STATE_PLAYING_OUTRO?"2":"1"));
         "_blank";
         _loc2_;
         ;
      }
   }
}
