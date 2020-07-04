package nape.dynamics
{
   import flash.Boot;
   import zpp_nape.dynamics.ZPP_Contact;
   import zpp_nape.util.ZNPList_ContactIterator;
   import zpp_nape.util.ZPP_ContactList;
   
   public class ContactList
   {
       
      
      public var zpp_inner:ZPP_ContactList;
      
      public function ContactList()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         zpp_inner = new ZPP_ContactList();
         zpp_inner.outer = this;
      }
      
      public static function fromArray(param1:Array) : ContactList
      {
         var _loc4_:* = null;
         var _loc2_:ContactList = new ContactList();
         var _loc3_:int = 0;
         while(_loc3_ < int(param1.length))
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public static function fromVector(param1:Vector.<Contact>) : ContactList
      {
         var _loc4_:* = null as Contact;
         var _loc2_:ContactList = new ContactList();
         var _loc3_:int = 0;
         while(_loc3_ < param1.length)
         {
            _loc4_ = param1[_loc3_];
            _loc3_++;
            _loc2_.push(_loc4_);
         }
         return _loc2_;
      }
      
      public function unshift(param1:Contact) : Boolean
      {
         var _loc3_:* = null as ZPP_Contact;
         var _loc4_:* = null as ZPP_Contact;
         zpp_inner.modify_test();
         zpp_inner.valmod();
         var _loc2_:Boolean = zpp_inner.adder != null?Boolean(zpp_inner.adder(param1)):true;
         if(_loc2_)
         {
            if(zpp_inner.reverse_flag)
            {
               if(zpp_inner.push_ite == null)
               {
                  §§push(zpp_inner);
                  if(empty())
                  {
                     §§push(null);
                  }
                  else
                  {
                     zpp_inner.valmod();
                     §§push(zpp_inner.inner);
                     if(zpp_inner.zip_length)
                     {
                        zpp_inner.zip_length = false;
                        zpp_inner.user_length = 0;
                        _loc3_ = zpp_inner.inner.next;
                        while(_loc3_ != null)
                        {
                           _loc4_ = _loc3_;
                           if(!!_loc4_.active && _loc4_.arbiter.active)
                           {
                              zpp_inner.user_length = zpp_inner.user_length + 1;
                           }
                           _loc3_ = _loc3_.next;
                        }
                     }
                     §§push(§§pop().iterator_at(zpp_inner.user_length - 1));
                  }
                  §§pop().push_ite = §§pop();
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
         var _loc4_:* = null as Contact;
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
      
      public function shift() : Contact
      {
         var _loc2_:* = null as ZPP_Contact;
         var _loc3_:* = null as ZPP_Contact;
         var _loc4_:* = null as ZPP_Contact;
         var _loc5_:* = null as Contact;
         zpp_inner.modify_test();
         zpp_inner.valmod();
         var _loc1_:ZPP_Contact = null;
         if(zpp_inner.reverse_flag)
         {
            if(zpp_inner.at_ite != null && zpp_inner.at_ite.next == null)
            {
               zpp_inner.at_ite = null;
            }
            zpp_inner.valmod();
            if(zpp_inner.zip_length)
            {
               zpp_inner.zip_length = false;
               zpp_inner.user_length = 0;
               _loc3_ = zpp_inner.inner.next;
               while(_loc3_ != null)
               {
                  _loc4_ = _loc3_;
                  if(!!_loc4_.active && _loc4_.arbiter.active)
                  {
                     zpp_inner.user_length = zpp_inner.user_length + 1;
                  }
                  _loc3_ = _loc3_.next;
               }
            }
            if(zpp_inner.user_length == 1)
            {
               §§push(null);
            }
            else
            {
               zpp_inner.valmod();
               §§push(zpp_inner.inner);
               if(zpp_inner.zip_length)
               {
                  zpp_inner.zip_length = false;
                  zpp_inner.user_length = 0;
                  _loc3_ = zpp_inner.inner.next;
                  while(_loc3_ != null)
                  {
                     _loc4_ = _loc3_;
                     if(!!_loc4_.active && _loc4_.arbiter.active)
                     {
                        zpp_inner.user_length = zpp_inner.user_length + 1;
                     }
                     _loc3_ = _loc3_.next;
                  }
               }
               §§push(§§pop().iterator_at(zpp_inner.user_length - 2));
            }
            _loc2_ = §§pop();
            _loc1_ = _loc2_ == null?zpp_inner.inner.next:_loc2_.next;
            _loc5_ = _loc1_.wrapper();
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc5_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.erase(_loc2_);
            }
         }
         else
         {
            _loc1_ = zpp_inner.inner.next;
            _loc5_ = _loc1_.wrapper();
            if(zpp_inner.subber != null)
            {
               zpp_inner.subber(_loc5_);
            }
            if(!zpp_inner.dontremove)
            {
               zpp_inner.inner.pop();
            }
         }
         zpp_inner.invalidate();
         _loc5_ = _loc1_.wrapper();
         return _loc5_;
      }
      
      public function remove(param1:Contact) : Boolean
      {
         var _loc4_:* = null as ZPP_Contact;
         zpp_inner.modify_test();
         zpp_inner.valmod();
         var _loc2_:Boolean = false;
         var _loc3_:ZPP_Contact = zpp_inner.inner.next;
         while(_loc3_ != null)
         {
            _loc4_ = _loc3_;
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
      
      public function push(param1:Contact) : Boolean
      {
         var _loc3_:* = null as ZPP_Contact;
         var _loc4_:* = null as ZPP_Contact;
         zpp_inner.modify_test();
         zpp_inner.valmod();
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
                  §§push(zpp_inner);
                  if(empty())
                  {
                     §§push(null);
                  }
                  else
                  {
                     zpp_inner.valmod();
                     §§push(zpp_inner.inner);
                     if(zpp_inner.zip_length)
                     {
                        zpp_inner.zip_length = false;
                        zpp_inner.user_length = 0;
                        _loc3_ = zpp_inner.inner.next;
                        while(_loc3_ != null)
                        {
                           _loc4_ = _loc3_;
                           if(!!_loc4_.active && _loc4_.arbiter.active)
                           {
                              zpp_inner.user_length = zpp_inner.user_length + 1;
                           }
                           _loc3_ = _loc3_.next;
                        }
                     }
                     §§push(§§pop().iterator_at(zpp_inner.user_length - 1));
                  }
                  §§pop().push_ite = §§pop();
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
      
      public function pop() : Contact
      {
         var _loc2_:* = null as Contact;
         var _loc3_:* = null as ZPP_Contact;
         var _loc4_:* = null as ZPP_Contact;
         var _loc5_:* = null as ZPP_Contact;
         zpp_inner.modify_test();
         zpp_inner.valmod();
         var _loc1_:ZPP_Contact = null;
         if(zpp_inner.reverse_flag)
         {
            _loc1_ = zpp_inner.inner.next;
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
            zpp_inner.valmod();
            if(zpp_inner.zip_length)
            {
               zpp_inner.zip_length = false;
               zpp_inner.user_length = 0;
               _loc4_ = zpp_inner.inner.next;
               while(_loc4_ != null)
               {
                  _loc5_ = _loc4_;
                  if(!!_loc5_.active && _loc5_.arbiter.active)
                  {
                     zpp_inner.user_length = zpp_inner.user_length + 1;
                  }
                  _loc4_ = _loc4_.next;
               }
            }
            if(zpp_inner.user_length == 1)
            {
               §§push(null);
            }
            else
            {
               zpp_inner.valmod();
               §§push(zpp_inner.inner);
               if(zpp_inner.zip_length)
               {
                  zpp_inner.zip_length = false;
                  zpp_inner.user_length = 0;
                  _loc4_ = zpp_inner.inner.next;
                  while(_loc4_ != null)
                  {
                     _loc5_ = _loc4_;
                     if(!!_loc5_.active && _loc5_.arbiter.active)
                     {
                        zpp_inner.user_length = zpp_inner.user_length + 1;
                     }
                     _loc4_ = _loc4_.next;
                  }
               }
               §§push(§§pop().iterator_at(zpp_inner.user_length - 2));
            }
            _loc3_ = §§pop();
            _loc1_ = _loc3_ == null?zpp_inner.inner.next:_loc3_.next;
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
      
      public function merge(param1:ContactList) : void
      {
         var _loc3_:* = null as Contact;
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
      
      public function iterator() : ContactIterator
      {
         zpp_inner.valmod();
         if(zpp_inner.iterators == null)
         {
            zpp_inner.iterators = new ZNPList_ContactIterator();
         }
         return ContactIterator.get(this);
      }
      
      public function has(param1:Contact) : Boolean
      {
         zpp_inner.valmod();
         return Boolean(zpp_inner.inner.has(param1.zpp_inner));
      }
      
      public function get length() : int
      {
         var _loc1_:* = null as ZPP_Contact;
         var _loc2_:* = null as ZPP_Contact;
         zpp_inner.valmod();
         if(zpp_inner.zip_length)
         {
            zpp_inner.zip_length = false;
            zpp_inner.user_length = 0;
            _loc1_ = zpp_inner.inner.next;
            while(_loc1_ != null)
            {
               _loc2_ = _loc1_;
               if(!!_loc2_.active && _loc2_.arbiter.active)
               {
                  zpp_inner.user_length = zpp_inner.user_length + 1;
               }
               _loc1_ = _loc1_.next;
            }
         }
         return zpp_inner.user_length;
      }
      
      public function foreach(param1:Function) : void
      {
         var _loc3_:ContactIterator = iterator();
      }
      
      public function filter(param1:Function) : ContactList
      {
         var _loc4_:* = null as Contact;
         var _loc6_:* = null as ZPP_Contact;
         var _loc7_:* = null as ZPP_Contact;
         var _loc3_:int = 0;
      }
      
      public function empty() : Boolean
      {
         var _loc1_:* = null as ZPP_Contact;
         var _loc2_:* = null as ZPP_Contact;
         zpp_inner.valmod();
         if(zpp_inner.zip_length)
         {
            zpp_inner.zip_length = false;
            zpp_inner.user_length = 0;
            _loc1_ = zpp_inner.inner.next;
            while(_loc1_ != null)
            {
               _loc2_ = _loc1_;
               if(!!_loc2_.active && _loc2_.arbiter.active)
               {
                  zpp_inner.user_length = zpp_inner.user_length + 1;
               }
               _loc1_ = _loc1_.next;
            }
         }
         return zpp_inner.user_length == 0;
      }
      
      public function copy(param1:Boolean = false) : ContactList
      {
         var _loc4_:* = null as Contact;
         var _loc2_:ContactList = new ContactList();
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
      
      public function at(param1:int) : Contact
      {
         var _loc2_:* = null as ZPP_Contact;
         var _loc3_:* = null as ZPP_Contact;
         zpp_inner.valmod();
         if(zpp_inner.reverse_flag)
         {
            zpp_inner.valmod();
            if(zpp_inner.zip_length)
            {
               zpp_inner.zip_length = false;
               zpp_inner.user_length = 0;
               _loc2_ = zpp_inner.inner.next;
               while(_loc2_ != null)
               {
                  _loc3_ = _loc2_;
                  if(!!_loc3_.active && _loc3_.arbiter.active)
                  {
                     zpp_inner.user_length = zpp_inner.user_length + 1;
                  }
                  _loc2_ = _loc2_.next;
               }
            }
            param1 = zpp_inner.user_length - 1 - param1;
         }
         if(param1 < zpp_inner.at_index || zpp_inner.at_ite == null)
         {
            zpp_inner.at_index = 0;
            zpp_inner.at_ite = zpp_inner.inner.next;
            while(true)
            {
               _loc2_ = zpp_inner.at_ite;
               if(!(!!_loc2_.active && _loc2_.arbiter.active))
               {
                  zpp_inner.at_ite = zpp_inner.at_ite.next;
                  continue;
               }
               break;
            }
         }
         loop2:
         while(zpp_inner.at_index != param1)
         {
            zpp_inner.at_index = zpp_inner.at_index + 1;
            zpp_inner.at_ite = zpp_inner.at_ite.next;
            while(true)
            {
               _loc2_ = zpp_inner.at_ite;
               if(!(!!_loc2_.active && _loc2_.arbiter.active))
               {
                  zpp_inner.at_ite = zpp_inner.at_ite.next;
                  continue;
               }
               continue loop2;
            }
         }
         return zpp_inner.at_ite.wrapper();
      }
      
      public function add(param1:Contact) : Boolean
      {
         return !!zpp_inner.reverse_flag?Boolean(push(param1)):Boolean(unshift(param1));
      }
   }
}
