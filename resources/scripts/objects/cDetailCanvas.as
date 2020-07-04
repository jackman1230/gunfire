package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class cDetailCanvas extends cDetail
   {
       
      
      var bClip:MovieClip;
      
      public function cDetailCanvas(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         this.bClip = new truck_canvas();
         super(param1,param2,param3,param4);
         addPoly(1,true,[-82,0,-79,-69,12,-69,48,-60,68,-38,82,0],Filters.object,Filters.objectMask,true,0.1);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         myBodyClip.addChild(this.bClip);
         this.bClip.y = this.bClip.y + 10;
         this.bClip.stop();
         hitRect = new Rectangle(0,0,160,68);
         hitRectOffsetY = -40;
      }
      
      override public function payLoad() : void
      {
         super.payLoad();
         this.bClip.gotoAndPlay(12);
      }
   }
}
