package
{
   import flash.display.MovieClip;
   
   public dynamic class enemy01 extends MovieClip
   {
       
      
      public var g:MovieClip;
      
      public var mr:Number;
      
      public var m:MovieClip;
      
      public var clip:MovieClip;
      
      public var myHandler;
      
      public function enemy01()
      {
         super();
         addFrameScript(0,frame1,191,frame192,219,frame220);
      }
      
      function frame220() : *
      {
         mr = Math.random();
         if(mr > 0.66)
         {
            gotoAndStop("die1");
         }
         else if(mr > 0.33)
         {
            gotoAndStop("die2");
         }
         else
         {
            gotoAndStop("die3");
         }
      }
      
      public function grenadeAction() : void
      {
         if(global.frameDebug)
         {
            trace("inner Grenade action got called ... let\'s see what happens");
         }
         myHandler.spriteGrenadeCall();
      }
      
      public function attackAction() : void
      {
         if(global.frameDebug)
         {
            trace("inner attack action got called ... let\'s see what happens");
         }
         myHandler.spriteAttackCall();
      }
      
      public function setHander(param1:*) : void
      {
         myHandler = param1;
         trace("local handler is " + myHandler);
      }
      
      function frame1() : *
      {
      }
      
      public function shootAction() : void
      {
         if(global.frameDebug)
         {
            trace("inner shoot action got called ... let\'s see what happens");
         }
         myHandler.spriteShootCall();
      }
      
      public function stand() : void
      {
         if(global.frameDebug)
         {
            trace("inner stand function got called. let\'s see what happens");
         }
         myHandler.spriteStandCall();
      }
      
      function frame192() : *
      {
         play();
      }
   }
}
