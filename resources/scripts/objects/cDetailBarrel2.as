package objects
{
   public class cDetailBarrel2 extends cDetailBarrel
   {
       
      
      public function cDetailBarrel2(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function getStats() : void
      {
         bClip = new block04();
         super.getStats();
      }
      
      override public function payLoad() : void
      {
         super.payLoad();
         bClip.gotoAndPlay(5);
      }
   }
}
