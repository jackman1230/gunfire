package
{
   import flash.display.Stage;
   import flash.events.Event;
   
   public class Snowflake extends snowflake_clip
   {
       
      
      private var xPos:Number = 0;
      
      private var yPos:Number = 0;
      
      private var xSpeed:Number = 0;
      
      private var ySpeed:Number = 0;
      
      private var radius:Number = 0;
      
      private var scale:Number = 0;
      
      private var alphaValue:Number = 0;
      
      private var maxHeight:Number = 0;
      
      private var maxWidth:Number = 0;
      
      public function Snowflake()
      {
         super();
      }
      
      public function SetInitialProperties() : void
      {
         this.xSpeed = 0.05 + Math.random() * 0.1;
         this.ySpeed = 0.1 + Math.random() * 3;
         this.radius = 0.1 + Math.random() * 2;
         this.scale = 0.01 + Math.random();
         this.alphaValue = 0.1 + Math.random();
         var _loc1_:Stage = global.mainStage;
         this.maxWidth = _loc1_.stageWidth;
         this.maxHeight = _loc1_.stageHeight;
         this.x = Math.random() * this.maxWidth;
         this.y = Math.random() * this.maxHeight;
         this.xPos = this.x;
         this.yPos = this.y;
         this.scaleX = this.scaleY = this.scale;
         this.alpha = this.alphaValue;
         this.addEventListener(Event.ENTER_FRAME,this.MoveSnowFlake);
         this.addEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
      }
      
      private function removedFromStage(param1:Event) : void
      {
         this.removeEventListener(Event.ENTER_FRAME,this.MoveSnowFlake);
         this.removeEventListener(Event.REMOVED_FROM_STAGE,this.removedFromStage);
      }
      
      private function MoveSnowFlake(param1:Event) : void
      {
         this.xPos = this.xPos + this.xSpeed;
         this.yPos = this.yPos + this.ySpeed;
         this.x = this.x + this.radius * Math.cos(this.xPos);
         this.y = this.y + this.ySpeed;
         if(this.y - this.height > this.maxHeight)
         {
            this.y = -10 - this.height;
            this.x = Math.random() * this.maxWidth;
         }
      }
   }
}
