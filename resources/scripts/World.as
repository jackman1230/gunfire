package
{
   import flash.display.Sprite;
   import flash.events.Event;
   import nape.geom.Vec2;
   import nape.space.Space;
   import objects.cObject;
   
   public class World extends Sprite
   {
      
      public static var currentLevel:Level;
      
      public static var gameScale:int = 1;
      
      public static var m_world:Space;
      
      public static var debugging:Boolean = true;
      
      public static var drawDebugShapes:Boolean = false;
      
      public static var followObj:cObject;
      
      public static var following:Boolean = true;
      
      public static var stepLock:Boolean = false;
      
      public static var bulletTimeCounter:int = -1;
      
      public static var bulletTimeMultiplier:Number = 1;
      
      public static var lowGravCounter:int = -1;
      
      public static var lowGravMultiplier:Number = 1;
      
      public static var iceCounter:int = -1;
      
      public static var iceMultiplier:int = 1;
      
      public static var invulnerabilityCounter:int = -1;
      
      public static var clampedCounter:int = -1;
      
      public static var climbTimer:int = -1;
      
      public static var stopTicking:Boolean = false;
       
      
      protected var m_iterations:int = 25;
      
      protected var m_timeStep:Number = 0.03333333333333333;
      
      public var worldLocked:Boolean = false;
      
      public var dragBody:Boner;
      
      public var main:Main;
      
      public var frameCount = 1;
      
      public var loaded_random_objects_for_this_panel:Boolean = false;
      
      public var CListener:EContactListener;
      
      public function World(param1:Main)
      {
         super();
         this.main = param1;
         m_world = new Space(new Vec2(0,9.8));
         BoxUtils.m_world = m_world;
         EContactListener.donkeyBoner();
         SpriteUtils.makeCanvases();
         new Camera();
      }
      
      public static function setInvulnerability() : void
      {
         invulnerabilityCounter = 250;
         EffectIndicator.self.addStatus(EffectIndicator.EFFECT_INVUL);
      }
      
      public static function removeInvulnerability() : void
      {
         invulnerabilityCounter = -1;
         EffectIndicator.self.removeStatus(EffectIndicator.EFFECT_INVUL);
      }
      
      public static function setClamped() : void
      {
         clampedCounter = 250;
         EffectIndicator.self.addStatus(EffectIndicator.EFFECT_CLAMP);
      }
      
      public static function removeClamped() : void
      {
         clampedCounter = -1;
         EffectIndicator.self.removeStatus(EffectIndicator.EFFECT_CLAMP);
      }
      
      public static function setLowGrav() : void
      {
         lowGravCounter = 250;
         EffectIndicator.self.addStatus(EffectIndicator.EFFECT_LOWGRAV);
      }
      
      public static function removeLowGrav() : void
      {
         lowGravCounter = -1;
         if(m_world != null && World.currentLevel != null)
         {
            m_world.gravity = new Vec2(0,World.currentLevel.gravity * 1);
         }
         EffectIndicator.self.removeStatus(EffectIndicator.EFFECT_LOWGRAV);
      }
      
      public static function setIcyRoad() : void
      {
         iceCounter = 250;
         EffectIndicator.self.addStatus(EffectIndicator.EFFECT_ICE);
      }
      
      public static function removeIcyRoad() : void
      {
         iceCounter = -1;
         if(GroundUtils.groundBrick != null)
         {
            GroundUtils.groundBrick.material.dynamicFriction = 1;
         }
         EffectIndicator.self.removeStatus(EffectIndicator.EFFECT_ICE);
      }
      
      public static function setBulletTime() : void
      {
         bulletTimeCounter = 250;
         EffectIndicator.self.addStatus(EffectIndicator.EFFECT_BULLET);
      }
      
      public static function removeBulletTime() : void
      {
         bulletTimeCounter = -1;
         bulletTimeMultiplier = 1;
         EffectIndicator.self.removeStatus(EffectIndicator.EFFECT_BULLET);
      }
      
      public function Update(param1:Event) : void
      {
         if(!this.worldLocked)
         {
            stepLock = true;
            if(!UIHandler.paused)
            {
               if(!stopTicking)
               {
                  m_world.step(1 / 30 * bulletTimeMultiplier,2,2);
                  m_world.step(1 / 30 * bulletTimeMultiplier,10,10);
               }
            }
            stepLock = false;
            if(World.drawDebugShapes)
            {
               SpriteUtils.debugMode.clear();
               SpriteUtils.debugMode.display.scaleX = World.gameScale;
               SpriteUtils.debugMode.display.scaleY = World.gameScale;
               SpriteUtils.debugMode.draw(m_world);
               SpriteUtils.debugMode.flush();
            }
         }
         if(climbTimer > -1)
         {
            climbTimer--;
            if(climbTimer == -1)
            {
               EffectIndicator.self.removeStatus(EffectIndicator.EFFECT_HINT);
            }
         }
         if(clampedCounter > -1)
         {
            clampedCounter--;
            if(clampedCounter == -1)
            {
               removeClamped();
            }
         }
         if(invulnerabilityCounter > -1)
         {
            invulnerabilityCounter--;
            if(invulnerabilityCounter == -1)
            {
               removeInvulnerability();
            }
         }
         if(lowGravCounter > -1)
         {
            lowGravCounter--;
            if(lowGravCounter == -1)
            {
               removeLowGrav();
            }
            else
            {
               m_world.gravity = new Vec2(0,World.currentLevel.gravity * 0.2);
            }
         }
         if(iceCounter > -1)
         {
            iceCounter--;
            if(iceCounter == -1)
            {
               removeIcyRoad();
            }
            else
            {
               GroundUtils.groundBrick.material.dynamicFriction = 0;
               GroundUtils.groundBrick.material.staticFriction = 0;
            }
         }
         if(bulletTimeCounter > -1)
         {
            bulletTimeCounter--;
            if(bulletTimeCounter == -1)
            {
               removeBulletTime();
            }
            else if(bulletTimeMultiplier > 0.3)
            {
               bulletTimeMultiplier = bulletTimeMultiplier * 0.95;
            }
         }
         Camera.update();
         GroundUtils.update();
         SpriteUtils.update();
         this.loadStuff();
      }
      
      public function loadStuff() : *
      {
      }
   }
}
