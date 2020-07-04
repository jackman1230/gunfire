package
{
   import flash.display.MovieClip;
   import objects.cCar;
   import objects.cObject;
   import objects.cSoldier;
   
   public class AITankHandler extends AICarHandler
   {
       
      
      public var wClip:MovieClip;
      
      public function AITankHandler(param1:GameMode, param2:cObject)
      {
         super(param1,param2);
         this.wClip = (myCar as cSoldier).mySoliderClip;
         this.wClip.setHander(this);
         ai_follow_distance_random_tolerance = 120;
         runSpeed_default = runSpeed_default * 0.5;
         runSpeed = runSpeed_default;
      }
      
      override public function toString() : String
      {
         return "[AITankHandler wClip=" + this.wClip + " clipPinned=" + clipPinned + "]";
      }
      
      override public function doAI() : void
      {
         super.doAI();
         control_knife_down = false;
         control_grenadeDown = false;
         control_JumpDown = false;
         if(!control_shoot_down)
         {
         }
         if(myCar.fire_count > -1)
         {
         }
         if(!control_rotLeftDown)
         {
         }
      }
      
      override public function set_ai(param1:String, param2:Boolean = false) : void
      {
         var _loc3_:int = 0;
         if(param1 == "shocked")
         {
            return;
         }
         if(param1.indexOf("die") == 0)
         {
            param1 = "explode";
         }
         if(param1 == "run")
         {
            param1 = "move";
         }
         if(param1 == "stand" || param1 == "move")
         {
            this.wClip.gotoAndStop(param1);
         }
         else
         {
            this.wClip.gotoAndPlay(param1);
         }
         if(cCar.currentPlayerClip.down.numChildren > 0)
         {
            _loc3_ = 0;
            while(_loc3_ < cCar.currentPlayerClip.down.numChildren)
            {
               if(param2)
               {
                  (cCar.currentPlayerClip.down.getChildAt(_loc3_) as MovieClip).play();
               }
               else
               {
                  (this.wClip.getChildAt(_loc3_) as MovieClip).gotoAndStop(0);
               }
               _loc3_++;
            }
         }
      }
      
      override public function getDefaultShoot() : String
      {
         return "shoot";
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
         if(myCar != null)
         {
            myCar.doFire();
            if(myCar.fire_count > -1)
            {
               myCar.fire_count = myCar.fire_delay * (1 + Math.random());
            }
         }
      }
   }
}
