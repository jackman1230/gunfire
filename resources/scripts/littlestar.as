package
{
   import flash.display.MovieClip;
   
   public dynamic class littlestar extends MovieClip
   {
       
      
      public function littlestar()
      {
         super();
         addFrameScript(18,this.frame19);
      }
      
      function frame19() : *
      {
         gotoAndPlay(1);
      }
   }
}
