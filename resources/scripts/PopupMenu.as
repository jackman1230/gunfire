package
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.events.MouseEvent;
   
   public class PopupMenu extends CustomWindow
   {
      
      public static const DIRECTION_UP:int = 1;
      
      public static const DIRECTION_DOWN:int = 2;
      
      public static const DIRECTION_FULLY_DOWN:int = 0;
      
      public static const DIRECTION_FULLY_UP:int = 4;
      
      public static const ALPHA_START:Number = 0.1;
      
      public static const ALPHA_FINISH:Number = 1;
       
      
      protected var handler:PopupHandler;
      
      public var direction:int = 0;
      
      public var active:Boolean = false;
      
      public var initialised:Boolean = false;
      
      public var exclusive:Boolean = true;
      
      public var clickGuard:Sprite;
      
      public var hasClickGuard:Boolean = false;
      
      public var xOffset:Number = 0;
      
      public var yOffset:Number = 0;
      
      public var forcedPopdown:Boolean = false;
      
      public var targWidth:Number = 500;
      
      public var targHeight:Number = 500;
      
      public var zoomChild:Sprite = null;
      
      public var zoomVeloX:Number = 1;
      
      public var zoomVeloY:Number = 1;
      
      public function PopupMenu(param1:Number = 0, param2:Number = 0, param3:Number = 640, param4:Number = 448, param5:String = " ", param6:Boolean = false)
      {
         super(param1,param2,param3,param4,param5,param6,false,false,false,true);
         this.handler = PopupHandler.self;
         this.initialised = false;
         visible = false;
         this.xOffset = param1;
         this.yOffset = param2;
         this.centerMe();
         if(this.hasClickGuard)
         {
            this.clickGuard = new clickguard();
            addChild(this.clickGuard);
            setChildIndex(this.clickGuard,0);
         }
         if(closeButton)
         {
            closeButton.visible = false;
         }
         if(titleFont)
         {
            titleFont.visible = false;
         }
         this.scrollRect = null;
      }
      
      override public function closeWindow(param1:MouseEvent) : void
      {
         this.popDown();
      }
      
      public function centerMe() : void
      {
         this.x = global.gameWidth / 2 + this.xOffset;
         this.y = global.gameHeight / 2 + this.yOffset;
         if(this.zoomChild)
         {
            this.zoomChild.x = 0;
            this.zoomChild.y = 0;
         }
      }
      
      public function initialise() : void
      {
         addEventListener(Event.ENTER_FRAME,this.frame);
         this.visible = false;
         this.initialised = true;
      }
      
      public function keyDown(param1:KeyboardEvent) : void
      {
      }
      
      public function popup() : void
      {
         if(this.exclusive)
         {
            PopupHandler.clearOtherMenus(this);
         }
         if(!this.initialised)
         {
            this.initialise();
         }
         this.direction = DIRECTION_UP;
         if(this.hasClickGuard)
         {
            this.clickGuard.visible = true;
         }
         this.active = true;
         visible = true;
         this.getZoomProperties(true);
         GameMode.gameMode.keyMenu = this;
      }
      
      private function getZoomProperties(param1:Boolean = true) : void
      {
         if(param1)
         {
            this.targWidth = originalUserWidth;
            this.targHeight = originalUserHeight;
            userWidth = 1;
            userHeight = 1;
         }
         else
         {
            userWidth = originalUserWidth;
            userHeight = originalUserHeight;
            this.targWidth = 1;
            this.targHeight = 1;
         }
         this.zoomVeloX = (this.targWidth - userWidth) / 15;
         this.zoomVeloY = (this.targHeight - userHeight) / 15;
      }
      
      public function popDown(param1:Boolean = false) : void
      {
         this.forcedPopdown = param1;
         if(this.active)
         {
            this.direction = DIRECTION_DOWN;
         }
         if(this.hasClickGuard)
         {
            this.clickGuard.visible = false;
         }
         if(GameMode.gameMode.keyMenu == this)
         {
            GameMode.gameMode.keyMenu = null;
         }
         this.getZoomProperties(false);
      }
      
      override public function setSize(param1:Number, param2:Number) : void
      {
         super.setSize(param1,param2);
         if(this.zoomChild)
         {
            if(this.direction == DIRECTION_UP && this is Menu_Intro)
            {
               userWidth = originalUserWidth;
               userHeight = originalUserHeight;
            }
            this.zoomChild.scaleX = userWidth / originalUserWidth;
            this.zoomChild.scaleY = userHeight / originalUserHeight;
         }
      }
      
      public function frame(param1:Event) : void
      {
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         if(this.direction == DIRECTION_UP || this.direction == DIRECTION_DOWN)
         {
            _loc2_ = userWidth + this.zoomVeloX;
            _loc3_ = userHeight + this.zoomVeloY;
            this.setSize(_loc2_,_loc3_);
            if(this.direction == DIRECTION_UP && (userWidth / this.targWidth >= 1 && userHeight / this.targHeight >= 1))
            {
               this.direction = DIRECTION_FULLY_UP;
               this.active = true;
               this.setSize(this.targWidth,this.targHeight);
            }
            §§push(this.direction == DIRECTION_DOWN);
            if(this.direction == DIRECTION_DOWN && (userWidth / this.targWidth <= 1 && userHeight / this.targHeight <= 1))
            {
               this.direction = DIRECTION_FULLY_DOWN;
               this.active = false;
               visible = false;
               PopupHandler.notifyDestruction(this);
               gMode.main.stage.focus = gMode.main;
               this.setSize(this.targWidth,this.targHeight);
            }
            this.centerMe();
         }
         if(this.hasClickGuard)
         {
            this.clickGuard.visible = this.direction == DIRECTION_FULLY_UP || this.direction == DIRECTION_UP;
            if(this.clickGuard.visible)
            {
               this.clickGuard.width = global.gameWidth;
               this.clickGuard.height = global.gameHeight;
               this.clickGuard.x = 0 - this.x;
               this.clickGuard.y = 0 - this.y;
            }
         }
      }
      
      override public function buttonPressed(param1:String) : void
      {
         super.buttonPressed(param1);
      }
   }
}
