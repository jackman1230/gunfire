package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import nape.dynamics.InteractionFilter;
   import nape.phys.BodyType;
   
   public class cDetailPlatform extends cDetail
   {
       
      
      var bClip:MovieClip;
      
      public function cDetailPlatform(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
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
         addContactListener(bodyParts[0]);
      }
      
      public function addPolys() : void
      {
         addPoly(10,true,[-115,8,-115,-8,115,-8,115,8],Filters.object,Filters.objectMask,false,0.1);
      }
      
      public function getClip() : void
      {
         this.bClip = new platform_hanging_no_cables();
      }
      
      override public function getStats() : void
      {
         super.getStats();
         this.getClip();
         myBodyClip.addChild(this.bClip);
         this.bClip.x = -316;
         this.bClip.y = -164;
         this.bClip.gotoAndStop(101);
         hitRect = new Rectangle(0,0,230,20);
         staticFlag = !World.currentLevel.inEditor;
         hostile = true;
         slug_health = 10;
         takesDamage = false;
      }
      
      override public function carContact(param1:cObject) : void
      {
         super.carContact(param1);
         if(param1 == World.followObj)
         {
            swellCount = 40;
         }
      }
      
      override public function subTick() : void
      {
         super.subTick();
         if(swellCount > -1)
         {
            if(swellCount % 10 == 0)
            {
               doFlash();
            }
         }
      }
      
      override public function payLoad() : void
      {
         bodyParts[0].setShapeFilters(new InteractionFilter(Filters.car,Filters.carMask));
         super.payLoad();
         this.bClip.gotoAndPlay(120);
         bodyParts[0].userData.isWheel = false;
         bodyParts[0].userData.isGround = false;
         bodyParts[0].isGround = false;
         takesDamage = false;
         dealsTouchDamage = 300;
         hostile = false;
      }
   }
}
