package
{
   import flash.display.DisplayObject;
   import flash.display.DisplayObjectContainer;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.MouseEvent;
   
   public class MakeButton extends Sprite
   {
       
      
      public var buttonCommand:String;
      
      public var par;
      
      public var doubleParent:Boolean = false;
      
      public function MakeButton(param1:Sprite, param2:String)
      {
         super();
         this.buttonCommand = param2;
         this.par = param1.parent;
         addEventListener(MouseEvent.MOUSE_OVER,this.mouseOver);
         addEventListener(MouseEvent.MOUSE_OUT,this.mouseOut);
         addEventListener(MouseEvent.MOUSE_UP,this.clicked);
      }
      
      public static function make(param1:Sprite, param2:String, param3:Boolean = false) : MakeButton
      {
         var _loc4_:DisplayObjectContainer = null;
         var _loc5_:MakeButton = null;
         if(param1.parent != null)
         {
            _loc5_ = new MakeButton(param1,param2);
            _loc4_ = param1.parent;
            _loc5_.x = param1.x;
            _loc5_.y = param1.y;
            param1.x = 0;
            param1.y = 0;
            _loc4_.removeChild(param1);
            _loc5_.addChild(param1);
            _loc4_.addChild(_loc5_);
            _loc5_.mouseChildren = false;
            _loc5_.useHandCursor = true;
            _loc5_.buttonMode = true;
            _loc5_.doubleParent = param3;
            return _loc5_;
         }
         return null;
      }
      
      public function mouseOver(param1:Event = null) : *
      {
         scaleX = 1.4;
         scaleY = 1.4;
      }
      
      public function mouseOut(param1:Event = null) : *
      {
         scaleX = 1;
         scaleY = 1;
      }
      
      public function clicked(param1:Event = null) : *
      {
         if(!this.doubleParent)
         {
            this.par.buttonPressed(this.buttonCommand);
         }
         else
         {
            this.par.parent.buttonPressed(this.buttonCommand);
         }
      }
      
      public function overrideParent(param1:DisplayObject) : *
      {
         this.par = param1;
         return this;
      }
   }
}
