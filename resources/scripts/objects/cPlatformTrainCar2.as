package objects
{
   public class cPlatformTrainCar2 extends cPlatformTrainCar
   {
       
      
      public function cPlatformTrainCar2(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function getGraphics() : void
      {
         bClip = new platform_traincar2();
      }
   }
}