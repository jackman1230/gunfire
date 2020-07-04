package nape.shape
{
   import flash.Boot;
   import nape.dynamics.InteractionFilter;
   import nape.geom.GeomPoly;
   import nape.geom.Vec2;
   import nape.geom.Vec2List;
   import nape.phys.Material;
   import zpp_nape.ZPP_Const;
   import zpp_nape.callbacks.ZPP_CbType;
   import zpp_nape.dynamics.ZPP_InteractionFilter;
   import zpp_nape.geom.ZPP_GeomVert;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Material;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.util.ZNPList_ZPP_Vec2;
   import zpp_nape.util.ZNPNode_ZPP_Vec2;
   
   public class Polygon extends Shape
   {
       
      
      public var zpp_inner_zn:ZPP_Polygon;
      
      public function Polygon(param1:*, param2:Material = undefined, param3:InteractionFilter = undefined)
      {
         var _loc4_:* = null as Array;
         var _loc5_:int = 0;
         var _loc6_:* = null;
         var _loc7_:* = null as Vec2;
         var _loc8_:* = null as Vector.<Vec2>;
         var _loc9_:* = null as Vec2;
         var _loc10_:* = null as Vec2List;
         var _loc11_:* = null as GeomPoly;
         var _loc12_:* = null as ZPP_GeomVert;
         var _loc13_:* = null as ZPP_GeomVert;
         var _loc14_:uint = 0;
         var _loc15_:* = null as ZNPList_ZPP_Vec2;
         var _loc16_:* = null as ZNPNode_ZPP_Vec2;
         var _loc17_:* = null as ZNPNode_ZPP_Vec2;
         var _loc18_:* = null as ZPP_Vec2;
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         zpp_inner_zn = new ZPP_Polygon();
         zpp_inner_zn.outer = this;
         zpp_inner_zn.outer_zn = this;
         zpp_inner = zpp_inner_zn;
         zpp_inner_i = zpp_inner;
         zpp_inner_i.outer_i = this;
         if(Std.§is§(param1,Array))
         {
            _loc4_ = param1;
            _loc5_ = 0;
            while(_loc5_ < int(_loc4_.length))
            {
               _loc6_ = _loc4_[_loc5_];
               _loc5_++;
               _loc7_ = _loc6_;
               if(zpp_inner_zn.wrap_lverts == null)
               {
                  zpp_inner_zn.getlverts();
               }
               zpp_inner_zn.wrap_lverts.push(_loc7_.copy());
            }
         }
         else if(Std.§is§(param1,ZPP_Const.vec2vector))
         {
            _loc8_ = param1;
            _loc5_ = 0;
            while(_loc5_ < _loc8_.length)
            {
               _loc7_ = _loc8_[_loc5_];
               _loc5_++;
               _loc9_ = _loc7_;
               if(zpp_inner_zn.wrap_lverts == null)
               {
                  zpp_inner_zn.getlverts();
               }
               zpp_inner_zn.wrap_lverts.push(_loc9_.copy());
            }
         }
         else if(Std.§is§(param1,Vec2List))
         {
            _loc10_ = param1;
            _loc6_ = _loc10_.iterator();
            while(true)
            {
               if(_loc6_.hasNext())
               {
                  _loc7_ = _loc6_.next();
                  if(zpp_inner_zn.wrap_lverts == null)
                  {
                     zpp_inner_zn.getlverts();
                  }
                  zpp_inner_zn.wrap_lverts.push(_loc7_.copy());
                  continue;
               }
            }
         }
         else if(Std.§is§(param1,GeomPoly))
         {
            _loc11_ = param1;
            _loc12_ = _loc11_.zpp_inner.vertices;
            if(_loc12_ != null)
            {
               _loc13_ = _loc12_;
               do
               {
                  _loc7_ = Vec2.get(_loc13_.x,_loc13_.y);
                  _loc13_ = _loc13_.next;
                  if(zpp_inner_zn.wrap_lverts == null)
                  {
                     zpp_inner_zn.getlverts();
                  }
                  zpp_inner_zn.wrap_lverts.push(_loc7_.copy());
                  _loc7_.dispose();
               }
               while(_loc13_ != _loc12_);
               
            }
         }
         if(Std.§is§(param1,Array))
         {
            _loc4_ = param1;
            _loc5_ = 0;
            while(_loc5_ < int(_loc4_.length))
            {
               _loc7_ = _loc4_[_loc5_];
               if(_loc7_.zpp_inner.weak)
               {
                  _loc7_.dispose();
                  §§push(true);
               }
               else
               {
                  §§push(false);
               }
               _loc4_.splice(_loc5_,1);
            }
         }
         else if(Std.§is§(param1,ZPP_Const.vec2vector))
         {
            _loc8_ = param1;
            if(!_loc8_.fixed)
            {
               _loc14_ = 0;
               while(_loc14_ < _loc8_.length)
               {
                  _loc7_ = _loc8_[_loc14_];
                  if(_loc7_.zpp_inner.weak)
                  {
                     _loc7_.dispose();
                     §§push(true);
                  }
                  else
                  {
                     §§push(false);
                  }
                  _loc8_.splice(_loc14_,1);
               }
            }
         }
         else if(Std.§is§(param1,Vec2List))
         {
            _loc10_ = param1;
            if(_loc10_.zpp_inner._validate != null)
            {
               _loc10_.zpp_inner._validate();
            }
            _loc15_ = _loc10_.zpp_inner.inner;
            _loc16_ = null;
            _loc17_ = _loc15_.head;
            while(_loc17_ != null)
            {
               _loc18_ = _loc17_.elt;
               if(_loc18_.outer.zpp_inner.weak)
               {
                  _loc17_ = _loc15_.erase(_loc16_);
                  if(_loc18_.outer.zpp_inner.weak)
                  {
                     _loc18_.outer.dispose();
                  }
               }
               else
               {
                  _loc16_ = _loc17_;
                  _loc17_ = _loc17_.next;
               }
            }
         }
         if(param2 == null)
         {
            if(ZPP_Material.zpp_pool == null)
            {
               zpp_inner.material = new ZPP_Material();
            }
            else
            {
               zpp_inner.material = ZPP_Material.zpp_pool;
               ZPP_Material.zpp_pool = zpp_inner.material.next;
               zpp_inner.material.next = null;
            }
            null;
         }
         else
         {
            zpp_inner.immutable_midstep("Shape::material");
            zpp_inner.setMaterial(param2.zpp_inner);
            zpp_inner.material.wrapper();
         }
         if(param3 == null)
         {
            if(ZPP_InteractionFilter.zpp_pool == null)
            {
               zpp_inner.filter = new ZPP_InteractionFilter();
            }
            else
            {
               zpp_inner.filter = ZPP_InteractionFilter.zpp_pool;
               ZPP_InteractionFilter.zpp_pool = zpp_inner.filter.next;
               zpp_inner.filter.next = null;
            }
            null;
         }
         else
         {
            zpp_inner.immutable_midstep("Shape::filter");
            zpp_inner.setFilter(param3.zpp_inner);
            zpp_inner.filter.wrapper();
         }
         zpp_inner_i.insert_cbtype(ZPP_CbType.ANY_SHAPE.zpp_inner);
      }
      
      public static function copy(param1:Polygon) : Polygon
      {
         var _loc2_:Shape = param1.zpp_inner.copy();
         return !!_loc2_.isPolygon()?_loc2_.zpp_inner.polygon.outer_zn:null;
      }
      
      public static function rect(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean = false) : Array
      {
         return [Vec2.get(param1,param2,param5),Vec2.get(Number(param1 + param3),param2,param5),Vec2.get(Number(param1 + param3),Number(param2 + param4),param5),Vec2.get(param1,Number(param2 + param4),param5)];
      }
      
      public static function box(param1:Number, param2:Number, param3:Boolean = false) : Array
      {
         return Polygon.rect(-param1 / 2,-param2 / 2,param1,param2,param3);
      }
      
      public static function regular(param1:Number, param2:Number, param3:int, param4:Number = 0.0, param5:Boolean = false) : Array
      {
         var _loc9_:int = 0;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as Vec2;
         var _loc6_:Array = [];
         var _loc7_:Number = Math.PI * 2 / param3;
         var _loc8_:int = 0;
         while(_loc8_ < param3)
         {
            _loc8_++;
            _loc9_ = _loc8_;
            _loc10_ = Number(_loc9_ * _loc7_ + param4);
            _loc11_ = Vec2.get(Math.cos(_loc10_) * param1 / 2,Math.sin(_loc10_) * param2 / 2,param5);
            _loc6_.push(_loc11_);
         }
         return _loc6_;
      }
      
      public function validity() : ValidationResult
      {
         return zpp_inner_zn.valid();
      }
      
      public function get worldVerts() : Vec2List
      {
         if(zpp_inner_zn.wrap_gverts == null)
         {
            zpp_inner_zn.getgverts();
         }
         return zpp_inner_zn.wrap_gverts;
      }
      
      public function get localVerts() : Vec2List
      {
         if(zpp_inner_zn.wrap_lverts == null)
         {
            zpp_inner_zn.getlverts();
         }
         return zpp_inner_zn.wrap_lverts;
      }
      
      public function get edges() : EdgeList
      {
         if(zpp_inner_zn.wrap_edges == null)
         {
            zpp_inner_zn.getedges();
         }
         return zpp_inner_zn.wrap_edges;
      }
   }
}
