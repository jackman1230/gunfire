package mochi.as3
{
   import flash.display.Loader;
   import flash.display.Sprite;
   import flash.net.URLRequest;
   import flash.net.URLRequestMethod;
   import flash.net.URLVariables;
   import flash.system.Capabilities;
   import flash.system.Security;
   
   public dynamic class MochiBot extends Sprite
   {
       
      
      public function MochiBot()
      {
         super();
      }
      
      public static function track(param1:Sprite, param2:String) : MochiBot
      {
         if(Security.sandboxType == "localWithFile")
         {
            return null;
         }
         var _loc3_:MochiBot = new MochiBot();
         param1.addChild(_loc3_);
         Security.allowDomain("*");
         Security.allowInsecureDomain("*");
         var _loc5_:URLVariables = new URLVariables();
         _loc5_["sb"] = Security.sandboxType;
         _loc5_["v"] = Capabilities.version;
         _loc5_["swfid"] = param2;
         _loc5_["mv"] = "8";
         _loc5_["fv"] = "9";
         var _loc6_:String = _loc3_.root.loaderInfo.loaderURL;
         if(_loc6_.indexOf("http") == 0)
         {
            _loc5_["url"] = _loc6_;
         }
         else
         {
            _loc5_["url"] = "local";
         }
         var _loc7_:URLRequest = new URLRequest("http://core.mochibot.com/my/core.swf");
         _loc7_.contentType = "application/x-www-form-urlencoded";
         _loc7_.method = URLRequestMethod.POST;
         _loc7_.data = _loc5_;
         var _loc8_:Loader = new Loader();
         _loc3_.addChild(_loc8_);
         _loc7_;
         _loc8_;
         return _loc3_;
      }
   }
}
