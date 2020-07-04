package zpp_nape.geom
{
   import flash.Boot;
   
   public class ZPP_MarchSpan
   {
      
      public static var zpp_pool:ZPP_MarchSpan;
       
      
      public var rank:int;
      
      public var parent:ZPP_MarchSpan;
      
      public var out:Boolean;
      
      public var next:ZPP_MarchSpan;
      
      public var freed:Boolean;
      
      public function ZPP_MarchSpan()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         parent = this;
      }
      
      public function free() : void
      {
         freed = true;
         parent = this;
      }
      
      public function alloc() : void
      {
         freed = false;
         out = false;
         rank = 0;
      }
   }
}
