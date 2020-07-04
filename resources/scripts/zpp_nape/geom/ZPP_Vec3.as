package zpp_nape.geom
{
   import flash.Boot;
   import nape.geom.Vec3;
   
   public class ZPP_Vec3
   {
       
      
      public var z:Number;
      
      public var y:Number;
      
      public var x:Number;
      
      public var outer:Vec3;
      
      public var immutable:Boolean;
      
      public var _validate:Object;
      
      public function ZPP_Vec3()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         immutable = false;
         _validate = null;
      }
   }
}
