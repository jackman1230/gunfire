package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import nape.geom.Vec2;
   import nape.phys.BodyType;
   
   public class cAISheller extends cAIShooter
   {
       
      
      public var targSpot:Vec2;
      
      public var tempTarg:Vec2;
      
      public var shellerGraphic:enemy10;
      
      public var facingLeft:Boolean = false;
      
      public var active:Boolean = true;
      
      public var state:int = 0;
      
      public var state_waiting:int = 0;
      
      public var state_firing:int = 1;
      
      public var state_die:int = 2;
      
      public var state_spare:int = 3;
      
      public var backToWaitCounter:int = -1;
      
      public var backToFireCounter:int = -1;
      
      public var fireAfter:int = -1;
      
      public function cAISheller(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         this.targSpot = new Vec2();
         this.shellerGraphic = new enemy10();
         super(param1,param2,param3,param4);
         bodyParts[0].spriteOffsetY = 8;
         if(World.currentLevel.inEditor)
         {
            makeWorldJoint(lastPart,true);
         }
         else
         {
            lastPart.type = BodyType.STATIC;
         }
      }
      
      override public function getTypeStringLol() : String
      {
         return "Copter";
      }
      
      override public function getStats() : void
      {
         var _loc1_:customFont = null;
         super.getStats();
         buildStatic = false;
         myBodyClip = new MovieClip();
         if(slugObject.showNames)
         {
            _loc1_ = new customFont(12,this.getTypeStringLol(),true);
            myBodyClip.addChild(_loc1_);
         }
         myBodyClip.addChild(this.shellerGraphic);
         this.shellerGraphic.gotoAndStop("stand");
         if(this.facingLeft)
         {
            this.shellerGraphic.scaleX = -1;
         }
         dealsTouchDamage = -1;
         touchDamageDelay = 0;
         hitRect = new Rectangle(0,0,60,90);
         shootAngle = 330;
         if(this.facingLeft)
         {
            shootAngle = 30;
         }
         hostile = true;
         slug_health = getDefaultEnemyHealth() * 0.5;
         fire_delay = 80;
         this.backToFireCounter = 30;
         ejectionX = -30 * (!!this.facingLeft?-1:1);
         ejectionY = -40;
      }
      
      override public function slugtick() : void
      {
         var _loc1_:Number = NaN;
         super.slugtick();
         if(this.active)
         {
            if(this.state == this.state_waiting)
            {
               if(this.backToFireCounter > -1)
               {
                  this.backToFireCounter--;
                  if(this.backToFireCounter == -1)
                  {
                     if(World.followObj.currentX >= currentX - 500)
                     {
                        this.backToWaitCounter = 26;
                        this.fireAfter = 12;
                        this.state = this.state_firing;
                        this.shellerGraphic.gotoAndPlay("shoot");
                     }
                     else
                     {
                        this.backToFireCounter = 1;
                     }
                  }
               }
            }
            if(this.state == this.state_firing)
            {
               if(this.backToWaitCounter > -1)
               {
                  this.backToWaitCounter--;
                  if(this.backToWaitCounter == -1)
                  {
                     this.state = this.state_waiting;
                     this.shellerGraphic.gotoAndStop("stand");
                     this.backToFireCounter = 80;
                  }
               }
            }
            if(this.fireAfter > -1)
            {
               this.fireAfter--;
               if(this.fireAfter == -1)
               {
                  doFire();
               }
            }
            if(flagged || flaggedTimer > -1)
            {
               this.active = false;
               this.state = this.state_die;
               _loc1_ = Math.random();
               if(_loc1_ > 0.7)
               {
                  this.shellerGraphic.gotoAndPlay("die1");
               }
               else if(_loc1_ > 0.4)
               {
                  this.shellerGraphic.gotoAndPlay("die2");
               }
               else
               {
                  this.shellerGraphic.gotoAndPlay("die3");
               }
            }
         }
      }
      
      override public function getProjectileClass() : Class
      {
         return cProjectileGroundShell;
      }
      
      public function smoothVec(param1:Vec2) : void
      {
         if(param1.length != 0)
         {
            param1.length = 1 / param1.length;
         }
         if(param1.length < 50)
         {
            param1.length = 50;
         }
         param1.muleq(-1);
      }
      
      override public function takeDamage(param1:slugObject, param2:int) : void
      {
         super.takeDamage(param1,param2);
         if(slug_health < 0)
         {
         }
      }
   }
}
