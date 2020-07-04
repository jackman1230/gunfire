package zpp_nape.shape
{
   import flash.Boot;
   import nape.geom.Mat23;
   import nape.geom.Vec2;
   import nape.geom.Vec2List;
   import nape.shape.EdgeList;
   import nape.shape.Polygon;
   import nape.shape.ValidationResult;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.util.ZNPList_ZPP_Edge;
   import zpp_nape.util.ZNPNode_ZPP_Edge;
   import zpp_nape.util.ZPP_EdgeList;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_MixVec2List;
   import zpp_nape.util.ZPP_Vec2List;
   
   public class ZPP_Polygon extends ZPP_Shape
   {
       
      
      public var zip_valid:Boolean;
      
      public var zip_lverts:Boolean;
      
      public var zip_laxi:Boolean;
      
      public var zip_gverts:Boolean;
      
      public var zip_gaxi:Boolean;
      
      public var wrap_lverts:Vec2List;
      
      public var wrap_gverts:Vec2List;
      
      public var wrap_edges:EdgeList;
      
      public var validation:ValidationResult;
      
      public var reverse_flag:Boolean;
      
      public var outer_zn:Polygon;
      
      public var lverts:ZPP_Vec2;
      
      public var gverts:ZPP_Vec2;
      
      public var edges:ZNPList_ZPP_Edge;
      
      public var edgeCnt:int;
      
      public function ZPP_Polygon()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super(ZPP_Flags.id_ShapeType_POLYGON);
         polygon = this;
         lverts = new ZPP_Vec2();
         gverts = new ZPP_Vec2();
         edges = new ZNPList_ZPP_Edge();
         edgeCnt = 0;
      }
      
      public function validate_lverts() : void
      {
         if(zip_lverts)
         {
            zip_lverts = false;
            splice_collinear();
            if(lverts.length > 2)
            {
               validate_area_inertia();
               if(area < 0)
               {
                  reverse_vertices();
                  area = -area;
               }
            }
         }
      }
      
      public function validate_laxi() : void
      {
         var _loc1_:* = null as ZNPNode_ZPP_Edge;
         var _loc2_:* = null as ZPP_Vec2;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Edge;
         var _loc6_:Number = NaN;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         if(zip_laxi)
         {
            zip_laxi = false;
            validate_lverts();
            _loc1_ = edges.head;
            _loc2_ = lverts.next;
            _loc3_ = _loc2_;
            _loc2_ = _loc2_.next;
            while(_loc2_ != null)
            {
               _loc4_ = _loc2_;
               _loc5_ = _loc1_.elt;
               _loc1_ = _loc1_.next;
               _loc5_.lp0 = _loc3_;
               _loc5_.lp1 = _loc4_;
               _loc6_ = _loc3_.x - _loc4_.x;
               _loc7_ = _loc3_.y - _loc4_.y;
               _loc8_ = Number(Math.sqrt(Number(_loc6_ * _loc6_ + _loc7_ * _loc7_)));
               _loc5_.length = _loc8_;
               _loc9_ = 1 / _loc8_;
               _loc6_ = _loc6_ * _loc9_;
               _loc7_ = _loc7_ * _loc9_;
               _loc9_ = _loc6_;
               _loc6_ = -_loc7_;
               _loc7_ = _loc9_;
               _loc5_.lprojection = Number(_loc6_ * _loc3_.x + _loc7_ * _loc3_.y);
               _loc5_.lnormx = _loc6_;
               _loc5_.lnormy = _loc7_;
               if(_loc5_.wrap_lnorm != null)
               {
                  _loc5_.wrap_lnorm.zpp_inner.x = _loc6_;
                  _loc5_.wrap_lnorm.zpp_inner.y = _loc7_;
               }
               _loc3_ = _loc4_;
               _loc2_ = _loc2_.next;
            }
            _loc4_ = lverts.next;
            _loc5_ = _loc1_.elt;
            _loc1_ = _loc1_.next;
            _loc5_.lp0 = _loc3_;
            _loc5_.lp1 = _loc4_;
            _loc6_ = _loc3_.x - _loc4_.x;
            _loc7_ = _loc3_.y - _loc4_.y;
            _loc8_ = Number(Math.sqrt(Number(_loc6_ * _loc6_ + _loc7_ * _loc7_)));
            _loc5_.length = _loc8_;
            _loc9_ = 1 / _loc8_;
            _loc6_ = _loc6_ * _loc9_;
            _loc7_ = _loc7_ * _loc9_;
            _loc9_ = _loc6_;
            _loc6_ = -_loc7_;
            _loc7_ = _loc9_;
            _loc5_.lprojection = Number(_loc6_ * _loc3_.x + _loc7_ * _loc3_.y);
            _loc5_.lnormx = _loc6_;
            _loc5_.lnormy = _loc7_;
            if(_loc5_.wrap_lnorm != null)
            {
               _loc5_.wrap_lnorm.zpp_inner.x = _loc6_;
               _loc5_.wrap_lnorm.zpp_inner.y = _loc7_;
            }
         }
      }
      
      public function valid() : ValidationResult
      {
         var _loc1_:* = null as ValidationResult;
         var _loc2_:Boolean = false;
         var _loc3_:Boolean = false;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:Boolean = false;
         var _loc10_:Boolean = false;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:* = null as ZPP_Vec2;
         var _loc16_:Boolean = false;
         var _loc17_:* = null as ZPP_Vec2;
         var _loc18_:Number = NaN;
         var _loc19_:Number = NaN;
         var _loc20_:Number = NaN;
         var _loc21_:Number = NaN;
         if(zip_valid)
         {
            zip_valid = false;
            validate_lverts();
            if(lverts.length < 3)
            {
               §§push();
               if(ZPP_Flags.ValidationResult_DEGENERATE == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.ValidationResult_DEGENERATE = new ValidationResult();
                  ZPP_Flags.§internal§ = false;
               }
               _loc1_ = ZPP_Flags.ValidationResult_DEGENERATE;
               §§pop().validation = _loc1_;
               return _loc1_;
            }
            validate_area_inertia();
            if(area < 1.0e-8)
            {
               §§push();
               if(ZPP_Flags.ValidationResult_DEGENERATE == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.ValidationResult_DEGENERATE = new ValidationResult();
                  ZPP_Flags.§internal§ = false;
               }
               _loc1_ = ZPP_Flags.ValidationResult_DEGENERATE;
               §§pop().validation = _loc1_;
               return _loc1_;
            }
            _loc2_ = true;
            _loc3_ = true;
            _loc4_ = lverts.next;
            _loc5_ = _loc4_;
            _loc4_ = _loc4_.next;
            while(_loc4_ != null)
            {
               _loc6_ = _loc4_;
               _loc7_ = _loc6_.x - _loc5_.x;
               _loc8_ = _loc6_.y - _loc5_.y;
               if(Number(_loc7_ * _loc7_ + _loc8_ * _loc8_) < 1.0e-8)
               {
                  _loc2_ = false;
                  _loc3_ = false;
                  break;
               }
               _loc5_ = _loc6_;
               _loc4_ = _loc4_.next;
            }
            if(_loc3_)
            {
               do
               {
                  _loc6_ = lverts.next;
                  _loc7_ = _loc6_.x - _loc5_.x;
                  _loc8_ = _loc6_.y - _loc5_.y;
               }
               while(Number(_loc7_ * _loc7_ + _loc8_ * _loc8_) >= 1.0e-8);
               
               _loc2_ = false;
            }
            if(!_loc2_)
            {
               §§push();
               if(ZPP_Flags.ValidationResult_DEGENERATE_EDGES == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.ValidationResult_DEGENERATE_EDGES = new ValidationResult();
                  ZPP_Flags.§internal§ = false;
               }
               _loc1_ = ZPP_Flags.ValidationResult_DEGENERATE_EDGES;
               §§pop().validation = _loc1_;
               return _loc1_;
            }
            _loc3_ = false;
            _loc9_ = false;
            _loc10_ = true;
            _loc4_ = lverts.next;
            _loc5_ = _loc4_;
            _loc4_ = _loc4_.next;
            _loc6_ = _loc4_;
            _loc4_ = _loc4_.next;
            while(_loc4_ != null)
            {
               _loc11_ = _loc4_;
               _loc7_ = _loc11_.x - _loc6_.x;
               _loc8_ = _loc11_.y - _loc6_.y;
               _loc12_ = _loc6_.x - _loc5_.x;
               _loc13_ = _loc6_.y - _loc5_.y;
               _loc14_ = _loc13_ * _loc7_ - _loc12_ * _loc8_;
               if(_loc14_ > 1.0e-8)
               {
                  _loc9_ = true;
               }
               else if(_loc14_ < -1.0e-8)
               {
                  _loc3_ = true;
               }
               if(!!_loc9_ && _loc3_)
               {
                  _loc10_ = false;
                  break;
               }
               _loc5_ = _loc6_;
               _loc6_ = _loc11_;
               _loc4_ = _loc4_.next;
            }
            if(_loc10_)
            {
               _loc4_ = lverts.next;
               _loc11_ = _loc4_;
               do
               {
                  _loc7_ = _loc11_.x - _loc6_.x;
                  _loc8_ = _loc11_.y - _loc6_.y;
                  _loc12_ = _loc6_.x - _loc5_.x;
                  _loc13_ = _loc6_.y - _loc5_.y;
                  _loc14_ = _loc13_ * _loc7_ - _loc12_ * _loc8_;
                  if(_loc14_ > 1.0e-8)
                  {
                     _loc9_ = true;
                  }
                  else if(_loc14_ < -1.0e-8)
                  {
                     _loc3_ = true;
                  }
               }
               while(!(!!_loc9_ && _loc3_));
               
               _loc10_ = false;
               if(_loc10_)
               {
                  _loc5_ = _loc6_;
                  _loc6_ = _loc11_;
                  _loc4_ = _loc4_.next;
                  _loc15_ = _loc4_;
                  _loc7_ = _loc15_.x - _loc6_.x;
                  _loc8_ = _loc15_.y - _loc6_.y;
                  _loc12_ = _loc6_.x - _loc5_.x;
                  _loc13_ = _loc6_.y - _loc5_.y;
                  _loc14_ = _loc13_ * _loc7_ - _loc12_ * _loc8_;
                  if(_loc14_ > 1.0e-8)
                  {
                     _loc9_ = true;
                  }
                  else if(_loc14_ < -1.0e-8)
                  {
                     _loc3_ = true;
                  }
                  if(!!_loc9_ && _loc3_)
                  {
                  }
               }
            }
            if(!!_loc9_ && _loc3_)
            {
               §§push();
               if(ZPP_Flags.ValidationResult_CONCAVE == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.ValidationResult_CONCAVE = new ValidationResult();
                  ZPP_Flags.§internal§ = false;
               }
               _loc1_ = ZPP_Flags.ValidationResult_CONCAVE;
               §§pop().validation = _loc1_;
               return _loc1_;
            }
            _loc2_ = true;
            _loc10_ = true;
            _loc4_ = lverts.next;
            _loc5_ = _loc4_;
            _loc4_ = _loc4_.next;
            while(_loc4_ != null)
            {
               _loc6_ = _loc4_;
               if(!_loc2_)
               {
                  _loc10_ = false;
                  break;
               }
               _loc16_ = true;
               _loc11_ = lverts.next;
               _loc15_ = _loc11_;
               _loc11_ = _loc11_.next;
               while(_loc11_ != null)
               {
                  _loc17_ = _loc11_;
                  if(_loc5_ == _loc15_ || _loc5_ == _loc17_ || _loc6_ == _loc15_ || _loc6_ == _loc17_)
                  {
                     _loc15_ = _loc17_;
                     _loc11_ = _loc11_.next;
                  }
                  else
                  {
                     _loc7_ = _loc5_.x - _loc15_.x;
                     _loc8_ = _loc5_.y - _loc15_.y;
                     _loc12_ = _loc6_.x - _loc5_.x;
                     _loc13_ = _loc6_.y - _loc5_.y;
                     _loc14_ = _loc17_.x - _loc15_.x;
                     _loc18_ = _loc17_.y - _loc15_.y;
                     _loc19_ = _loc13_ * _loc14_ - _loc12_ * _loc18_;
                     if(_loc19_ * _loc19_ > 1.0e-8)
                     {
                        _loc19_ = 1 / _loc19_;
                        _loc20_ = (_loc18_ * _loc7_ - _loc14_ * _loc8_) * _loc19_;
                        if(_loc20_ > 1.0e-8 && _loc20_ < 0.99999999)
                        {
                           _loc21_ = (_loc13_ * _loc7_ - _loc12_ * _loc8_) * _loc19_;
                           if(_loc21_ > 1.0e-8 && _loc21_ < 0.99999999)
                           {
                              _loc2_ = false;
                              _loc16_ = false;
                              break;
                           }
                        }
                     }
                     _loc15_ = _loc17_;
                     _loc11_ = _loc11_.next;
                  }
               }
               if(_loc16_)
               {
                  while(true)
                  {
                     _loc17_ = lverts.next;
                     if(!(_loc5_ == _loc15_ || _loc5_ == _loc17_ || _loc6_ == _loc15_ || _loc6_ == _loc17_))
                     {
                        _loc7_ = _loc5_.x - _loc15_.x;
                        _loc8_ = _loc5_.y - _loc15_.y;
                        _loc12_ = _loc6_.x - _loc5_.x;
                        _loc13_ = _loc6_.y - _loc5_.y;
                        _loc14_ = _loc17_.x - _loc15_.x;
                        _loc18_ = _loc17_.y - _loc15_.y;
                        _loc19_ = _loc13_ * _loc14_ - _loc12_ * _loc18_;
                        if(_loc19_ * _loc19_ > 1.0e-8)
                        {
                           _loc19_ = 1 / _loc19_;
                           _loc20_ = (_loc18_ * _loc7_ - _loc14_ * _loc8_) * _loc19_;
                           if(_loc20_ > 1.0e-8 && _loc20_ < 0.99999999)
                           {
                              _loc21_ = (_loc13_ * _loc7_ - _loc12_ * _loc8_) * _loc19_;
                              if(_loc21_ > 1.0e-8 && _loc21_ < 0.99999999)
                              {
                                 _loc2_ = false;
                                 break;
                              }
                           }
                        }
                        continue;
                     }
                     break;
                  }
               }
               _loc5_ = _loc6_;
               _loc4_ = _loc4_.next;
            }
            if(_loc10_)
            {
               while(true)
               {
                  _loc6_ = lverts.next;
                  if(_loc2_)
                  {
                     _loc16_ = true;
                     _loc11_ = lverts.next;
                     _loc15_ = _loc11_;
                     _loc11_ = _loc11_.next;
                     while(_loc11_ != null)
                     {
                        _loc17_ = _loc11_;
                        if(_loc5_ == _loc15_ || _loc5_ == _loc17_ || _loc6_ == _loc15_ || _loc6_ == _loc17_)
                        {
                           _loc15_ = _loc17_;
                           _loc11_ = _loc11_.next;
                        }
                        else
                        {
                           _loc7_ = _loc5_.x - _loc15_.x;
                           _loc8_ = _loc5_.y - _loc15_.y;
                           _loc12_ = _loc6_.x - _loc5_.x;
                           _loc13_ = _loc6_.y - _loc5_.y;
                           _loc14_ = _loc17_.x - _loc15_.x;
                           _loc18_ = _loc17_.y - _loc15_.y;
                           _loc19_ = _loc13_ * _loc14_ - _loc12_ * _loc18_;
                           if(_loc19_ * _loc19_ > 1.0e-8)
                           {
                              _loc19_ = 1 / _loc19_;
                              _loc20_ = (_loc18_ * _loc7_ - _loc14_ * _loc8_) * _loc19_;
                              if(_loc20_ > 1.0e-8 && _loc20_ < 0.99999999)
                              {
                                 _loc21_ = (_loc13_ * _loc7_ - _loc12_ * _loc8_) * _loc19_;
                                 if(_loc21_ > 1.0e-8 && _loc21_ < 0.99999999)
                                 {
                                    _loc2_ = false;
                                    _loc16_ = false;
                                    break;
                                 }
                              }
                           }
                           _loc15_ = _loc17_;
                           _loc11_ = _loc11_.next;
                        }
                     }
                     if(_loc16_)
                     {
                        while(true)
                        {
                           _loc17_ = lverts.next;
                           if(!(_loc5_ == _loc15_ || _loc5_ == _loc17_ || _loc6_ == _loc15_ || _loc6_ == _loc17_))
                           {
                              _loc7_ = _loc5_.x - _loc15_.x;
                              _loc8_ = _loc5_.y - _loc15_.y;
                              _loc12_ = _loc6_.x - _loc5_.x;
                              _loc13_ = _loc6_.y - _loc5_.y;
                              _loc14_ = _loc17_.x - _loc15_.x;
                              _loc18_ = _loc17_.y - _loc15_.y;
                              _loc19_ = _loc13_ * _loc14_ - _loc12_ * _loc18_;
                              if(_loc19_ * _loc19_ > 1.0e-8)
                              {
                                 _loc19_ = 1 / _loc19_;
                                 _loc20_ = (_loc18_ * _loc7_ - _loc14_ * _loc8_) * _loc19_;
                                 if(_loc20_ > 1.0e-8 && _loc20_ < 0.99999999)
                                 {
                                    _loc21_ = (_loc13_ * _loc7_ - _loc12_ * _loc8_) * _loc19_;
                                    if(_loc21_ > 1.0e-8 && _loc21_ < 0.99999999)
                                    {
                                       _loc2_ = false;
                                       break;
                                    }
                                 }
                              }
                              continue;
                           }
                           break;
                        }
                     }
                     continue;
                  }
                  break;
               }
            }
            if(!_loc2_)
            {
               §§push();
               if(ZPP_Flags.ValidationResult_SELF_INTERSECTING == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.ValidationResult_SELF_INTERSECTING = new ValidationResult();
                  ZPP_Flags.§internal§ = false;
               }
               _loc1_ = ZPP_Flags.ValidationResult_SELF_INTERSECTING;
               §§pop().validation = _loc1_;
               return _loc1_;
            }
            §§push();
            if(ZPP_Flags.ValidationResult_VALID == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.ValidationResult_VALID = new ValidationResult();
               ZPP_Flags.§internal§ = false;
            }
            _loc1_ = ZPP_Flags.ValidationResult_VALID;
            §§pop().validation = _loc1_;
            return _loc1_;
         }
         return validation;
      }
      
      public function splice_collinear() : void
      {
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:Number = NaN;
         var _loc9_:Number = NaN;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:* = false;
         var _loc13_:Number = NaN;
         var _loc1_:ZPP_Vec2 = lverts.next;
         var _loc2_:ZPP_Vec2 = _loc1_ == null?null:_loc1_.next;
         var _loc3_:int = lverts.length;
         while(_loc3_ > 2)
         {
            _loc4_ = _loc2_.next == null?lverts.next:_loc2_.next;
            _loc5_ = _loc1_;
            _loc6_ = _loc2_;
            _loc7_ = _loc4_;
            _loc8_ = _loc5_.x - _loc6_.x;
            _loc9_ = _loc5_.y - _loc6_.y;
            _loc10_ = _loc7_.x - _loc6_.x;
            _loc11_ = _loc7_.y - _loc6_.y;
            _loc13_ = _loc11_ * _loc8_ - _loc10_ * _loc9_;
            _loc12_ = _loc13_ * _loc13_ < 1.0e-8;
            if(_loc12_)
            {
               _loc3_--;
               cleanup_lvert(_loc2_);
               if(_loc2_ == lverts.next)
               {
                  lverts.pop();
                  break;
               }
               _loc2_ = lverts.erase(_loc1_);
               if(_loc2_ == null)
               {
                  _loc2_ = lverts.next;
               }
            }
            else
            {
               _loc1_ = _loc2_;
               _loc2_ = _loc4_;
            }
            if(_loc2_ != lverts.next.next)
            {
               continue;
            }
            break;
         }
      }
      
      public function setupLocalCOM() : void
      {
         wrap_localCOM = Vec2.get(localCOMx,localCOMy);
         wrap_localCOM.zpp_inner._inuse = true;
         wrap_localCOM.zpp_inner._validate = localCOM_validate;
         wrap_localCOM.zpp_inner._invalidate = localCOM_invalidate;
      }
      
      public function reverse_vertices() : void
      {
         lverts.reverse();
         gverts.reverse();
         edges.reverse();
         var _loc1_:ZNPNode_ZPP_Edge = edges.iterator_at(edgeCnt - 1);
         var _loc2_:ZPP_Edge = edges.pop_unsafe();
         edges.insert(_loc1_,_loc2_);
         reverse_flag = !reverse_flag;
         if(wrap_lverts != null)
         {
            wrap_lverts.zpp_inner.reverse_flag = reverse_flag;
         }
         if(wrap_gverts != null)
         {
            wrap_gverts.zpp_inner.reverse_flag = reverse_flag;
         }
         if(wrap_edges != null)
         {
            wrap_edges.zpp_inner.reverse_flag = reverse_flag;
         }
      }
      
      public function lverts_validate() : void
      {
         validate_lverts();
      }
      
      public function lverts_subber(param1:Vec2) : void
      {
         cleanup_lvert(param1.zpp_inner);
      }
      
      public function lverts_post_adder(param1:Vec2) : void
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Edge;
         var _loc7_:* = null as ZPP_Edge;
         param1.zpp_inner._invalidate = lverts_pa_invalidate;
         var _loc2_:ZPP_Vec2 = null;
         var _loc3_:ZNPNode_ZPP_Edge = null;
         var _loc4_:ZPP_Vec2 = lverts.next;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_;
            if(_loc5_ != param1.zpp_inner)
            {
               _loc2_ = _loc2_ == null?gverts.next:_loc2_.next;
               _loc3_ = _loc3_ == null?edges.head:_loc3_.next;
               _loc4_ = _loc4_.next;
               continue;
            }
            break;
         }
         if(ZPP_Vec2.zpp_pool == null)
         {
            _loc5_ = new ZPP_Vec2();
         }
         else
         {
            _loc5_ = ZPP_Vec2.zpp_pool;
            ZPP_Vec2.zpp_pool = _loc5_.next;
            _loc5_.next = null;
         }
         _loc5_.weak = false;
         _loc5_._immutable = true;
         _loc5_.x = 0;
         _loc5_.y = 0;
         _loc4_ = _loc5_;
         gverts.insert(_loc2_,_loc4_);
         if(lverts.next.next != null)
         {
            if(lverts.next.next.next == null)
            {
               if(ZPP_Edge.zpp_pool == null)
               {
                  _loc6_ = new ZPP_Edge();
               }
               else
               {
                  _loc6_ = ZPP_Edge.zpp_pool;
                  ZPP_Edge.zpp_pool = _loc6_.next;
                  _loc6_.next = null;
               }
               null;
               _loc6_.polygon = this;
               edges.add(_loc6_);
               if(ZPP_Edge.zpp_pool == null)
               {
                  _loc7_ = new ZPP_Edge();
               }
               else
               {
                  _loc7_ = ZPP_Edge.zpp_pool;
                  ZPP_Edge.zpp_pool = _loc7_.next;
                  _loc7_.next = null;
               }
               null;
               _loc7_.polygon = this;
               edges.add(_loc7_);
               edgeCnt = edgeCnt + 2;
            }
            else
            {
               if(ZPP_Edge.zpp_pool == null)
               {
                  _loc6_ = new ZPP_Edge();
               }
               else
               {
                  _loc6_ = ZPP_Edge.zpp_pool;
                  ZPP_Edge.zpp_pool = _loc6_.next;
                  _loc6_.next = null;
               }
               null;
               _loc6_.polygon = this;
               edges.insert(_loc3_,_loc6_);
               edgeCnt = edgeCnt + 1;
            }
         }
         _loc4_._validate = gverts_pa_validate;
      }
      
      public function lverts_pa_invalidate(param1:ZPP_Vec2) : void
      {
         invalidate_lverts();
      }
      
      public function lverts_invalidate(param1:ZPP_Vec2List) : void
      {
         invalidate_lverts();
      }
      
      public function localCOM_validate() : void
      {
         var _loc1_:* = null as ZPP_Polygon;
         var _loc2_:Number = NaN;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:Number = NaN;
         var _loc8_:* = null as ZPP_Vec2;
         if(zip_localCOM)
         {
            zip_localCOM = false;
            if(type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               _loc1_ = polygon;
               if(_loc1_.lverts.next.next == null)
               {
                  _loc1_.localCOMx = _loc1_.lverts.next.x;
                  _loc1_.localCOMy = _loc1_.lverts.next.y;
                  null;
               }
               else if(_loc1_.lverts.next.next.next == null)
               {
                  _loc1_.localCOMx = _loc1_.lverts.next.x;
                  _loc1_.localCOMy = _loc1_.lverts.next.y;
                  _loc2_ = 1;
                  _loc1_.localCOMx = Number(_loc1_.localCOMx + _loc1_.lverts.next.next.x * _loc2_);
                  _loc1_.localCOMy = Number(_loc1_.localCOMy + _loc1_.lverts.next.next.y * _loc2_);
                  _loc2_ = 0.5;
                  _loc1_.localCOMx = _loc1_.localCOMx * _loc2_;
                  _loc1_.localCOMy = _loc1_.localCOMy * _loc2_;
               }
               else
               {
                  _loc1_.localCOMx = 0;
                  _loc1_.localCOMy = 0;
                  _loc2_ = 0;
                  _loc3_ = _loc1_.lverts.next;
                  _loc4_ = _loc3_;
                  _loc3_ = _loc3_.next;
                  _loc5_ = _loc3_;
                  _loc3_ = _loc3_.next;
                  while(_loc3_ != null)
                  {
                     _loc6_ = _loc3_;
                     _loc2_ = Number(_loc2_ + _loc5_.x * (_loc6_.y - _loc4_.y));
                     _loc7_ = _loc6_.y * _loc5_.x - _loc6_.x * _loc5_.y;
                     _loc1_.localCOMx = Number(_loc1_.localCOMx + (_loc5_.x + _loc6_.x) * _loc7_);
                     _loc1_.localCOMy = Number(_loc1_.localCOMy + (_loc5_.y + _loc6_.y) * _loc7_);
                     _loc4_ = _loc5_;
                     _loc5_ = _loc6_;
                     _loc3_ = _loc3_.next;
                  }
                  _loc3_ = _loc1_.lverts.next;
                  _loc6_ = _loc3_;
                  _loc2_ = Number(_loc2_ + _loc5_.x * (_loc6_.y - _loc4_.y));
                  _loc7_ = _loc6_.y * _loc5_.x - _loc6_.x * _loc5_.y;
                  _loc1_.localCOMx = Number(_loc1_.localCOMx + (_loc5_.x + _loc6_.x) * _loc7_);
                  _loc1_.localCOMy = Number(_loc1_.localCOMy + (_loc5_.y + _loc6_.y) * _loc7_);
                  _loc4_ = _loc5_;
                  _loc5_ = _loc6_;
                  _loc3_ = _loc3_.next;
                  _loc8_ = _loc3_;
                  _loc2_ = Number(_loc2_ + _loc5_.x * (_loc8_.y - _loc4_.y));
                  _loc7_ = _loc8_.y * _loc5_.x - _loc8_.x * _loc5_.y;
                  _loc1_.localCOMx = Number(_loc1_.localCOMx + (_loc5_.x + _loc8_.x) * _loc7_);
                  _loc1_.localCOMy = Number(_loc1_.localCOMy + (_loc5_.y + _loc8_.y) * _loc7_);
                  _loc2_ = 1 / (3 * _loc2_);
                  _loc7_ = _loc2_;
                  _loc1_.localCOMx = _loc1_.localCOMx * _loc7_;
                  _loc1_.localCOMy = _loc1_.localCOMy * _loc7_;
               }
            }
            if(wrap_localCOM != null)
            {
               wrap_localCOM.zpp_inner.x = localCOMx;
               wrap_localCOM.zpp_inner.y = localCOMy;
            }
         }
      }
      
      public function localCOM_invalidate(param1:ZPP_Vec2) : void
      {
         var _loc2_:* = null as ZPP_Polygon;
         var _loc3_:Number = NaN;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:Number = NaN;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:Number = NaN;
         if(zip_localCOM)
         {
            zip_localCOM = false;
            if(type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               _loc2_ = polygon;
               if(_loc2_.lverts.next.next == null)
               {
                  _loc2_.localCOMx = _loc2_.lverts.next.x;
                  _loc2_.localCOMy = _loc2_.lverts.next.y;
                  null;
               }
               else if(_loc2_.lverts.next.next.next == null)
               {
                  _loc2_.localCOMx = _loc2_.lverts.next.x;
                  _loc2_.localCOMy = _loc2_.lverts.next.y;
                  _loc3_ = 1;
                  _loc2_.localCOMx = Number(_loc2_.localCOMx + _loc2_.lverts.next.next.x * _loc3_);
                  _loc2_.localCOMy = Number(_loc2_.localCOMy + _loc2_.lverts.next.next.y * _loc3_);
                  _loc3_ = 0.5;
                  _loc2_.localCOMx = _loc2_.localCOMx * _loc3_;
                  _loc2_.localCOMy = _loc2_.localCOMy * _loc3_;
               }
               else
               {
                  _loc2_.localCOMx = 0;
                  _loc2_.localCOMy = 0;
                  _loc3_ = 0;
                  _loc4_ = _loc2_.lverts.next;
                  _loc5_ = _loc4_;
                  _loc4_ = _loc4_.next;
                  _loc6_ = _loc4_;
                  _loc4_ = _loc4_.next;
                  while(_loc4_ != null)
                  {
                     _loc7_ = _loc4_;
                     _loc3_ = Number(_loc3_ + _loc6_.x * (_loc7_.y - _loc5_.y));
                     _loc8_ = _loc7_.y * _loc6_.x - _loc7_.x * _loc6_.y;
                     _loc2_.localCOMx = Number(_loc2_.localCOMx + (_loc6_.x + _loc7_.x) * _loc8_);
                     _loc2_.localCOMy = Number(_loc2_.localCOMy + (_loc6_.y + _loc7_.y) * _loc8_);
                     _loc5_ = _loc6_;
                     _loc6_ = _loc7_;
                     _loc4_ = _loc4_.next;
                  }
                  _loc4_ = _loc2_.lverts.next;
                  _loc7_ = _loc4_;
                  _loc3_ = Number(_loc3_ + _loc6_.x * (_loc7_.y - _loc5_.y));
                  _loc8_ = _loc7_.y * _loc6_.x - _loc7_.x * _loc6_.y;
                  _loc2_.localCOMx = Number(_loc2_.localCOMx + (_loc6_.x + _loc7_.x) * _loc8_);
                  _loc2_.localCOMy = Number(_loc2_.localCOMy + (_loc6_.y + _loc7_.y) * _loc8_);
                  _loc5_ = _loc6_;
                  _loc6_ = _loc7_;
                  _loc4_ = _loc4_.next;
                  _loc9_ = _loc4_;
                  _loc3_ = Number(_loc3_ + _loc6_.x * (_loc9_.y - _loc5_.y));
                  _loc8_ = _loc9_.y * _loc6_.x - _loc9_.x * _loc6_.y;
                  _loc2_.localCOMx = Number(_loc2_.localCOMx + (_loc6_.x + _loc9_.x) * _loc8_);
                  _loc2_.localCOMy = Number(_loc2_.localCOMy + (_loc6_.y + _loc9_.y) * _loc8_);
                  _loc3_ = 1 / (3 * _loc3_);
                  _loc8_ = _loc3_;
                  _loc2_.localCOMx = _loc2_.localCOMx * _loc8_;
                  _loc2_.localCOMy = _loc2_.localCOMy * _loc8_;
               }
            }
            if(wrap_localCOM != null)
            {
               wrap_localCOM.zpp_inner.x = localCOMx;
               wrap_localCOM.zpp_inner.y = localCOMy;
            }
         }
         _loc3_ = 0;
         _loc8_ = 0;
         _loc3_ = param1.x - localCOMx;
         _loc8_ = param1.y - localCOMy;
         _loc4_ = lverts.next;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_;
            _loc10_ = 1;
            _loc5_.x = Number(_loc5_.x + _loc3_ * _loc10_);
            _loc5_.y = Number(_loc5_.y + _loc8_ * _loc10_);
            _loc4_ = _loc4_.next;
         }
         invalidate_lverts();
      }
      
      public function invalidate_lverts() : void
      {
         invalidate_laxi();
         invalidate_area_inertia();
         invalidate_angDrag();
         invalidate_localCOM();
         invalidate_gverts();
         zip_lverts = true;
         zip_valid = true;
         if(body != null)
         {
            body.wake();
         }
      }
      
      public function invalidate_laxi() : void
      {
         invalidate_gaxi();
         zip_laxi = true;
      }
      
      public function invalidate_gverts() : void
      {
         invalidate_aabb();
         zip_gverts = true;
      }
      
      public function invalidate_gaxi() : void
      {
         zip_gaxi = true;
      }
      
      public function gverts_validate() : void
      {
         var _loc1_:* = null as ZPP_Body;
         var _loc2_:* = null as ZPP_Vec2;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         if(zip_gverts)
         {
            if(body != null)
            {
               zip_gverts = false;
               validate_lverts();
               _loc1_ = body;
               if(_loc1_.zip_axis)
               {
                  _loc1_.zip_axis = false;
                  _loc1_.axisx = Number(Math.sin(_loc1_.rot));
                  _loc1_.axisy = Number(Math.cos(_loc1_.rot));
                  null;
               }
               _loc2_ = lverts.next;
               _loc3_ = gverts.next;
               while(_loc3_ != null)
               {
                  _loc4_ = _loc3_;
                  _loc5_ = _loc2_;
                  _loc2_ = _loc2_.next;
                  _loc4_.x = Number(body.posx + (body.axisy * _loc5_.x - body.axisx * _loc5_.y));
                  _loc4_.y = Number(body.posy + (Number(_loc5_.x * body.axisx + _loc5_.y * body.axisy)));
                  _loc3_ = _loc3_.next;
               }
            }
         }
      }
      
      public function gverts_pa_validate() : void
      {
         var _loc1_:* = null as ZPP_Body;
         var _loc2_:* = null as ZPP_Vec2;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         if(zip_gverts)
         {
            if(body != null)
            {
               zip_gverts = false;
               validate_lverts();
               _loc1_ = body;
               if(_loc1_.zip_axis)
               {
                  _loc1_.zip_axis = false;
                  _loc1_.axisx = Number(Math.sin(_loc1_.rot));
                  _loc1_.axisy = Number(Math.cos(_loc1_.rot));
                  null;
               }
               _loc2_ = lverts.next;
               _loc3_ = gverts.next;
               while(_loc3_ != null)
               {
                  _loc4_ = _loc3_;
                  _loc5_ = _loc2_;
                  _loc2_ = _loc2_.next;
                  _loc4_.x = Number(body.posx + (body.axisy * _loc5_.x - body.axisx * _loc5_.y));
                  _loc4_.y = Number(body.posy + (Number(_loc5_.x * body.axisx + _loc5_.y * body.axisy)));
                  _loc3_ = _loc3_.next;
               }
            }
         }
      }
      
      public function getlverts() : void
      {
         wrap_lverts = ZPP_MixVec2List.get(lverts);
         wrap_lverts.zpp_inner.post_adder = lverts_post_adder;
         wrap_lverts.zpp_inner.subber = lverts_subber;
         wrap_lverts.zpp_inner._invalidate = lverts_invalidate;
         wrap_lverts.zpp_inner._validate = lverts_validate;
         wrap_lverts.zpp_inner.reverse_flag = reverse_flag;
      }
      
      public function getgverts() : void
      {
         wrap_gverts = ZPP_MixVec2List.get(gverts,true);
         wrap_gverts.zpp_inner.reverse_flag = reverse_flag;
         wrap_gverts.zpp_inner._validate = gverts_validate;
      }
      
      public function getedges() : void
      {
         wrap_edges = ZPP_EdgeList.get(edges,true);
         wrap_edges.zpp_inner.reverse_flag = reverse_flag;
         wrap_edges.zpp_inner._validate = edges_validate;
      }
      
      public function edges_validate() : void
      {
         validate_lverts();
      }
      
      public function cleanup_lvert(param1:ZPP_Vec2) : void
      {
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Edge;
         var _loc7_:* = null as ZPP_Edge;
         var _loc2_:ZPP_Vec2 = null;
         var _loc3_:ZNPNode_ZPP_Edge = null;
         var _loc4_:ZPP_Vec2 = lverts.next;
         while(_loc4_ != null)
         {
            _loc5_ = _loc4_;
            if(_loc5_ != param1)
            {
               _loc2_ = _loc2_ == null?gverts.next:_loc2_.next;
               _loc3_ = _loc3_ == null?edges.head:_loc3_.next;
               _loc4_ = _loc4_.next;
               continue;
            }
            break;
         }
         _loc4_ = _loc2_ == null?gverts.next:_loc2_.next;
         gverts.erase(_loc2_);
         _loc5_ = _loc4_;
         if(_loc5_.outer != null)
         {
            _loc5_.outer.zpp_inner = null;
            _loc5_.outer = null;
         }
         _loc5_._isimmutable = null;
         _loc5_._validate = null;
         _loc5_._invalidate = null;
         _loc5_.next = ZPP_Vec2.zpp_pool;
         ZPP_Vec2.zpp_pool = _loc5_;
         if(edgeCnt == 2)
         {
            _loc6_ = edges.pop_unsafe();
            _loc7_ = _loc6_;
            _loc7_.polygon = null;
            _loc7_.next = ZPP_Edge.zpp_pool;
            ZPP_Edge.zpp_pool = _loc7_;
            _loc6_ = edges.pop_unsafe();
            _loc7_ = _loc6_;
            _loc7_.polygon = null;
            _loc7_.next = ZPP_Edge.zpp_pool;
            ZPP_Edge.zpp_pool = _loc7_;
            edgeCnt = 0;
         }
         else if(edgeCnt != 0)
         {
            _loc6_ = _loc3_ == null?edges.head.elt:_loc3_.next.elt;
            edges.erase(_loc3_);
            _loc7_ = _loc6_;
            _loc7_.polygon = null;
            _loc7_.next = ZPP_Edge.zpp_pool;
            ZPP_Edge.zpp_pool = _loc7_;
            edgeCnt = edgeCnt - 1;
         }
      }
      
      public function __validate_area_inertia() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:* = null as ZPP_Vec2;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:Number = NaN;
         var _loc8_:Number = NaN;
         var _loc9_:* = null as ZPP_Vec2;
         if(lverts.next == null || lverts.next.next == null || lverts.next.next.next == null)
         {
            area = 0;
            inertia = 0;
         }
         else
         {
            area = 0;
            _loc1_ = 0;
            _loc2_ = 0;
            _loc3_ = lverts.next;
            _loc4_ = _loc3_;
            _loc3_ = _loc3_.next;
            _loc5_ = _loc3_;
            _loc3_ = _loc3_.next;
            while(_loc3_ != null)
            {
               _loc6_ = _loc3_;
               _loc7_ = _loc5_.y * _loc4_.x - _loc5_.x * _loc4_.y;
               _loc8_ = Number(Number(Number(_loc5_.x * _loc5_.x + _loc5_.y * _loc5_.y) + (Number(_loc5_.x * _loc4_.x + _loc5_.y * _loc4_.y))) + (Number(_loc4_.x * _loc4_.x + _loc4_.y * _loc4_.y)));
               _loc1_ = Number(_loc1_ + _loc7_ * _loc8_);
               _loc2_ = Number(_loc2_ + _loc7_);
               area = Number(area + _loc5_.x * (_loc6_.y - _loc4_.y));
               _loc4_ = _loc5_;
               _loc5_ = _loc6_;
               _loc3_ = _loc3_.next;
            }
            _loc3_ = lverts.next;
            _loc6_ = _loc3_;
            _loc7_ = _loc5_.y * _loc4_.x - _loc5_.x * _loc4_.y;
            _loc8_ = Number(Number(Number(_loc5_.x * _loc5_.x + _loc5_.y * _loc5_.y) + (Number(_loc5_.x * _loc4_.x + _loc5_.y * _loc4_.y))) + (Number(_loc4_.x * _loc4_.x + _loc4_.y * _loc4_.y)));
            _loc1_ = Number(_loc1_ + _loc7_ * _loc8_);
            _loc2_ = Number(_loc2_ + _loc7_);
            area = Number(area + _loc5_.x * (_loc6_.y - _loc4_.y));
            _loc4_ = _loc5_;
            _loc5_ = _loc6_;
            _loc3_ = _loc3_.next;
            _loc9_ = _loc3_;
            _loc7_ = _loc5_.y * _loc4_.x - _loc5_.x * _loc4_.y;
            _loc8_ = Number(Number(Number(_loc5_.x * _loc5_.x + _loc5_.y * _loc5_.y) + (Number(_loc5_.x * _loc4_.x + _loc5_.y * _loc4_.y))) + (Number(_loc4_.x * _loc4_.x + _loc4_.y * _loc4_.y)));
            _loc1_ = Number(_loc1_ + _loc7_ * _loc8_);
            _loc2_ = Number(_loc2_ + _loc7_);
            area = Number(area + _loc5_.x * (_loc9_.y - _loc4_.y));
            inertia = _loc1_ / (6 * _loc2_);
            area = area * 0.5;
            if(area < 0)
            {
               area = -area;
               reverse_vertices();
            }
         }
      }
      
      public function __validate_angDrag() : void
      {
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_Edge;
         var _loc10_:Number = NaN;
         var _loc11_:Number = NaN;
         var _loc12_:Number = NaN;
         var _loc13_:Number = NaN;
         var _loc14_:Number = NaN;
         var _loc15_:Number = NaN;
         var _loc16_:Number = NaN;
         var _loc17_:Number = NaN;
         var _loc18_:Number = NaN;
         validate_area_inertia();
         validate_laxi();
         var _loc1_:Number = 0;
         var _loc2_:ZNPNode_ZPP_Edge = edges.head;
         var _loc3_:Number = 0;
         var _loc5_:ZPP_Vec2 = lverts.next;
         var _loc6_:ZPP_Vec2 = _loc5_;
         var _loc7_:ZPP_Vec2 = _loc5_.next;
         while(_loc7_ != null)
         {
            _loc8_ = _loc7_;
            _loc9_ = _loc2_.elt;
            _loc2_ = _loc2_.next;
            _loc3_ = Number(_loc3_ + _loc9_.length);
            _loc10_ = _loc8_.x - _loc6_.x;
            _loc11_ = _loc8_.y - _loc6_.y;
            _loc1_ = Number(_loc1_ + _loc9_.length * 2.5 * material.dynamicFriction * _loc9_.lprojection * _loc9_.lprojection);
            _loc12_ = -(_loc6_.y * _loc9_.lnormx - _loc6_.x * _loc9_.lnormy) / (_loc11_ * _loc9_.lnormx - _loc10_ * _loc9_.lnormy);
            if(_loc12_ > 0)
            {
               _loc13_ = _loc12_ > 1?Number(1):_loc12_;
               _loc14_ = _loc6_.x;
               _loc15_ = _loc6_.y;
               _loc16_ = _loc13_;
               _loc14_ = Number(_loc14_ + _loc10_ * _loc16_);
               _loc15_ = Number(_loc15_ + _loc11_ * _loc16_);
               _loc16_ = _loc9_.lnormy * _loc6_.x - _loc9_.lnormx * _loc6_.y;
               _loc17_ = _loc9_.lnormy * _loc14_ - _loc9_.lnormx * _loc15_;
               _loc18_ = (_loc17_ * _loc17_ * _loc17_ - _loc16_ * _loc16_ * _loc16_) / (3 * (_loc17_ - _loc16_));
               _loc1_ = Number(_loc1_ + _loc18_ * _loc13_ * _loc9_.length * 100);
            }
            if(_loc12_ < 1)
            {
               _loc13_ = _loc12_ < 0?Number(0):_loc12_;
               _loc14_ = _loc6_.x;
               _loc15_ = _loc6_.y;
               _loc16_ = _loc13_;
               _loc14_ = Number(_loc14_ + _loc10_ * _loc16_);
               _loc15_ = Number(_loc15_ + _loc11_ * _loc16_);
               _loc16_ = _loc9_.lnormy * _loc14_ - _loc9_.lnormx * _loc15_;
               _loc17_ = _loc9_.lnormy * _loc8_.x - _loc9_.lnormx * _loc8_.y;
               _loc18_ = (_loc17_ * _loc17_ * _loc17_ - _loc16_ * _loc16_ * _loc16_) / (3 * (_loc17_ - _loc16_));
               _loc1_ = Number(_loc1_ + _loc18_ * 0.5 * (1 - _loc13_) * _loc9_.length * 100);
            }
            _loc5_ = _loc7_;
            _loc6_ = _loc8_;
            _loc7_ = _loc7_.next;
         }
         do
         {
            _loc7_ = lverts.next;
            _loc8_ = _loc7_;
            _loc9_ = _loc2_.elt;
            _loc2_ = _loc2_.next;
            _loc3_ = Number(_loc3_ + _loc9_.length);
            _loc10_ = _loc8_.x - _loc6_.x;
            _loc11_ = _loc8_.y - _loc6_.y;
            _loc1_ = Number(_loc1_ + _loc9_.length * 2.5 * material.dynamicFriction * _loc9_.lprojection * _loc9_.lprojection);
            _loc12_ = -(_loc6_.y * _loc9_.lnormx - _loc6_.x * _loc9_.lnormy) / (_loc11_ * _loc9_.lnormx - _loc10_ * _loc9_.lnormy);
            if(_loc12_ > 0)
            {
               _loc13_ = _loc12_ > 1?Number(1):_loc12_;
               _loc14_ = _loc6_.x;
               _loc15_ = _loc6_.y;
               _loc16_ = _loc13_;
               _loc14_ = Number(_loc14_ + _loc10_ * _loc16_);
               _loc15_ = Number(_loc15_ + _loc11_ * _loc16_);
               _loc16_ = _loc9_.lnormy * _loc6_.x - _loc9_.lnormx * _loc6_.y;
               _loc17_ = _loc9_.lnormy * _loc14_ - _loc9_.lnormx * _loc15_;
               _loc18_ = (_loc17_ * _loc17_ * _loc17_ - _loc16_ * _loc16_ * _loc16_) / (3 * (_loc17_ - _loc16_));
               _loc1_ = Number(_loc1_ + _loc18_ * _loc13_ * _loc9_.length * 100);
            }
         }
         while(_loc12_ >= 1);
         
         _loc13_ = _loc12_ < 0?Number(0):_loc12_;
         _loc14_ = _loc6_.x;
         _loc15_ = _loc6_.y;
         _loc16_ = _loc13_;
         _loc14_ = Number(_loc14_ + _loc10_ * _loc16_);
         _loc15_ = Number(_loc15_ + _loc11_ * _loc16_);
         _loc16_ = _loc9_.lnormy * _loc14_ - _loc9_.lnormx * _loc15_;
         _loc17_ = _loc9_.lnormy * _loc8_.x - _loc9_.lnormx * _loc8_.y;
         _loc18_ = (_loc17_ * _loc17_ * _loc17_ - _loc16_ * _loc16_ * _loc16_) / (3 * (_loc17_ - _loc16_));
         _loc1_ = Number(_loc1_ + _loc18_ * 0.5 * (1 - _loc13_) * _loc9_.length * 100);
         angDrag = _loc1_ / (inertia * _loc3_);
      }
      
      public function __translate(param1:Number, param2:Number) : void
      {
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:Number = NaN;
         var _loc3_:ZPP_Vec2 = lverts.next;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_;
            _loc5_ = 1;
            _loc4_.x = Number(_loc4_.x + param1 * _loc5_);
            _loc4_.y = Number(_loc4_.y + param2 * _loc5_);
            _loc3_ = _loc3_.next;
         }
         invalidate_lverts();
      }
      
      public function __transform(param1:Mat23) : void
      {
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:Number = NaN;
         var _loc2_:ZPP_Vec2 = lverts.next;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_;
            _loc4_ = Number(Number(param1.zpp_inner.a * _loc3_.x + param1.zpp_inner.b * _loc3_.y) + param1.zpp_inner.tx);
            _loc3_.y = Number(Number(param1.zpp_inner.c * _loc3_.x + param1.zpp_inner.d * _loc3_.y) + param1.zpp_inner.ty);
            _loc3_.x = _loc4_;
            _loc2_ = _loc2_.next;
         }
         invalidate_lverts();
      }
      
      public function __scale(param1:Number, param2:Number) : void
      {
         var _loc4_:* = null as ZPP_Vec2;
         var _loc3_:ZPP_Vec2 = lverts.next;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_;
            _loc4_.x = _loc4_.x * param1;
            _loc4_.y = _loc4_.y * param2;
            _loc3_ = _loc3_.next;
         }
         invalidate_lverts();
      }
      
      public function __rotate(param1:Number, param2:Number) : void
      {
         var _loc4_:* = null as ZPP_Vec2;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         var _loc3_:ZPP_Vec2 = lverts.next;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_;
            _loc5_ = param2 * _loc4_.x - param1 * _loc4_.y;
            _loc6_ = Number(_loc4_.x * param1 + _loc4_.y * param2);
            _loc4_.x = _loc5_;
            _loc4_.y = _loc6_;
            _loc3_ = _loc3_.next;
         }
         invalidate_lverts();
      }
      
      public function __copy() : ZPP_Polygon
      {
         var _loc2_:Polygon = outer_zn;
         §§push();
         if(_loc2_.zpp_inner_zn.wrap_lverts == null)
         {
            _loc2_.zpp_inner_zn.getlverts();
         }
         var _loc1_:ZPP_Polygon = new §§pop().Polygon(_loc2_.zpp_inner_zn.wrap_lverts).zpp_inner_zn;
         return _loc1_;
      }
      
      public function __clear() : void
      {
      }
   }
}
