package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class cProjectileGroundShell extends cProjectileGrenade
   {
       
      
      public function cProjectileGroundShell(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:int = 0, param6:Boolean = false)
      {
         random_y_spread = 0;
         super(param1,param2,param3,param4);
         bodyParts[0].userData.isWheel = true;
         bodyParts[0].gravMassScale = 0.4;
      }
      
      override public function getStats() : void
      {
         super.getStats();
         projectile_speed = 220;
         hitRect = new Rectangle(0,0,20,20);
         random_y_spread = 0;
      }
      
      override public function slugtick() : void
      {
         super.slugtick();
         if(!flagged && flaggedTimer == -1)
         {
            if(bodyParts.length > 0 && bodyParts[0] != null)
            {
               if(bodyParts[0].userData.groundConnected)
               {
                  payLoad();
               }
            }
         }
      }
      
      override public function getMyClip() : MovieClip
      {
         return new npc_shoot10();
      }
      
      override public function doAni() : void
      {
         bombClip.rotation = 0;
         bombClip.gotoAndStop("hit");
         (bombClip.getChildAt(0) as MovieClip).gotoAndPlay(1);
      }
      
      override public function subLoad() : void
      {
         manual_flag = 20;
      }
      
      override public function getTypeStringLol() : String
      {
         return "groundshell";
      }
   }
}
