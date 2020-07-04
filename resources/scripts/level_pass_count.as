package
{
   import flash.display.MovieClip;
   
   public dynamic class level_pass_count extends MovieClip
   {
       
      
      public var showpad:showpad_export;
      
      public function level_pass_count()
      {
         super();
         addFrameScript(0,frame1);
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
