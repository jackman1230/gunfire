package
{
   import flash.display.DisplayObject;
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.utils.getDefinitionByName;
   
   public class Preloader extends MovieClip
   {
       
      
      public var game:DisplayObject;
      
      public var disable_auto_launch:Boolean = true;
      
      public function Preloader()
      {
         super();
         if(stage)
         {
            this.addedToStage();
         }
         else
         {
            addEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         }
      }
      
      private function addedToStage(param1:Event = null) : void
      {
         removeEventListener(Event.ADDED_TO_STAGE,this.addedToStage);
         global.mainStage = stage;
         if(MochiConnect.staticSelf == null)
         {
            new MochiConnect(this);
         }
         addChild(new PreloaderToongames(this));
      }
      
      public function launchGame(param1:Sprite) : void
      {
         removeChild(param1);
         var _loc2_:Class = getDefinitionByName("Main") as Class;
         this.game = new _loc2_() as DisplayObject;
         addChild(this.game);
      }
      
      private function gotoWebsite(param1:MouseEvent) : void
      {
         URLUtils.openWindow(global.url_preloader);
      }
   }
}
