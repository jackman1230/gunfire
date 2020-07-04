package objects
{
   import flash.display.MovieClip;
   
   public class cDetailBoat extends cDetail
   {
       
      
      var bClip:MovieClip;
      
      public function cDetailBoat(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         this.bClip = new speedboat_start();
         super(param1,param2,param3,param4);
         addPoly(1,true,[-28,38,-28,-38,28,-38,28,38],Filters.fuckall,Filters.fuckallMask,false,0.1);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         myBodyClip.addChild(this.bClip);
         detail = true;
         takesDamage = false;
         staticFlag = !World.currentLevel.inEditor;
      }
      
      override public function getTypeStringLol() : String
      {
         return "boat_detail";
      }
   }
}
