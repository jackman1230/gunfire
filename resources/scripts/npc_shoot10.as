package
{
   import flash.display.MovieClip;
   
   public dynamic class npc_shoot10 extends MovieClip
   {
       
      
      public var g:MovieClip;
      
      public function npc_shoot10()
      {
         super();
         addFrameScript(0,frame1,2,frame3);
      }
      
      function frame1() : *
      {
         stop();
      }
      
      function frame3() : *
      {
         stop();
      }
   }
}
