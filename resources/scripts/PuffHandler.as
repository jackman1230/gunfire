package
{
   import flash.display.MovieClip;
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.geom.ColorTransform;
   
   public class PuffHandler
   {
      
      public static const PUFF_EXHAUST:int = 0;
      
      public static const PUFF_GROUND:int = 1;
      
      public static const PUFF_SCRAPE:int = 2;
      
      public static const PUFF_BIGPUFF_VECT:int = 3;
      
      public static const PUFF_SPLATTER:int = 4;
      
      public static const PUFF_EXPLOSION:int = 5;
      
      public static const PUFF_ENEMY_HIT_1:int = 6;
      
      public static const PUFF_ENEMY_HIT_2:int = 7;
      
      public static const PUFF_STAR_POP:int = 8;
      
      public static const PUFF_PLUS_50:int = 50;
      
      public static const PUFF_PLUS_100:int = 100;
      
      public static const PUFF_EXHAUST_2:int = 9;
      
      public static const PUFF_SPLATTER_2:int = 10;
      
      public static const PUFF_INVUL:int = 11;
      
      public static const PUFF_SIZE:int = 12;
      
      public static const PUFF_BUBBLES:int = 22;
      
      public static const PUFF_SANDHIT:int = 23;
      
      public static const PUFF_SINGLE_BUTTON:int = 24;
      
      public static const PUFF_SNOW:int = 25;
      
      public static const PUFF_PANG:int = 26;
      
      public static var self:PuffHandler;
      
      public static var myParent:Sprite;
      
      public static var puffVect:Vector.<Sprite> = new Vector.<Sprite>();
       
      
      public function PuffHandler(param1:Sprite)
      {
         super();
         myParent = param1;
         self = this;
      }
      
      public static function makePuff(param1:Boner, param2:int = 0, param3:Number = 0, param4:Number = 0, param5:Number = 1, param6:Number = 1, param7:Number = 1) : *
      {
         var _loc8_:Sprite = null;
         if(param1 != null)
         {
            switch(param2)
            {
               default:
                  _loc8_ = new MovieClip();
                  break;
               case PUFF_EXHAUST_2:
                  _loc8_ = new MovieClip();
                  _loc8_.rotation = Math.random() * 260;
                  break;
               case PUFF_GROUND:
                  if(Math.random() > 0.5)
                  {
                     _loc8_ = new new MovieClip()();
                  }
                  else
                  {
                     _loc8_ = new new MovieClip()();
                  }
                  _loc8_.alpha = 0.8;
                  break;
               case PUFF_SCRAPE:
                  if(Math.random() > 0.5)
                  {
                     _loc8_ = new new MovieClip()();
                     break;
                  }
                  _loc8_ = new new MovieClip()();
                  break;
               case PUFF_BIGPUFF_VECT:
                  _loc8_ = new new MovieClip()();
                  break;
               case PUFF_SPLATTER:
                  _loc8_ = new new MovieClip()();
                  break;
               case PUFF_SPLATTER_2:
                  if(Math.random() > 0.5)
                  {
                     _loc8_ = new new MovieClip()();
                     break;
                  }
                  _loc8_ = new new MovieClip()();
                  break;
               case PUFF_EXPLOSION:
                  _loc8_ = new new MovieClip()();
                  break;
               case PUFF_ENEMY_HIT_1:
                  _loc8_ = new new MovieClip()();
                  break;
               case PUFF_ENEMY_HIT_2:
                  _loc8_ = new Sprite();
                  break;
               case PUFF_STAR_POP:
                  _loc8_ = new new MovieClip()();
                  break;
               case PUFF_INVUL:
                  if(Math.random() > 0.5)
                  {
                     _loc8_ = new new MovieClip()();
                  }
                  else
                  {
                     _loc8_ = new new MovieClip()();
                  }
                  _loc8_.transform.colorTransform = new ColorTransform(0.5 + Math.random() * 0.5,0.5 + Math.random() * 0.5,0.5 + Math.random() * 0.5);
                  break;
               case PUFF_SIZE:
                  _loc8_ = new MovieClip();
                  break;
               case PUFF_BUBBLES:
                  _loc8_ = new MovieClip();
                  _loc8_.filters = [new DropShadowFilter()];
                  break;
               case PUFF_SANDHIT:
                  _loc8_ = new MovieClip();
                  break;
               case PUFF_SINGLE_BUTTON:
                  _loc8_ = new MovieClip();
                  break;
               case PUFF_PLUS_50:
                  _loc8_ = new MovieClip();
               case PUFF_PLUS_100:
                  _loc8_ = new MovieClip();
               case PUFF_SNOW:
                  _loc8_ = new MovieClip();
               case PUFF_PANG:
                  _loc8_ = new MovieClip();
            }
            if(param2 == PUFF_SCRAPE)
            {
               _loc8_.rotation = Math.random() * 20 - 10;
               _loc8_.scaleX = 1.5 + Math.random() / 10;
               _loc8_.scaleY = _loc8_.scaleX;
            }
            _loc8_.x = param1.position.x * World.gameScale;
            _loc8_.y = param1.position.y * World.gameScale;
            _loc8_.x = _loc8_.x + param3;
            _loc8_.y = _loc8_.y + param4;
            _loc8_.scaleX = param5;
            _loc8_.scaleY = param6;
            _loc8_.alpha = param7;
            SpriteUtils.gameClip.addChild(_loc8_);
            puffVect.push(_loc8_);
         }
      }
      
      public static function checkPuffs() : *
      {
         var _loc1_:Sprite = null;
         var _loc2_:int = 0;
         var _loc3_:Number = NaN;
         if(puffVect.length > 0)
         {
            _loc2_ = 0;
            while(_loc2_ < puffVect.length)
            {
               if(_loc2_ < puffVect.length)
               {
                  _loc1_ = puffVect[_loc2_];
                  _loc3_ = !!GameMode.goal?Number(0.05):Number(0.05);
                  _loc1_.alpha = _loc1_.alpha - _loc3_;
                  _loc1_.x = _loc1_.x - 1;
                  if(_loc1_.alpha <= -0.05)
                  {
                     if(SpriteUtils.gameClip.contains(_loc1_))
                     {
                        SpriteUtils.gameClip.removeChild(_loc1_);
                     }
                     puffVect.splice(_loc2_,1);
                  }
               }
               _loc2_++;
            }
         }
      }
      
      public static function cleanup() : void
      {
      }
   }
}
