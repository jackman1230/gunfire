package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import nape.dynamics.InteractionFilter;
   import nape.phys.BodyType;
   
   public class cPlatformTrainCar extends cDetail
   {
       
      
      var bClip:MovieClip;
      
      public function cPlatformTrainCar(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
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
         addPoly(10,true,[-100,1,-103,-125,-22,-128,-23,1],Filters.objectSelfNoCollide,Filters.objectSelfNoCollideMask,false,0.1);
         addPoly(10,true,[43,1,42,-129,102,-129,100,1],Filters.objectSelfNoCollide,Filters.objectSelfNoCollideMask,false,0.1);
         addPoly(10,true,[-131,-14,-131,-31,126,-32,127,-14],Filters.objectSelfNoCollide,Filters.objectSelfNoCollideMask,false,0.1);
         addPoly(10,true,[-102,-106,-100,-126,68,-129,103,-126],Filters.objectSelfNoCollide,Filters.objectSelfNoCollideMask,false,0.1);
      }
      
      public function getGraphics() : void
      {
         this.bClip = new platform_traincar3();
      }
      
      override public function getStats() : void
      {
         super.getStats();
         this.getGraphics();
         myBodyClip.addChild(this.bClip);
         this.bClip.gotoAndStop(1);
         hitRect = new Rectangle(0,0,200,128);
         hitRectOffsetY = -64;
         staticFlag = !World.currentLevel.inEditor;
         hostile = true;
         slug_health = 400;
      }
      
      override public function payLoad() : void
      {
         bodyParts[0].setShapeFilters(new InteractionFilter(Filters.car,Filters.carMask));
         super.payLoad();
         this.bClip.gotoAndPlay(50);
         hostile = false;
         bodyParts[0].userData.isWheel = false;
         bodyParts[0].userData.isGround = false;
         bodyParts[0].isGround = false;
         dealsTouchDamage = 10 + Math.random() * 4;
         hitRect.width = hitRect.width * 1.2;
         hitRect.height = hitRect.height * 1.2;
      }
   }
}
