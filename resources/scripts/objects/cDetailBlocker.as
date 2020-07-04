package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class cDetailBlocker extends cDetail
   {
       
      
      var bClip:MovieClip;
      
      public function cDetailBlocker(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         this.bClip = new block03();
         super(param1,param2,param3,param4);
         addPoly(1,true,[0,10,-50,-103,78,-130,78,10],Filters.object,Filters.objectMask,false,12);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         myBodyClip.addChild(this.bClip);
         this.bClip.y = this.bClip.y + 30;
         hitRect = new Rectangle(0,0,30,140);
         hitRectOffsetY = -50;
      }
      
      override public function slugtick() : void
      {
         super.slugtick();
         if(!flagged && flaggedTimer == -1)
         {
            bodyParts[0].rotation = 0;
         }
      }
      
      override public function payLoad() : void
      {
         super.payLoad();
         bodyParts[0].userData.clipRotationSource = GroundUtils.ground;
         this.bClip.gotoAndPlay(7);
      }
   }
}
