package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import nape.phys.BodyType;
   
   public class cDetailPlatformWood extends cDetail
   {
       
      
      var bClip:MovieClip;
      
      public function cDetailPlatformWood(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
         this.addPolys();
         lastPart.userData.neutralGround = true;
         lastPart.userData.isGround = true;
         lastPart.isGround = true;
         lastPart.owner = this;
         detail = false;
         if(!World.currentLevel.inEditor)
         {
            lastPart.type = BodyType.STATIC;
         }
         isAlwaysStatic = true;
      }
      
      public function addPolys() : void
      {
         addPoly(10,true,[-61,0,-61,11,68,11,68,0],Filters.object,Filters.objectMask,false,0.1);
      }
      
      public function getClip() : void
      {
         this.bClip = new platform_wooden();
      }
      
      override public function getStats() : void
      {
         super.getStats();
         this.getClip();
         myBodyClip.addChild(this.bClip);
         this.bClip.x = 0;
         this.bClip.y = 0;
         this.bClip.gotoAndStop(1);
         hitRect = new Rectangle(0,0,130,8);
         staticFlag = !World.currentLevel.inEditor;
         hostile = true;
         slug_health = 10;
      }
      
      override public function payLoad() : void
      {
         super.payLoad();
         this.bClip.gotoAndPlay(50);
         bodyParts[0].userData.isWheel = false;
         bodyParts[0].userData.isGround = false;
         hitRect.height = hitRect.height * 2;
         hitRect.width = hitRect.width * 1.2;
      }
   }
}
