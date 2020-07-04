package zpp_nape.shape
{
   import flash.Boot;
   import nape.geom.Vec2;
   import nape.shape.Edge;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.util.ZNPNode_ZPP_Edge;
   
   public class ZPP_Edge
   {
      
      public static var zpp_pool:ZPP_Edge;
      
      public static var §internal§:Boolean;
       
      
      public var wrap_lnorm:Vec2;
      
      public var wrap_gnorm:Vec2;
      
      public var tp1:Number;
      
      public var tp0:Number;
      
      public var polygon:ZPP_Polygon;
      
      public var outer:Edge;
      
      public var next:ZPP_Edge;
      
      public var lprojection:Number;
      
      public var lp1:ZPP_Vec2;
      
      public var lp0:ZPP_Vec2;
      
      public var lnormy:Number;
      
      public var lnormx:Number;
      
      public var length:Number;
      
      public var gprojection:Number;
      
      public var gp1:ZPP_Vec2;
      
      public var gp0:ZPP_Vec2;
      
      public var gnormy:Number;
      
      public var gnormx:Number;
      
      public function ZPP_Edge()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         lnormx = 0;
         lnormy = 0;
         gnormx = 0;
         gnormy = 0;
         length = 0;
         lprojection = 0;
         gprojection = 0;
      }
      
      public function wrapper() : Edge
      {
         if(outer == null)
         {
            ZPP_Edge.§internal§ = true;
            outer = new Edge();
            ZPP_Edge.§internal§ = false;
            outer.zpp_inner = this;
         }
         return outer;
      }
      
      public function lnorm_validate() : void
      {
         polygon.validate_laxi();
         wrap_lnorm.zpp_inner.x = lnormx;
         wrap_lnorm.zpp_inner.y = lnormy;
      }
      
      public function gnorm_validate() : void
      {
         var _loc2_:* = null as ZPP_Body;
         var _loc3_:* = null as ZNPNode_ZPP_Edge;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Edge;
         var _loc1_:ZPP_Polygon = polygon;
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
         wrap_gnorm.zpp_inner.x = gnormx;
         wrap_gnorm.zpp_inner.y = gnormy;
      }
      
      public function getlnorm() : void
      {
         wrap_lnorm = Vec2.get(lnormx,lnormy);
         wrap_lnorm.zpp_inner._immutable = true;
         wrap_lnorm.zpp_inner._validate = lnorm_validate;
      }
      
      public function getgnorm() : void
      {
         wrap_gnorm = Vec2.get(gnormx,gnormy);
         wrap_gnorm.zpp_inner._immutable = true;
         wrap_gnorm.zpp_inner._validate = gnorm_validate;
      }
   }
}
