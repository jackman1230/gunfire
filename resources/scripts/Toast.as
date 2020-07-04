package
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   import flash.geom.Rectangle;
   
   public class Toast extends CustomWindow
   {
      
      public static var defaultWidth:int = 160;
      
      public static var defaultHeight:int = 48;
       
      
      public var bodyFont:customFont;
      
      public var subjectFont:customFont;
      
      public var targetY:int = 0;
      
      public var targetX:int = 0;
      
      public var startX:int = 0;
      
      public var startY:int = 0;
      
      public var slideCurrent:Number = 120;
      
      public var slideTarget:Number = 0;
      
      public var slideing:Boolean = true;
      
      public var frameCount:int = 0;
      
      public var inID:int;
      
      public var myToaster:ToastHandler;
      
      public function Toast(param1:int)
      {
         this.inID = param1;
         super(100,100,defaultWidth,defaultHeight," ",true,false,false,false,true);
         visible = false;
      }
      
      override public function closeWindow(param1:MouseEvent) : void
      {
         ToastHandler.butterToast(this);
         super.closeWindow(null);
      }
      
      public function slideFrame(param1:Event = null) : void
      {
         if(this.frameCount == 0)
         {
            new Tweenie().tweenSprite(global.gameWidth + defaultWidth / 2 + 20,defaultWidth / 2 + 10,this,true);
         }
         if(this.frameCount > 200)
         {
            removeEventListener(Event.ENTER_FRAME,this.slideFrame);
            this.closeWindow(null);
         }
         this.frameCount++;
      }
      
      public function popup(param1:int, param2:int, param3:ToastHandler) : void
      {
         this.myToaster = param3;
         this.targetX = param1;
         this.targetY = param2;
         this.startX = param1;
         this.startY = param2 + defaultHeight;
         this.x = this.startX;
         this.y = this.startY;
         this.addEventListener(Event.ENTER_FRAME,this.slideFrame);
         this.drawBackgroundImage(false);
         this.addBand();
         this.drawMessage(this.inID);
         visible = true;
      }
      
      public function addBand() : void
      {
         var _loc1_:Sprite = new Sprite();
         addChild(_loc1_);
         _loc1_.x = -defaultWidth / 2 + _loc1_.width / 2;
         _loc1_.y = -defaultHeight / 2 + _loc1_.height / 2;
      }
      
      public function drawMessage(param1:int) : void
      {
         var _loc4_:String = UserStats.getAchievmentName(this.inID);
         titleFont = new customFont(16,"Achievement!",false,4473958);
         titleFont.x = 8 - defaultWidth / 2;
         titleFont.y = 4 - defaultHeight / 2;
         titleFont.drawString("Achievement!");
         addChild(titleFont);
         titleFont.scrollRect = new Rectangle(-1,-1,defaultWidth - 8,defaultHeight - 8);
         this.subjectFont = new customFont(16,"  ",false);
         this.subjectFont.setWrapWidth(defaultWidth - 30);
         this.subjectFont.drawString(_loc4_);
         addChild(this.subjectFont);
         this.subjectFont.scrollRect = new Rectangle(-1,-1,defaultWidth - 8,defaultHeight - 8);
         this.subjectFont.x = 40 - defaultWidth / 2;
         this.subjectFont.y = titleFont.y + titleFont.height + 4;
      }
   }
}
