package nape.geom
{
   import flash.Boot;
   import nape.shape.Shape;
   
   public class RayResult
   {
       
      
      public var shape:Shape;
      
      public var normal:Vec2;
      
      public var inner:Boolean;
      
      public var distance:Number;
      
      public function RayResult(param1:Vec2, param2:Number, param3:Boolean, param4:Shape)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         normal = param1;
         distance = param2;
         inner = param3;
         shape = param4;
      }
      
      public function toString() : String
      {
         return "{ shape: " + Std.string(shape) + " distance: " + distance + " ?inner: " + Std.string(inner) + " }";
      }
   }
}
