package
{
   import flash.display.MovieClip;
   
   public dynamic class droptank_spikes extends MovieClip
   {
       
      
      public var myHandler;
      
      public var g:MovieClip;
      
      public var point:MovieClip;
      
      public function droptank_spikes()
      {
         super();
         addFrameScript(0,frame1,36,frame37,60,frame61,64,frame65,86,frame87,88,frame89,114,frame115,204,frame205);
      }
      
      function frame1() : *
      {
      }
      
      function frame61() : *
      {
         try
         {
            this["attackAction"]();
            return;
         }
         catch(e:Error)
         {
            if(global.frameDebug)
            {
               trace("invalid attackAction");
            }
            return;
         }
      }
      
      function frame205() : *
      {
         stop();
      }
      
      public function grenadeAction() : void
      {
         if(global.frameDebug)
         {
            trace("inner Grenade action got called ... let\'s see what happens");
         }
         myHandler.spriteGrenadeCall();
      }
      
      function frame65() : *
      {
         try
         {
            this["attackAction"]();
            return;
         }
         catch(e:Error)
         {
            if(global.frameDebug)
            {
               trace("invalid attackAction");
            }
            return;
         }
      }
      
      public function attackAction() : void
      {
         if(global.frameDebug)
         {
            trace("inner attack action got called ... let\'s see what happens");
         }
         myHandler.spriteAttackCall();
      }
      
      function frame115() : *
      {
         try
         {
            this["stand"]();
            return;
         }
         catch(e:Error)
         {
            if(global.frameDebug)
            {
               trace("invalid stand");
            }
            return;
         }
      }
      
      function frame37() : *
      {
         try
         {
            this["stand"]();
            return;
         }
         catch(e:Error)
         {
            if(global.frameDebug)
            {
               trace("invalid attackAction");
            }
            return;
         }
      }
      
      function frame87() : *
      {
         try
         {
            this["stand"]();
            return;
         }
         catch(e:Error)
         {
            if(global.frameDebug)
            {
               trace("invalid stand");
            }
            return;
         }
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
      
      function frame89() : *
      {
         try
         {
            this["attackAction"]();
            return;
         }
         catch(e:Error)
         {
            if(global.frameDebug)
            {
               trace("invalid attackAction");
            }
            return;
         }
      }
      
      public function setHander(param1:*) : void
      {
         myHandler = param1;
         trace("local handler is " + myHandler);
      }
   }
}
