package
{
   import flash.display.Sprite;
   
   public class PopupHandler extends Sprite
   {
      
      public static var myParent:Sprite;
      
      public static var self:PopupHandler;
      
      public static var menuList:Vector.<PopupMenu> = new Vector.<PopupMenu>();
       
      
      public function PopupHandler(param1:Sprite)
      {
         super();
         myParent = param1;
         self = this;
         myParent.addChild(this);
      }
      
      public static function clearOtherMenus(param1:PopupMenu) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < menuList.length)
         {
            if(menuList[_loc2_] != null && menuList[_loc2_] != param1)
            {
               (menuList[_loc2_] as PopupMenu).popDown(true);
            }
            _loc2_++;
         }
      }
      
      public static function clearMenus(param1:Boolean = false) : void
      {
         var _loc2_:int = 0;
         _loc2_ = 0;
         while(_loc2_ < menuList.length)
         {
            if(menuList[_loc2_] != null)
            {
               (menuList[_loc2_] as PopupMenu).popDown(true);
            }
            _loc2_++;
         }
         GameMode.gameMode.keyMenu = null;
      }
      
      public static function countActive() : int
      {
         var _loc2_:int = 0;
         var _loc1_:int = 0;
         if(menuList.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < menuList.length)
            {
               if(menuList[_loc2_].direction == PopupMenu.DIRECTION_FULLY_UP || menuList[_loc2_].direction == PopupMenu.DIRECTION_UP)
               {
                  _loc1_++;
               }
               _loc2_++;
            }
         }
         return _loc1_;
      }
      
      public static function notifyDestruction(param1:PopupMenu) : void
      {
         if(param1 != null)
         {
            if(menuList.indexOf(param1) > -1)
            {
               menuList.splice(menuList.indexOf(param1),1);
               param1.cleanUp();
            }
            if(self.contains(param1))
            {
               self.removeChild(param1);
            }
         }
      }
      
      public static function popupAsMenu(param1:PopupMenu) : void
      {
         if(param1)
         {
            menuList.push(param1);
            if(!param1.initialised)
            {
               param1.initialise();
            }
            self.addChild(param1);
            EffectIndicator.self.removeAllStatuses();
            Menu_LevelSelect.selectActive = false;
            param1.popup();
            UIHandler.unPause();
            GameMode.gameMode.keyMenu = param1;
         }
      }
      
      public static function menuActive() : Boolean
      {
         return countActive() > 0;
      }
   }
}
