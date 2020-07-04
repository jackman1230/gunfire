package
{
   import flash.display.MovieClip;
   
   public dynamic class weapons extends MovieClip
   {
       
      
      public var dropType:String;
      
      public function weapons()
      {
         super();
         addFrameScript(0,frame1,5,frame6,16,frame17,27,frame28,38,frame39,49,frame50,59,frame60);
      }
      
      function frame17() : *
      {
         stop();
      }
      
      function frame1() : *
      {
         dropType = "b";
      }
      
      function frame60() : *
      {
         stop();
      }
      
      function frame50() : *
      {
         stop();
      }
      
      function frame6() : *
      {
         gotoAndPlay(dropType);
      }
      
      function frame28() : *
      {
         stop();
      }
      
      function frame39() : *
      {
         stop();
      }
   }
}
