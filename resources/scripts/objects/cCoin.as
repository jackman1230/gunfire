package objects
{
   import flash.display.MovieClip;
   
   public class cCoin extends cObject
   {
       
      
      public var myClip:MovieClip;
      
      public var reached:Boolean = false;
      
      public var myVal:int = 2000;
      
      public var frameCount:int = 0;
      
      public var truckMode:Boolean = true;
      
      public function cCoin(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
         isProximity = true;
         isUpright = false;
         isGround = false;
         isAlwaysSensor = true;
         this.getStats();
         addPart(BoxUtils.NewBox(param1,param2,30,30,1,false,Filters.fuckallMask,Filters.fuckallMask),this.myClip,true,false,true);
         aabbWidth = 1 * 16;
         aabbHeight = 1.7 * 16;
         postCreate();
      }
      
      public function getStats() : void
      {
         var _loc1_:Number = Math.random();
         this.myClip = new MovieClip();
         this.myVal = 1000;
      }
      
      override public function processNeighbours() : void
      {
         var _loc1_:cCar = null;
         QueryHandler.getCloseBodies(bodyParts[0]);
         if(QueryHandler.carConnected)
         {
            isProximity = false;
            PuffHandler.makePuff(bodyParts[0],PuffHandler.PUFF_SNOW,Math.random() * 20 - 10,Math.random() * 20 - 10,0.9 + Math.random() * 0.1,0.9 + Math.random() * 0.1);
            PuffHandler.makePuff(bodyParts[0],PuffHandler.PUFF_SNOW,Math.random() * 20 - 10,Math.random() * 20 - 10,0.9 + Math.random() * 0.1,0.9 + Math.random() * 0.1);
            if(World.currentLevel.myID >= Level.LEVEL_1)
            {
               SoundHandler.playSoundClass(sound_pickup_life);
            }
            isProximity = false;
            destroy();
            if(Level.hasTrailer)
            {
               _loc1_ = World.followObj as cCar;
               if(_loc1_ != null)
               {
               }
            }
            else if(this.truckMode)
            {
               _loc1_ = World.followObj as cCar;
               if(_loc1_ != null)
               {
               }
            }
            else
            {
               ScoreHandler.addCoin(-100);
            }
         }
      }
   }
}
