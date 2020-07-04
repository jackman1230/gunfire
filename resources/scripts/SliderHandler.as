package
{
   public class SliderHandler
   {
      
      public static var tempButton:eButton;
      
      public static const outPos = -100;
      
      public static const inPos = 120;
      
      public static var numSliders = 0;
      
      public static var sliders:Vector.<Slider> = new Vector.<Slider>();
      
      public static var myParent;
      
      public static var self;
       
      
      public function SliderHandler(param1:*)
      {
         super();
         numSliders = 0;
         myParent = param1;
         self = this;
      }
      
      public static function addSlider(param1:String) : *
      {
         var _loc2_:Slider = null;
         _loc2_ = new Slider(sliders.length * 350,70 + sliders.length * 50,param1,myParent,SliderHandler.self);
         sliders.push(_loc2_);
         myParent.addChild(_loc2_);
         _loc2_.slide();
         numSliders++;
      }
      
      public static function notifyEnd(param1:Slider) : *
      {
         sliders.splice(sliders.indexOf(param1),1);
         numSliders--;
      }
   }
}
