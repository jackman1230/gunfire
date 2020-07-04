package nape.geom
{
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_MarchingSquares;
   import zpp_nape.geom.ZPP_Vec2;
   
   public class MarchingSquares
   {
       
      
      public function MarchingSquares()
      {
      }
      
      public static function run(param1:Function, param2:AABB, param3:Vec2, param4:int = 2, param5:Vec2 = undefined, param6:Boolean = true) : GeomPolyList
      {
         var _loc8_:* = null as ZPP_AABB;
         var _loc9_:* = null as Vec2;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:int = 0;
         var _loc14_:int = 0;
         var _loc15_:int = 0;
         var _loc16_:int = 0;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         var _loc19_:int = 0;
         var _loc20_:int = 0;
         var _loc21_:Number = NaN;
         var _loc22_:Number = NaN;
         var _loc7_:GeomPolyList = new GeomPolyList();
         if(param5 == null)
         {
            _loc8_ = param2.zpp_inner;
            §§push(ZPP_MarchingSquares);
            §§push(param1);
            if(_loc8_._validate != null)
            {
               _loc8_._validate();
            }
            _loc8_ = param2.zpp_inner;
            §§push(param2.zpp_inner.minx);
            if(_loc8_._validate != null)
            {
               _loc8_._validate();
            }
            _loc9_ = param2.zpp_inner.getmax();
            _loc10_ = _loc9_.zpp_inner;
            §§push(param2.zpp_inner.miny);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc9_ = param2.zpp_inner.getmax();
            _loc10_ = _loc9_.zpp_inner;
            §§push(_loc9_.zpp_inner.x);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            §§pop().run(§§pop(),§§pop(),§§pop(),§§pop(),_loc9_.zpp_inner.y,param3,param4,param6,_loc7_);
         }
         else
         {
            _loc8_ = param2.zpp_inner;
            if(_loc8_._validate != null)
            {
               _loc8_._validate();
            }
            _loc8_ = param2.zpp_inner;
            _loc10_ = param5.zpp_inner;
            §§push(_loc8_.maxx - _loc8_.minx);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc11_ = §§pop() / param5.zpp_inner.x;
            _loc8_ = param2.zpp_inner;
            if(_loc8_._validate != null)
            {
               _loc8_._validate();
            }
            _loc8_ = param2.zpp_inner;
            _loc10_ = param5.zpp_inner;
            §§push(_loc8_.maxy - _loc8_.miny);
            if(_loc10_._validate != null)
            {
               _loc10_._validate();
            }
            _loc12_ = §§pop() / param5.zpp_inner.y;
            _loc13_ = _loc11_;
            _loc14_ = _loc12_;
            if(_loc13_ != _loc11_)
            {
               _loc13_++;
            }
            if(_loc14_ != _loc12_)
            {
               _loc14_++;
            }
            _loc15_ = 0;
            while(_loc15_ < _loc13_)
            {
               _loc15_++;
               _loc16_ = _loc15_;
               _loc8_ = param2.zpp_inner;
               if(_loc8_._validate != null)
               {
                  _loc8_._validate();
               }
               _loc10_ = param5.zpp_inner;
               §§push(param2.zpp_inner.minx);
               if(_loc10_._validate != null)
               {
                  _loc10_._validate();
               }
               _loc17_ = Number(§§pop() + param5.zpp_inner.x * _loc16_);
               if(_loc16_ == _loc13_ - 1)
               {
                  _loc9_ = param2.zpp_inner.getmax();
                  _loc10_ = _loc9_.zpp_inner;
                  if(_loc10_._validate != null)
                  {
                     _loc10_._validate();
                  }
                  §§push(_loc9_.zpp_inner.x);
               }
               else
               {
                  _loc10_ = param5.zpp_inner;
                  §§push(_loc17_);
                  if(_loc10_._validate != null)
                  {
                     _loc10_._validate();
                  }
                  §§push(Number(§§pop() + param5.zpp_inner.x));
               }
               _loc18_ = §§pop();
               _loc19_ = 0;
               while(_loc19_ < _loc14_)
               {
                  _loc19_++;
                  _loc20_ = _loc19_;
                  _loc8_ = param2.zpp_inner;
                  if(_loc8_._validate != null)
                  {
                     _loc8_._validate();
                  }
                  _loc10_ = param5.zpp_inner;
                  §§push(param2.zpp_inner.miny);
                  if(_loc10_._validate != null)
                  {
                     _loc10_._validate();
                  }
                  _loc21_ = Number(§§pop() + param5.zpp_inner.y * _loc20_);
                  if(_loc20_ == _loc14_ - 1)
                  {
                     _loc9_ = param2.zpp_inner.getmax();
                     _loc10_ = _loc9_.zpp_inner;
                     if(_loc10_._validate != null)
                     {
                        _loc10_._validate();
                     }
                     §§push(_loc9_.zpp_inner.y);
                  }
                  else
                  {
                     _loc10_ = param5.zpp_inner;
                     §§push(_loc21_);
                     if(_loc10_._validate != null)
                     {
                        _loc10_._validate();
                     }
                     §§push(Number(§§pop() + param5.zpp_inner.y));
                  }
                  _loc22_ = §§pop();
                  ZPP_MarchingSquares.run(param1,_loc17_,_loc21_,_loc18_,_loc22_,param3,param4,param6,_loc7_);
               }
            }
         }
         if(param3.zpp_inner.weak)
         {
            param3.dispose();
         }
         if(param5 != null)
         {
            if(param5.zpp_inner.weak)
            {
               param5.dispose();
            }
         }
         return _loc7_;
      }
   }
}
