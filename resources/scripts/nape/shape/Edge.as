package nape.shape
{
   import nape.geom.Vec2;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.shape.ZPP_Edge;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.util.ZNPNode_ZPP_Edge;
   
   public class Edge
   {
       
      
      public var zpp_inner:ZPP_Edge;
      
      public function Edge()
      {
      }
      
      public function toString() : String
      {
         var _loc1_:* = null as ZPP_Polygon;
         var _loc2_:* = null as ZPP_Body;
         var _loc3_:* = null as ZNPNode_ZPP_Edge;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Edge;
         if(zpp_inner.polygon == null)
         {
            return "Edge(object-pooled)";
         }
         if(zpp_inner.polygon.body == null)
         {
            zpp_inner.polygon.validate_laxi();
            return "{ localNormal : " + ("{ x: " + zpp_inner.lnormx + " y: " + zpp_inner.lnormy + " }") + " }";
         }
         _loc1_ = zpp_inner.polygon;
         if(_loc1_.zip_gaxi)
         {
            if(_loc1_.body != null)
            {
               _loc1_.zip_gaxi = false;
               _loc1_.validate_laxi();
               _loc2_ = _loc1_.body;
               if(_loc2_.zip_axis)
               {
                  _loc2_.zip_axis = false;
                  _loc2_.axisx = Number(Math.sin(_loc2_.rot));
                  _loc2_.axisy = Number(Math.cos(_loc2_.rot));
                  null;
               }
               _loc3_ = _loc1_.edges.head;
               _loc4_ = _loc1_.gverts.next;
               _loc5_ = _loc4_;
               _loc4_ = _loc4_.next;
               while(_loc4_ != null)
               {
                  _loc6_ = _loc4_;
                  _loc7_ = _loc3_.elt;
                  _loc3_ = _loc3_.next;
                  _loc7_.gp0 = _loc5_;
                  _loc7_.gp1 = _loc6_;
                  _loc7_.gnormx = _loc1_.body.axisy * _loc7_.lnormx - _loc1_.body.axisx * _loc7_.lnormy;
                  _loc7_.gnormy = Number(_loc7_.lnormx * _loc1_.body.axisx + _loc7_.lnormy * _loc1_.body.axisy);
                  _loc7_.gprojection = Number(Number(_loc1_.body.posx * _loc7_.gnormx + _loc1_.body.posy * _loc7_.gnormy) + _loc7_.lprojection);
                  if(_loc7_.wrap_gnorm != null)
                  {
                     _loc7_.wrap_gnorm.zpp_inner.x = _loc7_.gnormx;
                     _loc7_.wrap_gnorm.zpp_inner.y = _loc7_.gnormy;
                  }
                  _loc7_.tp0 = _loc7_.gp0.y * _loc7_.gnormx - _loc7_.gp0.x * _loc7_.gnormy;
                  _loc7_.tp1 = _loc7_.gp1.y * _loc7_.gnormx - _loc7_.gp1.x * _loc7_.gnormy;
                  _loc5_ = _loc6_;
                  _loc4_ = _loc4_.next;
               }
               _loc6_ = _loc1_.gverts.next;
               _loc7_ = _loc3_.elt;
               _loc3_ = _loc3_.next;
               _loc7_.gp0 = _loc5_;
               _loc7_.gp1 = _loc6_;
               _loc7_.gnormx = _loc1_.body.axisy * _loc7_.lnormx - _loc1_.body.axisx * _loc7_.lnormy;
               _loc7_.gnormy = Number(_loc7_.lnormx * _loc1_.body.axisx + _loc7_.lnormy * _loc1_.body.axisy);
               _loc7_.gprojection = Number(Number(_loc1_.body.posx * _loc7_.gnormx + _loc1_.body.posy * _loc7_.gnormy) + _loc7_.lprojection);
               if(_loc7_.wrap_gnorm != null)
               {
                  _loc7_.wrap_gnorm.zpp_inner.x = _loc7_.gnormx;
                  _loc7_.wrap_gnorm.zpp_inner.y = _loc7_.gnormy;
               }
               _loc7_.tp0 = _loc7_.gp0.y * _loc7_.gnormx - _loc7_.gp0.x * _loc7_.gnormy;
               _loc7_.tp1 = _loc7_.gp1.y * _loc7_.gnormx - _loc7_.gp1.x * _loc7_.gnormy;
            }
         }
         return "{ localNormal : " + ("{ x: " + zpp_inner.lnormx + " y: " + zpp_inner.lnormy + " }") + " worldNormal : " + ("{ x: " + zpp_inner.gnormx + " y: " + zpp_inner.gnormy + " }") + " }";
      }
      
      public function get worldProjection() : Number
      {
         var _loc2_:* = null as ZPP_Body;
         var _loc3_:* = null as ZNPNode_ZPP_Edge;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Edge;
         var _loc1_:ZPP_Polygon = zpp_inner.polygon;
         if(_loc1_.zip_gaxi)
         {
            if(_loc1_.body != null)
            {
               _loc1_.zip_gaxi = false;
               _loc1_.validate_laxi();
               _loc2_ = _loc1_.body;
               if(_loc2_.zip_axis)
               {
                  _loc2_.zip_axis = false;
                  _loc2_.axisx = Number(Math.sin(_loc2_.rot));
                  _loc2_.axisy = Number(Math.cos(_loc2_.rot));
                  null;
               }
               _loc3_ = _loc1_.edges.head;
               _loc4_ = _loc1_.gverts.next;
               _loc5_ = _loc4_;
               _loc4_ = _loc4_.next;
               while(_loc4_ != null)
               {
                  _loc6_ = _loc4_;
                  _loc7_ = _loc3_.elt;
                  _loc3_ = _loc3_.next;
                  _loc7_.gp0 = _loc5_;
                  _loc7_.gp1 = _loc6_;
                  _loc7_.gnormx = _loc1_.body.axisy * _loc7_.lnormx - _loc1_.body.axisx * _loc7_.lnormy;
                  _loc7_.gnormy = Number(_loc7_.lnormx * _loc1_.body.axisx + _loc7_.lnormy * _loc1_.body.axisy);
                  _loc7_.gprojection = Number(Number(_loc1_.body.posx * _loc7_.gnormx + _loc1_.body.posy * _loc7_.gnormy) + _loc7_.lprojection);
                  if(_loc7_.wrap_gnorm != null)
                  {
                     _loc7_.wrap_gnorm.zpp_inner.x = _loc7_.gnormx;
                     _loc7_.wrap_gnorm.zpp_inner.y = _loc7_.gnormy;
                  }
                  _loc7_.tp0 = _loc7_.gp0.y * _loc7_.gnormx - _loc7_.gp0.x * _loc7_.gnormy;
                  _loc7_.tp1 = _loc7_.gp1.y * _loc7_.gnormx - _loc7_.gp1.x * _loc7_.gnormy;
                  _loc5_ = _loc6_;
                  _loc4_ = _loc4_.next;
               }
               _loc6_ = _loc1_.gverts.next;
               _loc7_ = _loc3_.elt;
               _loc3_ = _loc3_.next;
               _loc7_.gp0 = _loc5_;
               _loc7_.gp1 = _loc6_;
               _loc7_.gnormx = _loc1_.body.axisy * _loc7_.lnormx - _loc1_.body.axisx * _loc7_.lnormy;
               _loc7_.gnormy = Number(_loc7_.lnormx * _loc1_.body.axisx + _loc7_.lnormy * _loc1_.body.axisy);
               _loc7_.gprojection = Number(Number(_loc1_.body.posx * _loc7_.gnormx + _loc1_.body.posy * _loc7_.gnormy) + _loc7_.lprojection);
               if(_loc7_.wrap_gnorm != null)
               {
                  _loc7_.wrap_gnorm.zpp_inner.x = _loc7_.gnormx;
                  _loc7_.wrap_gnorm.zpp_inner.y = _loc7_.gnormy;
               }
               _loc7_.tp0 = _loc7_.gp0.y * _loc7_.gnormx - _loc7_.gp0.x * _loc7_.gnormy;
               _loc7_.tp1 = _loc7_.gp1.y * _loc7_.gnormx - _loc7_.gp1.x * _loc7_.gnormy;
            }
         }
         return zpp_inner.gprojection;
      }
      
      public function get worldNormal() : Vec2
      {
         if(zpp_inner.wrap_gnorm == null)
         {
            zpp_inner.getgnorm();
         }
         return zpp_inner.wrap_gnorm;
      }
      
      public function get localProjection() : Number
      {
         zpp_inner.polygon.validate_laxi();
         return zpp_inner.lprojection;
      }
      
      public function get localNormal() : Vec2
      {
         if(zpp_inner.wrap_lnorm == null)
         {
            zpp_inner.getlnorm();
         }
         return zpp_inner.wrap_lnorm;
      }
      
      public function get length() : Number
      {
         zpp_inner.polygon.validate_laxi();
         return zpp_inner.length;
      }
   }
}
