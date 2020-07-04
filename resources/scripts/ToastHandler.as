package
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class ToastHandler extends Sprite
   {
      
      public static var myParent:Sprite;
      
      public static var self:ToastHandler;
      
      public static var toastArray:Array;
      
      public static var toastQueue:Array;
      
      public static var frameCount:int = 0;
      
      public static var gMode:GameMode;
       
      
      public function ToastHandler(param1:Sprite)
      {
         super();
         myParent = param1;
         self = this;
         toastArray = new Array();
         toastQueue = new Array();
         myParent.addChild(self);
         this.addEventListener(Event.ENTER_FRAME,frameCheck);
      }
      
      public static function checkQueue() : void
      {
         if(toastQueue.length > 0)
         {
            makeToast(toastQueue[0]);
            toastQueue.splice(0,1);
         }
      }
      
      public static function frameCheck(param1:Event) : void
      {
         frameCount++;
         if(frameCount % 20 == 0)
         {
            checkQueue();
         }
      }
      
      public static function enqueue(param1:Toast) : void
      {
         toastQueue.push(param1);
      }
      
      public static function makeToast(param1:Toast) : void
      {
         toastArray.push(param1);
         var _loc2_:int = global.gameHeight - 80 - toastArray.length * Toast.defaultHeight;
         UIHandler.self.addChild(param1);
         param1.popup(15,_loc2_,ToastHandler.self);
         param1 = null;
      }
      
      public static function butterToast(param1:Toast) : void
      {
         var _loc2_:int = 0;
         if(toastArray.indexOf(param1) > 0)
         {
            _loc2_ = toastArray.indexOf(param1);
            toastArray.splice(0,_loc2_);
            if(_loc2_ == toastArray.length - 1)
            {
               toastArray.splice(0,toastArray.length - 1);
            }
         }
         param1 = null;
      }
   }
}
