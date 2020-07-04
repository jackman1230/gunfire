package sluggie_done_as3_two_fla
{
   import flash.display.MovieClip;
   
   public dynamic class sprite334_96 extends MovieClip
   {
       
      
      public function sprite334_96()
      {
         super();
         addFrameScript(43,frame44);
      }
      
      function frame44() : *
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
               trace("soliderscript invalid dieAnimFinished3");
            }
            return;
         }
      }
   }
}
