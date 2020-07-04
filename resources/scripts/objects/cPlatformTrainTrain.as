package objects
{
   import flash.geom.Rectangle;
   
   public class cPlatformTrainTrain extends cPlatformTrainCar
   {
       
      
      public function cPlatformTrainTrain(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
         bodyParts[0].spriteOffsetY = 15;
      }
      
      override public function addPolys() : void
      {
         addPoly(10,true,[-89,0,-83,-65,85,-68,86,0],Filters.objectSelfNoCollide,Filters.objectSelfNoCollideMask,false,0.1);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         hitRect = new Rectangle(0,0,170,65);
         hitRectOffsetY = -65 / 2;
         slug_health = 200;
      }
      
      override public function getGraphics() : void
      {
         bClip = new platform_traintrain1();
      }
   }
}
