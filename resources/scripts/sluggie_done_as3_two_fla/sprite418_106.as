package sluggie_done_as3_two_fla
{
   import flash.display.MovieClip;
   
   public dynamic class sprite418_106 extends MovieClip
   {
       
      
      public function sprite418_106()
      {
         super();
         addFrameScript(21,frame22);
      }
      
      function frame22() : *
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
