package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class cPickup extends slugObject
   {
       
      
      public var part_main:Boner;
      
      public var fc:int = 0;
      
      public var thingyClip:weapons;
      
      public function cPickup(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:cObject = null)
      {
         super(param1,param2,param3,param4);
         this.createBody();
         this.createGraphics();
         this.setGraphics();
         postCreate();
      }
      
      override public function getStats() : void
      {
         var _loc1_:customFont = null;
         super.getStats();
         isBreakable = false;
         isBounceTrigger = false;
         isAlwaysEnabled = true;
         myBodyClip = new MovieClip();
         if(slugObject.showNames)
         {
            _loc1_ = new customFont(12,this.getTypeStringLol(),true);
            myBodyClip.addChild(_loc1_);
         }
         hitRect = new Rectangle(0,0,20,20);
         can_be_picked_up = true;
      }
      
      public function getTypeStringLol() : String
      {
         return "PIK";
      }
      
      public function getPickupString() : String
      {
         return "s";
      }
      
      public function createBody() : void
      {
         this.part_main = BoxUtils.NewBox(x,y,hitRect.width,hitRect.height,1,true,Filters.car,Filters.carMask);
         lastPart = this.part_main;
         addPart(this.part_main);
      }
      
      public function gotPickedUp(param1:slugObject) : void
      {
         this.thingyClip.gotoAndPlay("get");
         flaggedTimer = 5;
         this.playPickupSound();
      }
      
      public function playPickupSound() : void
      {
         SoundHandler.playSoundClass(sound_buttonPressed);
      }
      
      override public function slugtick() : void
      {
         super.slugtick();
         if(this.fc == 7)
         {
            this.thingyClip.gotoAndPlay(this.getPickupString());
         }
         this.fc++;
      }
      
      public function createGraphics() : void
      {
         setData(bodyParts[0],myBodyClip);
         this.thingyClip = new weapons();
         this.thingyClip.dropType = this.getPickupString();
         this.thingyClip.play();
         this.thingyClip.y = 5;
         myBodyClip.addChild(this.thingyClip);
      }
      
      public function setGraphics() : void
      {
      }
   }
}
