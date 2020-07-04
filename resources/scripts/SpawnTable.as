package
{
   import objects.*;
   
   public class SpawnTable
   {
       
      
      public var iconTypes:Vector.<String>;
      
      public var layer1Holders:Array;
      
      public var layer2Holders:Array;
      
      public var spawnList1:Array;
      
      public var spawnList2:Array;
      
      public var myParent:GameMode;
      
      private var lastLap:int = 0;
      
      public var subsLoaded:int = 0;
      
      public var subMax:int = 0;
      
      public function SpawnTable(param1:GameMode)
      {
         this.iconTypes = new Vector.<String>();
         this.layer1Holders = new Array();
         this.layer2Holders = new Array();
         this.spawnList1 = new Array();
         this.spawnList2 = new Array();
         super();
         this.myParent = param1;
         this.registerObjects();
         this.makeIconTypes();
      }
      
      public function makeIconTypes() : void
      {
         this.iconTypes.push("cAICopter");
         this.iconTypes.push("cAISheller");
         this.iconTypes.push("cAIShellerLeft");
         this.iconTypes.push("cCamBlocker");
         this.iconTypes.push("cCamBlockerMini");
         this.iconTypes.push("cCar");
         this.iconTypes.push("cDetailBarrel");
         this.iconTypes.push("cDetailBarrel2");
         this.iconTypes.push("cDetailBlocker");
         this.iconTypes.push("cDetailCanvas");
         this.iconTypes.push("cDetailCanvasOff");
         this.iconTypes.push("cDetailCar");
         this.iconTypes.push("cDetailJeep");
         this.iconTypes.push("cDetailPlatform");
         this.iconTypes.push("cDetailPlatformWood");
         this.iconTypes.push("cDetailSandbags");
         this.iconTypes.push("cDetailTruckLong");
         this.iconTypes.push("cPickupGun2");
         this.iconTypes.push("cPickupGun3");
         this.iconTypes.push("cPickupGun4");
         this.iconTypes.push("cPlatformTrainCar");
         this.iconTypes.push("cPlatformTrainCar2");
         this.iconTypes.push("cPlatformTrainCar3");
         this.iconTypes.push("cPlatformTrainTrain");
         this.iconTypes.push("cPlatformTrainTrain2");
         this.iconTypes.push("cPlatformTrainTrain3");
         this.iconTypes.push("cPlatformTrainTrain4");
         this.iconTypes.push("cProjectileBomb");
         this.iconTypes.push("cSoldier");
         this.iconTypes.push("cSoldierIdle");
         this.iconTypes.push("cSoldierIdleRight");
         this.iconTypes.push("cSoldierPlatform");
         this.iconTypes.push("cSoldierPlatformImmobile");
         this.iconTypes.push("cSoldierPlatformSmall");
         this.iconTypes.push("cSwordsMan");
         this.iconTypes.push("cTank");
         this.iconTypes.push("cTank2");
         this.iconTypes.push("cTank3");
         this.iconTypes.push("cTank4");
         this.iconTypes.push("cDetailBigassBombs");
         this.iconTypes.push("cHitler");
         this.iconTypes.push("cDetailBoat");
      }
      
      public function dummyFunct() : void
      {
         var _loc1_:Class = null;
         _loc1_ = cObject;
         _loc1_ = cAICopter;
         _loc1_ = cAISheller;
         _loc1_ = cAIShooter;
         _loc1_ = cBiped;
         _loc1_ = cCamBlocker;
         _loc1_ = cCar;
         _loc1_ = cDetailBarrel;
         _loc1_ = cDetailBarrel2;
         _loc1_ = cDetailBlocker;
         _loc1_ = cDetailCanvas;
         _loc1_ = cDetailCanvasOff;
         _loc1_ = cDetailCar;
         _loc1_ = cDetailJeep;
         _loc1_ = cDetailPlatform;
         _loc1_ = cDetailPlatformWood;
         _loc1_ = cDetailSandbags;
         _loc1_ = cDetailTruckLong;
         _loc1_ = cPickup;
         _loc1_ = cPickupGun2;
         _loc1_ = cPickupGun3;
         _loc1_ = cPickupGun4;
         _loc1_ = cPlatformTrainCar;
         _loc1_ = cPlatformTrainCar2;
         _loc1_ = cPlatformTrainCar3;
         _loc1_ = cPlatformTrainTrain;
         _loc1_ = cPlatformTrainTrain2;
         _loc1_ = cPlatformTrainTrain3;
         _loc1_ = cPlatformTrainTrain4;
         _loc1_ = cProjectileBomb;
         _loc1_ = cSoldier;
         _loc1_ = cSoldierIdle;
         _loc1_ = cSoldierIdleRight;
         _loc1_ = cSoldierPlatform;
         _loc1_ = cSoldierPlatformImmobile;
         _loc1_ = cSoldierPlatformSmall;
         _loc1_ = cSuspension;
         _loc1_ = cSwordsMan;
         _loc1_ = cTank;
         _loc1_ = cTank2;
         _loc1_ = cTank3;
         _loc1_ = cTank4;
         _loc1_ = cHitler;
         _loc1_ = cCamBlockerMini;
         _loc1_ = cAIShellerLeft;
         _loc1_ = cDetailBigassBombs;
         _loc1_ = cDetailBoat;
      }
      
      public function registerObjects() : void
      {
      }
      
      public function registerGroundObj(param1:Class, param2:int = 1, param3:int = 0, param4:Number = 1, param5:Number = 0) : *
      {
         this.layer1Holders.push(new SpawnHolder(param1,param2,param3,param4,param5));
      }
      
      public function registerSkyObj(param1:Class, param2:int = 1, param3:int = 0, param4:Number = 1, param5:Number = 0) : *
      {
         this.layer2Holders.push(new SpawnHolder(param1,param2,param3,param4,param5));
      }
      
      public function getYSpawn(param1:Class, param2:Array) : Number
      {
         return (param2[this.findClassIndex(param1,param2)] as SpawnHolder).spawnY;
      }
      
      public function getLapMax(param1:Class, param2:Array) : int
      {
         return (param2[this.findClassIndex(param1,param2)] as SpawnHolder).spawnY;
      }
      
      public function findClassIndex(param1:Class, param2:Array) : int
      {
         var _loc3_:int = 0;
         while(_loc3_ < param2.length)
         {
            if((param2[_loc3_] as SpawnHolder).myClass == param1)
            {
               return _loc3_;
            }
            _loc3_++;
         }
         return -1;
      }
      
      public function findClassFromIndex(param1:int, param2:Array) : Class
      {
         return (param2[param1] as SpawnHolder).myClass;
      }
      
      public function createSpawnList() : void
      {
         this.spawnList1 = this.createSpawnListLayer(this.layer1Holders);
         this.spawnList2 = this.createSpawnListLayer(this.layer2Holders);
      }
      
      public function createSpawnListLayer(param1:Array) : Array
      {
         var _loc3_:int = 0;
         var _loc4_:int = 0;
         var _loc6_:int = 0;
         var _loc2_:Array = new Array();
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc4_ = (param1[_loc5_] as SpawnHolder).frequency;
            _loc3_ = (param1[_loc5_] as SpawnHolder).max;
            if(World.followObj == null || World.followObj != null && World.followObj.laps >= _loc3_)
            {
               _loc6_ = 0;
               while(_loc6_ < _loc4_)
               {
                  _loc2_.push(this.findClassFromIndex(_loc5_,param1));
                  _loc6_++;
               }
            }
            _loc5_++;
         }
         return _loc2_;
      }
      
      public function spawnRandom(param1:GameMode, param2:int = 1) : *
      {
         if(this.spawnList1 == null || this.spawnList2 == null || this.spawnList1.length == 0 || this.spawnList2.length == 0 || this.lastLap != World.followObj.laps)
         {
            this.createSpawnList();
         }
         this.spawnLayer(this.spawnList1,this.layer1Holders,param2);
         this.spawnLayer(this.spawnList2,this.layer2Holders,param2);
         this.lastLap = World.followObj.laps;
      }
      
      public function spawnLayer(param1:Array, param2:Array, param3:int = 1) : void
      {
         var tObj:cObject = null;
         var rSel:int = 0;
         var chosenClass:Class = null;
         var blocksPerSection:int = 0;
         var chosenBlock:Number = NaN;
         var loadPosX:Number = NaN;
         var loadPosY:Number = NaN;
         var chosenSection:int = 0;
         var inList:Array = param1;
         var inLayerList:Array = param2;
         var whichSection:int = param3;
         var subChain:Function = function(param1:Class, param2:Number, param3:Number, param4:Number, param5:Number, param6:Number = 0.5):void
         {
            if(Math.random() < param6 && subsLoaded < subMax)
            {
               subSpawnSub(param1,param2,param3);
               subChain(param1,param2 + param4,param3 + param5,param4,param5,param6);
            }
         };
         var subSpawnSub:Function = function(param1:Class, param2:Number, param3:Number):*
         {
            LevelUtils.levelOb(new param1(param2,param3,myParent));
            subsLoaded++;
         };
         var numToSpawn:int = 3;
         var ct:int = 0;
         while(ct < numToSpawn)
         {
            this.subsLoaded = 0;
            rSel = Math.random() * inList.length;
            chosenClass = inList[rSel];
            blocksPerSection = 20;
            chosenBlock = blocksPerSection / (numToSpawn + 1) * ct + (Math.random() * 4 - 2);
            loadPosX = 0;
            loadPosY = 0;
            chosenSection = whichSection;
            loadPosX = (chosenSection * GroundUtils.sectionWidth + GroundUtils.sectionWidth / GroundUtils.blocksPerSection * chosenBlock) / World.gameScale;
            if(World.currentLevel.singleGroundLine)
            {
               loadPosY = this.getYSpawn(chosenClass,inLayerList) + 30;
            }
            else
            {
               loadPosY = this.getYSpawn(chosenClass,inLayerList) + GroundUtils.approximateGround(loadPosX);
            }
            ct++;
         }
      }
   }
}
