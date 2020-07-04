package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import flash.utils.getQualifiedClassName;
   
   public class cAIShooter extends slugObject
   {
       
      
      public var part_main:Boner;
      
      public var fire_delay:int = 50;
      
      public var fire_count:int = -1;
      
      public var firing:Boolean = false;
      
      public var shootAngle:Number = 0;
      
      public var buildStatic:Boolean = false;
      
      public var ejectionX:Number = 0;
      
      public var ejectionY:Number = 0;
      
      public function cAIShooter(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
         this.createBody();
         this.createGraphics();
         postCreate();
      }
      
      override public function getStats() : void
      {
         super.getStats();
         graphicScale = 1;
         isBreakable = true;
         isBounceTrigger = false;
         myBodyClip = new MovieClip();
         var _loc1_:customFont = new customFont(12,getQualifiedClassName(this),true);
         myBodyClip.addChild(_loc1_);
         hitRect = new Rectangle(0,-30,50,70);
         takesDamage = true;
         is_camlock_enemy = true;
      }
      
      public function createBody() : void
      {
         this.part_main = BoxUtils.NewCircle(x,y,20,1,true,Filters.fuckall,Filters.fuckallMask,1,0);
         lastPart = this.part_main;
         lastPart.gravMassScale = 0;
         addPart(this.part_main,null,true,false,this.buildStatic);
      }
      
      public function doFire() : void
      {
         var _loc1_:Class = this.getProjectileClass();
         var _loc3_:slugObject = new _loc1_(currentX + 0 + this.ejectionX,currentY + this.ejectionY,GameMode.gameMode,this.shootAngle) as slugObject;
         _loc3_.hostile = hostile;
         LevelUtils.levelOb(_loc3_);
      }
      
      public function getProjectileClass() : Class
      {
         return cProjectileBomb;
      }
      
      public function getTypeStringLol() : String
      {
         return "cAIShooter";
      }
      
      public function createGraphics() : void
      {
         setData(this.part_main,myBodyClip);
      }
      
      override public function death() : void
      {
         super.death();
         var _loc1_:Number = Math.random();
         if(_loc1_ > 0.75)
         {
            SoundHandler.playSoundClass(sound_die_1);
         }
         else if(_loc1_ > 0.5)
         {
            SoundHandler.playSoundClass(sound_die_2);
         }
         else if(_loc1_ > 0.25)
         {
            SoundHandler.playSoundClass(sound_die_3);
         }
         else
         {
            SoundHandler.playSoundClass(sound_die_4);
         }
      }
      
      override public function subTick() : void
      {
         super.subTick();
         if(this.fire_count > -1)
         {
            this.fire_count--;
         }
         else if(this.fire_count == -1)
         {
            if(this.firing)
            {
               this.doFire();
               this.fire_count = this.fire_delay;
            }
         }
      }
   }
}
