package objects
{
   import flash.display.MovieClip;
   
   public class cSoldier extends cBiped
   {
       
      
      public var mySoliderClip;
      
      public var weapOverride:int = -1;
      
      public function cSoldier(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:int = -1)
      {
         this.weapOverride = param5;
         super(param1,param2,param3,param4);
         isAlwaysEnabled = true;
      }
      
      override public function didHearAlert() : void
      {
         super.didHearAlert();
         if(myHandler.ai_notlooking_undisturbed)
         {
            myHandler.ai_notlooking_undisturbed = false;
         }
      }
      
      override public function getStats() : void
      {
         var _loc2_:Number = NaN;
         super.getStats();
         playerControlled = false;
         hostile = true;
         setLives(0);
         var _loc1_:int = Math.random() * 4;
         hasWeapons = [false,false,false,false];
         if(this.weapOverride > -1)
         {
            setWeapon(this.weapOverride,true);
         }
         else
         {
            _loc2_ = Camera.followX / 20000;
            _loc2_ = _loc2_ * Math.random();
            if(_loc2_ > 0.5)
            {
               setWeapon(cProjectileGun.TYPE_BAZOOKA,true);
            }
            else if(Math.random() > 0.37)
            {
               setWeapon(cProjectileGun.TYPE_RIFLE,true);
            }
            else
            {
               setWeapon(cProjectileGun.TYPE_PISTOL,true);
            }
         }
         is_camlock_enemy = true;
         alert_allies_on_damage = true;
         use_auto_death_flashing = false;
         can_notlook = true;
         slug_health = getDefaultEnemyHealth();
         scoreVal = 100;
      }
      
      public function getGraphicsClip() : MovieClip
      {
         return new enemy01();
      }
      
      override public function createGraphics() : void
      {
         super.createGraphics();
         this.mySoliderClip = this.getGraphicsClip();
         myBodyClip.addChild(this.mySoliderClip);
      }
      
      override public function takeDamage(param1:slugObject, param2:int) : void
      {
         super.takeDamage(param1,param2);
         if(myHandler.ai_notlooking_undisturbed)
         {
            myHandler.ai_notlooking_undisturbed = false;
         }
      }
   }
}
