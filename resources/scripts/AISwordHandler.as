package
{
   import objects.cObject;
   import objects.cSoldier;
   
   public class AISwordHandler extends AICarHandler
   {
      
      public static var clipPinned:Boolean = false;
       
      
      public var wClip:enemy09;
      
      public var done_break_animation:Boolean = false;
      
      public var break_animation_count:int = -1;
      
      public function AISwordHandler(param1:GameMode, param2:cObject)
      {
         super(param1,param2);
         this.wClip = (myCar as cSoldier).mySoliderClip;
         this.wClip.setHander(this);
         ai_follow_distance_random_tolerance = 0;
         runSpeed = runSpeed_default * 0.02;
      }
      
      override public function toString() : String
      {
         return "[AISwordHandler wClip=" + this.wClip + " crouchey_ai=" + crouchey_ai + " clipPinned=" + clipPinned + " firstFrame=" + firstFrame + "]";
      }
      
      override public function doAI() : void
      {
         super.doAI();
         control_knife_down = false;
         control_shoot_down = false;
         control_grenadeDown = false;
         if(this.break_animation_count == -1 && !this.done_break_animation && !playing_die_animation)
         {
            if(got_air)
            {
               runSpeed = runSpeed_default;
            }
            else
            {
               runSpeed = runSpeed_default * 0.02;
            }
         }
         if(this.break_animation_count > -1)
         {
            this.break_animation_count--;
            if(this.break_animation_count == -1)
            {
               this.done_break_animation = true;
               this.set_ai("run",true);
               myCar.takeDamage(myCar.slugCast,myCar.slugCast.slug_health * 2);
               runSpeed = runSpeed_default * 2;
            }
         }
         if(playing_die_animation && this.done_break_animation)
         {
            control_rotLeftDown = true;
         }
         if(this.break_animation_count > -1)
         {
            control_rotLeftDown = false;
            control_rotRightDown = false;
            ai_blocker_start_x = myCar.currentX + 200;
         }
      }
      
      override public function getFacingLeft() : Boolean
      {
         if(playing_die_animation)
         {
            return true;
         }
         return super.getFacingLeft();
      }
      
      public function swordHit() : void
      {
         if(!this.done_break_animation && this.break_animation_count == -1)
         {
            playing_die_animation = true;
            this.set_ai("break",true);
            this.break_animation_count = 50;
            myCar.dealsTouchDamage = -1;
         }
      }
      
      override public function set_ai(param1:String, param2:Boolean = false) : void
      {
         if(param1 == "shocked")
         {
            return;
         }
         if(param1.indexOf("die") == 0)
         {
            param1 = "run";
         }
         this.wClip.gotoAndStop(param1);
      }
      
      override public function triggerDie() : void
      {
         super.triggerDie();
      }
      
      override public function getDefaultShoot() : String
      {
         return "stand";
      }
      
      override public function getDefaultStand() : String
      {
         return "stand";
      }
      
      override public function getDefaultRun() : String
      {
         return "move";
      }
      
      override public function spriteStandCall() : void
      {
         this.set_ai(this.getDefaultStand(),true);
      }
      
      override public function spriteGrenadeCall() : void
      {
         if(myCar != null)
         {
         }
      }
      
      override public function spriteShootCall() : void
      {
         if(myCar != null)
         {
         }
      }
      
      override public function spriteAttackCall() : void
      {
      }
   }
}
