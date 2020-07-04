package objects
{
   import flash.display.MovieClip;
   
   public class cShottieBlob extends slugObject
   {
       
      
      public var part_main:Boner;
      
      public var sa:Number;
      
      public function cShottieBlob(param1:Number, param2:Number, param3:GameMode, param4:Number = 0, param5:cObject = null)
      {
         this.sa = param4;
         super(param1,param2,param3,param4);
         this.createBody();
         postCreate();
      }
      
      override public function getStats() : void
      {
         var _loc2_:customFont = null;
         super.getStats();
         myBodyClip = new MovieClip();
         if(slugObject.showNames)
         {
            _loc2_ = new customFont(12,this.getTypeStringLol(),true);
            myBodyClip.addChild(_loc2_);
         }
         var _loc1_:MovieClip = new shoot3();
         myBodyClip.addChild(_loc1_);
         _loc1_.play();
         _loc1_.rotation = this.sa * (180 / Math.PI);
         takesDamage = false;
         dealsTouchDamage = -1;
         lifetime = 7;
      }
      
      public function getTypeStringLol() : String
      {
         return "ShottieBlob";
      }
      
      public function createBody() : void
      {
         this.part_main = BoxUtils.NewBox(x,y,10,10,0.01,true,Filters.fuckall,Filters.fuckallMask);
         this.part_main.gravMassScale = 0;
         lastPart = this.part_main;
         addPart(this.part_main,null,true,false,false);
         setData(bodyParts[0],myBodyClip);
         addJoint(BoxUtils.NewSolJoint(bodyParts[0],World.followObj.bodyParts[0],0,0,false));
      }
   }
}
