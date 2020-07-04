package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import nape.phys.BodyType;
   
   public class cDetailBigassBombs extends cDetail
   {
       
      
      var bClip:MovieClip;
      
      public function cDetailBigassBombs(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         this.bClip = new asploding_missiles();
         super(param1,param2,param3,param4);
         addPoly(1,true,[-48,0,-48,-99,57,-100,57,0],Filters.object,Filters.objectMask,true,0.1);
         lastPart.userData.isGround = true;
         lastPart.isGround = true;
         lastPart.owner = this;
         if(!World.currentLevel.inEditor)
         {
            lastPart.type = BodyType.STATIC;
         }
         isAlwaysStatic = true;
      }
      
      override public function getStats() : void
      {
         super.getStats();
         myBodyClip.addChild(this.bClip);
         this.bClip.gotoAndStop(0);
         this.bClip.y = this.bClip.y + 10;
         hitRect = new Rectangle(0,0,115,104);
         staticFlag = !World.currentLevel.inEditor;
         slug_health = 40;
         takesDamage = true;
         swell = 10;
      }
      
      override public function payLoad() : void
      {
         super.payLoad();
         bodyParts[0].userData.clipRotationSource = GroundUtils.ground;
         this.bClip.gotoAndPlay(1);
         manual_flag = 40;
         hitRect.width = hitRect.width * 10.5;
         hitRect.height = hitRect.height * 10.5;
         hostile = false;
         dealsTouchDamage = 500;
         touchDamageDelay = 3;
      }
   }
}
