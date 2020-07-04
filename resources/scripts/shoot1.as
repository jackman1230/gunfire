package
{
   import flash.display.MovieClip;
   
   public dynamic class shoot1 extends MovieClip
   {
       
      
      public function shoot1()
      {
         super();
         addFrameScript(4,frame5,5,frame6,10,frame11,15,frame16,20,frame21,27,frame28);
      }
      
      function frame16() : *
      {
         stop();
      }
      
      function frame28() : *
      {
         stop();
      }
      
      function frame5() : *
      {
         stop();
      }
      
      function frame6() : *
      {
         play();
      }
      
      function frame21() : *
      {
         stop();
      }
      
      function frame11() : *
      {
      }
   }
}
