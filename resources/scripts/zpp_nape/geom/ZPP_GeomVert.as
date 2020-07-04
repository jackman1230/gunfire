package zpp_nape.geom
{
   import nape.geom.Vec2;
   
   public class ZPP_GeomVert
   {
      
      public static var zpp_pool:ZPP_GeomVert;
       
      
      public var y:Number;
      
      public var x:Number;
      
      public var wrap:Vec2;
      
      public var prev:ZPP_GeomVert;
      
      public var next:ZPP_GeomVert;
      
      public var forced:Boolean;
      
      public function ZPP_GeomVert()
      {
      }
      
      public static function get(param1:Number, param2:Number) : ZPP_GeomVert
      {
         var _loc3_:* = null as ZPP_GeomVert;
         if(ZPP_GeomVert.zpp_pool == null)
         {
            _loc3_ = new ZPP_GeomVert();
         }
         else
         {
            _loc3_ = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         _loc3_.alloc();
         _loc3_.x = param1;
         _loc3_.y = param2;
         return _loc3_;
      }
      
      public function wrapper() : Vec2
      {
         if(wrap == null)
         {
            wrap = Vec2.get(x,y);
            wrap.zpp_inner._inuse = true;
            wrap.zpp_inner._invalidate = modwrap;
            wrap.zpp_inner._validate = getwrap;
         }
         return wrap;
      }
      
      public function modwrap(param1:ZPP_Vec2) : void
      {
         x = param1.x;
         y = param1.y;
      }
      
      public function getwrap() : void
      {
         wrap.zpp_inner.x = x;
         wrap.zpp_inner.y = y;
      }
      
      public function free() : void
      {
         if(wrap != null)
         {
            wrap.zpp_inner._inuse = false;
            wrap.dispose();
            wrap = null;
         }
         next = null;
         prev = null;
      }
      
      public function alloc() : void
      {
         forced = false;
      }
   }
}
