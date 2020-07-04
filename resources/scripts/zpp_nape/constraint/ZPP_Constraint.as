package zpp_nape.constraint
{
   import flash.Boot;
   import nape.callbacks.CbType;
   import nape.callbacks.CbTypeList;
   import nape.constraint.Constraint;
   import nape.util.Debug;
   import zpp_nape.ZPP_ID;
   import zpp_nape.callbacks.ZPP_CbSet;
   import zpp_nape.callbacks.ZPP_CbType;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_Compound;
   import zpp_nape.space.ZPP_Component;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZNPList_ZPP_CbType;
   import zpp_nape.util.ZNPNode_ZPP_CbType;
   import zpp_nape.util.ZPP_CbTypeList;
   
   public class ZPP_Constraint
   {
       
      
      public var wrap_cbTypes:CbTypeList;
      
      public var userData;
      
      public var stiff:Boolean;
      
      public var space:ZPP_Space;
      
      public var removeOnBreak:Boolean;
      
      public var pre_dt:Number;
      
      public var outer:Constraint;
      
      public var maxForce:Number;
      
      public var maxError:Number;
      
      public var ignore:Boolean;
      
      public var id:int;
      
      public var frequency:Number;
      
      public var damping:Number;
      
      public var compound:ZPP_Compound;
      
      public var component:ZPP_Component;
      
      public var cbTypes:ZNPList_ZPP_CbType;
      
      public var cbSet:ZPP_CbSet;
      
      public var breakUnderForce:Boolean;
      
      public var breakUnderError:Boolean;
      
      public var active:Boolean;
      
      public var __velocity:Boolean;
      
      public function ZPP_Constraint()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         __velocity = false;
         id = int(ZPP_ID.Constraint());
         stiff = true;
         active = true;
         ignore = false;
         frequency = 10;
         damping = 1;
         maxForce = 1.79e308;
         maxError = 1.79e308;
         breakUnderForce = false;
         removeOnBreak = true;
         pre_dt = -1;
         cbTypes = new ZNPList_ZPP_CbType();
      }
      
      public function wrap_cbTypes_subber(param1:CbType) : void
      {
         var _loc2_:ZPP_CbType = param1.zpp_inner;
         if(cbTypes.has(_loc2_))
         {
            if(space != null)
            {
               dealloc_cbSet();
               _loc2_.constraints.remove(this);
            }
            cbTypes.remove(_loc2_);
            if(space != null)
            {
               alloc_cbSet();
               wake();
            }
         }
      }
      
      public function wrap_cbTypes_adder(param1:CbType) : Boolean
      {
         insert_cbtype(param1.zpp_inner);
         return false;
      }
      
      public function warmStart() : void
      {
      }
      
      public function wake_connected() : void
      {
      }
      
      public function wake() : void
      {
         if(space != null)
         {
            space.wake_constraint(this);
         }
      }
      
      public function validate() : void
      {
      }
      
      public function setupcbTypes() : void
      {
         wrap_cbTypes = ZPP_CbTypeList.get(cbTypes);
         wrap_cbTypes.zpp_inner.adder = wrap_cbTypes_adder;
         wrap_cbTypes.zpp_inner.subber = wrap_cbTypes_subber;
         wrap_cbTypes.zpp_inner.dontremove = true;
      }
      
      public function removedFromSpace() : void
      {
         var _loc2_:* = null as ZPP_CbType;
         if(active)
         {
            inactiveOrOutSpace();
         }
         inactiveBodies();
         var _loc1_:ZNPNode_ZPP_CbType = cbTypes.head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.elt;
            _loc2_.constraints.remove(this);
            _loc1_ = _loc1_.next;
         }
      }
      
      public function preStep(param1:Number) : Boolean
      {
         return false;
      }
      
      public function pair_exists(param1:int, param2:int) : Boolean
      {
         return false;
      }
      
      public function insert_cbtype(param1:ZPP_CbType) : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_CbType;
         var _loc3_:* = null as ZNPNode_ZPP_CbType;
         var _loc4_:* = null as ZPP_CbType;
         var _loc5_:* = null as ZNPList_ZPP_CbType;
         var _loc6_:* = null as ZNPNode_ZPP_CbType;
         var _loc7_:Boolean = false;
         if(!cbTypes.has(param1))
         {
            if(space != null)
            {
               dealloc_cbSet();
               param1.constraints.add(this);
            }
            _loc2_ = null;
            _loc3_ = cbTypes.head;
            while(_loc3_ != null)
            {
               _loc4_ = _loc3_.elt;
               if(param1.id >= _loc4_.id)
               {
                  _loc2_ = _loc3_;
                  _loc3_ = _loc3_.next;
                  continue;
               }
               break;
            }
            _loc5_ = cbTypes;
            if(ZNPNode_ZPP_CbType.zpp_pool == null)
            {
               _loc6_ = new ZNPNode_ZPP_CbType();
            }
            else
            {
               _loc6_ = ZNPNode_ZPP_CbType.zpp_pool;
               ZNPNode_ZPP_CbType.zpp_pool = _loc6_.next;
               _loc6_.next = null;
            }
            null;
            _loc6_.elt = param1;
            _loc3_ = _loc6_;
            if(_loc2_ == null)
            {
               _loc3_.next = _loc5_.head;
               _loc5_.head = _loc3_;
            }
            else
            {
               _loc3_.next = _loc2_.next;
               _loc2_.next = _loc3_;
            }
            _loc7_ = true;
            _loc5_.modified = _loc7_;
            _loc5_.pushmod = _loc7_;
            _loc5_.length = _loc5_.length + 1;
            _loc3_;
            if(space != null)
            {
               alloc_cbSet();
               wake();
            }
         }
      }
      
      public function inactiveOrOutSpace() : void
      {
         dealloc_cbSet();
         var _loc1_:ZPP_Component = component;
         _loc1_.body = null;
         _loc1_.constraint = null;
         null;
         _loc1_.next = ZPP_Component.zpp_pool;
         ZPP_Component.zpp_pool = _loc1_;
         component = null;
      }
      
      public function inactiveBodies() : void
      {
      }
      
      public function immutable_midstep(param1:String) : void
      {
      }
      
      public function forest() : void
      {
      }
      
      public function draw(param1:Debug) : void
      {
      }
      
      public function destroy() : void
      {
      }
      
      public function dealloc_cbSet() : void
      {
         var _loc1_:* = 0;
         var _loc2_:* = null as ZPP_CbSet;
         var _loc3_:* = null as ZPP_CbType;
         if(cbSet != null)
         {
            cbSet.constraints.remove(this);
            _loc1_ = cbSet.count - 1;
            cbSet.count = _loc1_;
            if(_loc1_ == 0)
            {
               space.cbsets.remove(cbSet);
               _loc2_ = cbSet;
               _loc2_.listeners.clear();
               _loc2_.zip_listeners = true;
               _loc2_.bodylisteners.clear();
               _loc2_.zip_bodylisteners = true;
               _loc2_.conlisteners.clear();
               _loc2_.zip_conlisteners = true;
               while(_loc2_.cbTypes.head != null)
               {
                  _loc3_ = _loc2_.cbTypes.pop_unsafe();
                  _loc3_.cbsets.remove(_loc2_);
               }
               null;
               _loc2_.next = ZPP_CbSet.zpp_pool;
               ZPP_CbSet.zpp_pool = _loc2_;
            }
            cbSet = null;
         }
      }
      
      public function deactivate() : void
      {
         if(space != null)
         {
            inactiveOrOutSpace();
         }
      }
      
      public function copyto(param1:Constraint) : void
      {
         var _loc4_:* = null as CbType;
         var _loc2_:Constraint = outer;
         if(_loc2_.zpp_inner.wrap_cbTypes == null)
         {
            _loc2_.zpp_inner.setupcbTypes();
         }
         var _loc3_:* = _loc2_.zpp_inner.wrap_cbTypes.iterator();
         while(_loc3_.hasNext())
         {
            _loc4_ = _loc3_.next();
            if(param1.zpp_inner.wrap_cbTypes == null)
            {
               param1.zpp_inner.setupcbTypes();
            }
            param1.zpp_inner.wrap_cbTypes.add(_loc4_);
         }
         param1.zpp_inner.removeOnBreak = _loc2_.zpp_inner.removeOnBreak;
         param1.zpp_inner.removeOnBreak;
         var _loc5_:Boolean = _loc2_.zpp_inner.breakUnderError;
         if(param1.zpp_inner.breakUnderError != _loc5_)
         {
            param1.zpp_inner.breakUnderError = _loc5_;
            param1.zpp_inner.wake();
         }
         param1.zpp_inner.breakUnderError;
         _loc5_ = _loc2_.zpp_inner.breakUnderForce;
         if(param1.zpp_inner.breakUnderForce != _loc5_)
         {
            param1.zpp_inner.breakUnderForce = _loc5_;
            param1.zpp_inner.wake();
         }
         param1.zpp_inner.breakUnderForce;
         var _loc6_:Number = _loc2_.zpp_inner.maxError;
         if(param1.zpp_inner.maxError != _loc6_)
         {
            param1.zpp_inner.maxError = _loc6_;
            param1.zpp_inner.wake();
         }
         param1.zpp_inner.maxError;
         _loc6_ = _loc2_.zpp_inner.maxForce;
         if(param1.zpp_inner.maxForce != _loc6_)
         {
            param1.zpp_inner.maxForce = _loc6_;
            param1.zpp_inner.wake();
         }
         param1.zpp_inner.maxForce;
         _loc6_ = _loc2_.zpp_inner.damping;
         if(param1.zpp_inner.damping != _loc6_)
         {
            param1.zpp_inner.damping = _loc6_;
            if(!param1.zpp_inner.stiff)
            {
               param1.zpp_inner.wake();
            }
         }
         param1.zpp_inner.damping;
         _loc6_ = _loc2_.zpp_inner.frequency;
         if(param1.zpp_inner.frequency != _loc6_)
         {
            param1.zpp_inner.frequency = _loc6_;
            if(!param1.zpp_inner.stiff)
            {
               param1.zpp_inner.wake();
            }
         }
         param1.zpp_inner.frequency;
         _loc5_ = _loc2_.zpp_inner.stiff;
         if(param1.zpp_inner.stiff != _loc5_)
         {
            param1.zpp_inner.stiff = _loc5_;
            param1.zpp_inner.wake();
         }
         param1.zpp_inner.stiff;
         _loc5_ = _loc2_.zpp_inner.ignore;
         if(param1.zpp_inner.ignore != _loc5_)
         {
            param1.zpp_inner.ignore = _loc5_;
            param1.zpp_inner.wake();
         }
         param1.zpp_inner.ignore;
         _loc5_ = _loc2_.zpp_inner.active;
         if(param1.zpp_inner.active != _loc5_)
         {
            if(param1.zpp_inner.component != null)
            {
               param1.zpp_inner.component.woken = false;
            }
            param1.zpp_inner.clearcache();
            if(_loc5_)
            {
               param1.zpp_inner.active = _loc5_;
               param1.zpp_inner.activate();
               if(param1.zpp_inner.space != null)
               {
                  if(param1.zpp_inner.component != null)
                  {
                     param1.zpp_inner.component.sleeping = true;
                  }
                  param1.zpp_inner.space.wake_constraint(param1.zpp_inner,true);
               }
            }
            else
            {
               if(param1.zpp_inner.space != null)
               {
                  param1.zpp_inner.wake();
                  param1.zpp_inner.space.live_constraints.remove(param1.zpp_inner);
               }
               param1.zpp_inner.active = _loc5_;
               param1.zpp_inner.deactivate();
            }
         }
         param1.zpp_inner.active;
      }
      
      public function copy(param1:Array = undefined, param2:Array = undefined) : Constraint
      {
         return null;
      }
      
      public function clearcache() : void
      {
      }
      
      public function clear() : void
      {
      }
      
      public function applyImpulseVel() : Boolean
      {
         return false;
      }
      
      public function applyImpulsePos() : Boolean
      {
         return false;
      }
      
      public function alloc_cbSet() : void
      {
         var _loc1_:ZPP_CbSet = space.cbsets.get(cbTypes);
         cbSet = _loc1_;
         if(_loc1_ != null)
         {
            cbSet.count = cbSet.count + 1;
            cbSet.constraints.add(this);
         }
      }
      
      public function addedToSpace() : void
      {
         var _loc2_:* = null as ZPP_CbType;
         if(active)
         {
            activeInSpace();
         }
         activeBodies();
         var _loc1_:ZNPNode_ZPP_CbType = cbTypes.head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.elt;
            _loc2_.constraints.add(this);
            _loc1_ = _loc1_.next;
         }
      }
      
      public function activeInSpace() : void
      {
         alloc_cbSet();
         if(ZPP_Component.zpp_pool == null)
         {
            component = new ZPP_Component();
         }
         else
         {
            component = ZPP_Component.zpp_pool;
            ZPP_Component.zpp_pool = component.next;
            component.next = null;
         }
         null;
         component.isBody = false;
         component.constraint = this;
      }
      
      public function activeBodies() : void
      {
      }
      
      public function activate() : void
      {
         if(space != null)
         {
            activeInSpace();
         }
      }
   }
}
