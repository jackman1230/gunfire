package
{
   import flash.display.MovieClip;
   
   public dynamic class projectile_dropbomb extends MovieClip
   {
       
      
      public function projectile_dropbomb()
      {
         super();
         addFrameScript(0,frame1,36,frame37);
      }
      
      function frame37() : *
      {
         stop();
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
