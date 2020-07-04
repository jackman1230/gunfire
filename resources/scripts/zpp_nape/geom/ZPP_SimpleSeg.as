package zpp_nape.geom
{
   import flash.Boot;
   import zpp_nape.ZPP_ID;
   import zpp_nape.util.ZPP_Set_ZPP_SimpleSeg;
   import zpp_nape.util.ZPP_Set_ZPP_SimpleVert;
   
   public class ZPP_SimpleSeg
   {
      
      public static var zpp_pool:ZPP_SimpleSeg;
       
      
      public var vertices:ZPP_Set_ZPP_SimpleVert;
      
      public var right:ZPP_SimpleVert;
      
      public var prev:ZPP_SimpleSeg;
      
      public var node:ZPP_Set_ZPP_SimpleSeg;
      
      public var next:ZPP_SimpleSeg;
      
      public var left:ZPP_SimpleVert;
      
      public var id:int;
      
      public function ZPP_SimpleSeg()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         id = int(ZPP_ID.ZPP_SimpleSeg());
      }
      
      public static function get(param1:ZPP_SimpleVert, param2:ZPP_SimpleVert) : ZPP_SimpleSeg
      {
         var _loc3_:* = null as ZPP_SimpleSeg;
         if(ZPP_SimpleSeg.zpp_pool == null)
         {
            _loc3_ = new ZPP_SimpleSeg();
         }
         else
         {
            _loc3_ = ZPP_SimpleSeg.zpp_pool;
            ZPP_SimpleSeg.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         _loc3_.alloc();
         _loc3_.left = param1;
         _loc3_.right = param2;
         _loc3_.vertices.insert(param1);
         _loc3_.vertices.insert(param2);
         return _loc3_;
      }
      
      public function less_xy(param1:ZPP_SimpleVert, param2:ZPP_SimpleVert) : Boolean
      {
         return param1.x < param2.x || param1.x == param2.x && param1.y < param2.y;
      }
      
      public function free() : void
      {
         right = null;
         left = null;
         prev = null;
         node = null;
         vertices.clear();
         var _loc2_:ZPP_Set_ZPP_SimpleVert = vertices;
         _loc2_.free();
         _loc2_.next = ZPP_Set_ZPP_SimpleVert.zpp_pool;
         ZPP_Set_ZPP_SimpleVert.zpp_pool = _loc2_;
         vertices = null;
      }
      
      public function alloc() : void
      {
         if(ZPP_Set_ZPP_SimpleVert.zpp_pool == null)
         {
            vertices = new ZPP_Set_ZPP_SimpleVert();
         }
         else
         {
            vertices = ZPP_Set_ZPP_SimpleVert.zpp_pool;
            ZPP_Set_ZPP_SimpleVert.zpp_pool = vertices.next;
            vertices.next = null;
         }
         vertices.alloc();
         vertices.lt = less_xy;
      }
   }
}
