package sluggie_done_as3_two_fla
{
   import flash.display.MovieClip;
   
   public dynamic class sprite542_114 extends MovieClip
   {
       
      
      public var point:MovieClip;
      
      public function sprite542_114()
      {
         super();
         addFrameScript(18,frame19,29,frame30);
      }
      
      function frame30() : *
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
               trace("invalid stand");
            }
            return;
         }
      }
      
      function frame19() : *
      {
         try
         {
            if(parent != null)
            {
               parent["grenadeAction"]();
            }
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
   }
}
