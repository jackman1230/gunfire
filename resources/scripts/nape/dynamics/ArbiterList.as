package nape.dynamics
{
   import flash.Boot;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.util.ZNPList_ArbiterIterator;
   import zpp_nape.util.ZNPNode_ZPP_Arbiter;
   import zpp_nape.util.ZPP_ArbiterList;
   
   public class ArbiterList
   {
       
      
      public var zpp_inner:ZPP_ArbiterList;
      
      public function ArbiterList()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = new ZPP_ArbiterList();
         zpp_inner.outer = this;
      }
      
      public static function fromArray(param1:Array) : ArbiterList
      {
         var _loc4_:* = null;
         var _loc2_:ArbiterList = new ArbiterList();
         var _loc3_:int = 0;
         while(_loc3_ < int(param1.length))
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public static function fromVector(param1:Vector.<Arbiter>) : ArbiterList
      {
         var _loc4_:* = null as Arbiter;
         var _loc2_:ArbiterList = new ArbiterList();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public function zpp_vm() : void
      {
         zpp_inner.valmod();
      }
      
      public function zpp_gl() : int
      {
         var _loc1_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc2_:* = null as ZPP_Arbiter;
         zpp_inner.valmod();
         if(zpp_inner.zip_length)
         {
            zpp_inner.zip_length = false;
            zpp_inner.user_length = 0;
            _loc1_ = zpp_inner.inner.head;
            while(_loc1_ != null)
            {
               _loc2_ = _loc1_.elt;
               if(_loc2_.active)
               {
                  zpp_inner.user_length = zpp_inner.user_length + 1;
               }
               _loc1_ = _loc1_.next;
            }
         }
         return zpp_inner.user_length;
      }
      
      public function unshift(param1:Arbiter) : Boolean
      {
         zpp_inner.modify_test();
         zpp_vm();
         var _loc2_:Boolean = zpp_inner.adder != null?Boolean(zpp_inner.adder(param1)):true;
         if(_loc2_)
         {
            if(zpp_inner.reverse_flag)
            {
               if(zpp_inner.push_ite == null)
               {
                  zpp_inner.push_ite = !!empty()?null:zpp_inner.inner.iterator_at(int(zpp_gl()) - 1);
               }
               zpp_inner.push_ite = zpp_inner.inner.insert(zpp_inner.push_ite,param1.zpp_inner);
            }
            else
            {
               zpp_inner.inner.add(param1.zpp_inner);
            }
            zpp_inner.invalidate();
            if(zpp_inner.post_adder != null)
            {
               zpp_inner.post_adder(param1);
            }
         }
         return _loc2_;
      }
      
      public function toString() : String
      {
         var _loc4_:* = null as Arbiter;
         var _loc1_:String = "[";
         var _loc2_:Boolean = true;
         var _loc3_:* = iterator();
         while(_loc3_.hasNext())
         {
            _loc4_ = _loc3_.next();
            if(!_loc2_)
            {
               _loc1_ = _loc1_ + ",";
            }
            _loc1_ = _loc1_ + (_loc4_ == null?"NULL":_loc4_.toString());
            _loc2_ = false;
         }
         return _loc1_ + "]";
      }
      
      public function shift() : Arbiter
      {
         var _loc2_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc3_:* = null as Arbiter;
         zpp_inner.modify_test();
         zpp_vm();
         var _loc1_:ZPP_Arbiter = null;
         if(zpp_inner.reverse_flag)
         {
            if(zpp_inner.at_ite != null && zpp_inner.at_ite.next == null)
            {
               zpp_inner.at_ite = null;
            }
            _loc2_ = int(zpp_gl()) == 1?null:zpp_inner.inner.iterator_at(int(zpp_gl()) - 2);
            _loc1_ = _loc2_ == null?zpp_inner.inner.head.elt:_loc2_.next.elt;
            _loc3_ = _loc1_.wrapper();
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc3_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.erase(_loc2_);
            }
         }
         else
         {
            _loc1_ = zpp_inner.inner.head.elt;
            _loc3_ = _loc1_.wrapper();
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc3_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.pop();
            }
         }
         zpp_inner.invalidate();
         _loc3_ = _loc1_.wrapper();
         return _loc3_;
      }
      
      public function remove(param1:Arbiter) : Boolean
      {
         var _loc4_:* = null as ZPP_Arbiter;
         zpp_inner.modify_test();
         zpp_vm();
         var _loc2_:Boolean = false;
         var _loc3_:ZNPNode_ZPP_Arbiter = zpp_inner.inner.head;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_.elt;
            if(_loc4_ == param1.zpp_inner)
            {
               _loc2_ = true;
               break;
            }
            _loc3_ = _loc3_.next;
         }
         if(_loc2_)
         {
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(param1);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.remove(param1.zpp_inner);
            }
            zpp_inner.invalidate();
         }
         return _loc2_;
      }
      
      public function push(param1:Arbiter) : Boolean
      {
         zpp_inner.modify_test();
         zpp_vm();
         var _loc2_:Boolean = zpp_inner.adder != null?Boolean(zpp_inner.adder(param1)):true;
         if(_loc2_)
         {
            if(zpp_inner.reverse_flag)
            {
               zpp_inner.inner.add(param1.zpp_inner);
            }
            else
            {
               if(zpp_inner.push_ite == null)
               {
                  zpp_inner.push_ite = !!empty()?null:zpp_inner.inner.iterator_at(int(zpp_gl()) - 1);
               }
               zpp_inner.push_ite = zpp_inner.inner.insert(zpp_inner.push_ite,param1.zpp_inner);
            }
            zpp_inner.invalidate();
            if(zpp_inner.post_adder != null)
            {
               zpp_inner.post_adder(param1);
            }
         }
         return _loc2_;
      }
      
      public function pop() : Arbiter
      {
         var _loc2_:* = null as Arbiter;
         var _loc3_:* = null as ZNPNode_ZPP_Arbiter;
         zpp_inner.modify_test();
         zpp_vm();
         var _loc1_:ZPP_Arbiter = null;
         if(zpp_inner.reverse_flag)
         {
            _loc1_ = zpp_inner.inner.head.elt;
            _loc2_ = _loc1_.wrapper();
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc2_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.pop();
            }
         }
         else
         {
            if(zpp_inner.at_ite != null && zpp_inner.at_ite.next == null)
            {
               zpp_inner.at_ite = null;
            }
            _loc3_ = int(zpp_gl()) == 1?null:zpp_inner.inner.iterator_at(int(zpp_gl()) - 2);
            _loc1_ = _loc3_ == null?zpp_inner.inner.head.elt:_loc3_.next.elt;
            _loc2_ = _loc1_.wrapper();
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc2_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.erase(_loc3_);
            }
         }
         zpp_inner.invalidate();
         _loc2_ = _loc1_.wrapper();
         return _loc2_;
      }
      
      public function merge(param1:ArbiterList) : void
      {
         var _loc3_:* = null as Arbiter;
         var _loc2_:* = param1.iterator();
         while(_loc2_.hasNext())
         {
            _loc3_ = _loc2_.next();
            if(!has(_loc3_))
            {
               add(_loc3_);
            }
         }
      }
      
      public function iterator() : ArbiterIterator
      {
         zpp_vm();
         if(zpp_inner.iterators == null)
         {
            zpp_inner.iterators = new ZNPList_ArbiterIterator();
         }
         return ArbiterIterator.get(this);
      }
      
      public function has(param1:Arbiter) : Boolean
      {
         zpp_vm();
         return Boolean(zpp_inner.inner.has(param1.zpp_inner));
      }
      
      public function get length() : int
      {
         return int(zpp_gl());
      }
      
      public function foreach(param1:Function) : void
      {
         var _loc3_:ArbiterIterator = iterator();
      }
      
      public function filter(param1:Function) : ArbiterList
      {
         var _loc4_:* = null as Arbiter;
         var _loc3_:int = 0;
      }
      
      public function empty() : Boolean
      {
         return int(zpp_gl()) == 0;
      }
      
      public function copy(param1:Boolean = false) : ArbiterList
      {
         var _loc4_:* = null as Arbiter;
         var _loc2_:ArbiterList = new ArbiterList();
         var _loc3_:* = iterator();
         while(_loc3_.hasNext())
         {
            _loc4_ = _loc3_.next();
            _loc2_.push(!!param1?null:_loc4_);
         }
         return _loc2_;
      }
      
      public function clear() : void
      {
         if(zpp_inner.reverse_flag)
         {
            while(!empty())
            {
               pop();
            }
         }
         else
         {
            while(!empty())
            {
               shift();
            }
         }
      }
      
      public function at(param1:int) : Arbiter
      {
         var _loc2_:* = null as ZPP_Arbiter;
         zpp_vm();
         if(zpp_inner.reverse_flag)
         {
            param1 = int(zpp_gl()) - 1 - param1;
         }
         if(param1 < zpp_inner.at_index || zpp_inner.at_ite == null)
         {
            zpp_inner.at_index = 0;
            zpp_inner.at_ite = zpp_inner.inner.head;
            while(true)
            {
               _loc2_ = zpp_inner.at_ite.elt;
               if(!_loc2_.active)
               {
                  zpp_inner.at_ite = zpp_inner.at_ite.next;
                  continue;
               }
               break;
            }
         }
         loop1:
         while(zpp_inner.at_index != param1)
         {
            zpp_inner.at_index = zpp_inner.at_index + 1;
            zpp_inner.at_ite = zpp_inner.at_ite.next;
            while(true)
            {
               _loc2_ = zpp_inner.at_ite.elt;
               if(!_loc2_.active)
               {
                  zpp_inner.at_ite = zpp_inner.at_ite.next;
                  continue;
               }
               continue loop1;
            }
         }
         return zpp_inner.at_ite.elt.wrapper();
      }
      
      public function add(param1:Arbiter) : Boolean
      {
         return !!zpp_inner.reverse_flag?Boolean(push(param1)):Boolean(unshift(param1));
      }
   }
}
