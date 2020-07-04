package zpp_nape.dynamics
{
   import flash.Boot;
   import nape.dynamics.CollisionArbiter;
   import nape.dynamics.Contact;
   import nape.dynamics.ContactList;
   import nape.geom.Vec2;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.util.ZPP_ContactList;
   
   public class ZPP_ColArbiter extends ZPP_Arbiter
   {
      
      public static var FACE1:int = 0;
      
      public static var FACE2:int = 1;
      
      public static var CIRCLE:int = 2;
      
      public static var zpp_pool:ZPP_ColArbiter;
       
      
      public var wrap_normal:Vec2;
      
      public var wrap_contacts:ContactList;
      
      public var surfacey:Number;
      
      public var surfacex:Number;
      
      public var stat_fric:Number;
      
      public var stat:Boolean;
      
      public var s2:ZPP_Shape;
      
      public var s1:ZPP_Shape;
      
      public var rt2b:Number;
      
      public var rt2a:Number;
      
      public var rt1b:Number;
      
      public var rt1a:Number;
      
      public var rn2b:Number;
      
      public var rn2a:Number;
      
      public var rn1b:Number;
      
      public var rn1a:Number;
      
      public var rfric:Number;
      
      public var rev:Boolean;
      
      public var restitution:Number;
      
      public var radius:Number;
      
      public var rMass:Number;
      
      public var ptype:int;
      
      public var pre_dt:Number;
      
      public var pjrAcc:Number;
      
      public var outer_zn:CollisionArbiter;
      
      public var oc2:ZPP_Contact;
      
      public var oc1:ZPP_Contact;
      
      public var ny:Number;
      
      public var nx:Number;
      
      public var next:ZPP_ColArbiter;
      
      public var mutable:Boolean;
      
      public var lproj:Number;
      
      public var lnormy:Number;
      
      public var lnormx:Number;
      
      public var kMassc:Number;
      
      public var kMassb:Number;
      
      public var kMassa:Number;
      
      public var k2y:Number;
      
      public var k2x:Number;
      
      public var k1y:Number;
      
      public var k1x:Number;
      
      public var jrAcc:Number;
      
      public var innards:ZPP_IContact;
      
      public var hc2:Boolean;
      
      public var dyn_fric:Number;
      
      public var contacts:ZPP_Contact;
      
      public var c2:ZPP_IContact;
      
      public var c1:ZPP_IContact;
      
      public var Kc:Number;
      
      public var Kb:Number;
      
      public var Ka:Number;
      
      public function ZPP_ColArbiter()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         pre_dt = -1;
         super();
         contacts = new ZPP_Contact();
         innards = new ZPP_IContact();
         type = ZPP_Arbiter.COL;
         colarb = this;
      }
      
      public function setupcontacts() : void
      {
         wrap_contacts = ZPP_ContactList.get(contacts,true);
         wrap_contacts.zpp_inner.immutable = !mutable;
         wrap_contacts.zpp_inner.adder = contacts_adder;
         wrap_contacts.zpp_inner.dontremove = true;
         wrap_contacts.zpp_inner.subber = contacts_subber;
      }
      
      public function normal_validate() : void
      {
         if(cleared)
         {
            Boot.lastError = new Error();
            throw "Error: Arbiter not currently in use";
         }
         wrap_normal.zpp_inner.x = nx;
         wrap_normal.zpp_inner.y = ny;
      }
      
      public function normal_invalidate(param1:ZPP_Vec2) : void
      {
         nx = param1.x;
         ny = param1.y;
      }
      
      public function getnormal() : void
      {
         wrap_normal = Vec2.get(0,0);
         wrap_normal.zpp_inner._immutable = !mutable;
         wrap_normal.zpp_inner._inuse = true;
         wrap_normal.zpp_inner._validate = normal_validate;
         wrap_normal.zpp_inner._invalidate = normal_invalidate;
      }
      
      public function contacts_subber(param1:Contact) : void
      {
         var _loc6_:* = null as ZPP_Contact;
         var _loc7_:* = null as ZPP_Contact;
         var _loc2_:ZPP_Contact = null;
         var _loc3_:ZPP_IContact = null;
         var _loc4_:ZPP_IContact = innards.next;
         var _loc5_:ZPP_Contact = contacts.next;
         while(_loc5_ != null)
         {
            _loc6_ = _loc5_;
            if(_loc6_ == param1.zpp_inner)
            {
               contacts.erase(_loc2_);
               innards.erase(_loc3_);
               _loc7_ = _loc6_;
               _loc7_.arbiter = null;
               _loc7_.next = ZPP_Contact.zpp_pool;
               ZPP_Contact.zpp_pool = _loc7_;
               break;
            }
            _loc2_ = _loc5_;
            _loc3_ = _loc4_;
            _loc4_ = _loc4_.next;
            _loc5_ = _loc5_.next;
         }
      }
      
      public function contacts_adder(param1:Contact) : Boolean
      {
         return false;
      }
   }
}
