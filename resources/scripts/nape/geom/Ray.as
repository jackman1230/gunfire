package nape.geom
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Ray;
   import zpp_nape.geom.ZPP_Vec2;
   
   public class Ray
   {
       
      
      public var zpp_inner:ZPP_Ray;
      
      public function Ray(param1:Vec2, param2:Vec2)
      {
         var _loc6_:* = null as ZPP_Vec2;
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = new ZPP_Ray();
         var _loc3_:Vec2 = zpp_inner.origin;
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc5_:Number = param1.zpp_inner.x;
         _loc6_ = param1.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         var _loc7_:Number = param1.zpp_inner.y;
         _loc6_ = _loc3_.zpp_inner;
         §§push(false);
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         if(_loc3_.zpp_inner.x == _loc5_)
         {
            §§pop();
            _loc6_ = _loc3_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(_loc3_.zpp_inner.y == _loc7_);
         }
         if(!§§pop())
         {
            _loc3_.zpp_inner.x = _loc5_;
            _loc3_.zpp_inner.y = _loc7_;
            _loc6_ = _loc3_.zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate(_loc6_);
            }
         }
         var _loc4_:Vec2 = _loc3_;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         _loc4_;
         zpp_inner.origin;
         _loc3_ = zpp_inner.direction;
         _loc6_ = param2.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc5_ = param2.zpp_inner.x;
         _loc6_ = param2.zpp_inner;
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         _loc7_ = param2.zpp_inner.y;
         _loc6_ = _loc3_.zpp_inner;
         §§push(false);
         if(_loc6_._validate != null)
         {
            _loc6_._validate();
         }
         if(_loc3_.zpp_inner.x == _loc5_)
         {
            §§pop();
            _loc6_ = _loc3_.zpp_inner;
            if(_loc6_._validate != null)
            {
               _loc6_._validate();
            }
            §§push(_loc3_.zpp_inner.y == _loc7_);
         }
         if(!§§pop())
         {
            _loc3_.zpp_inner.x = _loc5_;
            _loc3_.zpp_inner.y = _loc7_;
            _loc6_ = _loc3_.zpp_inner;
            if(_loc6_._invalidate != null)
            {
               _loc6_._invalidate(_loc6_);
            }
         }
         _loc4_ = _loc3_;
         if(param2.zpp_inner.weak)
         {
            param2.dispose();
         }
         _loc4_;
         zpp_inner.zip_dir = true;
         zpp_inner.direction;
         zpp_inner.maxdist = 1.79e308;
      }
      
      public static function fromSegment(param1:Vec2, param2:Vec2) : Ray
      {
         var _loc3_:Vec2 = param2.sub(param1,true);
         var _loc4_:Ray = new Ray(param1,_loc3_);
         var _loc7_:ZPP_Vec2 = param1.zpp_inner;
         §§push(_loc4_.zpp_inner);
         §§push(Math);
         if(_loc7_._validate != null)
         {
            _loc7_._validate();
         }
         _loc7_ = param2.zpp_inner;
         §§push(param1.zpp_inner.x);
         if(_loc7_._validate != null)
         {
            _loc7_._validate();
         }
         var _loc5_:Number = §§pop() - param2.zpp_inner.x;
         _loc7_ = param1.zpp_inner;
         if(_loc7_._validate != null)
         {
            _loc7_._validate();
         }
         _loc7_ = param2.zpp_inner;
         §§push(param1.zpp_inner.y);
         if(_loc7_._validate != null)
         {
            _loc7_._validate();
         }
         var _loc6_:Number = §§pop() - param2.zpp_inner.y;
         §§pop().maxdist = Number(§§pop().sqrt(Number(_loc5_ * _loc5_ + _loc6_ * _loc6_)));
         _loc4_.zpp_inner.maxdist;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         if(param2.zpp_inner.weak)
         {
            param2.dispose();
         }
         return _loc4_;
      }
      
      public function set origin(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc2_:Vec2 = zpp_inner.origin;
         _loc5_ = param1.zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         var _loc4_:Number = param1.zpp_inner.x;
         _loc5_ = param1.zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         var _loc6_:Number = param1.zpp_inner.y;
         _loc5_ = _loc2_.zpp_inner;
         §§push(false);
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         if(_loc2_.zpp_inner.x == _loc4_)
         {
            §§pop();
            _loc5_ = _loc2_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§push(_loc2_.zpp_inner.y == _loc6_);
         }
         if(!§§pop())
         {
            _loc2_.zpp_inner.x = _loc4_;
            _loc2_.zpp_inner.y = _loc6_;
            _loc5_ = _loc2_.zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate(_loc5_);
            }
         }
         var _loc3_:Vec2 = _loc2_;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         _loc3_;
         return zpp_inner.origin;
      }
      
      public function set maxDistance(param1:Number) : Number
      {
         zpp_inner.maxdist = param1;
         return zpp_inner.maxdist;
      }
      
      public function set direction(param1:Vec2) : Vec2
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc2_:Vec2 = zpp_inner.direction;
         _loc5_ = param1.zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         var _loc4_:Number = param1.zpp_inner.x;
         _loc5_ = param1.zpp_inner;
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         var _loc6_:Number = param1.zpp_inner.y;
         _loc5_ = _loc2_.zpp_inner;
         §§push(false);
         if(_loc5_._validate != null)
         {
            _loc5_._validate();
         }
         if(_loc2_.zpp_inner.x == _loc4_)
         {
            §§pop();
            _loc5_ = _loc2_.zpp_inner;
            if(_loc5_._validate != null)
            {
               _loc5_._validate();
            }
            §§push(_loc2_.zpp_inner.y == _loc6_);
         }
         if(!§§pop())
         {
            _loc2_.zpp_inner.x = _loc4_;
            _loc2_.zpp_inner.y = _loc6_;
            _loc5_ = _loc2_.zpp_inner;
            if(_loc5_._invalidate != null)
            {
               _loc5_._invalidate(_loc5_);
            }
         }
         var _loc3_:Vec2 = _loc2_;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         _loc3_;
         zpp_inner.zip_dir = true;
         return zpp_inner.direction;
      }
      
      public function get userData() : *
      {
         if(zpp_inner.userData == null)
         {
            zpp_inner.userData = {};
         }
         return zpp_inner.userData;
      }
      
      public function get origin() : Vec2
      {
         return zpp_inner.origin;
      }
      
      public function get maxDistance() : Number
      {
         return zpp_inner.maxdist;
      }
      
      public function get direction() : Vec2
      {
         return zpp_inner.direction;
      }
      
      public function copy() : Ray
      {
         var _loc1_:Ray = new Ray(zpp_inner.origin,zpp_inner.direction);
         _loc1_.zpp_inner.maxdist = zpp_inner.maxdist;
         _loc1_.zpp_inner.maxdist;
         return _loc1_;
      }
      
      public function at(param1:Number, param2:Boolean = false) : Vec2
      {
         zpp_inner.validate_dir();
         var _loc3_:Vec2 = zpp_inner.origin;
         var _loc4_:ZPP_Vec2 = _loc3_.zpp_inner;
         §§push(Vec2);
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         _loc3_ = zpp_inner.origin;
         _loc4_ = _loc3_.zpp_inner;
         §§push(Number(_loc3_.zpp_inner.x + param1 * zpp_inner.dirx));
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         return §§pop().get(§§pop(),Number(_loc3_.zpp_inner.y + param1 * zpp_inner.diry),param2);
      }
      
      public function aabb() : AABB
      {
         return zpp_inner.rayAABB().wrapper();
      }
   }
}
