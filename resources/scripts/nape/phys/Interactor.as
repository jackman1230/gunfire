package nape.phys
{
   import nape.callbacks.CbTypeList;
   import nape.dynamics.InteractionGroup;
   import nape.shape.Shape;
   import zpp_nape.dynamics.ZPP_InteractionGroup;
   import zpp_nape.phys.ZPP_Body;
   import zpp_nape.phys.ZPP_Compound;
   import zpp_nape.phys.ZPP_Interactor;
   import zpp_nape.shape.ZPP_Shape;
   
   public class Interactor
   {
       
      
      public var zpp_inner_i:ZPP_Interactor;
      
      public function Interactor()
      {
      }
      
      public function toString() : String
      {
         return "";
      }
      
      public function set group(param1:InteractionGroup) : InteractionGroup
      {
         zpp_inner_i.immutable_midstep("Interactor::group");
         zpp_inner_i.setGroup(param1 == null?null:param1.zpp_inner);
         return zpp_inner_i.group == null?null:zpp_inner_i.group.outer;
      }
      
      public function isShape() : Boolean
      {
         return zpp_inner_i.ishape != null;
      }
      
      public function isCompound() : Boolean
      {
         return zpp_inner_i.icompound != null;
      }
      
      public function isBody() : Boolean
      {
         return zpp_inner_i.ibody != null;
      }
      
      public function get userData() : *
      {
         if(zpp_inner_i.userData == null)
         {
            zpp_inner_i.userData = {};
         }
         return zpp_inner_i.userData;
      }
      
      public function get id() : int
      {
         return zpp_inner_i.id;
      }
      
      public function get group() : InteractionGroup
      {
         return zpp_inner_i.group == null?null:zpp_inner_i.group.outer;
      }
      
      public function get cbTypes() : CbTypeList
      {
         if(zpp_inner_i.wrap_cbTypes == null)
         {
            zpp_inner_i.setupcbTypes();
         }
         return zpp_inner_i.wrap_cbTypes;
      }
      
      public function get castShape() : Shape
      {
         return !!isShape()?zpp_inner_i.ishape.outer:null;
      }
      
      public function get castCompound() : Compound
      {
         return !!isCompound()?zpp_inner_i.icompound.outer:null;
      }
      
      public function get castBody() : Body
      {
         return !!isBody()?zpp_inner_i.ibody.outer:null;
      }
   }
}
