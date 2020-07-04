package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class cDetailBarrel extends cDetail
   {
       
      
      var bClip:MovieClip;
      
      public function cDetailBarrel(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         this.bClip = new block02();
         super(param1,param2,param3,param4);
         addPoly(1,true,[-28,38,-28,-38,28,-38,28,38],Filters.object,Filters.objectMask,false,0.1);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         myBodyClip.addChild(this.bClip);
         this.bClip.y = this.bClip.y + 40;
         hitRect = new Rectangle(0,0,40,85);
      }
      
      override public function payLoad() : void
      {
         super.payLoad();
         bodyParts[0].userData.clipRotationSource = GroundUtils.ground;
         this.bClip.gotoAndPlay(10);
      }
   }
}
