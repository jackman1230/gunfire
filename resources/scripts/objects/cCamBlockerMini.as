package objects
{
   public class cCamBlockerMini extends cCamBlocker
   {
       
      
      public function cCamBlockerMini(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:cObject = null)
      {
         super(param1,param2,param3,param4);
      }
      
      override public function getTypeStringLol() : String
      {
         return "MINICAM";
      }
   }
}
