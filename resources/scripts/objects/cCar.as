package objects
{
   public class cCar extends cBiped
   {
      
      public static var player_invincible:Boolean = false;
      
      public static var currentPlayerClip:player;
       
      
      public var myPlayerClip:player;
      
      public var goaltimer:int = -1;
      
      public function cCar(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         this.myPlayerClip = new player();
         super(param1,param2,param3,param4);
         aabbWidth = 3;
         aabbHeight = 14;
         hasWeapons = SlugScore.has_weapons;
         setWeapon(SlugScore.last_weapon);
         if(World.currentLevel.myID == Level.LEVEL_INTRO)
         {
            part_main.gravMassScale = 0;
            translateTo(250,448 * 1 / 3);
         }
      }
      
      override public function getStats() : void
      {
         super.getStats();
         playerControlled = true;
         slug_lives = 99;
         if(SlugScore.lastLives > slug_lives)
         {
            slug_lives = SlugScore.lastLives;
         }
         fire_delay = 1;
         can_pickup = true;
      }
      
      override public function slugtick() : void
      {
         super.slugtick();
         if(this.goaltimer > -1)
         {
            this.goaltimer--;
            if(this.goaltimer == -1)
            {
               GameMode.goal = true;
            }
         }
      }
      
      override public function createGraphics() : void
      {
         super.createGraphics();
         this.myPlayerClip = new player();
         myBodyClip.addChild(this.myPlayerClip);
         currentPlayerClip = this.myPlayerClip;
      }
      
      override public function takeDamage(param1:slugObject, param2:int) : void
      {
         super.takeDamage(param1,param2);
      }
      
      public function dummyFunction() : void
      {
         Migrate.dummyFunction();
      }
      
      public function setGraphics() : void
      {
      }
   }
}
