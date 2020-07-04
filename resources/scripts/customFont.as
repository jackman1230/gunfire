package
{
   import flash.display.Sprite;
   import flash.filters.DropShadowFilter;
   import flash.filters.GlowFilter;
   import flash.text.AntiAliasType;
   import flash.text.Font;
   import flash.text.TextField;
   import flash.text.TextFieldAutoSize;
   import flash.text.TextFormat;
   import flash.text.TextFormatAlign;
   
   public class customFont extends Sprite
   {
      
      public static var lastVal:int = 0;
       
      
      public var currentText:String = "";
      
      public var labelHint:TextField;
      
      private var textFormat:TextFormat;
      
      public var hintFont:Font;
      
      public var gf:GlowFilter;
      
      public var centerMe:Boolean = false;
      
      public var sbg:Sprite;
      
      public var hasBackground:Boolean = false;
      
      public var fixedBackground:Boolean = false;
      
      public var damageBar:Sprite = null;
      
      public function customFont(param1:int, param2:String, param3:Boolean = false, param4:uint = 16776960, param5:uint = 3355443, param6:Boolean = false, param7:int = 0, param8:Boolean = false)
      {
         var _loc9_:Font = null;
         this.labelHint = new TextField();
         this.textFormat = new TextFormat();
         super();
         if(param7 == 1)
         {
            _loc9_ = new font_MyriadPro();
         }
         else
         {
            _loc9_ = new font_MyriadPro();
         }
         this.textFormat.font = _loc9_.fontName;
         this.textFormat.size = param1;
         this.textFormat.color = param4;
         this.textFormat.kerning = true;
         if(param3)
         {
            this.textFormat.align = TextFormatAlign.CENTER;
         }
         this.labelHint.embedFonts = true;
         this.labelHint.autoSize = TextFieldAutoSize.LEFT;
         this.textFormat.bold = true;
         this.labelHint.selectable = false;
         this.labelHint.antiAliasType = AntiAliasType.ADVANCED;
         this.labelHint.wordWrap = param6;
         this.labelHint.defaultTextFormat = this.textFormat;
         this.labelHint.setTextFormat(this.textFormat);
         this.sbg = new customFont_BG();
         this.sbg.alpha = 0.5;
         this.drawHtml(param2.toUpperCase());
         addChild(this.labelHint);
         if(param8 == false)
         {
            this.labelHint.filters = [new GlowFilter(param5,1,8,8,8,1,false,false),new DropShadowFilter(4,45,0,0.5)];
         }
         else
         {
            this.labelHint.filters = [new GlowFilter(param5,1,8,8,8,1,false,false)];
         }
         this.labelHint.x = 0;
         this.labelHint.y = 0;
         this.centerMe = param3;
         this.recenter();
      }
      
      public static function getColors(param1:String) : String
      {
         var _loc2_:* = "";
         var _loc4_:String = "";
         var _loc5_:int = 0;
         while(_loc5_ < param1.length)
         {
            _loc2_ = "<font color=\'#" + getNiceColor().toString(16) + "\'>";
            _loc4_ = _loc4_ + _loc2_;
            _loc4_ = _loc4_ + param1.charAt(_loc5_);
            _loc4_ = _loc4_ + "</font>";
            _loc5_++;
         }
         return _loc4_;
      }
      
      public static function getNiceColor() : int
      {
         lastVal++;
         if(lastVal == 4)
         {
            lastVal = 0;
         }
         if(lastVal == 0)
         {
            return 8052446;
         }
         if(lastVal == 1)
         {
            return 6029180;
         }
         if(lastVal == 2)
         {
            return 12577301;
         }
         return 16405827;
      }
      
      public function colorise() : *
      {
         this.drawHtml(getColors(this.currentText));
      }
      
      public function addBackground(param1:Boolean = false, param2:int = 0) : customFont
      {
         this.fixedBackground = param1;
         this.hasBackground = true;
         this.drawString(this.currentText);
         addChild(this.sbg);
         setChildIndex(this.sbg,0);
         return this;
      }
      
      public function addDamageBar(param1:Sprite) : void
      {
         this.damageBar = param1;
         addChild(this.damageBar);
      }
      
      public function recenter() : void
      {
         if(this.centerMe)
         {
            this.labelHint.x = 0 - this.labelHint.width / 2;
            this.labelHint.y = 0 - this.labelHint.height / 2;
         }
         else
         {
            this.labelHint.x = 0;
            this.labelHint.y = 0;
         }
      }
      
      public function setWrapWidth(param1:int) : void
      {
         this.labelHint.width = param1;
         this.recenter();
      }
      
      public function drawString(param1:String) : void
      {
         this.currentText = param1;
         this.labelHint.text = param1;
         this.labelHint.setTextFormat(this.textFormat);
         this.labelHint.defaultTextFormat = this.textFormat;
         this.recenter();
         this.updateBackground(param1);
      }
      
      public function drawHtml(param1:String) : void
      {
         this.currentText = param1;
         this.labelHint.text = "";
         this.labelHint.setTextFormat(this.textFormat);
         this.labelHint.defaultTextFormat = this.textFormat;
         this.labelHint.htmlText = param1;
         this.recenter();
         this.updateBackground(param1);
      }
      
      public function updateBackground(param1:String) : void
      {
         if(this.hasBackground)
         {
            if(this.fixedBackground)
            {
               this.sbg.x = 0;
               this.sbg.y = 0 + 4;
            }
            else
            {
               if(this.centerMe)
               {
                  this.sbg.x = 0;
                  this.sbg.y = 0;
               }
               else
               {
                  this.sbg.x = this.labelHint.width / 2;
                  this.sbg.y = this.labelHint.height / 2;
               }
               this.sbg.width = this.labelHint.width * 1.2;
               this.sbg.height = this.labelHint.height * 1.2;
            }
            this.sbg.visible = param1 != "" && param1 != " ";
         }
      }
   }
}
