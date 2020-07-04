package
{
   import flash.display.MovieClip;
   import flash.display.SimpleButton;
   
   public dynamic class fade_Intro extends MovieClip
   {
       
      
      public var backie:MovieClip;
      
      public var btn_moregames:slugbutton_more_games;
      
      public var btn_download:slugbutton_download;
      
      public var btn_highscores:slugbutton_highscores;
      
      public var btn_play:SimpleButton;
      
      public function fade_Intro()
      {
         super();
         addFrameScript(0,frame1,14,frame15,19,frame20,29,frame30,35,frame36,69,frame70,108,frame109,117,frame118,132,frame133,143,frame144);
      }
      
      function frame1() : *
      {
         Migrate.stopMusic = true;
      }
      
      function frame30() : *
      {
         Migrate.soundPending = true;
      }
      
      function frame36() : *
      {
         Migrate.soundPending = true;
      }
      
      function frame15() : *
      {
         Migrate.soundPending = true;
      }
      
      function frame133() : *
      {
         Migrate.bulletPending = true;
      }
      
      function frame109() : *
      {
         Migrate.bulletPending = true;
      }
      
      function frame70() : *
      {
         Migrate.beginMusic = true;
         Migrate.buttonSafe = true;
      }
      
      function frame118() : *
      {
         Migrate.bulletPending = true;
      }
      
      function frame20() : *
      {
         Migrate.soundPending = true;
      }
      
      function frame144() : *
      {
         stop();
      }
   }
}
