package
{
   import flash.display.MovieClip;
   
   public dynamic class asploding_missiles extends MovieClip
   {
       
      
      public var g:MovieClip;
      
      public function asploding_missiles()
      {
         super();
         addFrameScript(73,frame74);
      }
      
      function frame74() : *
      {
         stop();
      }
   }
}
