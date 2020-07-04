package
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   
   public class Migrate
   {
      
      public static var gun_direction:Number = 0;
      
      public static var y_speed:Number = 18;
      
      public static var states:String = "";
      
      public static var stopMusic:Boolean = false;
      
      public static var player_ready:Boolean = false;
      
      public static var soundPending:Boolean = false;
      
      public static var fo;
      
      public static var turning:Boolean = false;
      
      public static var can_width:Boolean = false;
      
      public static var buttonSafe:Boolean = false;
      
      public static var shooting:Boolean = false;
      
      public static var g:MovieClip = new MovieClip();
      
      public static var ready:Boolean = false;
      
      public static var changing:Boolean = false;
      
      public static var bulletPending:Boolean = false;
      
      public static var beginMusic:Boolean = false;
       
      
      public function Migrate()
      {
         super();
      }
      
      public static function throwAction(param1:* = null) : void
      {
      }
      
      public static function jump_Action(param1:Sprite, param2:Number) : void
      {
      }
      
      public static function attackAction(param1:*) : void
      {
      }
      
      public static function dummyFunction() : void
      {
         trace("yay compiler");
      }
      
      public static function stopThrowing() : void
      {
         fo.myHandler.stopThrowing();
      }
      
      public static function player_born() : void
      {
         if(fo != null)
         {
            fo.myHandler.unDie();
         }
         else
         {
            trace("Migrate, trapped a FO crash");
         }
      }
      
      public static function shootAction() : void
      {
      }
   }
}
