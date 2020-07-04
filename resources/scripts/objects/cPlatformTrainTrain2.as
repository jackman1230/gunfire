package objects
{
   import flash.geom.Rectangle;
   
   public class cPlatformTrainTrain2 extends cPlatformTrainCar
   {
       
      
      public function cPlatformTrainTrain2(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
         bodyParts[0].spriteOffsetY = 15;
      }
      
      override public function addPolys() : void
      {
         addPoly(10,true,[-219,0,-217,-108,211,-108,209,0],Filters.objectSelfNoCollide,Filters.objectSelfNoCollideMask,false,0.1);
         addPoly(10,true,[-243,0,-237,66,225,-53,240,-32,241,0],Filters.objectSelfNoCollide,Filters.objectSelfNoCollideMask,false,0.1);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         slug_health = 500000;
         hitRect = new Rectangle(0,0,440,108);
         hitRectOffsetY = -108 / 2;
         takesDamage = false;
      }
      
      override public function getGraphics() : void
      {
         bClip = new platform_traintrain2();
      }
   }
}
