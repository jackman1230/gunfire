package zpp_nape.util
{
   import nape.geom.GeomPolyIterator;
   
   public class ZNPNode_GeomPolyIterator
   {
      
      public static var zpp_pool:ZNPNode_GeomPolyIterator;
       
      
      public var next:ZNPNode_GeomPolyIterator;
      
      public var elt:GeomPolyIterator;
      
      public function ZNPNode_GeomPolyIterator()
      {
      }
   }
}
