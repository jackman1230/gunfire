package
{
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyType;
   import objects.cObject;
   
   public class Boner extends Body
   {
       
      
      public var owner:cObject;
      
      public var isGround:Boolean = false;
      
      public var spriteOffsetX:Number = 0;
      
      public var spriteOffsetY:Number = 0;
      
      public function Boner(param1:BodyType = null, param2:Vec2 = null)
      {
         super(param1,param2);
      }
   }
}
