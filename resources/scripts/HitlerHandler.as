package
{
   import flash.display.MovieClip;
   import objects.cCar;
   import objects.cObject;
   import objects.cSoldier;
   
   public class HitlerHandler extends AICarHandler
   {
      
      public static var clipPinned:Boolean = false;
       
      
      public var wClip:hitler;
      
      public var done_break_animation:Boolean = false;
      
      public var break_animation_count:int = -1;
      
      public function HitlerHandler(param1:GameMode, param2:cObject)
      {
         super(param1,param2);
         this.wClip = (myCar as cSoldier).mySoliderClip;
         this.wClip.setHander(this);
         ai_follow_distance_random_tolerance = 30;
         runSpeed = runSpeed_default * 0.04;
      }
      
      override public function toString() : String
      {
         return "[AISwordHandler wClip=" + this.wClip + " crouchey_ai=" + crouchey_ai + " clipPinned=" + clipPinned + " firstFrame=" + firstFrame + "]";
      }
      
      override public function doAI() : void
      {
         super.doAI();
         if(control_grenadeDown || control_knife_down)
         {
            control_grenadeDown = false;
            control_knife_down = false;
            control_shoot_down = true;
         }
         if(!got_air && last_air)
         {
            this.set_ai(this.getDefaultRun(),true);
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
            param1 = "die0";
         }
         if(param1.indexOf("shoot") > -1)
         {
            param1 = "shoot_1";
         }
         this.wClip.gotoAndStop(param1);
         var _loc3_:int = 0;
         while(_loc3_ < cCar.currentPlayerClip.down.numChildren)
         {
            if(param2)
            {
               (this.wClip.getChildAt(_loc3_) as MovieClip).play();
            }
            else
            {
               (this.wClip.getChildAt(_loc3_) as MovieClip).gotoAndStop(0);
            }
            _loc3_++;
         }
      }
      
      override public function triggerDie() : void
      {
         super.triggerDie();
      }
      
      override public function getDefaultShoot() : String
      {
         return "shoot_1";
      }
      
      override public function getDefaultStand() : String
      {
         return "stand";
      }
      
      override public function getDefaultRun() : String
      {
         return "run";
      }
   }
}
