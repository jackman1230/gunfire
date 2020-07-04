package zpp_nape.util
{
   import avm2.intrinsics.memory.lf32;
   import avm2.intrinsics.memory.li32;
   import avm2.intrinsics.memory.sf32;
   import avm2.intrinsics.memory.si32;
   import flash.Boot;
   import nape.geom.Mat23;
   import nape.geom.Vec2;
   import nape.util.Debug;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Mat23;
   import zpp_nape.geom.ZPP_Vec2;
   
   public class ZPP_Debug
   {
      
      public static var §internal§:Boolean = false;
       
      
      public var xnull:Boolean;
      
      public var xform:ZPP_Mat23;
      
      public var xdet:Number;
      
      public var width:int;
      
      public var viewport:ZPP_AABB;
      
      public var tmpab:ZPP_AABB;
      
      public var outer:Debug;
      
      public var isbmp:Boolean;
      
      public var iport:ZPP_AABB;
      
      public var height:int;
      
      public var d_shape:ZPP_ShapeDebug;
      
      public var d_bmp:ZPP_BitmapDebug;
      
      public var bg_r:Number;
      
      public var bg_g:Number;
      
      public var bg_col:int;
      
      public var bg_b:Number;
      
      public function ZPP_Debug(param1:int = 0, param2:int = 0)
      {
         var _loc3_:* = null as ZPP_AABB;
         if(Boot.skip_constructor)
         {
            return;
         }
         xnull = true;
         xdet = 1;
         width = param1;
         height = param2;
         §§push();
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc3_ = new ZPP_AABB();
         }
         else
         {
            _loc3_ = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         null;
         _loc3_.minx = 0;
         _loc3_.miny = 0;
         _loc3_.maxx = param1;
         _loc3_.maxy = param2;
         §§pop().viewport = _loc3_;
         §§push();
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc3_ = new ZPP_AABB();
         }
         else
         {
            _loc3_ = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         null;
         _loc3_.minx = 0;
         _loc3_.miny = 0;
         _loc3_.maxx = param1;
         _loc3_.maxy = param2;
         §§pop().iport = _loc3_;
         tmpab = new ZPP_AABB();
      }
      
      public function xform_invalidate() : void
      {
         var _loc2_:Number = NaN;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc3_:Mat23 = xform.outer;
         _loc2_ = _loc3_.zpp_inner.a * _loc3_.zpp_inner.d - _loc3_.zpp_inner.b * _loc3_.zpp_inner.c;
         var _loc1_:Number = _loc2_ < 0?-_loc2_:_loc2_;
         §§push();
         if(_loc1_ == 0)
         {
            §§push(0);
         }
         else
         {
            sf32(_loc1_,0);
            si32(1597463007 - (li32(0) >> 1),0);
            _loc2_ = lf32(0);
            §§push(1 / (_loc2_ * (1.5 - 0.5 * _loc1_ * _loc2_ * _loc2_)));
         }
         §§pop().xdet = §§pop();
         xnull = xform.a == 1 && xform.b == 0 && xform.c == 0 && xform.d == 1 && xform.tx == 0 && xform.ty == 0;
         _loc3_ = xform.outer.inverse();
         var _loc4_:Vec2 = Vec2.get();
         var _loc5_:Vec2 = _loc3_.transform(_loc4_);
         _loc6_ = _loc5_.zpp_inner;
         §§push(iport);
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§pop().minx = _loc5_.zpp_inner.x;
         _loc6_ = _loc5_.zpp_inner;
         §§push(iport);
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         §§pop().miny = _loc5_.zpp_inner.y;
         iport.maxx = iport.minx;
         iport.maxy = iport.miny;
         _loc5_.dispose();
         _loc1_ = width;
         _loc6_ = _loc4_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         if(_loc4_.zpp_inner.x != _loc1_)
         {
            _loc4_.zpp_inner.x = _loc1_;
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate(_loc6_);
            }
         }
         _loc6_ = _loc4_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc4_.zpp_inner.x;
         _loc5_ = _loc3_.transform(_loc4_);
         var _loc7_:ZPP_AABB = iport;
         _loc6_ = _loc5_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc1_ = _loc5_.zpp_inner.x;
         _loc6_ = _loc5_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc2_ = _loc5_.zpp_inner.y;
         if(_loc1_ < _loc7_.minx)
         {
            _loc7_.minx = _loc1_;
         }
         if(_loc1_ > _loc7_.maxx)
         {
            _loc7_.maxx = _loc1_;
         }
         if(_loc2_ < _loc7_.miny)
         {
            _loc7_.miny = _loc2_;
         }
         if(_loc2_ > _loc7_.maxy)
         {
            _loc7_.maxy = _loc2_;
         }
         _loc5_.dispose();
         _loc1_ = height;
         _loc6_ = _loc4_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         if(_loc4_.zpp_inner.y != _loc1_)
         {
            _loc4_.zpp_inner.y = _loc1_;
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate(_loc6_);
            }
         }
         _loc6_ = _loc4_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc4_.zpp_inner.y;
         _loc5_ = _loc3_.transform(_loc4_);
         _loc7_ = iport;
         _loc6_ = _loc5_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc1_ = _loc5_.zpp_inner.x;
         _loc6_ = _loc5_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc2_ = _loc5_.zpp_inner.y;
         if(_loc1_ < _loc7_.minx)
         {
            _loc7_.minx = _loc1_;
         }
         if(_loc1_ > _loc7_.maxx)
         {
            _loc7_.maxx = _loc1_;
         }
         if(_loc2_ < _loc7_.miny)
         {
            _loc7_.miny = _loc2_;
         }
         if(_loc2_ > _loc7_.maxy)
         {
            _loc7_.maxy = _loc2_;
         }
         _loc5_.dispose();
         _loc6_ = _loc4_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         if(_loc4_.zpp_inner.x != 0)
         {
            _loc4_.zpp_inner.x = 0;
            _loc6_ = _loc4_.zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate(_loc6_);
            }
         }
         _loc6_ = _loc4_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc4_.zpp_inner.x;
         _loc5_ = _loc3_.transform(_loc4_);
         _loc7_ = iport;
         _loc6_ = _loc5_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc1_ = _loc5_.zpp_inner.x;
         _loc6_ = _loc5_.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc2_ = _loc5_.zpp_inner.y;
         if(_loc1_ < _loc7_.minx)
         {
            _loc7_.minx = _loc1_;
         }
         if(_loc1_ > _loc7_.maxx)
         {
            _loc7_.maxx = _loc1_;
         }
         if(_loc2_ < _loc7_.miny)
         {
            _loc7_.miny = _loc2_;
         }
         if(_loc2_ > _loc7_.maxy)
         {
            _loc7_.maxy = _loc2_;
         }
         _loc5_.dispose();
         _loc4_.dispose();
      }
      
      public function sup_setbg(param1:int) : void
      {
         bg_r = param1 >> 16 & 255;
         bg_g = param1 >> 8 & 255;
         bg_b = param1 & 255;
         bg_col = param1;
      }
      
      public function setform() : void
      {
         xform = new Mat23().zpp_inner;
         xform._invalidate = xform_invalidate;
      }
      
      public function cull(param1:ZPP_AABB) : Boolean
      {
         var _loc2_:* = null as ZPP_AABB;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc7_:* = null as ZPP_AABB;
         if(xnull)
         {
            _loc2_ = viewport;
            return _loc2_.miny <= param1.maxy && param1.miny <= _loc2_.maxy && _loc2_.minx <= param1.maxx && param1.minx <= _loc2_.maxx;
         }
         _loc5_ = param1.minx;
         _loc6_ = param1.miny;
         tmpab.minx = Number(Number(xform.a * _loc5_ + xform.b * _loc6_) + xform.tx);
         tmpab.miny = Number(Number(xform.c * _loc5_ + xform.d * _loc6_) + xform.ty);
         tmpab.maxx = tmpab.minx;
         tmpab.maxy = tmpab.miny;
         _loc5_ = param1.maxx;
         _loc3_ = Number(Number(xform.a * _loc5_ + xform.b * _loc6_) + xform.tx);
         _loc4_ = Number(Number(xform.c * _loc5_ + xform.d * _loc6_) + xform.ty);
         _loc2_ = tmpab;
         if(_loc3_ < _loc2_.minx)
         {
            _loc2_.minx = _loc3_;
         }
         if(_loc3_ > _loc2_.maxx)
         {
            _loc2_.maxx = _loc3_;
         }
         if(_loc4_ < _loc2_.miny)
         {
            _loc2_.miny = _loc4_;
         }
         if(_loc4_ > _loc2_.maxy)
         {
            _loc2_.maxy = _loc4_;
         }
         _loc6_ = param1.maxy;
         _loc3_ = Number(Number(xform.a * _loc5_ + xform.b * _loc6_) + xform.tx);
         _loc4_ = Number(Number(xform.c * _loc5_ + xform.d * _loc6_) + xform.ty);
         _loc2_ = tmpab;
         if(_loc3_ < _loc2_.minx)
         {
            _loc2_.minx = _loc3_;
         }
         if(_loc3_ > _loc2_.maxx)
         {
            _loc2_.maxx = _loc3_;
         }
         if(_loc4_ < _loc2_.miny)
         {
            _loc2_.miny = _loc4_;
         }
         if(_loc4_ > _loc2_.maxy)
         {
            _loc2_.maxy = _loc4_;
         }
         _loc5_ = param1.minx;
         _loc3_ = Number(Number(xform.a * _loc5_ + xform.b * _loc6_) + xform.tx);
         _loc4_ = Number(Number(xform.c * _loc5_ + xform.d * _loc6_) + xform.ty);
         _loc2_ = tmpab;
         if(_loc3_ < _loc2_.minx)
         {
            _loc2_.minx = _loc3_;
         }
         if(_loc3_ > _loc2_.maxx)
         {
            _loc2_.maxx = _loc3_;
         }
         if(_loc4_ < _loc2_.miny)
         {
            _loc2_.miny = _loc4_;
         }
         if(_loc4_ > _loc2_.maxy)
         {
            _loc2_.maxy = _loc4_;
         }
         _loc2_ = tmpab;
         _loc7_ = viewport;
         return _loc7_.miny <= _loc2_.maxy && _loc2_.miny <= _loc7_.maxy && _loc7_.minx <= _loc2_.maxx && _loc2_.minx <= _loc7_.maxx;
      }
   }
}
