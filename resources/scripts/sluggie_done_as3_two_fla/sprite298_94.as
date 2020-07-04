package sluggie_done_as3_two_fla
{
   import flash.display.MovieClip;
   
   public dynamic class sprite298_94 extends MovieClip
   {
       
      
      public function sprite298_94()
      {
         super();
         addFrameScript(46,frame47);
      }
      
      function frame47() : *
      {
         try
         {
            if(parent != null)
            {
               parent["dieAnimFinished"]();
            }
            return;
         }
         catch(e:Error)
         {
            if(global.frameDebug)
            {
               trace("soliderscript invalid dieAnimFinished() ");
            }
            return;
         }
      }
   }
}
