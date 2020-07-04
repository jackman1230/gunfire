package
{
   import flash.display.Sprite;
   
   public class WipeHandler
   {
      
      public static var myParent:Sprite;
      
      public static var self:WipeHandler;
      
      public static var pendingFunction:Function = null;
      
      public static var pendingParameter = null;
      
      public static var activeSwipe:Wipe;
       
      
      public function WipeHandler(param1:Sprite)
      {
         super();
         myParent = param1;
         self = this;
      }
      
      public static function beginSwipe(param1:Function, param2:* = null, param3:Boolean = false) : void
      {
         clearSwiper();
         pendingFunction = param1;
         pendingParameter = param2;
         var _loc4_:Sprite = new wl_loading_image();
         _loc4_.width = global.gameWidth;
         _loc4_.height = global.gameHeight;
         activeSwipe = new Wipe(_loc4_);
         activeSwipe.beginWipe(param3);
      }
      
      public static function wipeWaiting(param1:Wipe) : void
      {
         if(pendingFunction != null)
         {
            if(pendingParameter != null)
            {
               pendingFunction(pendingParameter);
            }
            else
            {
               pendingFunction();
            }
         }
      }
      
      public static function finishSwipe() : void
      {
         if(activeSwipe != null)
         {
            activeSwipe.finishWipe();
         }
      }
      
      public static function wipeFinished(param1:Wipe) : void
      {
         clearSwiper();
      }
      
      public static function clearSwiper() : void
      {
         if(activeSwipe != null)
         {
            if(UIHandler.self.contains(activeSwipe))
            {
               UIHandler.self.removeChild(activeSwipe);
            }
            pendingFunction = null;
            pendingParameter = null;
            activeSwipe = null;
         }
      }
   }
}
