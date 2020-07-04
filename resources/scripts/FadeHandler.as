package
{
   import flash.display.Sprite;
   
   public class FadeHandler
   {
      
      public static var self:FadeHandler;
      
      public static var myParent:Sprite;
      
      public static var fadeVect:Vector.<fadeIn> = new Vector.<fadeIn>();
       
      
      public function FadeHandler(param1:Sprite)
      {
         super();
         myParent = param1;
         self = this;
      }
      
      public static function makeFade(param1:String, param2:int, param3:Boolean = false, param4:Boolean = false) : *
      {
         var _loc5_:fadeIn = null;
         if(World.followObj != null)
         {
            _loc5_ = new fadeIn(320,190,param1,param2,UIHandler.self,param3);
            _loc5_.x = 320 - _loc5_.width / 2;
            if(param4)
            {
               _loc5_.x = _loc5_.x + 170;
            }
            myParent.addChild(_loc5_);
            fadeVect.push(_loc5_);
         }
      }
      
      public static function checkFades() : *
      {
         var _loc1_:fadeIn = null;
         var _loc2_:int = 0;
         if(fadeVect.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < fadeVect.length)
            {
               if(_loc2_ < fadeVect.length)
               {
                  _loc1_ = fadeVect[_loc2_];
                  if(_loc1_.alpha < 0.1)
                  {
                     fadeVect.splice(fadeVect.indexOf(_loc1_),1);
                     if(myParent.contains(_loc1_))
                     {
                        myParent.removeChild(_loc1_);
                     }
                  }
               }
               _loc2_++;
            }
         }
      }
      
      public static function cleanup() : void
      {
      }
   }
}
