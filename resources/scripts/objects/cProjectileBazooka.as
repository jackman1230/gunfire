package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   import nape.geom.Vec2;
   
   public class cProjectileBazooka extends cProjectileGrenade
   {
       
      
      public function cProjectileBazooka(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:int = 0, param6:Boolean = false)
      {
         projectile_speed = 200;
         super(param1,param2,param3,param4);
         bodyParts[0].gravMassScale = 0.1;
      }
      
      override public function slugtick() : void
      {
         super.slugtick();
         if(!flagged && flaggedTimer == -1)
         {
            if(World.followObj != null && World.followObj.slugCast.slug_health > 0)
            {
               if(bodyParts.length > -1 && bodyParts[0] != null)
               {
                  if(World.followObj.currentY < currentY)
                  {
                     bodyParts[0].applyWorldForce(new Vec2(0,-2));
                  }
                  else
                  {
                     bodyParts[0].applyWorldForce(new Vec2(0,2));
                  }
               }
            }
         }
      }
      
      override public function getTypeStringLol() : String
      {
         return "BAZOOKA";
      }
      
      override public function getStats() : void
      {
         super.getStats();
         hitRect = new Rectangle(0,0,20,20);
      }
      
      override public function getMyClip() : MovieClip
      {
         return new npc_shoot10();
      }
      
      override public function doAni() : void
      {
         bombClip.rotation = 0;
         bombClip.gotoAndStop("hit");
      }
      
      override public function subLoad() : void
      {
         manual_flag = 60;
      }
   }
}
