package
{
   import flash.display.MovieClip;
   
   public dynamic class hitler extends MovieClip
   {
       
      
      public var myHandler;
      
      public var m:MovieClip;
      
      public var g:MovieClip;
      
      public function hitler()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      public function grenadeAction() : void
      {
         if(global.frameDebug)
         {
            trace("inner Grenade action got called ... let\'s see what happens");
         }
         myHandler.spriteGrenadeCall();
      }
      
      public function shootAction() : void
      {
         if(global.frameDebug)
         {
            trace("inner shoot action got called ... let\'s see what happens");
         }
         myHandler.spriteShootCall();
      }
      
      function frame1() : *
      {
      }
      
      public function setHander(param1:*) : void
      {
         myHandler = param1;
         trace("local handler is " + myHandler);
      }
      
      public function attackAction() : void
      {
         if(global.frameDebug)
         {
            trace("inner attack action got called ... let\'s see what happens");
         }
         myHandler.spriteAttackCall();
      }
      
      public function stand() : void
      {
         if(global.frameDebug)
         {
            trace("inner stand function got called. let\'s see what happens");
         }
         myHandler.spriteStandCall();
      }
   }
}
