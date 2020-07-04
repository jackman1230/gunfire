package sluggie_done_as3_two_fla
{
   import flash.display.MovieClip;
   
   public dynamic class sprite549_115 extends MovieClip
   {
       
      
      public var point:MovieClip;
      
      public function sprite549_115()
      {
         super();
         addFrameScript(3,frame4,11,frame12);
      }
      
      function frame12() : *
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
      
      function frame4() : *
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
               trace("invalid shootAction");
            }
            return;
         }
      }
   }
}
