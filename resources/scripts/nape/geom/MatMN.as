package nape.geom
{
   import flash.Boot;
   import zpp_nape.geom.ZPP_MatMN;
   
   public class MatMN
   {
       
      
      public var zpp_inner:ZPP_MatMN;
      
      public function MatMN(param1:int, param2:int)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = new ZPP_MatMN(param1,param2);
         zpp_inner.outer = this;
      }
      
      public function x(param1:int, param2:int) : Number
      {
         return Number(zpp_inner.x[param1 * zpp_inner.n + param2]);
      }
      
      public function transpose() : MatMN
      {
         var _loc4_:int = 0;
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc1_:MatMN = new MatMN(zpp_inner.n,zpp_inner.m);
         var _loc2_:int = 0;
         var _loc3_:int = zpp_inner.m;
         while(_loc2_ < _loc3_)
         {
            _loc2_++;
            _loc4_ = _loc2_;
            _loc5_ = 0;
            _loc6_ = zpp_inner.n;
            while(_loc5_ < _loc6_)
            {
               _loc5_++;
               _loc7_ = _loc5_;
               _loc1_.zpp_inner.x[_loc7_ * _loc1_.zpp_inner.n + _loc4_] = Number(zpp_inner.x[_loc4_ * zpp_inner.n + _loc7_]);
            }
         }
         return _loc1_;
      }
      
      public function toString() : String
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc1_:String = "{ ";
         var _loc2_:Boolean = true;
         var _loc3_:int = 0;
         var _loc4_:int = zpp_inner.m;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            if(!_loc2_)
            {
               _loc1_ = _loc1_ + "; ";
            }
            _loc2_ = false;
            _loc6_ = 0;
            _loc7_ = zpp_inner.n;
            while(_loc6_ < _loc7_)
            {
               _loc6_++;
               _loc8_ = _loc6_;
               _loc1_ = _loc1_ + (Number(zpp_inner.x[_loc5_ * zpp_inner.n + _loc8_]) + " ");
            }
         }
         _loc1_ = _loc1_ + "}";
         return _loc1_;
      }
      
      public function setx(param1:int, param2:int, param3:Number) : Number
      {
         var _loc4_:Number = param3;
         zpp_inner.x[param1 * zpp_inner.n + param2] = _loc4_;
         return _loc4_;
      }
      
      public function mul(param1:MatMN) : MatMN
      {
         var _loc5_:int = 0;
         var _loc6_:int = 0;
         var _loc7_:int = 0;
         var _loc8_:int = 0;
         var _loc9_:Number = NaN;
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         var _loc12_:int = 0;
         var _loc2_:MatMN = new MatMN(zpp_inner.m,param1.zpp_inner.n);
         var _loc3_:int = 0;
         var _loc4_:int = zpp_inner.m;
         while(_loc3_ < _loc4_)
         {
            _loc3_++;
            _loc5_ = _loc3_;
            _loc6_ = 0;
            _loc7_ = param1.zpp_inner.n;
            while(_loc6_ < _loc7_)
            {
               _loc6_++;
               _loc8_ = _loc6_;
               _loc9_ = 0;
               _loc10_ = 0;
               _loc11_ = zpp_inner.n;
               while(_loc10_ < _loc11_)
               {
                  _loc10_++;
                  _loc12_ = _loc10_;
                  _loc9_ = Number(_loc9_ + zpp_inner.x[_loc5_ * zpp_inner.n + _loc12_] * param1.zpp_inner.x[_loc12_ * param1.zpp_inner.n + _loc8_]);
               }
               _loc2_.zpp_inner.x[_loc5_ * _loc2_.zpp_inner.n + _loc8_] = _loc9_;
            }
         }
         return _loc2_;
      }
      
      public function get rows() : int
      {
         return zpp_inner.m;
      }
      
      public function get cols() : int
      {
         return zpp_inner.n;
      }
   }
}
