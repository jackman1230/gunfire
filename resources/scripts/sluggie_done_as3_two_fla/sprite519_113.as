package sluggie_done_as3_two_fla
{
   import flash.display.MovieClip;
   
   public dynamic class sprite519_113 extends MovieClip
   {
       
      
      public var point:MovieClip;
      
      public function sprite519_113()
      {
         super();
         addFrameScript(5,frame6,28,frame29);
      }
      
      function frame6() : *
      {
         try
         {
            if(parent != null)
            {
               parent["shootAction"]();
            }
            return;
         }
         catch(e:Error)
         {
            if(global.frameDebug)
            {
               trace("soliderscript invalid shootAction");
            }
            return;
         }
      }
      
      function frame29() : *
      {
         try
         {
            if(parent != null)
            {
               parent["stand"]();
            }
            return;
         }
         catch(e:Error)
         {
            if(global.frameDebug)
            {
               trace("soliderscript invalid stand");
            }
            return;
         }
      }
   }
}
