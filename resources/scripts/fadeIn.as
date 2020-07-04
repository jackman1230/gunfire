package
{
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.filters.GlowFilter;
   import flash.geom.ColorTransform;
   
   public class fadeIn extends Sprite
   {
       
      
      protected var parentClass;
      
      public var inactive = true;
      
      public var myText:customFont;
      
      public var gf:GlowFilter;
      
      public var moveUp:Boolean = false;
      
      public var moveDelta:int = 12;
      
      public function fadeIn(param1:int, param2:int, param3:String, param4:int, param5:*, param6:Boolean = false)
      {
         super();
         this.parentClass = param5;
         this.myText = new customFont(param4,param3,true);
         this.myText.x = 0;
         this.myText.y = 0;
         this.x = param1;
         this.y = param2;
         addChild(this.myText);
         this.moveUp = param6;
         addEventListener(Event.ENTER_FRAME,this.frame);
      }
      
      public function frame(param1:Event) : *
      {
         alpha = alpha * 0.98;
         transform.colorTransform = new ColorTransform(1,1,1,alpha,0,0,0,0);
         if(this.moveDelta > 0.2)
         {
            this.moveDelta = this.moveDelta - 0.05;
         }
         if(this.moveUp)
         {
            this.y = this.y - this.moveDelta;
         }
      }
   }
}
