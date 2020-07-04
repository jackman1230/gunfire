package sluggie_done_as3_two_fla
{
   import flash.display.MovieClip;
   
   public dynamic class sprite466_110 extends MovieClip
   {
       
      
      public var point:MovieClip;
      
      public function sprite466_110()
      {
         super();
         addFrameScript(19,frame20,46,frame47);
      }
      
      function frame47() : *
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
      
      function frame20() : *
      {
         try
         {
            if(parent != null)
            {
               parent["attackAction"]();
            }
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
   }
}
