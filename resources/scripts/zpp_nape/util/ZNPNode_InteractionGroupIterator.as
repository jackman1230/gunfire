package zpp_nape.util
{
   import nape.dynamics.InteractionGroupIterator;
   
   public class ZNPNode_InteractionGroupIterator
   {
      
      public static var zpp_pool:ZNPNode_InteractionGroupIterator;
       
      
      public var next:ZNPNode_InteractionGroupIterator;
      
      public var elt:InteractionGroupIterator;
      
      public function ZNPNode_InteractionGroupIterator()
      {
      }
   }
}
