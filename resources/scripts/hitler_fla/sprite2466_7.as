package hitler_fla
{
   import flash.display.MovieClip;
   
   public dynamic class sprite2466_7 extends MovieClip
   {
       
      
      public var point:MovieClip;
      
      public function sprite2466_7()
      {
         super();
         addFrameScript(9,frame10,28,frame29);
      }
      
      function frame10() : *
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
               trace("hitler invalid shootaction");
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
