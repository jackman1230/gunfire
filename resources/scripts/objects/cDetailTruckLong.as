package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class cDetailTruckLong extends cDetail
   {
       
      
      var bClip:MovieClip;
      
      public function cDetailTruckLong(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         this.bClip = new MovieClip();
         super(param1,param2,param3,param4);
         addPoly(10,true,[0,-4,0,-40,533,-40,533,-4],Filters.object,Filters.objectMask,true,0.1);
         lastPart.userData.isGround = true;
         isGround = true;
         isAlwaysEnabled = true;
      }
      
      override public function getStats() : void
      {
         super.getStats();
         myBodyClip.addChild(this.bClip);
         this.bClip.y = this.bClip.y + 10;
         this.bClip.stop();
         hitRect = new Rectangle(0,0,120,60);
         hitRectOffsetY = -30;
         takesDamage = false;
      }
      
      override public function payLoad() : void
      {
         super.payLoad();
         this.bClip.gotoAndPlay(48);
         hitRectOffsetY = 0;
      }
   }
}
