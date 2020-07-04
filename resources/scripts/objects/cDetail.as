package objects
{
   import flash.display.MovieClip;
   import flash.geom.Rectangle;
   
   public class cDetail extends slugObject
   {
       
      
      public var part_main:Boner;
      
      public var blockLOS:Boolean = false;
      
      public var outroTime:int = 20;
      
      public var swell:int = 5;
      
      public var swellCount:int = -1;
      
      public var staticFlag:Boolean = false;
      
      public var manual_flag:int = -1;
      
      private var detaildied:Boolean = false;
      
      public function cDetail(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:cObject = null)
      {
         super(param1,param2,param3,param4);
         this.createBody();
         postCreate();
      }
      
      override public function getStats() : void
      {
         var _loc1_:customFont = null;
         super.getStats();
         myBodyClip = new MovieClip();
         if(slugObject.showNames)
         {
            _loc1_ = new customFont(12,this.getTypeStringLol(),true);
            myBodyClip.addChild(_loc1_);
         }
         hitRect = new Rectangle(0,0,20,20);
         takesDamage = true;
         slug_health = 150;
         detail = true;
         alert_allies_on_damage = true;
      }
      
      public function getTypeStringLol() : String
      {
         return "DETAIL";
      }
      
      public function createBody() : void
      {
         isAlwaysStatic = this.staticFlag;
         isAlwaysStatic = false;
         this.staticFlag = false;
         this.part_main = BoxUtils.NewBox(x,y,10,10,1,true,Filters.objectSelfNoCollide,Filters.objectSelfNoCollideMask);
         this.part_main.userData.isGround = true;
         this.part_main.isGround = true;
         lastPart = this.part_main;
         addPart(this.part_main,null,false,this is cDetailPlatform,this.staticFlag);
         setData(bodyParts[0],myBodyClip);
      }
      
      override public function slugtick() : void
      {
         super.slugtick();
         if(this.swellCount > -1)
         {
            this.swellCount--;
            if(this.swellCount == -1)
            {
               this.manual_flag = this.outroTime;
               hostile = false;
               dealsTouchDamage = 150;
               touchDamageDelay = 1;
               this.payLoad();
            }
         }
         if(this.manual_flag > -1)
         {
            this.manual_flag = this.manual_flag - 1;
            if(this.manual_flag == -1)
            {
               flaggedTimer = 1;
               gotFlagged();
            }
         }
      }
      
      public function payLoad() : void
      {
         hitRect = new Rectangle(0,0,140,140);
         SoundHandler.playSoundClass(sound_asplosion);
      }
      
      override public function takeDamage(param1:slugObject, param2:int) : void
      {
         if(this.manual_flag == -1 && this.swellCount == -1)
         {
            if(slug_health - param2 <= 0)
            {
               if(!this.detaildied)
               {
                  this.swellCount = this.swell;
               }
            }
            else
            {
               super.takeDamage(param1,param2);
            }
         }
      }
   }
}
