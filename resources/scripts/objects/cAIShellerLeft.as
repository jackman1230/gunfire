package objects
{
   public class cAIShellerLeft extends cAISheller
   {
       
      
      public function cAIShellerLeft(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function getTypeStringLol() : String
      {
         return "Sheller Left";
      }
      
      override public function getStats() : void
      {
         facingLeft = true;
         super.getStats();
      }
   }
}
