package
{
   import flash.display.MovieClip;
   
   public dynamic class enemy10 extends MovieClip
   {
       
      
      public var g:MovieClip;
      
      public var point:MovieClip;
      
      public var gun:MovieClip;
      
      public function enemy10()
      {
         super();
         addFrameScript(0,frame1,48,frame49,59,frame60,64,frame65,70,frame71,75,frame76,82,frame83);
      }
      
      function frame1() : *
      {
      }
      
      function frame83() : *
      {
         play();
         gun.gotoAndPlay("explode");
      }
      
      function frame65() : *
      {
         gun.gotoAndPlay("explode");
      }
      
      function frame60() : *
      {
         this.stand();
      }
      
      function frame49() : *
      {
         this.shootAction();
      }
      
      function frame76() : *
      {
         gun.gotoAndPlay("explode");
      }
      
      public function shootAction() : void
      {
         if(global.frameDebug)
         {
            trace("inner shoot action got called ... let\'s see what happens");
         }
      }
      
      public function stand() : void
      {
         if(global.frameDebug)
         {
            trace("inner stand function got called. let\'s see what happens");
         }
      }
      
      public function attackAction() : void
      {
         if(global.frameDebug)
         {
            trace("inner attack action got called ... let\'s see what happens");
         }
      }
      
      function frame71() : *
      {
         gun.gotoAndPlay("explode");
      }
   }
}
