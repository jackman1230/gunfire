package
{
   import flash.display.IBitmapDrawable;
   import flash.display.Sprite;
   
   public class GroundLoader
   {
      
      public static var tempClip:IBitmapDrawable = new Sprite();
      
      public static var noGround:Boolean = false;
       
      
      public function GroundLoader()
      {
         super();
      }
      
      public static function getSingeGround() : Array
      {
         return [new intro_thingie(),tempClip,tempClip,tempClip,tempClip];
      }
      
      public static function getPanelsForIndex(param1:int = 0) : Array
      {
         var _loc2_:Array = new Array();
         if(noGround)
         {
            _loc2_ = [new Sprite(),new Sprite(),new Sprite()];
         }
         else
         {
            if(0)
            {
            }
            _loc2_ = [new ls.level_0_0(),new ls.level_0_1(),new ls.level_0_2(),new ls.level_0_3(),new ls.level_0_4(),new ls.level_0_5(),new ls.level_0_6(),new ls.level_0_7()];
         }
         return _loc2_;
      }
   }
}
