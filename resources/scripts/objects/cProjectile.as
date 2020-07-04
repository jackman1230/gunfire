package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import nape.geom.Vec2;
   
   public class cProjectile extends slugObject
   {
       
      
      public var part_main:Boner;
      
      public var projectile_speed:Number = 180;
      
      public var random_y_spread:Number = 40;
      
      public var projectile_collides:Boolean = false;
      
      public var anglePlus:Number = 0;
      
      public var useFollowAngles:Boolean = true;
      
      public var singleLastAngle:Number = 0;
      
      public var useLastAngle:Boolean = false;
      
      public function cProjectile(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:cObject = null)
      {
         this.getSpread();
         var _loc6_:Number = param4 - 90;
         var _loc7_:Vec2 = new Vec2(Math.cos(_loc6_ * Math.PI / 180),Math.sin(_loc6_ * Math.PI / 180));
         var _loc8_:Vec2 = _loc7_.copy().rotate(90);
         var _loc9_:Number = this.random_y_spread * Math.random() * (Math.random() > 0.5?1:-1);
         _loc8_.length = _loc9_;
         super(param1 + _loc8_.x,param2 + _loc8_.y,param3,param4);
         this.createBody();
         this.createGraphics();
         this.setGraphics();
         bodyParts[0].gravMassScale = 0;
         _loc7_.length = this.projectile_speed;
         bodyParts[0].velocity = _loc7_;
         postCreate();
         SoundHandler.playSoundClass(this.getSpawnSound());
      }
      
      public function getSpread() : void
      {
      }
      
      public function getSpawnSound() : Class
      {
         return sound_clicking;
      }
      
      override public function gotFlagged() : void
      {
         super.gotFlagged();
         if(bodyParts[0] != null)
         {
            bodyParts[0].velocity = new Vec2();
         }
      }
      
      override public function getStats() : void
      {
         var _loc1_:customFont = null;
         super.getStats();
         isBreakable = false;
         isBounceTrigger = false;
         isAlwaysEnabled = false;
         myBodyClip = new MovieClip();
         if(slugObject.showNames)
         {
            _loc1_ = new customFont(12,this.getTypeStringLol(),true);
            myBodyClip.addChild(_loc1_);
         }
         dealsTouchDamage = 40;
         touchDamageDelay = -1;
         hitRect = new Rectangle(0,0,20,20);
         scoreVal = 0;
      }
      
      public function getTypeStringLol() : String
      {
         return "X";
      }
      
      public function createBody() : void
      {
         if(this.projectile_collides)
         {
            this.part_main = BoxUtils.NewCircle(x,y,2,1,true,!!this.projectile_collides?uint(Filters.car):uint(Filters.fuckall),!!this.projectile_collides?uint(Filters.carMask):uint(Filters.fuckallMask));
         }
         else
         {
            this.part_main = BoxUtils.NewBox(x,y,hitRect.width,hitRect.height,1,true,!!this.projectile_collides?int(Filters.car):int(Filters.fuckall),!!this.projectile_collides?uint(Filters.carMask):uint(Filters.fuckallMask));
         }
         lastPart = this.part_main;
         addPart(this.part_main);
      }
      
      override public function subTick() : void
      {
         var _loc2_:int = 0;
         super.subTick();
         var _loc1_:Number = bodyParts[0].velocity.angle * 180 / Math.PI;
         _loc1_ = _loc1_ + this.anglePlus;
         if(this.useFollowAngles || this.useLastAngle)
         {
            _loc2_ = 0;
            while(_loc2_ < myBodyClip.numChildren)
            {
               myBodyClip.getChildAt(_loc2_).rotation = !!this.useLastAngle?Number(this.singleLastAngle):Number(_loc1_);
               _loc2_++;
            }
            this.useLastAngle = false;
         }
         this.singleLastAngle = _loc1_;
      }
      
      public function createGraphics() : void
      {
         setData(bodyParts[0],myBodyClip);
      }
      
      public function setGraphics() : void
      {
      }
   }
}
