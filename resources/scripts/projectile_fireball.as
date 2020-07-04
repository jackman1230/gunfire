package
{
   import flash.display.MovieClip;
   
   public dynamic class projectile_fireball extends MovieClip
   {
       
      
      public var g:MovieClip;
      
      public function projectile_fireball()
      {
         super();
         addFrameScript(0,frame1,14,frame15);
      }
      
      function frame15() : *
      {
         stop();
      }
      
      function frame1() : *
      {
         stop();
      }
   }
}
