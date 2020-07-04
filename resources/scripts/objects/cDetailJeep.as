package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class cDetailJeep extends cDetail
   {
       
      
      var bClip:MovieClip;
      
      public function cDetailJeep(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         this.bClip = new truck_jeep();
         super(param1,param2,param3,param4);
         addPoly(1,true,[-69,0,-69,-47,30,-50,59,-37,66,0],Filters.object,Filters.objectMask,true,0.1,1.4);
         addPoly(1,true,[-4,-41,4,-55,28,-55,41,-34],Filters.object,Filters.objectMask,true,0.1,1.4);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         myBodyClip.addChild(this.bClip);
         graphicScale = 1.4;
         this.bClip.y = this.bClip.y + 10;
         this.bClip.stop();
         hitRect = new Rectangle(0,0,120 * 1.2,60 * 1.2);
         hitRectOffsetY = -30 * 1.2;
         slug_health = 200;
      }
      
      override public function payLoad() : void
      {
         super.payLoad();
         this.bClip.gotoAndPlay(48);
         hitRectOffsetY = 0;
      }
   }
}
