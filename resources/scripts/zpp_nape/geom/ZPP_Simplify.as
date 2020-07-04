package zpp_nape.geom
{
   import zpp_nape.util.ZNPList_ZPP_SimplifyP;
   import zpp_nape.util.ZNPNode_ZPP_SimplifyP;
   
   public class ZPP_Simplify
   {
       
      
      public function ZPP_Simplify()
      {
      }
      
      public static function lessval(param1:ZPP_SimplifyV, param2:ZPP_SimplifyV) : Number
      {
         return Number(param1.x - param2.x + (param1.y - param2.y));
      }
      
      public static function less(param1:ZPP_SimplifyV, param2:ZPP_SimplifyV) : Boolean
      {
         return Number(ZPP_Simplify.lessval(param1,param2)) < 0;
      }
      
      public static function distance(param1:ZPP_SimplifyV, param2:ZPP_SimplifyV, param3:ZPP_SimplifyV) : Number
      {
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc4_:Number = param3.x - param2.x;
         var _loc5_:Number = param3.y - param2.y;
         var _loc6_:Number = param1.x - param2.x;
         var _loc7_:Number = param1.y - param2.y;
         var _loc8_:Number = Number(_loc4_ * _loc4_ + _loc5_ * _loc5_);
         if(_loc8_ == 0)
         {
            return Number(_loc6_ * _loc6_ + _loc7_ * _loc7_);
         }
         _loc9_ = (Number(_loc6_ * _loc4_ + _loc7_ * _loc5_)) / (Number(_loc4_ * _loc4_ + _loc5_ * _loc5_));
         if(_loc9_ <= 0)
         {
            return Number(_loc6_ * _loc6_ + _loc7_ * _loc7_);
         }
         if(_loc9_ >= 1)
         {
            _loc10_ = param1.x - param3.x;
            _loc11_ = param1.y - param3.y;
            return Number(_loc10_ * _loc10_ + _loc11_ * _loc11_);
         }
         _loc10_ = _loc9_;
         _loc6_ = _loc6_ - _loc4_ * _loc10_;
         _loc7_ = _loc7_ - _loc5_ * _loc10_;
         return Number(_loc6_ * _loc6_ + _loc7_ * _loc7_);
      }
      
      public static function simplify(param1:ZPP_GeomVert, param2:Number) : ZPP_GeomVert
      {
         var _loc10_:* = null as ZPP_SimplifyV;
         var _loc11_:* = null as ZPP_SimplifyV;
         var _loc12_:* = null as ZPP_SimplifyV;
         var _loc13_:Boolean = false;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:* = null as ZPP_SimplifyP;
         var _loc17_:* = null as ZPP_SimplifyP;
         var _loc18_:* = null as ZPP_SimplifyV;
         var _loc20_:* = null as ZPP_GeomVert;
         var _loc21_:* = null as ZPP_GeomVert;
         var _loc3_:ZPP_SimplifyV = null;
         var _loc4_:ZPP_SimplifyV = null;
         var _loc5_:ZPP_SimplifyV = null;
         param2 = param2 * param2;
         var _loc6_:ZNPList_ZPP_SimplifyP = new ZNPList_ZPP_SimplifyP();
         var _loc7_:ZPP_SimplifyV = null;
         var _loc8_:ZPP_SimplifyV = null;
         var _loc9_:ZPP_GeomVert = param1;
         do
         {
            _loc10_ = ZPP_SimplifyV.get(_loc9_);
            _loc10_.forced = _loc9_.forced;
            if(_loc10_.forced)
            {
               _loc10_.flag = true;
               if(_loc7_ != null)
               {
                  _loc6_.add(ZPP_SimplifyP.get(_loc7_,_loc10_));
               }
               else
               {
                  _loc8_ = _loc10_;
               }
               _loc7_ = _loc10_;
            }
            _loc11_ = _loc10_;
            if(_loc3_ == null)
            {
               _loc12_ = _loc11_;
               _loc11_.next = _loc12_;
               _loc12_ = _loc12_;
               _loc11_.prev = _loc12_;
               _loc3_ = _loc12_;
            }
            else
            {
               _loc11_.prev = _loc3_;
               _loc11_.next = _loc3_.next;
               _loc3_.next.prev = _loc11_;
               _loc3_.next = _loc11_;
            }
            _loc3_ = _loc11_;
            if(_loc4_ == null)
            {
               _loc4_ = _loc3_;
               _loc5_ = _loc3_;
            }
            else
            {
               if(ZPP_Simplify.less(_loc3_,_loc4_))
               {
                  _loc4_ = _loc3_;
               }
               if(ZPP_Simplify.less(_loc5_,_loc3_))
               {
                  _loc5_ = _loc3_;
               }
            }
            _loc9_ = _loc9_.next;
         }
         while(_loc9_ != param1);
         
         if(_loc6_.head == null)
         {
            if(_loc8_ == null)
            {
               _loc13_ = true;
               _loc5_.flag = _loc13_;
               _loc4_.flag = _loc13_;
               _loc6_.add(ZPP_SimplifyP.get(_loc4_,_loc5_));
               _loc6_.add(ZPP_SimplifyP.get(_loc5_,_loc4_));
            }
            else
            {
               _loc14_ = Number(ZPP_Simplify.lessval(_loc4_,_loc8_));
               if(_loc14_ < 0)
               {
                  _loc14_ = -_loc14_;
               }
               _loc15_ = Number(ZPP_Simplify.lessval(_loc5_,_loc8_));
               if(_loc15_ < 0)
               {
                  _loc15_ = -_loc15_;
               }
               if(_loc14_ > _loc15_)
               {
                  _loc13_ = true;
                  _loc8_.flag = _loc13_;
                  _loc4_.flag = _loc13_;
                  _loc6_.add(ZPP_SimplifyP.get(_loc4_,_loc8_));
                  _loc6_.add(ZPP_SimplifyP.get(_loc8_,_loc4_));
               }
               else
               {
                  _loc13_ = true;
                  _loc8_.flag = _loc13_;
                  _loc5_.flag = _loc13_;
                  _loc6_.add(ZPP_SimplifyP.get(_loc5_,_loc8_));
                  _loc6_.add(ZPP_SimplifyP.get(_loc8_,_loc5_));
               }
            }
         }
         else
         {
            _loc6_.add(ZPP_SimplifyP.get(_loc7_,_loc8_));
         }
         while(_loc6_.head != null)
         {
            _loc16_ = _loc6_.pop_unsafe();
            _loc10_ = _loc16_.min;
            _loc11_ = _loc16_.max;
            _loc17_ = _loc16_;
            _loc17_.free();
            _loc17_.next = ZPP_SimplifyP.zpp_pool;
            ZPP_SimplifyP.zpp_pool = _loc17_;
            _loc14_ = param2;
            _loc12_ = null;
            _loc18_ = _loc10_.next;
            while(_loc18_ != _loc11_)
            {
               _loc15_ = Number(ZPP_Simplify.distance(_loc18_,_loc10_,_loc11_));
               if(_loc15_ > _loc14_)
               {
                  _loc14_ = _loc15_;
                  _loc12_ = _loc18_;
               }
               _loc18_ = _loc18_.next;
            }
            if(_loc12_ != null)
            {
               _loc12_.flag = true;
               _loc6_.add(ZPP_SimplifyP.get(_loc10_,_loc12_));
               _loc6_.add(ZPP_SimplifyP.get(_loc12_,_loc11_));
            }
         }
         var _loc19_:ZPP_GeomVert = null;
         while(_loc3_ != null)
         {
            if(_loc3_.flag)
            {
               _loc20_ = ZPP_GeomVert.get(_loc3_.x,_loc3_.y);
               if(_loc19_ == null)
               {
                  _loc21_ = _loc20_;
                  _loc20_.next = _loc21_;
                  _loc21_ = _loc21_;
                  _loc20_.prev = _loc21_;
                  _loc19_ = _loc21_;
               }
               else
               {
                  _loc20_.prev = _loc19_;
                  _loc20_.next = _loc19_.next;
                  _loc19_.next.prev = _loc20_;
                  _loc19_.next = _loc20_;
               }
               _loc19_ = _loc20_;
               _loc19_.forced = _loc3_.forced;
            }
            if(_loc3_ != null && _loc3_.prev == _loc3_)
            {
               _loc10_ = null;
               _loc3_.prev = _loc10_;
               _loc3_.next = _loc10_;
               _loc10_ = _loc3_;
               _loc10_.free();
               _loc10_.next = ZPP_SimplifyV.zpp_pool;
               ZPP_SimplifyV.zpp_pool = _loc10_;
               _loc3_ = null;
               §§push(_loc3_);
            }
            else
            {
               _loc10_ = _loc3_.next;
               _loc3_.prev.next = _loc3_.next;
               _loc3_.next.prev = _loc3_.prev;
               _loc11_ = null;
               _loc3_.prev = _loc11_;
               _loc3_.next = _loc11_;
               _loc11_ = _loc3_;
               _loc11_.free();
               _loc11_.next = ZPP_SimplifyV.zpp_pool;
               ZPP_SimplifyV.zpp_pool = _loc11_;
               _loc3_ = null;
               §§push(_loc10_);
            }
            _loc3_ = §§pop();
         }
         return _loc19_;
      }
   }
}
