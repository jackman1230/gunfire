package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import nape.dynamics.InteractionFilter;
   
   public class cDetailCar extends cDetail
   {
       
      
      public var fudgeScale:Number = 1.2;
      
      var bClip:MovieClip;
      
      public function cDetailCar(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         this.bClip = new detail_carboom();
         super(param1,param2,param3,param4);
         addPoly(1,true,[-45,0,-42,-21,28,-27,39,-17,44,0],Filters.object,Filters.objectMask,true,0.1,this.fudgeScale);
         addPoly(1,true,[-28,-23,-21,-39,3,-41,17,-33,22,-15],Filters.object,Filters.objectMask,true,0.1,this.fudgeScale);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         myBodyClip.addChild(this.bClip);
         this.bClip.scaleX = this.fudgeScale;
         this.bClip.scaleY = this.fudgeScale;
         this.bClip.y = this.bClip.y + 10;
         this.bClip.stop();
         (this.bClip.getChildAt(0) as MovieClip).stop();
         hitRect = new Rectangle(0,0,80,40);
         hitRectOffsetY = -20;
         slug_health = 40;
      }
      
      override public function payLoad() : void
      {
         bodyParts[0].setShapeFilters(new InteractionFilter(Filters.car,Filters.carMask));
         super.payLoad();
         this.bClip.gotoAndPlay(48);
         manual_flag = 80;
      }
   }
}
