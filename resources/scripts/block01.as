package
{
   import flash.display.MovieClip;
   
   public dynamic class block01 extends MovieClip
   {
       
      
      public var g:MovieClip;
      
      public function block01()
      {
         super();
         addFrameScript(0,frame1,6,frame7,48,frame49);
      }
      
      function frame49() : *
      {
         stop();
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame7() : *
      {
         play();
      }
   }
}
