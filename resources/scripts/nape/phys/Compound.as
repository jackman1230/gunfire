package nape.phys
{
   import flash.Boot;
   import nape.constraint.Constraint;
   import nape.constraint.ConstraintList;
   import nape.geom.Vec2;
   import nape.space.Space;
   import zpp_nape.callbacks.ZPP_CbType;
   import zpp_nape.phys.ZPP_Compound;
   import zpp_nape.space.ZPP_Space;
   
   public class Compound extends Interactor
   {
       
      
      public var zpp_inner:ZPP_Compound;
      
      public function Compound()
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         zpp_inner = new ZPP_Compound();
         zpp_inner.outer = this;
         zpp_inner.outer_i = this;
         zpp_inner_i = zpp_inner;
         zpp_inner.insert_cbtype(ZPP_CbType.ANY_COMPOUND.zpp_inner);
      }
      
      public function visitConstraints(param1:Function) : void
      {
         var _loc3_:* = null as Constraint;
         var _loc4_:* = null as Compound;
         var _loc2_:* = zpp_inner.wrap_constraints.iterator();
         while(_loc2_.hasNext())
         {
            _loc3_ = _loc2_.next();
            param1(_loc3_);
         }
         _loc2_ = zpp_inner.wrap_compounds.iterator();
         while(_loc2_.hasNext())
         {
            _loc4_ = _loc2_.next();
            _loc4_.visitConstraints(param1);
         }
      }
      
      public function visitCompounds(param1:Function) : void
      {
         var _loc3_:* = null as Compound;
         var _loc2_:* = zpp_inner.wrap_compounds.iterator();
         while(_loc2_.hasNext())
         {
            _loc3_ = _loc2_.next();
            param1(_loc3_);
            _loc3_.visitCompounds(param1);
         }
      }
      
      public function visitBodies(param1:Function) : void
      {
         var _loc3_:* = null as Body;
         var _loc4_:* = null as Compound;
         var _loc2_:* = zpp_inner.wrap_bodies.iterator();
         while(_loc2_.hasNext())
         {
            _loc3_ = _loc2_.next();
            param1(_loc3_);
         }
         _loc2_ = zpp_inner.wrap_compounds.iterator();
         while(_loc2_.hasNext())
         {
            _loc4_ = _loc2_.next();
            _loc4_.visitBodies(param1);
         }
      }
      
      public function translate(param1:Vec2) : void
      {
         var translation:Vec2 = param1;
         var _loc2_:Boolean = translation.zpp_inner.weak;
         translation.zpp_inner.weak = false;
         visitBodies(function(param1:Body):void
         {
            if(param1.zpp_inner.wrap_pos == null)
            {
               param1.zpp_inner.setupPosition();
            }
            param1.zpp_inner.wrap_pos.addeq(translation);
         });
         translation.zpp_inner.weak = _loc2_;
         if(translation.zpp_inner.weak)
         {
            translation.dispose();
         }
      }
      
      override public function toString() : String
      {
         return "Compound#" + zpp_inner_i.id;
      }
      
      public function set space(param1:Space) : Space
      {
         zpp_inner.immutable_midstep("Compound::space");
         if((zpp_inner.space == null?null:zpp_inner.space.outer) != param1)
         {
            if(param1 != null)
            {
               param1.zpp_inner.wrap_compounds.add(this);
            }
         }
         return zpp_inner.space == null?null:zpp_inner.space.outer;
      }
      
      public function set compound(param1:Compound) : Compound
      {
         zpp_inner.immutable_midstep("Compound::compound");
         if((zpp_inner.compound == null?null:zpp_inner.compound.outer) != param1)
         {
            if(param1 != null)
            {
               param1.zpp_inner.wrap_compounds.add(this);
            }
         }
         return zpp_inner.compound == null?null:zpp_inner.compound.outer;
      }
      
      public function rotate(param1:Vec2, param2:Number) : void
      {
         var centre:Vec2 = param1;
         var angle:Number = param2;
         var _loc3_:Boolean = centre.zpp_inner.weak;
         centre.zpp_inner.weak = false;
         visitBodies(function(param1:Body):void
         {
            param1.rotate(centre,angle);
         });
         centre.zpp_inner.weak = _loc3_;
         if(centre.zpp_inner.weak)
         {
            centre.dispose();
         }
      }
      
      public function get space() : Space
      {
         return zpp_inner.space == null?null:zpp_inner.space.outer;
      }
      
      public function get constraints() : ConstraintList
      {
         return zpp_inner.wrap_constraints;
      }
      
      public function get compounds() : CompoundList
      {
         return zpp_inner.wrap_compounds;
      }
      
      public function get compound() : Compound
      {
         return zpp_inner.compound == null?null:zpp_inner.compound.outer;
      }
      
      public function get bodies() : BodyList
      {
         return zpp_inner.wrap_bodies;
      }
      
      public function copy() : Compound
      {
         return zpp_inner.copy();
      }
      
      public function breakApart() : void
      {
         zpp_inner.breakApart();
      }
      
      public function COM() : Vec2
      {
         var ret:Vec2 = new Vec2();
         var total:Number = 0;
         visitBodies(function(param1:Body):void
         {
            §§push(ret);
            if(param1.zpp_inner.wrap_worldCOM == null)
            {
               param1.zpp_inner.wrap_worldCOM = Vec2.get(param1.zpp_inner.worldCOMx,param1.zpp_inner.worldCOMy);
               param1.zpp_inner.wrap_worldCOM.zpp_inner._inuse = true;
               param1.zpp_inner.wrap_worldCOM.zpp_inner._immutable = true;
               param1.zpp_inner.wrap_worldCOM.zpp_inner._validate = param1.zpp_inner.getworldCOM;
            }
            param1.zpp_inner.validate_mass();
            §§pop().addeq(param1.zpp_inner.wrap_worldCOM.mul(param1.zpp_inner.cmass,true));
            param1.zpp_inner.validate_mass();
            total = Number(total + param1.zpp_inner.cmass);
         });
         ret.muleq(1 / total);
         return ret;
      }
   }
}
