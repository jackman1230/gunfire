package zpp_nape.util
{
   import nape.shape.EdgeIterator;
   
   public class ZNPNode_EdgeIterator
   {
      
      public static var zpp_pool:ZNPNode_EdgeIterator;
       
      
      public var next:ZNPNode_EdgeIterator;
      
      public var elt:EdgeIterator;
      
      public function ZNPNode_EdgeIterator()
      {
      }
   }
}
