package
{
   import objects.*;
   
   public class Level
   {
      
      public static var numPlayableLevels:int = 11;
      
      public static var hasTrailer:Boolean = false;
      
      public static const MOTORMODE_GEARED:int = 0;
      
      public static const MOTORMODE_TORQUE:int = 1;
      
      public static const MOTORMODE_FREEWHEEL:int = 2;
      
      public static var slMax:int = 100;
      
      public static var slPerBlock:Number = 1.4;
      
      public static const MODE_NORMAL:int = 0;
      
      public static const MODE_EDITOR:int = 1;
      
      public static const MODE_PREVIEW:int = 2;
      
      public static var editString:String = "";
      
      public static const LEVEL_INTRO:int = 0;
      
      public static const LEVEL_CHALLENGE:int = 4;
      
      public static const LEVEL_1:int = 8;
      
      public static const LEVEL_2:int = 9;
      
      public static const LEVEL_3:int = 10;
      
      public static const LEVEL_4:int = 11;
      
      public static const LEVEL_5:int = 12;
      
      public static const LEVEL_6:int = 13;
      
      public static const LEVEL_7:int = 14;
      
      public static const LEVEL_8:int = 15;
      
      public static const LEVEL_9:int = 16;
      
      public static const LEVEL_10:int = 17;
      
      public static const LEVEL_11:int = 18;
      
      public static const LEVEL_12:int = 19;
      
      public static const LEVEL_13:int = 20;
       
      
      public var levelObjects:Vector.<cObject>;
      
      public var levelString:String;
      
      public var gravity:Number = 313.6;
      
      public var inEditor:Boolean = false;
      
      public var inEditorPreview:Boolean = false;
      
      public var inEditorOrPreview:Boolean = false;
      
      public var myID:int = 0;
      
      public var myMode:int = 0;
      
      public var allowWrapping:Boolean = false;
      
      public var transferClip:Boolean = true;
      
      public var loadRandomObjects:Boolean = false;
      
      public var controlable:Boolean = true;
      
      public var carCanJump:Boolean = false;
      
      public var carCanBoost:Boolean = true;
      
      public var carCanBrake:Boolean = true;
      
      public var carNeedsFuel:Boolean = false;
      
      public var carAutoBraking:Boolean = false;
      
      public var carDampenRotation:Boolean = true;
      
      public var carCanSmackHead:Boolean = false;
      
      public var motorMode:int = 1;
      
      public var preloadGroundSections:Boolean = true;
      
      public var gearLimiter:Boolean = true;
      
      public var yScroll:Boolean = true;
      
      public var scrollingBackground:Boolean = true;
      
      public var yScrollBackground:Boolean = true;
      
      public var yScrollBackgroundOffset:Number = 200;
      
      public var yScrollBackgroundOffset2:Number = 200;
      
      public var singleGroundClip:Boolean = false;
      
      public var singleGroundLine:Boolean = false;
      
      public var streamingGround:Boolean = false;
      
      public var load_phys_id:int = 0;
      
      public var load_image_id:int = 0;
      
      public var carInFront:Boolean = true;
      
      public var useSystemTime:Boolean = true;
      
      public var allowCheevies:Boolean = false;
      
      public var allowStunts:Boolean = false;
      
      public var allowKills:Boolean = false;
      
      public var staggeredLoading:Boolean = false;
      
      public var staggeredLoadingBlock:int = 0;
      
      public var staggeredLoadingComplete:Boolean = false;
      
      public var staggeredLoadingStarted:Boolean = false;
      
      public var respawnTimer:int = -1;
      
      public var autoScaling:Boolean = true;
      
      public var goingLeft:Boolean = false;
      
      public var currentDistance:int = 0;
      
      public var coinsRequired:int = 0;
      
      public function Level()
      {
         this.levelObjects = new Vector.<cObject>();
         super();
      }
      
      public static function createLevel(param1:int = 0, param2:int = 0) : Level
      {
         var _loc3_:Level = levelData(param1,param2);
         return _loc3_;
      }
      
      public static function getLevelIndex() : int
      {
         var _loc1_:int = World.currentLevel.myID - Level.LEVEL_1;
         if(_loc1_ > -1 && _loc1_ < Level.numPlayableLevels)
         {
            return _loc1_;
         }
         return -555;
      }
      
      public static function levelData(param1:int = 0, param2:int = 0) : Level
      {
         var _loc3_:Level = new Level();
         _loc3_.myID = param1;
         _loc3_.myMode = param2;
         if(param1 == LEVEL_INTRO)
         {
            _loc3_.load_phys_id = 0;
            _loc3_.load_image_id = 0;
            _loc3_.controlable = false;
            _loc3_.yScroll = false;
            _loc3_.yScrollBackground = false;
            _loc3_.levelString = "";
            _loc3_.staggeredLoading = false;
            _loc3_.levelString = "^,1,5,^,0,0,0,0,0,0,|cCar,18.0,2.79,X|cAICopter,18,0";
         }
         if(param1 == LEVEL_1)
         {
            _loc3_.load_image_id = 1;
            _loc3_.load_phys_id = 1;
            _loc3_.levelString = "^,1,21,^,0,0,0,0,0,0,|cCar,45.06,17.50,0.0000|cSwordsMan,152.4,18.94,0.0000|cDetailSandbags,58.63,19.75,0.0000|cDetailSandbags,145.7,21.50,-0.1208|cAISheller,158.4,20.06,0.0000|cCamBlocker,178.9,8.750,0.0000|cSoldierPlatformSmall,130.4,14.56,0.0000|cSoldierIdleRight,69.00,18.25,-0.00000000000000006917|cSoldierIdle,64.38,18.06,0.0000|cDetailSandbags,93.00,14.63,-0.1819|cSoldier,81.44,14.19,-0.0000000000000000002828|cSoldier,86.13,14.13,-0.0000000000000000002877|cSoldier,89.19,9.875,0.0000|cSoldierIdle,101.8,13.50,0.0000|cAICopter,155.5,7.188,0.0000|cSoldierPlatformSmall,133.6,14.77,0.0000|cSoldierPlatformSmall,125.1,14.00,-0.000000000000001329|cDetailBarrel2,184.4,8.313,-0.1061|cCamBlockerMini,137.2,6.750,0.0000|cSoldierIdleRight,105.1,14.69,0.0000|cCamBlockerMini,110.4,5.063,0.0000|cCamBlockerMini,73.63,9.063,0.0000|";
            _loc3_.levelString = "^,1,21,^,0,0,0,0,0,0,|cCar,45.06,17.50,0.0000|cSwordsMan,152.4,18.94,0.0000|cDetailSandbags,58.63,19.75,0.0000|cDetailSandbags,145.7,21.50,-0.1208|cAISheller,158.4,20.06,0.0000|cCamBlocker,178.9,8.750,0.0000|cSoldierPlatformSmall,130.4,14.56,0.0000|cSoldierIdleRight,69.00,18.25,-0.00000000000000006917|cSoldierIdle,64.38,18.06,0.0000|cSoldier,81.44,14.19,-0.0000000000000000002828|cSoldier,86.13,14.13,-0.0000000000000000002877|cSoldier,89.19,9.875,0.0000|cSoldierIdle,101.8,13.50,0.0000|cAICopter,155.5,7.188,0.0000|cSoldierPlatformSmall,133.6,14.77,0.0000|cSoldierPlatformSmall,125.1,14.00,-0.000000000000001329|cDetailBarrel2,184.4,8.313,-0.1061|cCamBlockerMini,137.2,6.750,0.0000|cSoldierIdleRight,105.1,14.69,0.0000|cCamBlockerMini,110.4,5.063,0.0000|cCamBlockerMini,73.63,9.063,0.0000|cDetailSandbags,96.06,15.81,0.1456|";
         }
         if(param1 == LEVEL_2)
         {
            _loc3_.load_image_id = 2;
            _loc3_.load_phys_id = 2;
            _loc3_.levelString = "^,1,4,^,0,0,0,0,0,0,|cCar,48.45,10,-0.1001|cAICopter,48.45,10,0.0000|";
            _loc3_.levelString = "^,2,25,^,0,0,0,0,0,0,|cCar,188.9,7d.563,0.00000000000002843|cDetailPlatformWood,256.7,6.000,0.002540|cAISheller,254.2,15.00,0.0000|cSoldierPlatformSmall,265.4,5.000,0.0000|cDetailSandbags,235.4,14.81,-0.08617|cSoldierPlatformImmobile,242.1,13.81,0.0000|cSoldierPlatformImmobile,245.6,14.77,0.0000|cDetailPlatformWood,264.8,7.188,0.008451|cDetailPlatformWood,274.3,5.563,0.2731|cSoldierPlatformSmall,274.5,3.063,0.0000|cSoldierIdleRight,267.2,4.813,0.0000|cSoldier,256.2,3.375,0.0000|cSoldierPlatformImmobile,256.6,4.063,0.0000|cSwordsMan,268.3,14.31,0.0000|cDetailPlatformWood,308.4,5.500,0.7150|cAISheller,308.4,3.813,0.0000|cAISheller,288.9,14.31,0.0000|cDetailSandbags,283.0,15.00,0.0000|cDetailSandbags,296.0,15.00,-0.07311|cSoldierIdle,302.8,13.88,0.0000|cSoldier,307.4,14.13,0.0000|cSoldier,311.4,14.06,0.0000|cSoldierIdleRight,321.8,11.19,0.0000|cDetailCanvasOff,217.2,13.94,0.02485|cSoldierPlatformImmobile,216.0,8.375,0.0000|cDetailCar,226.8,14.50,0.01082|";
            _loc3_.levelString = "^,2,33,^,0,0,0,0,0,0,|cCar,188.9,7.563,0.00000000000002843|cDetailPlatformWood,256.7,6.000,0.002540|cAISheller,254.2,15.00,0.0000|cSoldierPlatformSmall,265.4,5.000,0.0000|cSoldierPlatformImmobile,242.1,13.81,0.0000|cSoldierPlatformImmobile,245.6,14.77,0.0000|cDetailPlatformWood,264.8,7.188,0.008451|cDetailPlatformWood,274.3,5.563,0.2731|cSoldierPlatformSmall,274.5,3.063,0.0000|cSoldierIdleRight,267.2,4.813,0.0000|cSoldier,256.2,3.375,0.0000|cSoldierPlatformImmobile,256.6,4.063,0.0000|cSwordsMan,268.3,14.31,0.0000|cDetailPlatformWood,308.4,5.500,0.7150|cAISheller,308.4,3.813,0.0000|cAISheller,288.9,14.31,0.0000|cDetailSandbags,283.0,15.00,0.0000|cDetailSandbags,296.0,15.00,-0.07311|cSoldierIdle,302.8,13.88,0.0000|cSoldier,307.4,14.13,0.0000|cSoldier,311.4,14.06,0.0000|cDetailCanvasOff,217.2,13.94,0.02485|cSoldierPlatformImmobile,216.0,8.375,0.0000|cDetailCar,226.8,14.50,0.01082|cTank,315.1,11.06,0.0000|cAISheller,335.6,10.44,0.0000|cDetailSandbags,232.5,22.50,0.2162|cAISheller,239.1,23.00,0.0000|cDetailSandbags,234.6,14.56,-0.03641|cSoldierIdleRight,304.4,13.88,0.0000|cTank,318.3,11.44,0.0000|cCamBlocker,321.4,9.813,0.0000|cDetailBarrel2,339.7,7.250,0.0000|cDetailBarrel2,343.6,5.688,-0.00000001785|";
            _loc3_.levelString = "^,2,30,^,0,0,0,0,0,0,|cCar,188.9,7.563,0.00000000000002843|cDetailPlatformWood,256.7,6.000,0.002540|cAISheller,254.2,15.00,0.0000|cSoldierPlatformSmall,265.4,5.000,0.0000|cSoldierPlatformImmobile,242.1,13.81,0.0000|cSoldierPlatformImmobile,245.6,14.77,0.0000|cDetailPlatformWood,264.8,7.188,0.008451|cDetailPlatformWood,274.3,5.563,0.2731|cSoldierPlatformSmall,274.5,3.063,0.0000|cSoldierIdleRight,267.2,4.813,0.0000|cSoldier,256.2,3.375,0.0000|cSoldierPlatformImmobile,256.6,4.063,0.0000|cSwordsMan,268.3,14.31,0.0000|cDetailPlatformWood,308.4,5.500,0.7150|cAISheller,308.4,3.813,0.0000|cAISheller,288.9,14.31,0.0000|cDetailSandbags,283.0,15.00,0.0000|cDetailSandbags,296.0,15.00,-0.07311|cSoldierIdle,302.8,13.88,0.0000|cSoldier,307.4,14.13,0.0000|cSoldier,311.4,14.06,0.0000|cDetailCanvasOff,217.2,13.94,0.02485|cSoldierPlatformImmobile,216.0,8.375,0.0000|cDetailCar,226.8,14.50,0.01082|cTank,315.1,11.06,0.0000|cDetailSandbags,232.5,22.50,0.2162|cAISheller,239.1,23.00,0.0000|cDetailSandbags,234.6,14.56,-0.03641|cSoldierIdleRight,304.4,13.88,0.0000|cTank,318.3,11.44,0.0000|cCamBlocker,321.4,9.813,0.0000|";
            _loc3_.levelString = "^,2,32,^,0,0,0,0,0,0,|cCar,188.9,7.563,0.00000000000002843|cDetailPlatformWood,256.7,6.000,0.002540|cAISheller,254.2,15.00,0.0000|cSoldierPlatformImmobile,242.1,13.81,0.0000|cSoldierPlatformImmobile,245.6,14.77,0.0000|cDetailPlatformWood,264.8,7.188,0.008451|cDetailPlatformWood,274.3,5.563,0.2731|cSoldierPlatformSmall,274.5,3.063,0.0000|cSoldierIdleRight,267.2,4.813,0.0000|cSoldier,256.2,3.375,0.0000|cSoldierPlatformImmobile,256.6,4.063,0.0000|cSwordsMan,269.3,14.44,0.0000|cDetailPlatformWood,308.4,5.500,0.7150|cAISheller,308.4,3.813,0.0000|cAISheller,288.9,14.31,0.0000|cDetailSandbags,283.0,15.00,0.0000|cDetailSandbags,296.0,15.00,-0.07311|cSoldierIdle,302.8,13.88,0.0000|cSoldier,307.4,14.13,0.0000|cSoldier,311.4,14.06,0.0000|cDetailCanvasOff,217.2,13.94,0.02485|cSoldierPlatformImmobile,216.0,8.375,0.0000|cDetailCar,226.8,14.50,0.01082|cTank,315.1,11.06,0.0000|cDetailSandbags,232.5,22.50,0.2162|cAISheller,239.1,23.00,0.0000|cDetailSandbags,234.6,14.56,-0.03641|cSoldierIdleRight,304.4,13.88,0.0000|cTank,318.3,11.44,0.0000|cCamBlocker,321.4,9.813,0.0000|cCamBlockerMini,221.4,3.125,0.0000|cCamBlockerMini,281.7,2.563,0.0000|cSoldierPlatformSmall,264.9,3.938,0.0000|";
         }
         if(param1 == LEVEL_3)
         {
            _loc3_.load_image_id = 3;
            _loc3_.load_phys_id = 3;
            _loc3_.levelString = "^,1,4,^,0,0,0,0,0,0,|cCar,48.45,10,-0.1001|cAICopter,48.45,10,0.0000|";
            _loc3_.levelString = "^,3,23,^,0,0,0,0,0,0,|cCar,383.4,18.25,0.0000|cAICopter,410.1,5.375,0.0000|cAICopter,428.3,5.938,0.0000|cAISheller,410.0,19.44,0.0000|cDetailBarrel,403.9,17.81,0.0000|cDetailBlocker,423.0,19.13,0.03037|cAISheller,437.8,24.00,0.0000|cDetailPlatformWood,445.8,7.688,0.008451|cDetailPlatformWood,459.1,12.25,0.6739|cDetailPlatformWood,450.4,13.88,0.5025|cDetailSandbags,442.3,19.13,0.0000|cSoldierIdle,451.8,12.00,0.0000|cSoldierIdleRight,459.1,9.938,0.0000|cSoldierIdleRight,445.3,5.563,0.0000|cDetailBarrel2,448.9,9.938,0.03702|cSoldierIdleRight,463.8,17.88,0.0000|cDetailBarrel2,475.7,17.44,0.0000|cDetailBarrel2,479.8,17.31,0.0000|cDetailBarrel2,483.6,17.06,0.0000|cDetailBarrel2,477.7,12.56,0.0000000000000001410|cDetailBarrel2,479.8,7.813,1.571|cDetailBarrel2,481.3,12.31,-0.02696|cDetailBarrel,400.3,17.50,0.0000|cDetailBarrel,494.2,16.25,1.571|";
            _loc3_.levelString = "^,3,27,^,0,0,0,0,0,0,|cCar,383.4,18.25,0.0000|cAICopter,410.1,5.375,0.0000|cAICopter,428.3,5.938,0.0000|cAISheller,410.0,19.44,0.0000|cDetailBarrel,403.9,17.81,0.0000|cDetailBlocker,423.0,19.13,0.03037|cAISheller,437.8,24.00,0.0000|cDetailPlatformWood,445.8,7.688,0.008451|cDetailPlatformWood,459.1,12.25,0.6739|cDetailPlatformWood,450.4,13.88,0.5025|cDetailSandbags,442.3,19.13,0.0000|cSoldierIdle,451.8,12.00,0.0000|cSoldierIdleRight,459.1,9.938,0.0000|cSoldierIdleRight,445.3,5.563,0.0000|cDetailBarrel2,448.9,9.938,0.03702|cSoldierIdleRight,463.8,17.88,0.0000|cDetailBarrel2,475.7,17.44,0.0000|cDetailBarrel2,479.8,17.31,0.0000|cDetailBarrel2,483.6,17.06,0.0000|cDetailBarrel2,477.7,12.56,0.0000000000000001410|cDetailBarrel2,479.8,7.813,1.571|cDetailBarrel2,481.3,12.31,-0.02696|cDetailBarrel,400.3,17.50,0.0000|cTank4,499.2,17.94,0.0000|cTank4,528.2,17.94,0.0000|cCamBlocker,540.3,17.88,0.0000|cSoldierPlatformImmobile,508.6,5.375,0.0000|cDetailPlatformWood,508.6,7.750,0.3117|";
            _loc3_.levelString = "^,3,28,^,0,0,0,0,0,0,|cCar,383.4,18.25,0.0000|cAICopter,410.1,5.375,0.0000|cAICopter,428.3,5.938,0.0000|cAISheller,410.0,19.44,0.0000|cDetailBarrel,403.9,17.81,0.0000|cAISheller,437.8,24.00,0.0000|cDetailPlatformWood,445.8,7.688,0.008451|cDetailPlatformWood,459.1,12.25,0.6739|cDetailPlatformWood,450.4,13.88,0.5025|cDetailSandbags,442.3,19.13,0.0000|cSoldierIdle,451.8,12.00,0.0000|cSoldierIdleRight,459.1,9.938,0.0000|cSoldierIdleRight,445.3,5.563,0.0000|cDetailBarrel2,448.9,9.938,0.03702|cSoldierIdleRight,463.8,17.88,0.0000|cDetailBarrel2,475.7,17.44,0.0000|cDetailBarrel2,479.8,17.31,0.0000|cDetailBarrel2,483.6,17.06,0.0000|cDetailBarrel2,477.7,12.56,0.0000000000000001410|cDetailBarrel2,479.8,7.813,1.571|cDetailBarrel2,481.3,12.31,-0.02696|cDetailBarrel,400.3,17.50,0.0000|cTank4,499.2,17.94,0.0000|cTank4,528.2,17.94,0.0000|cCamBlocker,540.3,17.88,0.0000|cSoldierPlatformImmobile,508.6,5.375,0.0000|cDetailPlatformWood,508.4,7.750,0.008451|cDetailBlocker,421.8,19.25,-0.4568|cDetailPlatformWood,424.1,12.13,-0.2079|";
         }
         if(param1 == LEVEL_4)
         {
            _loc3_.load_image_id = 4;
            _loc3_.load_phys_id = 4;
            _loc3_.levelString = "^,4,18,^,0,0,0,0,0,0,|cCar,554.9,14.50,0.0000|cAISheller,577.1,15.38,0.0000|cAISheller,584.2,17.00,0.0000|cDetailSandbags,569.9,13.43,0.000000000000000007329|cDetailSandbags,590.2,16.88,0.0000|cDetailBarrel,595.3,15.28,0.0000|cDetailBarrel,596.3,9.875,0.0000|cDetailBarrel,600.2,13.31,0.0000|cDetailJeep,614.3,15.25,-0.08961|cSoldierPlatformImmobile,612.9,11.13,0.0000|cSoldierPlatformImmobile,605.0,13.75,0.0000|cSoldierIdle,580.3,15.10,0.0000000000000000005473|cSoldierIdleRight,584.8,15.75,0.0000|cSoldierIdleRight,629.9,12.19,0.0000|cSoldierIdle,625.2,12.75,0.0000|cAISheller,656.9,12.81,0.0000|cAISheller,665.2,15.38,0.0000|cTank3,677.8,16.00,0.0000|cCamBlocker,701.9,15.56,0.0000|";
            _loc3_.levelString = "^,4,22,^,0,0,0,0,0,0,|cCar,554.9,14.50,0.0000|cAISheller,577.1,15.38,0.0000|cAISheller,584.2,17.00,0.0000|cDetailSandbags,569.9,13.43,0.000000000000000007329|cDetailSandbags,590.2,16.88,0.0000|cDetailBarrel,595.3,15.28,0.0000|cDetailBarrel,596.3,9.875,0.0000|cDetailBarrel,600.2,13.31,0.0000|cSoldierPlatformImmobile,605.0,13.75,0.0000|cSoldierIdle,580.3,15.10,0.0000000000000000005473|cSoldierIdleRight,584.8,15.75,0.0000|cSoldierIdleRight,630.1,12.25,0.0000|cSoldierIdle,625.2,12.75,0.0000|cAISheller,656.9,12.81,0.0000|cAISheller,665.2,15.38,0.0000|cTank3,677.8,16.00,0.0000|cCamBlocker,701.9,15.56,0.0000|cSoldierPlatformImmobile,604.1,13.88,0.0000|cDetailJeep,618.7,13.06,-0.8081|cSoldierIdleRight,636.1,12.19,0.0000|cSoldierIdleRight,640.4,13.38,0.0000|cSoldierIdleRight,643.9,14.56,0.0000|cSoldierIdleRight,647.4,15.81,0.0000|";
            _loc3_.levelString = "^,4,22,^,0,0,0,0,0,0,|cCar,554.9,14.50,0.0000|cAISheller,577.1,15.38,0.0000|cAISheller,584.2,17.00,0.0000|cDetailSandbags,569.9,13.43,0.000000000000000007329|cDetailSandbags,590.2,16.88,0.0000|cDetailBarrel,595.3,15.28,0.0000|cSoldierIdle,580.3,15.10,0.0000000000000000005473|cSoldierIdleRight,584.8,15.75,0.0000|cSoldierIdleRight,630.1,12.25,0.0000|cAISheller,656.9,12.81,0.0000|cAISheller,665.2,15.38,0.0000|cTank3,677.8,16.00,0.0000|cCamBlocker,701.9,15.56,0.0000|cDetailJeep,618.7,13.06,-0.8081|cSoldierIdleRight,636.1,12.19,0.0000|cSoldierIdleRight,640.4,13.38,0.0000|cSoldierIdleRight,643.9,14.56,0.0000|cSoldierIdleRight,647.4,15.81,0.0000|cSoldierIdle,627.3,12.19,-0.0000000000000000006246|cSoldierIdleRight,608.8,13.38,-0.0000000000000000005716|cSoldierIdle,605.1,14.56,-0.000000000000000001090|cDetailBarrel,599.3,14.06,0.1050|cDetailBarrel,600.3,9.125,-0.1372|";
         }
         if(param1 == LEVEL_5)
         {
            _loc3_.load_image_id = 5;
            _loc3_.load_phys_id = 5;
            _loc3_.levelString = "^,5,48,^,0,0,0,0,0,0,|cCar,709.4,17.88,0.0000|cDetailPlatformWood,736.5,14.06,0.002540|cDetailPlatformWood,739.9,9.188,0.1390|cAISheller,740.3,8.063,0.0000|cAISheller,736.5,13.00,0.0000|cAISheller,733.5,23.94,0.0000|cPlatformTrainCar,753.9,23.13,-0.1432|cDetailBarrel2,780.4,21.13,0.0000|cSoldierPlatformSmall,756.2,13.38,0.0000|cSoldierPlatformImmobile,754.1,19.50,0.0000|cDetailBlocker,798.0,22.56,-0.7350|cDetailPlatformWood,798.4,8.938,0.0000|cDetailPlatformWood,799.8,16.25,-0.2079|cSoldierPlatform,798.3,7.063,0.0000|cPlatformTrainTrain4,789.4,22.63,0.0000|cSoldierPlatformImmobile,786.1,19.38,0.0000|cDetailCar,790.6,20.13,0.0000|cAICopter,789.7,6.000,0.0000|cPlatformTrainCar2,770.4,22.94,-0.1686|cSoldierPlatformImmobile,766.7,13.44,0.0000|cPlatformTrainCar2,832.1,23.75,-0.03475|cDetailCanvas,808.5,23.38,-0.02267|cPlatformTrainTrain4,847.6,23.44,0.0000|cDetailCanvas,846.2,21.50,-0.3948|cPlatformTrainTrain4,880.1,22.94,0.0000|cPlatformTrainCar2,864.7,23.63,0.03401|cDetailJeep,879.2,20.44,-0.2259|cSwordsMan,866.6,14.13,0.0000|cSoldierPlatformImmobile,884.7,19.63,0.000000000000000001940|cSoldierPlatformImmobile,876.6,15.69,0.0000|cSoldierPlatformImmobile,852.5,20.56,0.0000|cSoldierPlatformImmobile,835.6,14.31,0.0000|cSoldierPlatformImmobile,831.9,14.44,0.0000|cSoldierPlatformImmobile,828.5,14.56,0.0000|cSoldier,816.8,22.38,0.0000|cSoldier,820.9,22.56,0.0000|cAISheller,799.3,14.63,0.0000|cAICopter,943.8,7.500,0.0000|cTank2,957.3,21.63,0.0000|cTank2,942.9,20.94,0.0000|cPlatformTrainTrain2,914.5,24.13,-0.003197|cAISheller,908.1,17.63,0.0000|cTank2,977.4,21.69,0.0000|cCamBlocker,999.8,19.19,0.0000|cDetailPlatformWood,955.4,10.50,0.2731|cAISheller,955.3,9.000,0.0000|cDetailPlatformWood,994.3,11.06,0.4356|cAISheller,994.5,9.750,0.0000|cDetailPlatformWood,930.1,10.25,0.6105|";
            _loc3_.levelString = "^,5,48,^,0,0,0,0,0,0,|cCar,709.4,17.88,0.0000|cDetailPlatformWood,736.5,14.06,0.002540|cDetailPlatformWood,739.9,9.188,0.1390|cAISheller,740.3,8.063,0.0000|cAISheller,736.5,13.00,0.0000|cAISheller,733.5,23.94,0.0000|cPlatformTrainCar,753.9,23.13,-0.1432|cDetailBarrel2,780.4,21.13,0.0000|cSoldierPlatformSmall,756.2,13.38,0.0000|cSoldierPlatformImmobile,754.1,19.50,0.0000|cDetailBlocker,798.0,22.56,-0.7350|cDetailPlatformWood,798.4,8.938,0.0000|cDetailPlatformWood,799.8,16.25,-0.2079|cSoldierPlatform,798.3,7.063,0.0000|cPlatformTrainTrain4,789.4,22.63,0.0000|cSoldierPlatformImmobile,786.1,19.38,0.0000|cDetailCar,790.6,20.13,0.0000|cAICopter,789.7,6.000,0.0000|cPlatformTrainCar2,770.4,22.94,-0.1686|cSoldierPlatformImmobile,766.7,13.44,0.0000|cPlatformTrainCar2,832.1,23.75,-0.03475|cDetailCanvas,808.5,23.38,-0.02267|cPlatformTrainTrain4,847.6,23.44,0.0000|cPlatformTrainTrain4,880.1,22.94,0.0000|cPlatformTrainCar2,864.7,23.63,0.03401|cSwordsMan,866.6,14.13,0.0000|cSoldierPlatformImmobile,884.7,19.63,0.000000000000000001940|cSoldierPlatformImmobile,876.6,15.69,0.0000|cSoldierPlatformImmobile,852.5,20.56,0.0000|cSoldierPlatformImmobile,835.6,14.31,0.0000|cSoldierPlatformImmobile,831.9,14.44,0.0000|cSoldierPlatformImmobile,828.5,14.56,0.0000|cSoldier,816.8,22.38,0.0000|cSoldier,820.9,22.56,0.0000|cAISheller,799.3,14.63,0.0000|cAICopter,943.8,7.500,0.0000|cPlatformTrainTrain2,914.5,24.13,-0.003197|cAISheller,908.1,17.63,0.0000|cCamBlocker,999.8,19.19,0.0000|cDetailPlatformWood,955.4,10.50,0.2731|cAISheller,955.3,9.000,0.0000|cDetailPlatformWood,994.3,11.06,0.4356|cAISheller,994.5,9.750,0.0000|cDetailPlatformWood,930.1,10.25,0.6105|cTank2,979.9,20.63,0.0000|cTank2,959.4,19.75,0.0000|cTank2,943.6,19.75,0.0000|cDetailJeep,880.4,20.00,0.05842|cDetailCanvas,847.1,20.13,0.4491|";
            _loc3_.levelString = "^,5,49,^,0,0,0,0,0,0,|cCar,709.4,17.88,0.0000|cDetailPlatformWood,736.5,14.06,0.002540|cDetailPlatformWood,739.9,9.188,0.1390|cAISheller,740.3,8.063,0.0000|cAISheller,736.5,13.00,0.0000|cAISheller,733.5,23.94,0.0000|cPlatformTrainCar,753.9,23.13,-0.1432|cDetailBarrel2,780.4,21.13,0.0000|cSoldierPlatformSmall,756.2,13.38,0.0000|cSoldierPlatformImmobile,754.1,19.50,0.0000|cDetailBlocker,798.0,22.56,-0.7350|cDetailPlatformWood,798.4,8.938,0.0000|cDetailPlatformWood,799.8,16.25,-0.2079|cSoldierPlatform,798.3,7.063,0.0000|cPlatformTrainTrain4,789.4,22.63,0.0000|cSoldierPlatformImmobile,786.1,19.38,0.0000|cDetailCar,790.6,20.13,0.0000|cAICopter,789.7,6.000,0.0000|cPlatformTrainCar2,770.4,22.94,-0.1686|cSoldierPlatformImmobile,766.7,13.44,0.0000|cPlatformTrainCar2,832.1,23.75,-0.03475|cDetailCanvas,808.5,23.38,-0.02267|cPlatformTrainTrain4,847.6,23.44,0.0000|cPlatformTrainTrain4,880.1,22.94,0.0000|cPlatformTrainCar2,864.7,23.63,0.03401|cSwordsMan,866.6,14.13,0.0000|cSoldierPlatformImmobile,884.7,19.63,0.000000000000000001940|cSoldierPlatformImmobile,876.6,15.69,0.0000|cSoldierPlatformImmobile,852.5,20.56,0.0000|cSoldierPlatformImmobile,835.6,14.31,0.0000|cSoldierPlatformImmobile,831.9,14.44,0.0000|cSoldierPlatformImmobile,828.5,14.56,0.0000|cSoldier,816.8,22.38,0.0000|cSoldier,820.9,22.56,0.0000|cAISheller,799.3,14.63,0.0000|cAICopter,943.8,7.500,0.0000|cPlatformTrainTrain2,914.5,24.13,-0.003197|cAISheller,908.1,17.63,0.0000|cCamBlocker,999.8,19.19,0.0000|cDetailPlatformWood,955.4,10.50,0.2731|cAISheller,955.3,9.000,0.0000|cDetailPlatformWood,994.3,11.06,0.4356|cAISheller,994.5,9.750,0.0000|cDetailPlatformWood,930.1,10.25,0.6105|cTank2,959.4,19.75,0.0000|cTank2,943.6,19.75,0.0000|cDetailJeep,880.4,20.00,0.05842|cDetailCanvas,847.1,20.13,0.4491|cTank2,980.6,20.31,0.0000|cAICopter,999.3,3.063,0.0000|";
            _loc3_.levelString = "^,5,48,^,0,0,0,0,0,0,|cCar,709.4,17.88,0.0000|cDetailPlatformWood,736.5,14.06,0.002540|cDetailPlatformWood,739.9,9.188,0.1390|cAISheller,740.3,8.063,0.0000|cAISheller,736.5,13.00,0.0000|cAISheller,733.5,23.94,0.0000|cPlatformTrainCar,753.9,23.13,-0.1432|cDetailBarrel2,780.4,21.13,0.0000|cSoldierPlatformSmall,756.2,13.38,0.0000|cSoldierPlatformImmobile,754.1,19.50,0.0000|cDetailBlocker,798.0,22.56,-0.7350|cDetailPlatformWood,798.4,8.938,0.0000|cDetailPlatformWood,799.8,16.25,-0.2079|cSoldierPlatform,798.3,7.063,0.0000|cPlatformTrainTrain4,789.4,22.63,0.0000|cSoldierPlatformImmobile,786.1,19.38,0.0000|cDetailCar,790.6,20.13,0.0000|cAICopter,789.7,6.000,0.0000|cPlatformTrainCar2,770.4,22.94,-0.1686|cSoldierPlatformImmobile,766.7,13.44,0.0000|cPlatformTrainCar2,832.1,23.75,-0.03475|cDetailCanvas,808.5,23.38,-0.02267|cPlatformTrainTrain4,847.6,23.44,0.0000|cPlatformTrainTrain4,880.1,22.94,0.0000|cPlatformTrainCar2,864.7,23.63,0.03401|cSwordsMan,866.6,14.13,0.0000|cSoldierPlatformImmobile,884.7,19.63,0.000000000000000001940|cSoldierPlatformImmobile,876.6,15.69,0.0000|cSoldierPlatformImmobile,852.5,20.56,0.0000|cSoldierPlatformImmobile,835.6,14.31,0.0000|cSoldierPlatformImmobile,831.9,14.44,0.0000|cSoldierPlatformImmobile,828.5,14.56,0.0000|cSoldier,816.8,22.38,0.0000|cSoldier,820.9,22.56,0.0000|cAISheller,799.3,14.63,0.0000|cAICopter,943.8,7.500,0.0000|cPlatformTrainTrain2,914.5,24.13,-0.003197|cAISheller,908.1,17.63,0.0000|cCamBlocker,999.8,19.19,0.0000|cDetailPlatformWood,955.4,10.50,0.2731|cAISheller,955.3,9.000,0.0000|cDetailPlatformWood,994.3,11.06,0.4356|cAISheller,994.5,9.750,0.0000|cDetailPlatformWood,930.1,10.25,0.6105|cTank2,959.4,19.75,0.0000|cTank2,943.6,19.75,0.0000|cDetailJeep,880.4,20.00,0.05842|cDetailCanvas,847.1,20.13,0.4491|cTank2,980.6,20.31,0.0000|";
            _loc3_.levelString = "^,5,52,^,0,0,0,0,0,0,|cCar,709.4,17.88,0.0000|cDetailPlatformWood,736.5,14.06,0.002540|cDetailPlatformWood,739.9,9.188,0.1390|cAISheller,740.3,8.063,0.0000|cAISheller,736.5,13.00,0.0000|cAISheller,733.9,23.75,0.0000|cPlatformTrainCar,753.9,23.13,-0.1432|cDetailBarrel2,780.4,21.13,0.0000|cSoldierPlatformSmall,756.2,13.38,0.0000|cSoldierPlatformImmobile,754.1,19.50,0.0000|cDetailBlocker,798.0,22.56,-0.7350|cDetailPlatformWood,798.4,8.938,0.0000|cDetailPlatformWood,799.8,16.25,-0.2079|cSoldierPlatform,798.3,7.063,0.0000|cPlatformTrainTrain4,789.4,22.63,0.0000|cSoldierPlatformImmobile,786.1,19.38,0.0000|cDetailCar,790.6,20.13,0.0000|cAICopter,789.7,6.000,0.0000|cPlatformTrainCar2,770.4,22.94,-0.1686|cSoldierPlatformImmobile,766.7,13.44,0.0000|cPlatformTrainCar2,832.1,23.75,-0.03475|cDetailCanvas,808.5,23.38,-0.02267|cPlatformTrainTrain4,847.6,23.44,0.0000|cPlatformTrainTrain4,880.1,22.94,0.0000|cPlatformTrainCar2,864.7,23.63,0.03401|cSwordsMan,866.6,14.13,0.0000|cSoldierPlatformImmobile,884.7,19.63,0.000000000000000001940|cSoldierPlatformImmobile,876.6,15.69,0.0000|cSoldierPlatformImmobile,852.5,20.56,0.0000|cSoldierPlatformImmobile,835.6,14.31,0.0000|cSoldierPlatformImmobile,831.9,14.44,0.0000|cSoldierPlatformImmobile,828.5,14.56,0.0000|cSoldier,816.8,22.38,0.0000|cSoldier,820.9,22.56,0.0000|cAISheller,799.3,14.63,0.0000|cAICopter,943.8,7.500,0.0000|cPlatformTrainTrain2,914.5,24.13,-0.003197|cAISheller,908.1,17.63,0.0000|cCamBlocker,999.8,19.19,0.0000|cDetailPlatformWood,955.4,10.50,0.2731|cAISheller,955.3,9.000,0.0000|cDetailPlatformWood,994.3,11.06,0.4356|cAISheller,994.5,9.750,0.0000|cDetailPlatformWood,930.1,10.25,0.6105|cTank2,943.6,19.75,0.0000|cDetailJeep,880.4,20.00,0.05842|cDetailCanvas,847.1,20.13,0.4491|cTank2,980.6,20.31,0.0000|cCamBlockerMini,746.7,4.625,0.0000|cCamBlockerMini,778.1,4.938,0.0000|cCamBlockerMini,854.1,4.625,0.0000|cCamBlockerMini,915.2,5.125,0.0000|cCamBlockerMini,964.4,3.313,0.0000|";
         }
         if(param1 == LEVEL_6)
         {
            _loc3_.load_image_id = 6;
            _loc3_.load_phys_id = 6;
            _loc3_.levelString = "^,1,4,^,0,0,0,0,0,0,|cCar,800.45,10,-0.1001|X,48.45,10,0.0000|";
            _loc3_.levelString = "^,6,15,^,0,0,0,0,0,0,|cCar,1074,20.69,0.0000|cDetailPlatformWood,1082,8.938,0.002540|cDetailCar,1081,7.188,-0.001468|cPlatformTrainCar,1115,23.56,-0.06518|cPlatformTrainCar,1099,23.69,-0.06507|cAICopter,1160,6.688,0.0000|cAICopter,1167,7.375,0.0000|cSoldierPlatformImmobile,1099,20.25,0.0000|cSoldierPlatformImmobile,1115,20.06,-0.0000000000000003633|cSoldierPlatformSmall,1098,14.13,0.0000|cSoldierPlatformSmall,1101,14.25,0.0000|cSoldierPlatformSmall,1104,14.06,0.0000|cSoldierPlatformSmall,1116,14.13,0.0000|cDetailSandbags,1082,23.25,-0.07362|cAISheller,1089,23.38,0.0000|cAISheller,1120,14.88,0.0000|";
            _loc3_.levelString = "^,6,28,^,0,0,0,0,0,0,|cCar,1074,20.69,0.0000|cDetailPlatformWood,1082,8.938,0.002540|cDetailCar,1081,7.188,-0.001468|cPlatformTrainCar,1115,23.56,-0.06518|cPlatformTrainCar,1099,23.69,-0.06507|cAICopter,1160,6.688,0.0000|cAICopter,1167,7.375,0.0000|cSoldierPlatformImmobile,1099,20.25,0.0000|cSoldierPlatformImmobile,1115,20.06,-0.0000000000000003633|cSoldierPlatformSmall,1098,14.13,0.0000|cSoldierPlatformSmall,1101,14.25,0.0000|cSoldierPlatformSmall,1104,14.06,0.0000|cSoldierPlatformSmall,1116,14.13,0.0000|cDetailSandbags,1082,23.25,-0.07362|cAISheller,1089,23.38,0.0000|cAISheller,1120,14.94,0.0000|cAISheller,1175,23.81,0.0000|cAISheller,1181,23.19,0.0000|cAISheller,1195,19.38,0.0000|cAISheller,1191,19.56,0.0000|cPlatformTrainTrain,1193,22.88,0.006590|cDetailPlatform,1265,15.63,0.0000|cTank,1213,21.56,0.0000|cTank4,1156,21.44,0.0000|cTank4,1227,22.13,0.0000|cAISheller,1250,23.50,0.0000|cDetailSandbags,1243,24.00,-0.0000000000000007324|cAICopter,1253,4.750,0.0000|cCamBlocker,1253,20.38,0.0000|";
            _loc3_.levelString = "^,6,28,^,0,0,0,0,0,0,|cCar,1074,20.69,0.0000|cDetailPlatformWood,1082,8.938,0.002540|cDetailCar,1081,7.188,-0.001468|cPlatformTrainCar,1115,23.56,-0.06518|cPlatformTrainCar,1099,23.69,-0.06507|cAICopter,1160,6.688,0.0000|cAICopter,1167,7.375,0.0000|cSoldierPlatformImmobile,1099,20.25,0.0000|cSoldierPlatformImmobile,1115,20.06,-0.0000000000000003633|cSoldierPlatformSmall,1098,14.13,0.0000|cSoldierPlatformSmall,1101,14.25,0.0000|cSoldierPlatformSmall,1104,14.06,0.0000|cSoldierPlatformSmall,1116,14.13,0.0000|cDetailSandbags,1082,23.25,-0.07362|cAISheller,1089,23.38,0.0000|cAISheller,1120,14.94,0.0000|cAISheller,1175,23.81,0.0000|cAISheller,1181,23.19,0.0000|cAISheller,1195,19.38,0.0000|cAISheller,1191,19.56,0.0000|cPlatformTrainTrain,1193,22.88,0.006590|cDetailPlatform,1265,15.63,0.0000|cTank,1213,21.56,0.0000|cTank4,1156,21.44,0.0000|cTank4,1227,22.13,0.0000|cAISheller,1250,23.50,0.0000|cDetailSandbags,1243,24.00,-0.0000000000000007324|cCamBlocker,1253,20.38,0.0000|cAICopter,1241,6.000,0.0000|";
            _loc3_.levelString = "^,6,28,^,0,0,0,0,0,0,|cCar,1074,20.69,0.0000|cDetailPlatformWood,1082,8.938,0.002540|cDetailCar,1081,7.188,-0.001468|cPlatformTrainCar,1115,23.56,-0.06518|cPlatformTrainCar,1099,23.69,-0.06507|cAICopter,1160,6.688,0.0000|cAICopter,1167,7.375,0.0000|cSoldierPlatformImmobile,1099,20.25,0.0000|cSoldierPlatformImmobile,1115,20.06,-0.0000000000000003633|cSoldierPlatformSmall,1098,14.13,0.0000|cSoldierPlatformSmall,1101,14.25,0.0000|cSoldierPlatformSmall,1104,14.06,0.0000|cSoldierPlatformSmall,1116,14.13,0.0000|cDetailSandbags,1082,23.25,-0.07362|cAISheller,1089,23.38,0.0000|cAISheller,1120,14.94,0.0000|cAISheller,1175,23.81,0.0000|cAISheller,1181,23.19,0.0000|cAISheller,1195,19.38,0.0000|cAISheller,1191,19.56,0.0000|cPlatformTrainTrain,1193,22.88,0.006590|cTank,1213,21.56,0.0000|cTank4,1156,21.44,0.0000|cTank4,1227,22.13,0.0000|cAISheller,1250,23.50,0.0000|cDetailSandbags,1243,24.00,-0.0000000000000007324|cCamBlocker,1253,20.38,0.0000|cAICopter,1241,6.000,0.0000|cDetailPlatform,1266,24.13,0.0000|";
            _loc3_.levelString = "^,6,30,^,0,0,0,0,0,0,|cCar,1074,21.25,0.0000|cDetailPlatformWood,1082,8.938,0.002540|cDetailCar,1081,7.188,-0.001468|cPlatformTrainCar,1115,23.56,-0.06518|cPlatformTrainCar,1099,23.69,-0.06507|cAICopter,1160,6.688,0.0000|cSoldierPlatformImmobile,1099,20.25,0.0000|cSoldierPlatformImmobile,1115,20.06,-0.0000000000000003633|cSoldierPlatformSmall,1098,14.13,0.0000|cSoldierPlatformSmall,1101,14.25,0.0000|cSoldierPlatformSmall,1104,14.06,0.0000|cSoldierPlatformSmall,1116,14.13,0.0000|cDetailSandbags,1082,23.25,-0.07362|cAISheller,1089,23.38,0.0000|cAISheller,1120,14.94,0.0000|cAISheller,1175,23.81,0.0000|cAISheller,1181,23.19,0.0000|cAISheller,1195,19.38,0.0000|cAISheller,1191,19.56,0.0000|cPlatformTrainTrain,1193,22.88,0.006590|cTank,1213,21.56,0.0000|cTank4,1156,21.44,0.0000|cTank4,1227,22.13,0.0000|cAISheller,1250,23.50,0.0000|cDetailSandbags,1243,24.00,-0.0000000000000007324|cCamBlocker,1253,20.38,0.0000|cAICopter,1241,6.000,0.0000|cDetailPlatform,1266,24.13,0.0000|cCamBlockerMini,1126,7.188,0.0000|cCamBlockerMini,1201,5.813,0.0000|";
         }
         if(param1 == LEVEL_7)
         {
            _loc3_.load_image_id = 7;
            _loc3_.load_phys_id = 7;
            _loc3_.levelString = "^,7,16,^,0,0,0,0,0,0,|cCar,1245,21.06,0.0000|cDetailPlatform,1291,23.00,0.0000|cDetailPlatform,1268,22.94,0.0000|cAISheller,1268,22.00,0.0000|cAISheller,1292,22.00,0.0000|cDetailBigassBombs,1384,23.18,0.0000|cDetailBigassBombs,1372,24.38,-0.00009984|cDetailBigassBombs,1373,18.13,-0.009524|cDetailBigassBombs,1379,23.50,0.07800|cHitler,1373,9.875,0.0000|cCamBlocker,1374,2.563,0.0000|cDetailBigassBombs,1377,10.75,0.09014|cDetailBigassBombs,1366,24.25,0.000000000000001003|cDetailBigassBombs,1378,16.81,0.004589|cDetailBigassBombs,1384,17.19,-0.003481|cDetailBigassBombs,1384,11.50,0.04349|cDetailBigassBombs,1381,5.188,0.1735|";
            _loc3_.levelString = "^,7,18,^,0,0,0,0,0,0,|cCar,1245,21.06,0.0000|cDetailBigassBombs,1384,23.18,0.0000|cDetailBigassBombs,1372,24.38,-0.00009984|cDetailBigassBombs,1373,18.13,-0.009524|cDetailBigassBombs,1379,23.50,0.07800|cHitler,1373,9.875,0.0000|cCamBlocker,1374,2.563,0.0000|cDetailBigassBombs,1377,10.75,0.09014|cDetailBigassBombs,1366,24.25,0.000000000000001003|cDetailBigassBombs,1378,16.81,0.004589|cDetailBigassBombs,1384,17.19,-0.003481|cDetailBigassBombs,1384,11.50,0.04349|cDetailBigassBombs,1381,5.188,0.1735|cDetailPlatform,1265,24.06,0.0000|cAISheller,1265,23.19,0.0000|cDetailPlatform,1280,24.06,0.0000|cAISheller,1279,23.13,0.0000|cDetailPlatform,1297,24.00,0.0000|cAISheller,1298,23.06,0.0000|";
            _loc3_.levelString = "^,7,18,^,0,0,0,0,0,0,|cCar,1245,21.06,0.0000|cDetailBigassBombs,1384,23.18,0.0000|cDetailBigassBombs,1372,24.38,-0.00009984|cDetailBigassBombs,1373,18.13,-0.009524|cDetailBigassBombs,1379,23.50,0.07800|cHitler,1373,9.875,0.0000|cDetailBigassBombs,1377,10.75,0.09014|cDetailBigassBombs,1366,24.25,0.000000000000001003|cDetailBigassBombs,1378,16.81,0.004589|cDetailBigassBombs,1384,17.19,-0.003481|cDetailBigassBombs,1384,11.50,0.04349|cDetailBigassBombs,1381,5.188,0.1735|cDetailPlatform,1265,24.06,0.0000|cAISheller,1265,23.19,0.0000|cDetailPlatform,1280,24.06,0.0000|cAISheller,1279,23.13,0.0000|cDetailPlatform,1297,24.00,0.0000|cAISheller,1298,23.06,0.0000|cCamBlocker,1386,3.125,0.0000|";
            _loc3_.levelString = "^,7,18,^,0,0,0,0,0,0,|cCar,1245,21.06,0.0000|cDetailBigassBombs,1384,23.18,0.0000|cDetailBigassBombs,1372,24.38,-0.00009984|cDetailBigassBombs,1373,18.13,-0.009524|cDetailBigassBombs,1379,23.50,0.07800|cDetailBigassBombs,1377,10.75,0.09014|cDetailBigassBombs,1366,24.25,0.000000000000001003|cDetailBigassBombs,1378,16.81,0.004589|cDetailBigassBombs,1384,17.19,-0.003481|cDetailBigassBombs,1384,11.50,0.04349|cDetailBigassBombs,1381,5.188,0.1735|cDetailPlatform,1265,24.06,0.0000|cAISheller,1265,23.19,0.0000|cDetailPlatform,1280,24.06,0.0000|cAISheller,1279,23.13,0.0000|cDetailPlatform,1297,24.00,0.0000|cAISheller,1298,23.06,0.0000|cCamBlocker,1386,3.125,0.0000|cHitler,1360,21.88,0.0000|";
            _loc3_.levelString = "^,7,18,^,0,0,0,0,0,0,|cCar,1245,21.06,0.0000|cDetailBigassBombs,1372,24.38,-0.00009984|cDetailPlatform,1265,24.06,0.0000|cAISheller,1265,23.19,0.0000|cDetailPlatform,1280,24.06,0.0000|cAISheller,1279,23.13,0.0000|cDetailPlatform,1297,24.00,0.0000|cAISheller,1298,23.06,0.0000|cCamBlocker,1386,3.125,0.0000|cHitler,1360,21.88,0.0000|cDetailBigassBombs,1372,18.56,-0.01944|cDetailBigassBombs,1371,12.63,-0.07084|cDetailBigassBombs,1378,24.94,-0.00000001442|cDetailBigassBombs,1378,19.38,-0.01344|cDetailBigassBombs,1377,13.50,-0.003871|cDetailBigassBombs,1384,24.19,-0.00000007956|cDetailBigassBombs,1383,18.75,-0.01579|cDetailBigassBombs,1383,12.94,-0.007936|cDetailBigassBombs,1381,7.875,-0.009524|";
         }
         if(param1 == LEVEL_8)
         {
            _loc3_.load_image_id = 8;
            _loc3_.load_phys_id = 8;
            _loc3_.levelString = "^,8,29,^,0,0,0,0,0,0,|cCar,1248,15.06,0.0000|cPlatformTrainCar,1115,23.56,-0.06518|cPlatformTrainCar,1099,23.69,-0.06507|cSoldierPlatformImmobile,1099,20.25,0.0000|cSoldierPlatformImmobile,1115,20.06,-0.0000000000000003633|cSoldierPlatformSmall,1098,14.13,0.0000|cSoldierPlatformSmall,1101,14.25,0.0000|cSoldierPlatformSmall,1104,14.06,0.0000|cSoldierPlatformSmall,1116,14.13,0.0000|cDetailSandbags,1082,23.25,-0.07362|cAIShellerLeft,1195,19.56,0.0000|cAIShellerLeft,1191,19.56,0.0000|cPlatformTrainTrain,1192,24.00,0.00004712|cAIShellerLeft,1203,23.50,0.0000|cTank,1211,23.25,0.0000|cAIShellerLeft,1180,23.56,0.0000|cAIShellerLeft,1172,23.19,0.0000|cAICopter,1226,6.063,0.0000|cCamBlockerMini,1215,12.06,0.0000|cDetailSandbags,1231,24.63,-0.000000000000001242|cAICopter,1157,7.000,0.0000|cAICopter,1141,6.875,0.0000|cCamBlockerMini,1127,8.500,0.0000|cCamBlockerMini,1170,10.31,0.0000|cAIShellerLeft,1088,23.56,0.0000|cAIShellerLeft,1120,14.88,0.0000|cAIShellerLeft,1075,23.31,0.0000|cAIShellerLeft,1069,23.56,0.0000|cAIShellerLeft,1064,23.56,0.0000|cCamBlocker,1053,10.81,0.0000|";
            _loc3_.goingLeft = true;
         }
         if(param1 == LEVEL_9)
         {
            _loc3_.load_image_id = 4;
            _loc3_.load_phys_id = 4;
            _loc3_.levelString = "^,3,10,^,0,0,0,0,0,0,|cCar,16.8,14.08,X|X,176.2,18.78|X,229.4,18.71|X,461.9,16.40|X,497.5,25.84|cCarryable,7.204,14.19,0.0000|cCarryable,3.451,12.39,0.0000|cCarryable,4.688,13.95,0.0000|cCarryable,5.437,12.39,0.0000|cCarryable,7.375,12.33,0.0000|";
            _loc3_.levelString = "^,5,48,^,0,0,0,0,0,0,|cCar,709.4,17.88,0.0000|cDetailPlatformWood,736.5,14.06,0.002540|cDetailPlatformWood,739.9,9.188,0.1390|cAISheller,740.3,8.063,0.0000|cAISheller,736.5,13.00,0.0000|cAISheller,733.5,23.94,0.0000|cPlatformTrainCar,753.9,23.13,-0.1432|cDetailBarrel2,780.4,21.13,0.0000|cSoldierPlatformSmall,756.2,13.38,0.0000|cSoldierPlatformImmobile,754.1,19.50,0.0000|cDetailBlocker,798.0,22.56,-0.7350|cDetailPlatformWood,798.4,8.938,0.0000|cDetailPlatformWood,799.8,16.25,-0.2079|cSoldierPlatform,798.3,7.063,0.0000|cPlatformTrainTrain4,789.4,22.63,0.0000|cSoldierPlatformImmobile,786.1,19.38,0.0000|cDetailCar,790.6,20.13,0.0000|cAICopter,789.7,6.000,0.0000|cPlatformTrainCar2,770.4,22.94,-0.1686|cSoldierPlatformImmobile,766.7,13.44,0.0000|cPlatformTrainCar2,832.1,23.75,-0.03475|cDetailCanvas,808.5,23.38,-0.02267|cPlatformTrainTrain4,847.6,23.44,0.0000|cPlatformTrainTrain4,880.1,22.94,0.0000|cPlatformTrainCar2,864.7,23.63,0.03401|cSwordsMan,866.6,14.13,0.0000|cSoldierPlatformImmobile,884.7,19.63,0.000000000000000001940|cSoldierPlatformImmobile,876.6,15.69,0.0000|cSoldierPlatformImmobile,852.5,20.56,0.0000|cSoldierPlatformImmobile,835.6,14.31,0.0000|cSoldierPlatformImmobile,831.9,14.44,0.0000|cSoldierPlatformImmobile,828.5,14.56,0.0000|cSoldier,816.8,22.38,0.0000|cSoldier,820.9,22.56,0.0000|cAISheller,799.3,14.63,0.0000|cAICopter,943.8,7.500,0.0000|cPlatformTrainTrain2,914.5,24.13,-0.003197|cAISheller,908.1,17.63,0.0000|cCamBlocker,999.8,19.19,0.0000|cDetailPlatformWood,955.4,10.50,0.2731|cAISheller,955.3,9.000,0.0000|cDetailPlatformWood,994.3,11.06,0.4356|cAISheller,994.5,9.750,0.0000|cDetailPlatformWood,930.1,10.25,0.6105|cTank2,959.4,19.75,0.0000|cTank2,943.6,19.75,0.0000|cDetailJeep,880.4,20.00,0.05842|cDetailCanvas,847.1,20.13,0.4491|cTank2,980.6,20.31,0.0000|";
            _loc3_.levelString = "^,4,22,^,0,0,0,0,0,0,|cCar,554.9,14.50,0.0000|cAISheller,577.1,15.38,0.0000|cAISheller,584.2,17.00,0.0000|cDetailSandbags,569.9,13.43,0.000000000000000007329|cDetailSandbags,590.2,16.88,0.0000|cDetailBarrel,595.3,15.28,0.0000|cSoldierIdle,580.3,15.10,0.0000000000000000005473|cSoldierIdleRight,584.8,15.75,0.0000|cSoldierIdleRight,630.1,12.25,0.0000|cAISheller,656.9,12.81,0.0000|cAISheller,665.2,15.38,0.0000|cTank3,677.8,16.00,0.0000|cCamBlocker,701.9,15.56,0.0000|cDetailJeep,618.7,13.06,-0.8081|cSoldierIdleRight,636.1,12.19,0.0000|cSoldierIdleRight,640.4,13.38,0.0000|cSoldierIdleRight,643.9,14.56,0.0000|cSoldierIdleRight,647.4,15.81,0.0000|cSoldierIdle,627.3,12.19,-0.0000000000000000006246|cSoldierIdleRight,608.8,13.38,-0.0000000000000000005716|cSoldierIdle,605.1,14.56,-0.000000000000000001090|cDetailBarrel,599.3,14.06,0.1050|cDetailBarrel,600.3,9.125,-0.1372|";
            _loc3_.levelString = "^,4,39,^,0,0,0,0,0,0,|cCar,769.8,21.81,0.0000|cAISheller,577.1,15.38,0.0000|cAISheller,584.2,17.00,0.0000|cDetailSandbags,569.9,13.43,0.000000000000000007329|cDetailSandbags,590.2,16.88,0.0000|cDetailBarrel,595.3,15.28,0.0000|cSoldierIdle,580.3,15.10,0.0000000000000000005473|cSoldierIdleRight,584.8,15.75,0.0000|cSoldierIdleRight,630.1,12.25,0.0000|cAISheller,656.9,12.81,0.0000|cAISheller,665.2,15.38,0.0000|cTank3,677.8,16.00,0.0000|cDetailJeep,618.7,13.06,-0.8081|cSoldierIdleRight,636.1,12.19,0.0000|cSoldierIdleRight,640.4,13.38,0.0000|cSoldierIdleRight,643.9,14.56,0.0000|cSoldierIdleRight,647.4,15.81,0.0000|cSoldierIdle,627.3,12.19,-0.0000000000000000006246|cSoldierIdleRight,608.8,13.38,-0.0000000000000000005716|cSoldierIdle,605.1,14.56,-0.000000000000000001090|cDetailBarrel,599.3,14.06,0.1050|cDetailBarrel,600.3,9.125,-0.1372|cDetailJeep,747.4,23.75,0.00002758|cCamBlockerMini,726.8,6.563,0.0000|cDetailSandbags,736.1,23.56,0.0000000005596|cAIShellerLeft,740.8,5.125,0.0000|cAIShellerLeft,734.4,9.438,0.0000|cDetailPlatformWood,733.8,10.88,0.002540|cDetailBarrel2,733.8,14.06,0.0000|cAIShellerLeft,737.8,15.69,0.0000|cDetailPlatformWood,735.3,17.50,0.0000|cAIShellerLeft,730.1,23.13,0.0000|cAIShellerLeft,708.3,19.38,0.0000|cAIShellerLeft,712.9,19.50,0.0000|cAIShellerLeft,717.6,19.75,0.0000|cDetailPlatformWood,740.5,6.625,0.1075|cAIShellerLeft,712.6,8.125,0.0000|cDetailPlatformWood,712.6,9.438,0.002540|cDetailBarrel,690.7,18.56,-0.1974|";
            _loc3_.levelString = "^,4,45,^,0,0,0,0,0,0,|cCar,769.9,22.31,0.0000|cAISheller,577.1,15.38,0.0000|cAISheller,584.2,17.00,0.0000|cDetailSandbags,569.9,13.43,0.000000000000000007329|cDetailSandbags,590.2,16.88,0.0000|cDetailBarrel,595.3,15.28,0.0000|cSoldierIdle,580.3,15.10,0.0000000000000000005473|cSoldierIdleRight,584.8,15.75,0.0000|cSoldierIdleRight,630.1,12.25,0.0000|cAISheller,656.9,12.81,0.0000|cAISheller,665.2,15.38,0.0000|cTank3,677.8,16.00,0.0000|cDetailJeep,618.7,13.06,-0.8081|cSoldierIdleRight,636.1,12.19,0.0000|cSoldierIdleRight,640.4,13.38,0.0000|cSoldierIdleRight,643.9,14.56,0.0000|cSoldierIdleRight,647.4,15.81,0.0000|cSoldierIdle,627.3,12.19,-0.0000000000000000006246|cSoldierIdleRight,608.8,13.38,-0.0000000000000000005716|cSoldierIdle,605.1,14.56,-0.000000000000000001090|cDetailBarrel,599.3,14.06,0.1050|cDetailBarrel,600.3,9.125,-0.1372|cDetailJeep,747.4,23.75,0.00002758|cCamBlockerMini,726.9,6.688,0.0000|cDetailSandbags,736.1,23.56,0.0000000005596|cAIShellerLeft,740.8,5.125,0.0000|cAIShellerLeft,734.4,9.438,0.0000|cDetailPlatformWood,733.8,10.88,0.002540|cDetailBarrel2,733.8,14.06,0.0000|cAIShellerLeft,737.8,15.69,0.0000|cDetailPlatformWood,735.3,17.50,0.0000|cAIShellerLeft,730.1,23.13,0.0000|cAIShellerLeft,708.3,19.38,0.0000|cAIShellerLeft,712.9,19.50,0.0000|cAIShellerLeft,717.6,19.75,0.0000|cDetailPlatformWood,740.5,6.625,0.1075|cAIShellerLeft,712.6,8.125,0.0000|cDetailPlatformWood,712.6,9.438,0.002540|cDetailBarrel,690.7,18.56,-0.1974|cCamBlockerMini,652.5,2.563,0.0000|cAICopter,566.7,3.750,0.0000|cSoldierIdle,521.8,18.44,0.0000|cSoldierIdleRight,526.1,18.56,0.0000|cCamBlockerMini,552.9,2.688,0.0000|cCamBlocker,507.8,8.625,0.0000|";
            _loc3_.goingLeft = true;
         }
         if(param1 == LEVEL_10)
         {
            _loc3_.load_image_id = 6;
            _loc3_.load_phys_id = 6;
            _loc3_.levelString = "^,3,28,^,0,0,0,0,0,0,|cCar,383.4,18.25,0.0000|cAICopter,410.1,5.375,0.0000|cAICopter,428.3,5.938,0.0000|cAISheller,410.0,19.44,0.0000|cDetailBarrel,403.9,17.81,0.0000|cAISheller,437.8,24.00,0.0000|cDetailPlatformWood,445.8,7.688,0.008451|cDetailPlatformWood,459.1,12.25,0.6739|cDetailPlatformWood,450.4,13.88,0.5025|cDetailSandbags,442.3,19.13,0.0000|cSoldierIdle,451.8,12.00,0.0000|cSoldierIdleRight,459.1,9.938,0.0000|cSoldierIdleRight,445.3,5.563,0.0000|cDetailBarrel2,448.9,9.938,0.03702|cSoldierIdleRight,463.8,17.88,0.0000|cDetailBarrel2,475.7,17.44,0.0000|cDetailBarrel2,479.8,17.31,0.0000|cDetailBarrel2,483.6,17.06,0.0000|cDetailBarrel2,477.7,12.56,0.0000000000000001410|cDetailBarrel2,479.8,7.813,1.571|cDetailBarrel2,481.3,12.31,-0.02696|cDetailBarrel,400.3,17.50,0.0000|cTank4,499.2,17.94,0.0000|cTank4,528.2,17.94,0.0000|cCamBlocker,540.3,17.88,0.0000|cSoldierPlatformImmobile,508.6,5.375,0.0000|cDetailPlatformWood,508.4,7.750,0.008451|cDetailBlocker,421.8,19.25,-0.4568|cDetailPlatformWood,424.1,12.13,-0.2079|";
            _loc3_.levelString = "^,6,38,^,0,0,0,0,0,0,|cCar,512.8,17.69,-0.00000000000004096|cAICopter,410.1,5.375,0.0000|cAICopter,428.3,5.938,0.0000|cAISheller,410.0,19.44,0.0000|cDetailPlatformWood,445.8,7.688,0.008451|cDetailPlatformWood,459.1,12.25,0.6739|cSoldierIdle,451.8,12.00,0.0000|cSoldierIdleRight,459.1,9.938,0.0000|cSoldierIdleRight,445.3,5.563,0.0000|cDetailBarrel2,448.9,9.938,0.03702|cSoldierIdleRight,463.6,18.77,0.0000|cDetailBarrel2,475.7,17.44,0.0000|cDetailBarrel2,479.8,17.31,0.0000|cDetailBarrel2,477.7,12.56,0.0000000000000001410|cDetailBarrel,400.3,17.50,0.0000|cTank4,528.2,17.94,0.0000|cDetailPlatformWood,424.1,12.13,-0.2079|cSoldierPlatformImmobile,496.4,2.438,0.0000|cDetailPlatformWood,496.4,4.500,0.0000|cTank4,469.1,17.50,-0.00000000000001497|cDetailPlatformWood,491.2,9.250,0.3269|cDetailPlatformWood,502.1,11.50,0.002540|cSoldierPlatformImmobile,504.1,9.313,0.0000|cAIShellerLeft,500.3,10.31,0.0000|cAIShellerLeft,490.3,7.500,0.0000|cDetailBarrel2,483.4,17.63,0.0000|cDetailBarrel2,481.6,12.63,0.002002|cAIShellerLeft,432.9,23.00,0.0000|cAIShellerLeft,438.9,24.69,0.0000|cDetailSandbags,428.5,19.19,-0.04227|cDetailPlatformWood,462.6,7.063,0.3331|cSoldierIdleRight,462.0,4.563,0.00000000000005671|cDetailPlatformWood,450.7,13.94,0.0000|cDetailPlatformWood,443.1,11.06,0.3244|cDetailBarrel,403.8,17.56,-0.04706|cDetailBarrel,385.0,19.06,-0.2450|cCamBlockerMini,475.1,2.938,0.0000|cCamBlockerMini,440.8,2.375,0.0000|cCamBlockerMini,380.1,2.250,0.0000|";
            _loc3_.levelString = "^,6,37,^,0,0,0,0,0,0,|cCar,512.8,17.69,-0.00000000000004096|cAICopter,410.1,5.375,0.0000|cAICopter,428.3,5.938,0.0000|cDetailPlatformWood,445.8,7.688,0.008451|cDetailPlatformWood,459.1,12.25,0.6739|cSoldierIdle,451.8,12.00,0.0000|cSoldierIdleRight,459.1,9.938,0.0000|cSoldierIdleRight,445.3,5.563,0.0000|cDetailBarrel2,448.9,9.938,0.03702|cSoldierIdleRight,463.6,18.77,0.0000|cDetailBarrel2,475.7,17.44,0.0000|cDetailBarrel2,479.8,17.31,0.0000|cDetailBarrel2,477.7,12.56,0.0000000000000001410|cDetailBarrel,400.3,17.50,0.0000|cDetailPlatformWood,424.1,12.13,-0.2079|cSoldierPlatformImmobile,496.4,2.438,0.0000|cDetailPlatformWood,496.4,4.500,0.0000|cTank4,469.1,17.50,-0.00000000000001497|cDetailPlatformWood,491.2,9.250,0.3269|cDetailPlatformWood,502.1,11.50,0.002540|cSoldierPlatformImmobile,504.1,9.313,0.0000|cAIShellerLeft,500.3,10.31,0.0000|cAIShellerLeft,490.3,7.500,0.0000|cDetailBarrel2,483.4,17.63,0.0000|cDetailBarrel2,481.6,12.63,0.002002|cAIShellerLeft,432.9,23.00,0.0000|cAIShellerLeft,438.9,24.69,0.0000|cDetailSandbags,428.5,19.19,-0.04227|cDetailPlatformWood,462.6,7.063,0.3331|cSoldierIdleRight,462.0,4.563,0.00000000000005671|cDetailPlatformWood,450.7,13.94,0.0000|cDetailPlatformWood,443.1,11.06,0.3244|cDetailBarrel,403.8,17.56,-0.04706|cDetailBarrel,385.0,19.06,-0.2450|cCamBlockerMini,475.1,2.938,0.0000|cCamBlockerMini,440.8,2.375,0.0000|cCamBlockerMini,380.1,2.250,0.0000|cAIShellerLeft,410.6,19.25,0.0000|";
            _loc3_.levelString = "^,6,40,^,0,0,0,0,0,0,|cCar,512.8,17.69,-0.00000000000004096|cAICopter,427.6,6.375,0.0000|cDetailPlatformWood,445.8,7.688,0.008451|cDetailPlatformWood,459.1,12.25,0.6739|cSoldierIdle,451.8,12.00,0.0000|cSoldierIdleRight,459.1,9.938,0.0000|cSoldierIdleRight,445.3,5.563,0.0000|cDetailBarrel2,448.9,9.938,0.03702|cSoldierIdleRight,463.6,18.77,0.0000|cDetailBarrel2,475.7,17.44,0.0000|cDetailBarrel2,479.8,17.31,0.0000|cDetailBarrel2,477.7,12.56,0.0000000000000001410|cDetailBarrel,400.5,17.66,0.0000|cDetailPlatformWood,424.1,12.13,-0.2079|cSoldierPlatformImmobile,496.4,2.438,0.0000|cDetailPlatformWood,496.4,4.500,0.0000|cTank4,469.1,17.50,-0.00000000000001497|cDetailPlatformWood,491.2,9.250,0.3269|cDetailPlatformWood,502.1,11.50,0.002540|cSoldierPlatformImmobile,504.1,9.313,0.0000|cAIShellerLeft,500.3,10.31,0.0000|cAIShellerLeft,490.3,7.500,0.0000|cDetailBarrel2,483.4,17.63,0.0000|cDetailBarrel2,481.6,12.63,0.002002|cAIShellerLeft,432.9,23.00,0.0000|cAIShellerLeft,438.9,24.69,0.0000|cDetailSandbags,428.5,19.19,-0.04227|cDetailPlatformWood,462.6,7.063,0.3331|cSoldierIdleRight,462.0,4.563,0.00000000000005671|cDetailPlatformWood,450.7,13.94,0.0000|cDetailPlatformWood,443.1,11.06,0.3244|cDetailBarrel,403.8,17.56,-0.04706|cDetailBarrel,385.0,19.06,-0.2450|cCamBlockerMini,475.1,2.938,0.0000|cCamBlockerMini,440.8,2.375,0.0000|cAIShellerLeft,410.6,19.25,0.0000|cAICopter,436.4,6.688,0.0000|cAICopter,408.7,5.625,0.0000|cAICopter,399.8,4.188,0.0000|cCamBlocker,379.3,2.938,0.0000|cTank3,392.9,17.19,0.0000|";
            _loc3_.levelString = "^,6,40,^,0,0,0,0,0,0,|cCar,512.8,17.69,-0.00000000000004096|cAICopter,427.6,6.375,0.0000|cDetailPlatformWood,445.8,7.688,0.008451|cDetailPlatformWood,459.1,12.25,0.6739|cSoldierIdle,451.8,12.00,0.0000|cSoldierIdleRight,459.1,9.938,0.0000|cSoldierIdleRight,445.3,5.563,0.0000|cDetailBarrel2,448.9,9.938,0.03702|cSoldierIdleRight,463.6,18.77,0.0000|cDetailBarrel2,475.7,17.44,0.0000|cDetailBarrel2,479.8,17.31,0.0000|cDetailBarrel2,477.7,12.56,0.0000000000000001410|cDetailBarrel,400.5,17.66,0.0000|cDetailPlatformWood,424.1,12.13,-0.2079|cSoldierPlatformImmobile,496.4,2.438,0.0000|cDetailPlatformWood,496.4,4.500,0.0000|cTank4,469.1,17.50,-0.00000000000001497|cDetailPlatformWood,491.2,9.250,0.3269|cDetailPlatformWood,502.1,11.50,0.002540|cSoldierPlatformImmobile,504.1,9.313,0.0000|cAIShellerLeft,500.3,10.31,0.0000|cAIShellerLeft,490.3,7.500,0.0000|cDetailBarrel2,483.4,17.63,0.0000|cDetailBarrel2,481.6,12.63,0.002002|cAIShellerLeft,432.9,23.00,0.0000|cAIShellerLeft,438.9,24.69,0.0000|cDetailSandbags,428.5,19.19,-0.04227|cDetailPlatformWood,462.6,7.063,0.3331|cSoldierIdleRight,462.0,4.563,0.00000000000005671|cDetailPlatformWood,450.7,13.94,0.0000|cDetailPlatformWood,443.1,11.06,0.3244|cDetailBarrel,403.8,17.56,-0.04706|cDetailBarrel,385.0,19.06,-0.2450|cCamBlockerMini,475.1,2.938,0.0000|cCamBlockerMini,440.8,2.375,0.0000|cAIShellerLeft,410.6,19.25,0.0000|cAICopter,436.4,6.688,0.0000|cAICopter,408.7,5.625,0.0000|cAICopter,399.8,4.188,0.0000|cTank3,392.9,17.19,0.0000|cCamBlocker,387.5,3.313,0.0000|";
            _loc3_.goingLeft = true;
         }
         if(param1 == LEVEL_11)
         {
            _loc3_.load_image_id = 5;
            _loc3_.load_phys_id = 5;
            _loc3_.levelString = "^,3,10,^,0,0,0,0,0,0,|cCar,16.8,14.08,X|X,176.2,18.78|X,229.4,18.71|X,461.9,16.40|X,497.5,25.84|cCarryable,7.204,14.19,0.0000|cCarryable,3.451,12.39,0.0000|cCarryable,4.688,13.95,0.0000|cCarryable,5.437,12.39,0.0000|cCarryable,7.375,12.33,0.0000|";
            _loc3_.levelString = "^,5,8,^,0,0,0,0,0,0,|cCar,16.8,14.08,X|cCarryable,7.204,14.19,0.0000|cCarryable,3.451,12.39,0.0000|cCarryable,4.688,13.95,0.0000|cCarryable,5.437,12.39,0.0000|cCarryable,7.375,12.33,0.0000|cMMTCollector,487.5,25.94|cSlowSign,437.5,25.94|cMMTKiller,198.2,26.91|";
            _loc3_.levelString = "^,1,50,^,0,0,0,0,0,0,|cCar,312.1,13.38,0.0000|cCamBlockerMini,149.6,1.813,0.0000|cSoldierPlatformImmobile,153.3,7.250,0.0000|cAIShellerLeft,149.6,20.69,0.0000|cAIShellerLeft,156.4,19.75,0.0000|cSoldier,124.7,14.19,0.0000|cSoldier,128.8,14.38,0.0000|cSoldier,132.2,14.19,0.0000|cSoldier,136.2,14.88,0.0000|cCamBlockerMini,114.5,3.063,0.0000|cSoldier,115.1,17.38,0.0000|cTank,94.25,13.13,0.0000|cTank,105.3,15.13,0.0000|cTank,81.81,14.44,0.0000|cDetailSandbags,65.13,19.56,-0.0002930|cAIShellerLeft,57.81,19.00,0.0000|cAICopter,72.69,6.688,0.0000|cCamBlockerMini,55.63,1.313,0.0000|cDetailPlatformWood,153.1,9.313,0.5666|cDetailPlatformWood,211.0,6.000,0.002540|cDetailSandbags,224.9,14.86,0.0000|cSoldierIdle,213.0,13.15,0.0000|cSoldierIdleRight,218.3,13.94,0.0000000000000000001534|cSoldierIdle,208.3,12.56,0.0000|cSoldierIdle,204.2,12.44,0.0000|cSoldierIdle,209.5,3.750,0.0000|cSoldierIdle,213.3,3.688,0.0000|cSoldierIdleRight,226.9,3.500,0.0000|cDetailJeep,187.7,10.31,0.2261|cSoldierPlatformImmobile,187.3,6.063,0.00000000000007795|cSoldierIdleRight,232.6,14.50,0.0000|cDetailPlatformWood,242.1,6.313,0.3518|cAIShellerLeft,239.9,4.688,0.0000|cAIShellerLeft,243.9,4.625,0.0000|cAIShellerLeft,240.1,15.31,0.0000|cSoldier,254.5,14.63,0.0000|cSoldier,259.0,14.38,0.0000|cSoldier,262.9,14.77,0.0000|cAICopter,259.1,3.063,0.0000|cCamBlockerMini,179.3,1.313,0.0000|cCamBlockerMini,235.6,1.375,0.0000|cDetailSandbags,247.7,15.38,-0.009656|cDetailSandbags,283.8,15.56,0.00000003975|cAIShellerLeft,273.0,15.44,0.0000|cCamBlockerMini,270.8,1.813,0.0000|cDetailPlatformWood,226.6,5.563,0.2364|cDetailBarrel2,274.5,2.750,0.0000|cDetailBarrel2,278.3,2.750,0.0000|cDetailPlatformWood,276.0,5.875,0.2016|cAIShellerLeft,277.4,15.63,0.0000|cSoldierIdleRight,288.4,15.25,0.0000|";
            _loc3_.levelString = "^,5,52,^,0,0,0,0,0,0,|cCar,311.9,14.25,0.0000|cCamBlockerMini,149.6,1.813,0.0000|cSoldierPlatformImmobile,153.3,7.250,0.0000|cAIShellerLeft,149.6,20.69,0.0000|cAIShellerLeft,156.4,19.75,0.0000|cSoldier,124.7,14.19,0.0000|cSoldier,128.8,14.38,0.0000|cSoldier,132.2,14.19,0.0000|cSoldier,136.2,14.88,0.0000|cCamBlockerMini,114.5,3.063,0.0000|cSoldier,115.1,17.38,0.0000|cTank,94.25,13.13,0.0000|cTank,105.3,15.13,0.0000|cTank,81.81,14.44,0.0000|cDetailSandbags,65.13,19.56,-0.0002930|cAIShellerLeft,57.81,19.00,0.0000|cAICopter,72.69,6.688,0.0000|cDetailPlatformWood,153.1,9.313,0.5666|cDetailPlatformWood,211.0,6.000,0.002540|cDetailSandbags,224.9,14.86,0.0000|cSoldierIdle,213.0,13.15,0.0000|cSoldierIdleRight,218.3,13.94,0.0000000000000000001534|cSoldierIdle,208.3,12.56,0.0000|cSoldierIdle,204.2,12.44,0.0000|cSoldierIdle,209.5,3.750,0.0000|cSoldierIdle,213.3,3.688,0.0000|cSoldierIdleRight,226.9,3.500,0.0000|cDetailJeep,187.7,10.31,0.2261|cSoldierPlatformImmobile,187.3,6.063,0.00000000000007795|cSoldierIdleRight,232.6,14.50,0.0000|cDetailPlatformWood,242.1,6.313,0.3518|cAIShellerLeft,239.9,4.688,0.0000|cAIShellerLeft,243.9,4.625,0.0000|cAIShellerLeft,240.1,15.31,0.0000|cSoldier,254.5,14.63,0.0000|cSoldier,259.0,14.38,0.0000|cSoldier,262.9,14.77,0.0000|cAICopter,259.1,3.063,0.0000|cCamBlockerMini,179.3,1.313,0.0000|cCamBlockerMini,235.6,1.375,0.0000|cDetailSandbags,247.7,15.38,-0.009656|cDetailSandbags,283.8,15.56,0.00000003975|cAIShellerLeft,273.0,15.44,0.0000|cCamBlockerMini,270.8,1.813,0.0000|cDetailPlatformWood,226.6,5.563,0.2364|cDetailBarrel2,274.5,2.750,0.0000|cDetailBarrel2,278.3,2.750,0.0000|cDetailPlatformWood,276.0,5.875,0.2016|cAIShellerLeft,277.4,15.63,0.0000|cSoldierIdleRight,288.4,15.25,0.0000|cCamBlocker,48.88,3.875,0.0000|cDetailBoat,21.81,18.94,0.0000|";
            _loc3_.goingLeft = true;
         }
         if(param1 == LEVEL_12)
         {
            _loc3_.load_image_id = 6;
            _loc3_.load_phys_id = 6;
            _loc3_.levelString = "^,3,10,^,0,0,0,0,0,0,|cCar,16.8,14.08,X|X,176.2,18.78|X,229.4,18.71|X,461.9,16.40|X,497.5,25.84|cCarryable,7.204,14.19,0.0000|cCarryable,3.451,12.39,0.0000|cCarryable,4.688,13.95,0.0000|cCarryable,5.437,12.39,0.0000|cCarryable,7.375,12.33,0.0000|";
         }
         if(param1 == LEVEL_13)
         {
            _loc3_.load_image_id = 7;
            _loc3_.load_phys_id = 7;
            _loc3_.levelString = "^,3,10,^,0,0,0,0,0,0,|cCar,16.8,14.08,X|X,176.2,18.78|X,229.4,18.71|X,461.9,16.40|X,497.5,25.84|cCarryable,7.204,14.19,0.0000|cCarryable,3.451,12.39,0.0000|cCarryable,4.688,13.95,0.0000|cCarryable,5.437,12.39,0.0000|cCarryable,7.375,12.33,0.0000|";
            _loc3_.levelString = "^,7,9,^,0,0,0,0,0,0,|cCar,16.8,14.08,X|cCarryable,7.204,14.19,0.0000|cCarryable,3.451,12.39,0.0000|cCarryable,4.688,13.95,0.0000|cCarryable,5.437,12.39,0.0000|cMMTCollector,487.5,25.88|cSlowSign,437.5,25.81|cCarryable,7.562,12.45,0.0000|cMMTKiller,315.3,19.45|cMMTKiller,107.2,21.45|";
         }
         if(param1 >= LEVEL_1 && param1 < LEVEL_1 + numPlayableLevels + 1)
         {
            switch(_loc3_.myID - LEVEL_1 + 1)
            {
               default:
                  _loc3_.coinsRequired = 1;
                  break;
               case 1:
                  _loc3_.coinsRequired = 2;
                  break;
               case 2:
                  _loc3_.coinsRequired = 3;
                  break;
               case 3:
                  _loc3_.coinsRequired = 3;
                  break;
               case 4:
                  _loc3_.coinsRequired = 3;
                  break;
               case 5:
                  _loc3_.coinsRequired = 4;
                  break;
               case 6:
                  _loc3_.coinsRequired = 4;
                  break;
               case 7:
                  _loc3_.coinsRequired = 4;
                  break;
               case 8:
                  _loc3_.coinsRequired = 4;
                  break;
               case 9:
                  _loc3_.coinsRequired = 6;
                  break;
               case 10:
                  _loc3_.coinsRequired = 5;
            }
         }
         if(param2 == MODE_EDITOR)
         {
            _loc3_.levelString = editString;
            _loc3_.inEditorPreview = false;
            _loc3_.inEditor = true;
            _loc3_.inEditorOrPreview = true;
            _loc3_.controlable = false;
            _loc3_.staggeredLoading = false;
         }
         if(param2 == MODE_PREVIEW)
         {
            _loc3_.levelString = editString;
            _loc3_.inEditor = false;
            _loc3_.inEditorPreview = true;
            _loc3_.inEditorOrPreview = true;
            _loc3_.staggeredLoading = false;
         }
         return _loc3_;
      }
      
      public function setupTimer() : void
      {
         if(this.useSystemTime)
         {
            ScoreHandler.startTicking();
         }
      }
   }
}
