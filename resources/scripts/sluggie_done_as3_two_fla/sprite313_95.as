package sluggie_done_as3_two_fla
{
   import flash.display.MovieClip;
   
   public dynamic class sprite313_95 extends MovieClip
   {
       
      
      public function sprite313_95()
      {
         super();
         addFrameScript(38,frame39);
      }
      
      function frame39() : *
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
               trace("soliderscript invalid dieAnimFinished2");
            }
            return;
         }
      }
   }
}
