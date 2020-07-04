package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class cDetailSandbags extends cDetail
   {
       
      
      var bClip:MovieClip;
      
      public function cDetailSandbags(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         this.bClip = new block01();
         super(param1,param2,param3,param4);
         addPoly(1,true,[-70,10,-16,-48,12.5,-52,68.5,10],Filters.object,Filters.objectMask,false,12);
      }
      
      override public function getStats() : void
      {
         super.getStats();
         myBodyClip.addChild(this.bClip);
         this.bClip.y = this.bClip.y + 10;
         hitRect = new Rectangle(0,0,80,85);
      }
      
      override public function payLoad() : void
      {
         super.payLoad();
         bodyParts[0].userData.clipRotationSource = GroundUtils.ground;
         this.bClip.gotoAndPlay(7);
      }
   }
}
