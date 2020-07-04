package
{
   public class YesNoPopup extends PopupMenu
   {
       
      
      public var funct1:Function;
      
      public var funct2:Function;
      
      public var val1:String;
      
      public var val2:String;
      
      public var questionText:String;
      
      public var titleText:String;
      
      public var buttonLeft:eButton;
      
      public var buttonRight:eButton;
      
      public var questionFont:customFont;
      
      public var newTitle:customFont;
      
      public var param1;
      
      public var param2;
      
      public var buttonsPressed:Boolean = false;
      
      public function YesNoPopup(param1:String, param2:GameMode, param3:PopupHandler, param4:Function, param5:Function, param6:String = "Really do that?", param7:String = "No", param8:String = "Yes", param9:* = null, param10:* = null)
      {
         hasClickGuard = false;
         super();
         var _loc11_:menuBG_dialogue = new menuBG_dialogue();
         addChild(_loc11_);
         zoomChild = _loc11_;
         makeButton(_loc11_.btn_yes,"btn_yes");
         makeButton(_loc11_.btn_no,"btn_no");
      }
      
      override public function buttonPressed(param1:String) : void
      {
         if(param1 == "btn_yes")
         {
            ScoreHandler.cleanupEverything();
            Serialiser.saveStats();
         }
         GameMode.gameMode.newGame();
      }
   }
}
