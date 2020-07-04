package
{
   import flash.display.MovieClip;
   
   public dynamic class shoot2 extends MovieClip
   {
       
      
      public function shoot2()
      {
         super();
         addFrameScript(9,frame10,11,frame12,15,frame16,19,frame20,23,frame24);
      }
      
      function frame16() : *
      {
         stop();
         this.exploding();
      }
      
      function frame20() : *
      {
         stop();
         stop();
      }
      
      function frame10() : *
      {
         stop();
      }
      
      function frame12() : *
      {
         stop();
         this.exploding();
      }
      
      function frame24() : *
      {
         stop();
         stop();
      }
   }
}
