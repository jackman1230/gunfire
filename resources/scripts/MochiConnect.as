package
{
   import flash.display.MovieClip;
   import mochi.as3.MochiBot;
   import mochi.as3.MochiEvents;
   import mochi.as3.MochiScores;
   import mochi.as3.MochiServices;
   
   public dynamic class MochiConnect extends MovieClip
   {
      
      public static var containerClip:MovieClip;
      
      public static var staticSelf:MochiConnect = null;
      
      public static var doneConnections:Boolean;
       
      
      public function MochiConnect(param1:MovieClip)
      {
         super();
         staticSelf = this;
         containerClip = param1;
         containerClip.addChild(this);
         this.doConnections();
      }
      
      public function doConnections() : void
      {
         if(global.mainStage.loaderInfo.url.toLowerCase().indexOf("file://") > -1)
         {
            doneConnections = true;
         }
         if(!doneConnections)
         {
            MochiBot.track(MochiConnect.containerClip,"e06e150b");
            MochiBot.track(MochiConnect.containerClip,"c1da8dcf");
            MochiServices.connect("3ae12f2a88bc097a",MochiConnect.containerClip);
            doneConnections = true;
         }
      }
      
      public function startPlay() : void
      {
         MochiEvents.startPlay();
      }
      
      public function submitScore(param1:int) : void
      {
         var inVal:int = param1;
         var o:Object = {
            "n":[6,12,14,3,7,14,13,5,6,8,3,11,13,11,9,13],
            "f":function(param1:Number, param2:String):String
            {
               if(param2.length == 16)
               {
                  return param2;
               }
               return this.f(param1 + 1,param2 + this.n[param1].toString(16));
            }
         };
         var boardID:String = o.f(0,"");
         MochiScores.showLeaderboard({
            "boardID":boardID,
            "score":inVal
         });
      }
      
      public function showScores(param1:int) : void
      {
         var inVal:int = param1;
         containerClip.stage.focus = this;
         var o:Object = {
            "n":[6,12,14,3,7,14,13,5,6,8,3,11,13,11,9,13],
            "f":function(param1:Number, param2:String):String
            {
               if(param2.length == 16)
               {
                  return param2;
               }
               return this.f(param1 + 1,param2 + this.n[param1].toString(16));
            }
         };
         var boardID:String = o.f(0,"");
         MochiScores.showLeaderboard({"boardID":boardID});
      }
   }
}
