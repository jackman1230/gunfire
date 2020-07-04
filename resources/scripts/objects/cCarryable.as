package objects
{
   import flash.display.Sprite;
   import nape.dynamics.InteractionFilter;
   
   public class cCarryable extends cObject
   {
      
      public static var carryID:int = 0;
      
      public static var TYPE_PIGLET:int = 0;
      
      public static var TYPE_TOMATO:int = 1;
      
      public static var TYPE_CARROT:int = 2;
      
      public static var TYPE_PUMPKIN:int = 3;
      
      public static var TYPE_PIG:int = 4;
      
      public static var TYPE_COW:int = 5;
      
      public static var TYPE_SHEEP:int = 6;
       
      
      public var myClip:Sprite;
      
      public var carryScale:Number = 1;
      
      public var hasValue:Boolean = false;
      
      public function cCarryable(param1:Number, param2:Number, param3:GameMode, param4:Number = 0)
      {
         super(param1,param2,param3,param4);
         editorRotateable = true;
         this.getStats();
         carryID = Math.random() * 6;
         this.carryScale = 0.7;
         PuffHandler.makePuff(bodyParts[0],PuffHandler.PUFF_SNOW,0,0,0.4,0.4);
         rotateAboutPoint(param4);
         postCreate();
      }
      
      public function doCircle(param1:Sprite) : void
      {
         addPart(BoxUtils.NewCircle(x,y,0.5 * 16,0.1 * 16,true,Filters.carryable,Filters.carryableMask));
         param1.scaleX = this.carryScale;
         param1.scaleY = this.carryScale;
         SpriteUtils.setData(lastPart,param1,false);
         var _loc2_:int = cCar.currentPlayerClip.parent.getChildIndex(cCar.currentPlayerClip);
         SpriteUtils.gameClip.setChildIndex(param1,_loc2_);
      }
      
      public function doShape(param1:Array, param2:Sprite) : void
      {
         addPart(BoxUtils.defineBody(x,y,2.5,true,Filters.carryable,Filters.carryableMask,param1,this.carryScale));
         param2.scaleX = this.carryScale;
         param2.scaleY = this.carryScale;
         SpriteUtils.setData(lastPart,param2,false);
         var _loc3_:int = cCar.currentPlayerClip.parent.getChildIndex(cCar.currentPlayerClip);
         SpriteUtils.gameClip.setChildIndex(param2,_loc3_);
      }
      
      public function goSensor() : void
      {
         var _loc1_:Boner = null;
         for each(_loc1_ in bodyParts)
         {
            _loc1_.setShapeFilters(new InteractionFilter(Filters.fuckall,Filters.fuckallMask));
         }
         isAlwaysSensor = true;
         setSensor();
      }
      
      public function getStats() : void
      {
         this.myClip = new soloCoin();
      }
   }
}
