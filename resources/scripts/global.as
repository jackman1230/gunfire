package
{
   import flash.display.Stage;
   
   public class global
   {
      
      public static var url_BatmanTruck1:String = "http://www.toongames.com";
      
      public static const url_pmg_charselect:String = "http://www.toongames.com/cat/21/Top-games/newest-1.html?utm_source=games&utm_medium=metalslugpr";
      
      public static var url_preloader:String = "http://www.toongames.com/cat/21/Top-games/newest-1.html?utm_source=games&utm_medium=metalslugpr";
      
      public static const url_pmg_regular:String = "http://www.toongames.com/cat/21/Top-games/newest-1.html?utm_source=games&utm_medium=metalslug1pmg";
      
      public static const url_pmg_ingame:String = url_pmg_regular + "_ingame";
      
      public static const url_pmg_loading:String = url_pmg_regular + "_level_loader";
      
      public static const url_pmg_menu:String = url_pmg_regular + "_menu";
      
      public static const url_pmg_gamecomplete:String = url_pmg_regular + "_gamecomplete";
      
      public static const url_sponsor_title:String = url_pmg_regular + "_titlescreen";
      
      public static const pmg_button_title:String = "More\nGames!";
      
      public static const pmg_button_command_regular:String = "btn_pmg_regular";
      
      public static const pmg_button_command_ingame:String = "btn_pmg_ingame";
      
      public static const pmg_button_command_loading:String = "btn_pmg_loading";
      
      public static const pmg_button_command_menu:String = "btn_pmg_menu";
      
      public static const pmg_button_command_charselect:String = "btn_pmg_charselect";
      
      public static const url_fgfsy:String = "http://www.toongames.com/index.php?task=GFS";
      
      public static const gameHeight:int = 448;
      
      public static const gameWidth:int = 640;
      
      public static var DK:Boolean = true;
      
      public static var disable_auto_launch:Boolean = false;
      
      public static var mainStage:Stage = null;
      
      public static var frameDebug:Boolean = false;
       
      
      public function global()
      {
         super();
      }
   }
}
