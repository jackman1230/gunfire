package
{
   import flash.display.Bitmap;
   import flash.display.BitmapData;
   import flash.display.Sprite;
   import flash.events.Event;
   import flash.events.KeyboardEvent;
   import flash.geom.Matrix;
   import flash.geom.Rectangle;
   import flash.ui.Keyboard;
   
   public class Menu_Loading extends PopupMenu
   {
       
      
      public var popupHandler:PopupHandler;
      
      public var frameCount:int = 0;
      
      public var bg:menuBG_Loading;
      
      public var bud:BitmapData;
      
      public var over:BitmapData;
      
      public var newContinue:Sprite;
      
      public var flip:Boolean = true;
      
      public function Menu_Loading(param1:GameMode, param2:PopupHandler)
      {
         gMode = param1;
         this.popupHandler = param2;
         hasClickGuard = false;
         super();
         this.bg = new menuBG_Loading();
         addChild(this.bg);
         if(titleFont)
         {
            titleFont.visible = false;
         }
         this.bg.drawtext.htmlText = customFont.getColors(this.bg.drawtext.text);
         this.bud = new BitmapData(381,32,true,5596791);
         this.over = new BitmapData(381,32,true,5596791);
         var _loc3_:Bitmap = new Bitmap(this.bud,"auto",true);
         this.bg.addChild(_loc3_);
         _loc3_.x = -174;
         _loc3_.y = 44;
         this.over.draw(SpriteUtils.groundClips[0],new Matrix(1 / 22,0,0,1 / 27,0,0),null,null,null,true);
         this.over.draw(SpriteUtils.groundClips[1],new Matrix(1 / 22,0,0,1 / 27,2800 * 1 / 22,0),null,null,null,true);
         rc(this.bg.btn_pmg,new eButton(0,0,global.pmg_button_title,this,global.pmg_button_command_loading),false,true);
         rc(this.bg.btn_continue,this.newContinue = new eButton(0,0,"Continue",this,"btn_continue"),false,true);
         this.newContinue.visible = false;
         this.bg.btn_continue.visible = false;
         this.bg.plaque.visible = false;
         World.currentLevel.staggeredLoadingStarted = true;
         gMode.keyMenu = this;
      }
      
      override public function keyDown(param1:KeyboardEvent) : void
      {
         if(param1.keyCode == Keyboard.ENTER || param1.keyCode == 82)
         {
            this.buttonPressed("btn_continue");
         }
      }
      
      override public function frame(param1:Event) : void
      {
         var _loc2_:Matrix = null;
         var _loc3_:Rectangle = null;
         super.frame(param1);
         this.flip = !this.flip;
         if(!World.currentLevel.staggeredLoadingComplete && World.currentLevel.staggeredLoadingBlock < Level.slMax && this.flip)
         {
            _loc2_ = new Matrix(1,0,0,1,0,0);
            _loc2_.scale(1 / 22,1 / 27);
            _loc3_ = new Rectangle(0,0,8400,960);
            SpriteUtils.drawGrass();
            SpriteUtils.gameClip.scrollRect = null;
            this.bud.draw(SpriteUtils.gameClip,_loc2_,null,null,null,true);
            this.bud.draw(this.over);
            World.currentLevel.staggeredLoadingBlock = World.currentLevel.staggeredLoadingBlock + 1;
         }
         if(World.currentLevel.staggeredLoadingComplete && !GameMode.helpShown)
         {
            GameMode.helpShown = true;
            this.bg.plaque.visible = true;
            this.bg.btn_continue.visible = true;
            this.bg.btn_pmg.visible = false;
            this.bg.drawtext.visible = false;
            this.newContinue.visible = true;
         }
      }
      
      override public function buttonPressed(param1:String) : void
      {
         super.buttonPressed(param1);
         switch(param1)
         {
            case "btn_continue":
               this.continuePressed();
         }
      }
      
      public function continuePressed() : void
      {
         GameMode.gameMode.finishStaggeredLoading();
      }
      
      public function launchURL(param1:String) : void
      {
         gMode.launchURL(param1);
      }
   }
}
