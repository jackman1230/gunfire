package
{
   import flash.external.ExternalInterface;
   import flash.net.URLRequest;
   import flash.net.navigateToURL;
   
   public class URLUtils
   {
      
      protected static const WINDOW_OPEN_FUNCTION:String = "window.open";
       
      
      public function URLUtils()
      {
         super();
      }
      
      public static function openWindow(param1:String, param2:String = "_blank", param3:String = "") : void
      {
         var _loc4_:String = null;
         if(ExternalInterface.available)
         {
            _loc4_ = getBrowserName();
            if(getBrowserName() == "Firefox")
            {
               ExternalInterface.call(WINDOW_OPEN_FUNCTION,param1,param2,param3);
            }
            else if(_loc4_ == "IE")
            {
               ExternalInterface.call("function setWMWindow() {window.open(\'" + param1 + "\');}");
            }
            else if(_loc4_ == "Safari")
            {
               param2;
               new URLRequest(param1);
               ;
            }
            else if(_loc4_ == "Opera")
            {
               param2;
               new URLRequest(param1);
               ;
            }
            else
            {
               param2;
               new URLRequest(param1);
               ;
            }
         }
         else
         {
            param2;
            new URLRequest(param1);
            ;
         }
      }
      
      private static function getBrowserName() : String
      {
         var _loc1_:String = null;
         var _loc2_:String = ExternalInterface.call("function getBrowser(){return navigator.userAgent;}");
         if(_loc2_ != null && _loc2_.indexOf("Firefox") >= 0)
         {
            _loc1_ = "Firefox";
         }
         else if(_loc2_ != null && _loc2_.indexOf("Safari") >= 0)
         {
            _loc1_ = "Safari";
         }
         else if(_loc2_ != null && _loc2_.indexOf("MSIE") >= 0)
         {
            _loc1_ = "IE";
         }
         else if(_loc2_ != null && _loc2_.indexOf("Opera") >= 0)
         {
            _loc1_ = "Opera";
         }
         else
         {
            _loc1_ = "Undefined";
         }
         return _loc1_;
      }
   }
}
