package objects
{
   import flash.geom.Rectangle;
   
   public class cPlatformTrainTrain3 extends cPlatformTrainCar
   {
       
      
      public function cPlatformTrainTrain3(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
         bodyParts[0].spriteOffsetY = 15;
      }
      
      override public function addPolys() : void
      {
         addPoly(10,true,[-123,0,-121,-107,111,-107,115,6],Filters.objectSelfNoCollide,Filters.objectSelfNoCollideMask,false,0.1);
         addPoly(10,true,[-151,5,-144,-59,-121,-71,127,-51,146,-29,148,0],Filters.objectSelfNoCollide,Filters.objectSelfNoCollideMask,false,0.1);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         hitRect = new Rectangle(0,0,245,100);
         hitRectOffsetY = -100 / 2;
         slug_health = 200;
      }
      
      override public function getGraphics() : void
      {
         bClip = new platform_traintrain3();
      }
   }
}
