package objects
{
   import flash.display.MovieClip;
   
   public class cFrag extends cObject
   {
       
      
      public function cFrag(param1:Number, param2:Number, param3:GameMode)
      {
         super(param1,param2,param3);
         isBreakable = true;
         isFraggable = false;
         isGround = false;
         var _loc4_:int = 0;
         while(_loc4_ < 8)
         {
            addPart(BoxUtils.NewBox(param1 + Math.random() * 2 - 1,param2 + Math.random() * 2 - 1,0.2,0.2,10,false,Filters.fuckall,Filters.fuckallMask),new MovieClip(),true);
            _loc4_++;
         }
         explodeTimer = 1;
         postCreate();
      }
   }
}
