package nape.geom
{
   import flash.Boot;
   import zpp_nape.ZPP_Const;
   import zpp_nape.geom.ZPP_Convex;
   import zpp_nape.geom.ZPP_Cutter;
   import zpp_nape.geom.ZPP_GeomPoly;
   import zpp_nape.geom.ZPP_GeomVert;
   import zpp_nape.geom.ZPP_GeomVertexIterator;
   import zpp_nape.geom.ZPP_Monotone;
   import zpp_nape.geom.ZPP_PartitionedPoly;
   import zpp_nape.geom.ZPP_Simple;
   import zpp_nape.geom.ZPP_Simplify;
   import zpp_nape.geom.ZPP_Triangular;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.util.ZNPList_ZPP_GeomVert;
   import zpp_nape.util.ZNPList_ZPP_PartitionedPoly;
   import zpp_nape.util.ZNPList_ZPP_Vec2;
   import zpp_nape.util.ZNPNode_ZPP_GeomVert;
   import zpp_nape.util.ZNPNode_ZPP_PartitionedPoly;
   import zpp_nape.util.ZNPNode_ZPP_Vec2;
   import zpp_nape.util.ZPP_Flags;
   
   public class GeomPoly
   {
       
      
      public var zpp_inner:ZPP_GeomPoly;
      
      public function GeomPoly(param1:* = undefined)
      {
         var _loc2_:* = null as Array;
         var _loc3_:int = 0;
         var _loc4_:* = null;
         var _loc5_:* = null as Vec2;
         var _loc6_:* = null as ZPP_GeomVert;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZPP_GeomVert;
         var _loc9_:* = null as Vector.<Vec2>;
         var _loc10_:* = null as Vec2;
         var _loc11_:* = null as Vec2List;
         var _loc12_:* = null as GeomPoly;
         var _loc13_:* = null as ZPP_GeomVert;
         var _loc14_:* = null as ZPP_GeomVert;
         var _loc15_:uint = 0;
         var _loc16_:* = null as ZNPList_ZPP_Vec2;
         var _loc17_:* = null as ZNPNode_ZPP_Vec2;
         var _loc18_:* = null as ZNPNode_ZPP_Vec2;
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = new ZPP_GeomPoly(this);
         if(param1 != null)
         {
            if(Std.§is§(param1,Array))
            {
               _loc2_ = param1;
               _loc3_ = 0;
               while(_loc3_ < int(_loc2_.length))
               {
                  _loc4_ = _loc2_[_loc3_];
                  _loc3_++;
                  _loc5_ = _loc4_;
                  _loc7_ = _loc5_.zpp_inner;
                  §§push(zpp_inner);
                  §§push(ZPP_GeomVert);
                  if(_loc7_._validate != null)
                  {
                     _loc7_._validate();
                  }
                  _loc7_ = _loc5_.zpp_inner;
                  §§push(_loc5_.zpp_inner.x);
                  if(_loc7_._validate != null)
                  {
                     _loc7_._validate();
                  }
                  _loc6_ = §§pop().get(§§pop(),_loc5_.zpp_inner.y);
                  if(zpp_inner.vertices == null)
                  {
                     _loc8_ = _loc6_;
                     _loc6_.next = _loc8_;
                     _loc8_ = _loc8_;
                     _loc6_.prev = _loc8_;
                     zpp_inner.vertices = _loc8_;
                  }
                  else
                  {
                     _loc6_.prev = zpp_inner.vertices;
                     _loc6_.next = zpp_inner.vertices.next;
                     zpp_inner.vertices.next.prev = _loc6_;
                     zpp_inner.vertices.next = _loc6_;
                  }
                  §§pop().vertices = _loc6_;
               }
            }
            else if(Std.§is§(param1,ZPP_Const.vec2vector))
            {
               _loc9_ = param1;
               _loc3_ = 0;
               while(_loc3_ < _loc9_.length)
               {
                  _loc5_ = _loc9_[_loc3_];
                  _loc3_++;
                  _loc10_ = _loc5_;
                  _loc7_ = _loc10_.zpp_inner;
                  §§push(zpp_inner);
                  §§push(ZPP_GeomVert);
                  if(_loc7_._validate != null)
                  {
                     _loc7_._validate();
                  }
                  _loc7_ = _loc10_.zpp_inner;
                  §§push(_loc10_.zpp_inner.x);
                  if(_loc7_._validate != null)
                  {
                     _loc7_._validate();
                  }
                  _loc6_ = §§pop().get(§§pop(),_loc10_.zpp_inner.y);
                  if(zpp_inner.vertices == null)
                  {
                     _loc8_ = _loc6_;
                     _loc6_.next = _loc8_;
                     _loc8_ = _loc8_;
                     _loc6_.prev = _loc8_;
                     zpp_inner.vertices = _loc8_;
                  }
                  else
                  {
                     _loc6_.prev = zpp_inner.vertices;
                     _loc6_.next = zpp_inner.vertices.next;
                     zpp_inner.vertices.next.prev = _loc6_;
                     zpp_inner.vertices.next = _loc6_;
                  }
                  §§pop().vertices = _loc6_;
               }
            }
            else if(Std.§is§(param1,Vec2List))
            {
               _loc11_ = param1;
               _loc4_ = _loc11_.iterator();
               while(true)
               {
                  if(_loc4_.hasNext())
                  {
                     _loc5_ = _loc4_.next();
                     _loc7_ = _loc5_.zpp_inner;
                     §§push(zpp_inner);
                     §§push(ZPP_GeomVert);
                     if(_loc7_._validate != null)
                     {
                        _loc7_._validate();
                     }
                     _loc7_ = _loc5_.zpp_inner;
                     §§push(_loc5_.zpp_inner.x);
                     if(_loc7_._validate != null)
                     {
                        _loc7_._validate();
                     }
                     _loc6_ = §§pop().get(§§pop(),_loc5_.zpp_inner.y);
                     if(zpp_inner.vertices == null)
                     {
                        _loc8_ = _loc6_;
                        _loc6_.next = _loc8_;
                        _loc8_ = _loc8_;
                        _loc6_.prev = _loc8_;
                        zpp_inner.vertices = _loc8_;
                     }
                     else
                     {
                        _loc6_.prev = zpp_inner.vertices;
                        _loc6_.next = zpp_inner.vertices.next;
                        zpp_inner.vertices.next.prev = _loc6_;
                        zpp_inner.vertices.next = _loc6_;
                     }
                     §§pop().vertices = _loc6_;
                     continue;
                  }
               }
            }
            else if(Std.§is§(param1,GeomPoly))
            {
               _loc12_ = param1;
               _loc6_ = _loc12_.zpp_inner.vertices;
               if(_loc6_ != null)
               {
                  _loc8_ = _loc6_;
                  do
                  {
                     _loc5_ = Vec2.get(_loc8_.x,_loc8_.y);
                     _loc8_ = _loc8_.next;
                     _loc7_ = _loc5_.zpp_inner;
                     §§push(zpp_inner);
                     §§push(ZPP_GeomVert);
                     if(_loc7_._validate != null)
                     {
                        _loc7_._validate();
                     }
                     _loc7_ = _loc5_.zpp_inner;
                     §§push(_loc5_.zpp_inner.x);
                     if(_loc7_._validate != null)
                     {
                        _loc7_._validate();
                     }
                     _loc13_ = §§pop().get(§§pop(),_loc5_.zpp_inner.y);
                     if(zpp_inner.vertices == null)
                     {
                        _loc14_ = _loc13_;
                        _loc13_.next = _loc14_;
                        _loc14_ = _loc14_;
                        _loc13_.prev = _loc14_;
                        zpp_inner.vertices = _loc14_;
                     }
                     else
                     {
                        _loc13_.prev = zpp_inner.vertices;
                        _loc13_.next = zpp_inner.vertices.next;
                        zpp_inner.vertices.next.prev = _loc13_;
                        zpp_inner.vertices.next = _loc13_;
                     }
                     §§pop().vertices = _loc13_;
                     _loc5_.dispose();
                  }
                  while(_loc8_ != _loc6_);
                  
               }
            }
            if(Std.§is§(param1,Array))
            {
               _loc2_ = param1;
               _loc3_ = 0;
               while(_loc3_ < int(_loc2_.length))
               {
                  _loc5_ = _loc2_[_loc3_];
                  if(_loc5_.zpp_inner.weak)
                  {
                     _loc5_.dispose();
                     §§push(true);
                  }
                  else
                  {
                     §§push(false);
                  }
                  _loc2_.splice(_loc3_,1);
               }
            }
            else if(Std.§is§(param1,ZPP_Const.vec2vector))
            {
               _loc9_ = param1;
               if(!_loc9_.fixed)
               {
                  _loc15_ = 0;
                  while(_loc15_ < _loc9_.length)
                  {
                     _loc5_ = _loc9_[_loc15_];
                     if(_loc5_.zpp_inner.weak)
                     {
                        _loc5_.dispose();
                        §§push(true);
                     }
                     else
                     {
                        §§push(false);
                     }
                     _loc9_.splice(_loc15_,1);
                  }
               }
            }
            else if(Std.§is§(param1,Vec2List))
            {
               _loc11_ = param1;
               if(_loc11_.zpp_inner._validate != null)
               {
                  _loc11_.zpp_inner._validate();
               }
               _loc16_ = _loc11_.zpp_inner.inner;
               _loc17_ = null;
               _loc18_ = _loc16_.head;
               while(_loc18_ != null)
               {
                  _loc7_ = _loc18_.elt;
                  if(_loc7_.outer.zpp_inner.weak)
                  {
                     _loc18_ = _loc16_.erase(_loc17_);
                     if(_loc7_.outer.zpp_inner.weak)
                     {
                        _loc7_.outer.dispose();
                     }
                  }
                  else
                  {
                     _loc17_ = _loc18_;
                     _loc18_ = _loc18_.next;
                  }
               }
            }
         }
      }
      
      public function winding() : Winding
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as ZPP_GeomVert;
         if(zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next)
         {
            if(ZPP_Flags.Winding_UNDEFINED == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.Winding_UNDEFINED = new Winding();
               ZPP_Flags.§internal§ = false;
            }
            return ZPP_Flags.Winding_UNDEFINED;
         }
         _loc2_ = 0;
         _loc3_ = zpp_inner.vertices;
         _loc4_ = zpp_inner.vertices;
         if(_loc3_ != null)
         {
            _loc5_ = _loc3_;
            do
            {
               _loc6_ = _loc5_;
               _loc2_ = Number(_loc2_ + _loc6_.x * (_loc6_.next.y - _loc6_.prev.y));
               _loc5_ = _loc5_.next;
            }
            while(_loc5_ != _loc4_);
            
         }
         _loc1_ = _loc2_;
         if(_loc1_ > 0)
         {
            if(ZPP_Flags.Winding_CLOCKWISE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.Winding_CLOCKWISE = new Winding();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.Winding_CLOCKWISE);
         }
         else if(_loc1_ == 0)
         {
            if(ZPP_Flags.Winding_UNDEFINED == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.Winding_UNDEFINED = new Winding();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.Winding_UNDEFINED);
         }
         else
         {
            if(ZPP_Flags.Winding_ANTICLOCKWISE == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.Winding_ANTICLOCKWISE = new Winding();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.Winding_ANTICLOCKWISE);
         }
         return §§pop();
      }
      
      public function unshift(param1:Vec2) : GeomPoly
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc3_:ZPP_Vec2 = param1.zpp_inner;
         §§push(zpp_inner);
         §§push(ZPP_GeomVert);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = param1.zpp_inner;
         §§push(param1.zpp_inner.x);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc2_:ZPP_GeomVert = §§pop().get(§§pop(),param1.zpp_inner.y);
         if(zpp_inner.vertices == null)
         {
            _loc4_ = _loc2_;
            _loc2_.next = _loc4_;
            _loc4_ = _loc4_;
            _loc2_.prev = _loc4_;
            zpp_inner.vertices = _loc4_;
         }
         else
         {
            _loc2_.next = zpp_inner.vertices;
            _loc2_.prev = zpp_inner.vertices.prev;
            zpp_inner.vertices.prev.next = _loc2_;
            zpp_inner.vertices.prev = _loc2_;
         }
         §§pop().vertices = _loc2_;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return this;
      }
      
      public function triangular_decomposition() : GeomPolyList
      {
         var _loc3_:* = null as ZPP_PartitionedPoly;
         var _loc4_:* = null as ZNPList_ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as GeomPoly;
         var _loc1_:ZNPList_ZPP_PartitionedPoly = ZPP_Monotone.decompose(zpp_inner.vertices).extract_partitions();
         var _loc2_:GeomPolyList = new GeomPolyList();
         while(_loc1_.head != null)
         {
            _loc3_ = _loc1_.pop_unsafe();
            _loc4_ = ZPP_Triangular.triangulate(_loc3_).extract();
            while(_loc4_.head != null)
            {
               _loc5_ = _loc4_.pop_unsafe();
               _loc6_ = new GeomPoly();
               _loc6_.zpp_inner.vertices = _loc5_;
               _loc2_.add(_loc6_);
            }
         }
         return _loc2_;
      }
      
      public function transform(param1:Mat23) : GeomPoly
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:Number = NaN;
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               _loc6_ = Number(Number(param1.zpp_inner.a * _loc5_.x + param1.zpp_inner.b * _loc5_.y) + param1.zpp_inner.tx);
               _loc5_.y = Number(Number(param1.zpp_inner.c * _loc5_.x + param1.zpp_inner.d * _loc5_.y) + param1.zpp_inner.ty);
               _loc5_.x = _loc6_;
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         return this;
      }
      
      public function top() : Vec2
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc1_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices.next;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               if(_loc5_.y < _loc1_.y)
               {
                  _loc1_ = _loc5_;
               }
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         return _loc1_.wrapper();
      }
      
      public function toString() : String
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc1_:String = "GeomPoly[";
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               if(_loc5_ != zpp_inner.vertices)
               {
                  _loc1_ = _loc1_ + ",";
               }
               _loc1_ = _loc1_ + ("{" + _loc5_.x + "," + _loc5_.y + "}");
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         return _loc1_ + "]";
      }
      
      public function skip_forward(param1:int) : GeomPoly
      {
         if(zpp_inner.vertices != null)
         {
            if(param1 > 0)
            {
               while(true)
               {
                  param1--;
                  if(param1 <= 0)
                  {
                     break;
                  }
                  zpp_inner.vertices = zpp_inner.vertices.next;
               }
            }
            else if(param1 < 0)
            {
               while(true)
               {
                  param1++;
                  if(param1 >= 0)
                  {
                     break;
                  }
                  zpp_inner.vertices = zpp_inner.vertices.prev;
               }
            }
         }
         return this;
      }
      
      public function skip_backwards(param1:int) : GeomPoly
      {
         return skip_forward(-param1);
      }
      
      public function size() : int
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc1_:int = 0;
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               _loc1_++;
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         return _loc1_;
      }
      
      public function simplify(param1:Number) : GeomPoly
      {
         var _loc2_:* = null as ZPP_GeomVert;
         var _loc3_:* = null as GeomPoly;
         if(zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next)
         {
            return copy();
         }
         _loc2_ = ZPP_Simplify.simplify(zpp_inner.vertices,param1);
         _loc3_ = new GeomPoly();
         _loc3_.zpp_inner.vertices = _loc2_;
         return _loc3_;
      }
      
      public function simple_decomposition() : GeomPolyList
      {
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc4_:* = null as GeomPoly;
         var _loc1_:ZNPList_ZPP_GeomVert = ZPP_Simple.decompose(zpp_inner.vertices);
         var _loc2_:GeomPolyList = new GeomPolyList();
         while(_loc1_.head != null)
         {
            _loc3_ = _loc1_.pop_unsafe();
            _loc4_ = new GeomPoly();
            _loc4_.zpp_inner.vertices = _loc3_;
            _loc2_.add(_loc4_);
         }
         return _loc2_;
      }
      
      public function shift() : GeomPoly
      {
         var _loc2_:* = null as ZPP_GeomVert;
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc1_:ZPP_GeomVert = zpp_inner.vertices;
         §§push(zpp_inner);
         if(zpp_inner.vertices != null && zpp_inner.vertices.prev == zpp_inner.vertices)
         {
            _loc2_ = null;
            zpp_inner.vertices.prev = _loc2_;
            zpp_inner.vertices.next = _loc2_;
            _loc2_ = null;
            zpp_inner.vertices = _loc2_;
            §§push(_loc2_);
         }
         else
         {
            _loc2_ = zpp_inner.vertices.next;
            zpp_inner.vertices.prev.next = zpp_inner.vertices.next;
            zpp_inner.vertices.next.prev = zpp_inner.vertices.prev;
            _loc3_ = null;
            zpp_inner.vertices.prev = _loc3_;
            zpp_inner.vertices.next = _loc3_;
            zpp_inner.vertices = null;
            §§push(_loc2_);
         }
         §§pop().vertices = §§pop();
         _loc2_ = _loc1_;
         _loc2_.free();
         _loc2_.next = ZPP_GeomVert.zpp_pool;
         ZPP_GeomVert.zpp_pool = _loc2_;
         return this;
      }
      
      public function right() : Vec2
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc1_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices.next;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               if(_loc5_.x > _loc1_.x)
               {
                  _loc1_ = _loc5_;
               }
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         return _loc1_.wrapper();
      }
      
      public function push(param1:Vec2) : GeomPoly
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc3_:ZPP_Vec2 = param1.zpp_inner;
         §§push(zpp_inner);
         §§push(ZPP_GeomVert);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         _loc3_ = param1.zpp_inner;
         §§push(param1.zpp_inner.x);
         if(_loc3_._validate != null)
         {
            _loc3_._validate();
         }
         var _loc2_:ZPP_GeomVert = §§pop().get(§§pop(),param1.zpp_inner.y);
         if(zpp_inner.vertices == null)
         {
            _loc4_ = _loc2_;
            _loc2_.next = _loc4_;
            _loc4_ = _loc4_;
            _loc2_.prev = _loc4_;
            zpp_inner.vertices = _loc4_;
         }
         else
         {
            _loc2_.prev = zpp_inner.vertices;
            _loc2_.next = zpp_inner.vertices.next;
            zpp_inner.vertices.next.prev = _loc2_;
            zpp_inner.vertices.next = _loc2_;
         }
         §§pop().vertices = _loc2_;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return this;
      }
      
      public function pop() : GeomPoly
      {
         var _loc2_:* = null as ZPP_GeomVert;
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc1_:ZPP_GeomVert = zpp_inner.vertices;
         §§push(zpp_inner);
         if(zpp_inner.vertices != null && zpp_inner.vertices.prev == zpp_inner.vertices)
         {
            _loc2_ = null;
            zpp_inner.vertices.prev = _loc2_;
            zpp_inner.vertices.next = _loc2_;
            §§push(null);
         }
         else
         {
            _loc2_ = zpp_inner.vertices.prev;
            zpp_inner.vertices.prev.next = zpp_inner.vertices.next;
            zpp_inner.vertices.next.prev = zpp_inner.vertices.prev;
            _loc3_ = null;
            zpp_inner.vertices.prev = _loc3_;
            zpp_inner.vertices.next = _loc3_;
            zpp_inner.vertices = null;
            §§push(_loc2_);
         }
         §§pop().vertices = §§pop();
         _loc2_ = _loc1_;
         _loc2_.free();
         _loc2_.next = ZPP_GeomVert.zpp_pool;
         ZPP_GeomVert.zpp_pool = _loc2_;
         return this;
      }
      
      public function monotone_decomposition() : GeomPolyList
      {
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc4_:* = null as GeomPoly;
         var _loc1_:ZNPList_ZPP_GeomVert = ZPP_Monotone.decompose(zpp_inner.vertices).extract();
         var _loc2_:GeomPolyList = new GeomPolyList();
         while(_loc1_.head != null)
         {
            _loc3_ = _loc1_.pop_unsafe();
            _loc4_ = new GeomPoly();
            _loc4_.zpp_inner.vertices = _loc3_;
            _loc2_.add(_loc4_);
         }
         return _loc2_;
      }
      
      public function left() : Vec2
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc1_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices.next;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               if(_loc5_.x < _loc1_.x)
               {
                  _loc1_ = _loc5_;
               }
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         return _loc1_.wrapper();
      }
      
      public function iterator() : GeomVertexIterator
      {
         return ZPP_GeomVertexIterator.get(zpp_inner.vertices,true);
      }
      
      public function isSimple() : Boolean
      {
         return zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next?true:Boolean(ZPP_Simple.isSimple(zpp_inner.vertices));
      }
      
      public function isMonotone() : Boolean
      {
         return zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next?true:Boolean(ZPP_Monotone.isMonotone(zpp_inner.vertices));
      }
      
      public function isDegenerate() : Boolean
      {
         return zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next?true:Number(area()) < 1.0e-8;
      }
      
      public function isConvex() : Boolean
      {
         var _loc1_:Boolean = false;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as ZPP_GeomVert;
         var _loc7_:* = null as ZPP_GeomVert;
         var _loc8_:* = null as ZPP_GeomVert;
         var _loc9_:* = null as ZPP_GeomVert;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         if(zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next)
         {
            §§push(true);
         }
         else
         {
            _loc1_ = false;
            _loc2_ = false;
            _loc3_ = true;
            _loc4_ = zpp_inner.vertices;
            _loc5_ = zpp_inner.vertices;
            if(_loc4_ != null)
            {
               _loc6_ = _loc4_;
               do
               {
                  _loc7_ = _loc6_;
                  _loc8_ = _loc7_.prev;
                  _loc9_ = _loc7_.next;
                  _loc10_ = _loc9_.x - _loc7_.x;
                  _loc11_ = _loc9_.y - _loc7_.y;
                  _loc12_ = _loc7_.x - _loc8_.x;
                  _loc13_ = _loc7_.y - _loc8_.y;
                  _loc14_ = _loc13_ * _loc10_ - _loc12_ * _loc11_;
                  if(_loc14_ > 0)
                  {
                     _loc2_ = true;
                  }
                  else if(_loc14_ < 0)
                  {
                     _loc1_ = true;
                  }
                  if(!!_loc2_ && _loc1_)
                  {
                     _loc3_ = false;
                     break;
                  }
                  _loc6_ = _loc6_.next;
               }
               while(_loc6_ != _loc5_);
               
            }
            §§push(_loc3_);
         }
         return §§pop();
      }
      
      public function isClockwise() : Boolean
      {
         §§push(winding());
         if(ZPP_Flags.Winding_CLOCKWISE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.Winding_CLOCKWISE = new Winding();
            ZPP_Flags.§internal§ = false;
         }
         return §§pop() == ZPP_Flags.Winding_CLOCKWISE;
      }
      
      public function forward_iterator() : GeomVertexIterator
      {
         return ZPP_GeomVertexIterator.get(zpp_inner.vertices,true);
      }
      
      public function erase(param1:int) : GeomPoly
      {
         var _loc2_:* = null as ZPP_GeomVert;
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc4_:* = null as ZPP_GeomVert;
         while(param1 != 0 && zpp_inner.vertices != null)
         {
            _loc2_ = zpp_inner.vertices;
            if(param1 > 0)
            {
               §§push(zpp_inner);
               if(zpp_inner.vertices != null && zpp_inner.vertices.prev == zpp_inner.vertices)
               {
                  _loc3_ = null;
                  zpp_inner.vertices.prev = _loc3_;
                  zpp_inner.vertices.next = _loc3_;
                  _loc3_ = null;
                  zpp_inner.vertices = _loc3_;
                  §§push(_loc3_);
               }
               else
               {
                  _loc3_ = zpp_inner.vertices.next;
                  zpp_inner.vertices.prev.next = zpp_inner.vertices.next;
                  zpp_inner.vertices.next.prev = zpp_inner.vertices.prev;
                  _loc4_ = null;
                  zpp_inner.vertices.prev = _loc4_;
                  zpp_inner.vertices.next = _loc4_;
                  zpp_inner.vertices = null;
                  §§push(_loc3_);
               }
               §§pop().vertices = §§pop();
               param1--;
            }
            else if(param1 < 0)
            {
               §§push(zpp_inner);
               if(zpp_inner.vertices != null && zpp_inner.vertices.prev == zpp_inner.vertices)
               {
                  _loc3_ = null;
                  zpp_inner.vertices.prev = _loc3_;
                  zpp_inner.vertices.next = _loc3_;
                  §§push(null);
               }
               else
               {
                  _loc3_ = zpp_inner.vertices.prev;
                  zpp_inner.vertices.prev.next = zpp_inner.vertices.next;
                  zpp_inner.vertices.next.prev = zpp_inner.vertices.prev;
                  _loc4_ = null;
                  zpp_inner.vertices.prev = _loc4_;
                  zpp_inner.vertices.next = _loc4_;
                  zpp_inner.vertices = null;
                  §§push(_loc3_);
               }
               §§pop().vertices = §§pop();
               param1++;
            }
            _loc3_ = _loc2_;
            _loc3_.free();
            _loc3_.next = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc3_;
         }
         return this;
      }
      
      public function empty() : Boolean
      {
         return zpp_inner.vertices == null;
      }
      
      public function cut(param1:Vec2, param2:Vec2, param3:Boolean = false, param4:Boolean = false) : GeomPolyList
      {
         var _loc5_:GeomPolyList = ZPP_Cutter.run(zpp_inner.vertices,param1,param2,param3,param4);
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         if(param2.zpp_inner.weak)
         {
            param2.dispose();
         }
         return _loc5_;
      }
      
      public function current() : Vec2
      {
         return zpp_inner.vertices.wrapper();
      }
      
      public function copy() : GeomPoly
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as ZPP_GeomVert;
         var _loc7_:* = null as ZPP_GeomVert;
         var _loc1_:GeomPoly = new GeomPoly();
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               _loc6_ = ZPP_GeomVert.get(_loc5_.x,_loc5_.y);
               §§push(_loc1_.zpp_inner);
               if(_loc1_.zpp_inner.vertices == null)
               {
                  _loc7_ = _loc6_;
                  _loc6_.next = _loc7_;
                  _loc7_ = _loc7_;
                  _loc6_.prev = _loc7_;
                  _loc1_.zpp_inner.vertices = _loc7_;
               }
               else
               {
                  _loc6_.prev = _loc1_.zpp_inner.vertices;
                  _loc6_.next = _loc1_.zpp_inner.vertices.next;
                  _loc1_.zpp_inner.vertices.next.prev = _loc6_;
                  _loc1_.zpp_inner.vertices.next = _loc6_;
               }
               §§pop().vertices = _loc6_;
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         return _loc1_;
      }
      
      public function convex_decomposition() : GeomPolyList
      {
         var _loc3_:* = null as ZPP_PartitionedPoly;
         var _loc4_:* = null as ZNPList_ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as GeomPoly;
         var _loc1_:ZNPList_ZPP_PartitionedPoly = ZPP_Monotone.decompose(zpp_inner.vertices).extract_partitions();
         var _loc2_:GeomPolyList = new GeomPolyList();
         while(_loc1_.head != null)
         {
            _loc3_ = _loc1_.pop_unsafe();
            ZPP_Triangular.triangulate(_loc3_);
            ZPP_Convex.optimise(_loc3_);
            _loc4_ = _loc3_.extract();
            while(_loc4_.head != null)
            {
               _loc5_ = _loc4_.pop_unsafe();
               _loc6_ = new GeomPoly();
               _loc6_.zpp_inner.vertices = _loc5_;
               _loc2_.add(_loc6_);
            }
         }
         return _loc2_;
      }
      
      public function contains(param1:Vec2) : Boolean
      {
         var _loc9_:* = null as ZPP_GeomVert;
         var _loc10_:* = null as ZPP_GeomVert;
         var _loc11_:* = null as ZPP_GeomVert;
         var _loc4_:ZPP_Vec2 = param1.zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc3_:Number = param1.zpp_inner.x;
         _loc4_ = param1.zpp_inner;
         if(_loc4_._validate != null)
         {
            _loc4_._validate();
         }
         var _loc5_:Number = param1.zpp_inner.y;
         var _loc6_:* = false;
         var _loc7_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc8_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc7_ != null)
         {
            _loc9_ = _loc7_;
            do
            {
               _loc10_ = _loc9_;
               _loc11_ = _loc10_.prev;
               if((_loc10_.y < _loc5_ && _loc11_.y >= _loc5_ || _loc11_.y < _loc5_ && _loc10_.y >= _loc5_) && (_loc10_.x <= _loc3_ || _loc11_.x <= _loc3_))
               {
                  if(Number(_loc10_.x + (_loc5_ - _loc10_.y) / (_loc11_.y - _loc10_.y) * (_loc11_.x - _loc10_.x)) < _loc3_)
                  {
                     _loc6_ = !_loc6_;
                  }
               }
               _loc9_ = _loc9_.next;
            }
            while(_loc9_ != _loc8_);
            
         }
         var _loc2_:Boolean = _loc6_;
         if(param1.zpp_inner.weak)
         {
            param1.dispose();
         }
         return _loc2_;
      }
      
      public function clear() : GeomPoly
      {
         var _loc1_:* = null as ZPP_GeomVert;
         var _loc2_:* = null as ZPP_GeomVert;
         var _loc3_:* = null as ZPP_GeomVert;
         while(zpp_inner.vertices != null)
         {
            _loc1_ = zpp_inner.vertices;
            §§push(zpp_inner);
            if(zpp_inner.vertices != null && zpp_inner.vertices.prev == zpp_inner.vertices)
            {
               _loc2_ = null;
               zpp_inner.vertices.prev = _loc2_;
               zpp_inner.vertices.next = _loc2_;
               _loc2_ = null;
               zpp_inner.vertices = _loc2_;
               §§push(_loc2_);
            }
            else
            {
               _loc2_ = zpp_inner.vertices.next;
               zpp_inner.vertices.prev.next = zpp_inner.vertices.next;
               zpp_inner.vertices.next.prev = zpp_inner.vertices.prev;
               _loc3_ = null;
               zpp_inner.vertices.prev = _loc3_;
               zpp_inner.vertices.next = _loc3_;
               zpp_inner.vertices = null;
               §§push(_loc2_);
            }
            §§pop().vertices = §§pop();
            _loc2_ = _loc1_;
            _loc2_.free();
            _loc2_.next = ZPP_GeomVert.zpp_pool;
            ZPP_GeomVert.zpp_pool = _loc2_;
         }
         return this;
      }
      
      public function bounds() : AABB
      {
         var _loc7_:* = null as ZPP_GeomVert;
         var _loc8_:* = null as ZPP_GeomVert;
         var _loc1_:Number = 1.0e100;
         var _loc2_:Number = 1.0e100;
         var _loc3_:Number = -1.0e100;
         var _loc4_:Number = -1.0e100;
         var _loc5_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc6_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc5_ != null)
         {
            _loc7_ = _loc5_;
            do
            {
               _loc8_ = _loc7_;
               if(_loc8_.x < _loc1_)
               {
                  _loc1_ = _loc8_.x;
               }
               if(_loc8_.y < _loc2_)
               {
                  _loc2_ = _loc8_.y;
               }
               if(_loc8_.x > _loc3_)
               {
                  _loc3_ = _loc8_.x;
               }
               if(_loc8_.y > _loc4_)
               {
                  _loc4_ = _loc8_.y;
               }
               _loc7_ = _loc7_.next;
            }
            while(_loc7_ != _loc6_);
            
         }
         return new AABB(_loc1_,_loc2_,_loc3_ - _loc1_,_loc4_ - _loc2_);
      }
      
      public function bottom() : Vec2
      {
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc1_:ZPP_GeomVert = zpp_inner.vertices;
         var _loc2_:ZPP_GeomVert = zpp_inner.vertices.next;
         var _loc3_:ZPP_GeomVert = zpp_inner.vertices;
         if(_loc2_ != null)
         {
            _loc4_ = _loc2_;
            do
            {
               _loc5_ = _loc4_;
               if(_loc5_.y > _loc1_.y)
               {
                  _loc1_ = _loc5_;
               }
               _loc4_ = _loc4_.next;
            }
            while(_loc4_ != _loc3_);
            
         }
         return _loc1_.wrapper();
      }
      
      public function backwards_iterator() : GeomVertexIterator
      {
         return ZPP_GeomVertexIterator.get(zpp_inner.vertices,false);
      }
      
      public function area() : Number
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:* = null as ZPP_GeomVert;
         var _loc4_:* = null as ZPP_GeomVert;
         var _loc5_:* = null as ZPP_GeomVert;
         var _loc6_:* = null as ZPP_GeomVert;
         if(zpp_inner.vertices == null || zpp_inner.vertices.next == null || zpp_inner.vertices.prev == zpp_inner.vertices.next)
         {
            §§push(0);
         }
         else
         {
            _loc2_ = 0;
            _loc3_ = zpp_inner.vertices;
            _loc4_ = zpp_inner.vertices;
            if(_loc3_ != null)
            {
               _loc5_ = _loc3_;
               do
               {
                  _loc6_ = _loc5_;
                  _loc2_ = Number(_loc2_ + _loc6_.x * (_loc6_.next.y - _loc6_.prev.y));
                  _loc5_ = _loc5_.next;
               }
               while(_loc5_ != _loc4_);
               
            }
            _loc1_ = _loc2_;
            §§push(_loc1_ < 0?-_loc1_:_loc1_);
         }
         return §§pop();
      }
   }
}
