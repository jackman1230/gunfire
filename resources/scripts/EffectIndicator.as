package
{
   import flash.display.Sprite;
   import flash.events.Event;
   
   public class EffectIndicator extends Sprite
   {
      
      public static const EFFECT_CONNECT:int = 0;
      
      public static const EFFECT_HINT:int = 1;
      
      public static const EFFECT_RECONNECT:int = 2;
      
      public static const EFFECT_HITSPACE:int = 3;
      
      public static const EFFECT_INVUL:int = 110;
      
      public static const EFFECT_LOWGRAV:int = 111;
      
      public static const EFFECT_ICE:int = 112;
      
      public static const EFFECT_CLAMP:int = 113;
      
      public static const EFFECT_BULLET:int = 114;
      
      public static var self:EffectIndicator;
      
      public static var myParent:Sprite;
       
      
      public var effectTypes:Vector.<int>;
      
      public var effectSprites:Vector.<Sprite>;
      
      public var tweeners:Vector.<Tweenie>;
      
      public var activated:Array;
      
      public var active:Array;
      
      public var updateRequired:Boolean = false;
      
      private var allActive:Boolean = false;
      
      private var allActivated:Boolean = false;
      
      public function EffectIndicator(param1:Sprite)
      {
         this.effectTypes = new Vector.<int>();
         this.effectSprites = new Vector.<Sprite>();
         this.tweeners = new Vector.<Tweenie>();
         super();
         myParent = param1;
         self = this;
         myParent.addChild(self);
         this.addEventListener(Event.ENTER_FRAME,this.onFrame);
      }
      
      public function sign(param1:Number) : Number
      {
         if(param1 < 0)
         {
            return -1;
         }
         return 1;
      }
      
      public function onFrame(param1:Event) : void
      {
         var _loc2_:int = 0;
         if(this.updateRequired && this.effectTypes.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < this.effectTypes.length)
            {
               this.tweeners[_loc2_].tweenSprite(this.effectSprites[_loc2_].x,200 + _loc2_ * 200,this.effectSprites[_loc2_],true);
               _loc2_++;
            }
            this.updateRequired = false;
         }
         if(this.allActivated == false)
         {
            this.allActivated = true;
            _loc2_ = 0;
            while(_loc2_ < this.activated.length)
            {
               if(this.activated[_loc2_] == 0)
               {
                  this.allActivated = false;
               }
               _loc2_++;
            }
            if(this.allActivated)
            {
               AchievementChecker.allStatusAchieve();
            }
         }
         if(this.effectTypes.length >= 3)
         {
            AchievementChecker.allStatusAchieve2();
         }
      }
      
      public function cleanup() : void
      {
         this.active = [0,0,0,0,0];
         this.activated = [0,0,0,0,0];
         this.allActive = false;
         this.allActivated = false;
      }
      
      public function removeAllStatuses() : void
      {
         var _loc1_:int = 0;
         if(this.active != null)
         {
            _loc1_ = 0;
            while(_loc1_ < this.active.length)
            {
               this.removeStatus(_loc1_);
               _loc1_++;
            }
         }
      }
      
      public function addStatus(param1:int) : void
      {
         var _loc2_:Sprite = null;
         if(!(World.currentLevel != null && World.currentLevel.inEditorOrPreview))
         {
            this.removeStatus(param1);
            this.active[param1] = 1;
            this.activated[param1] = 1;
            this.effectTypes.push(param1);
            _loc2_ = this.spriteForEffect(param1);
            _loc2_.x = 800;
            _loc2_.y = 90;
            addChild(_loc2_);
            this.effectSprites.push(_loc2_);
            this.tweeners.push(new Tweenie());
            this.updateRequired = true;
         }
      }
      
      public function removeStatus(param1:int) : void
      {
         this.active[param1] = 0;
         var _loc2_:int = -1;
         var _loc3_:int = 0;
         while(_loc3_ < this.effectTypes.length)
         {
            if(this.effectTypes[_loc3_] == param1)
            {
               _loc2_ = _loc3_;
            }
            _loc3_++;
         }
         if(_loc2_ > -1)
         {
            this.effectTypes.splice(_loc2_,1);
            if(this.effectSprites[_loc2_] != null && contains(this.effectSprites[_loc2_]))
            {
               removeChild(this.effectSprites[_loc2_]);
            }
            this.effectSprites.splice(_loc2_,1);
            this.tweeners[_loc2_].disable();
            this.tweeners.splice(_loc2_,1);
            this.updateRequired = true;
         }
      }
      
      public function spriteForEffect(param1:int) : Sprite
      {
         var _loc2_:Sprite = null;
         switch(param1)
         {
            default:
               _loc2_ = new customFont(20,"[" + param1.toString() + "]",true);
               break;
            case 0:
               _loc2_ = new Sprite();
               break;
            case 1:
               _loc2_ = new Sprite();
               break;
            case 2:
               _loc2_ = new Sprite();
               break;
            case 3:
               _loc2_ = new Sprite();
         }
         return _loc2_;
      }
   }
}
