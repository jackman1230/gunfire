package
{
   import flash.display.MovieClip;
   
   public dynamic class bomb01 extends MovieClip
   {
       
      
      public var g:MovieClip;
      
      public function bomb01()
      {
         super();
         addFrameScript(0,frame1,1,frame2,2,frame3,3,frame4);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame2() : *
      {
         stop();
      }
      
      function frame3() : *
      {
         stop();
      }
      
      function frame4() : *
      {
         stop();
      }
   }
}
