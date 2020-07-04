package sluggie_done_as3_two_fla
{
   import flash.display.MovieClip;
   
   public dynamic class sprite508_112 extends MovieClip
   {
       
      
      public var point:MovieClip;
      
      public function sprite508_112()
      {
         super();
         addFrameScript(10,frame11,33,frame34,43,frame44,57,frame58);
      }
      
      function frame11() : *
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
               trace("soliderscript invalid shootaction");
            }
            return;
         }
      }
      
      function frame58() : *
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
      
      function frame44() : *
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
      
      function frame34() : *
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
