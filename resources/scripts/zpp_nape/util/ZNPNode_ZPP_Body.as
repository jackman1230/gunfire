package zpp_nape.util
{
   import zpp_nape.phys.ZPP_Body;
   
   public class ZNPNode_ZPP_Body
   {
      
      public static var zpp_pool:ZNPNode_ZPP_Body;
       
      
      public var next:ZNPNode_ZPP_Body;
      
      public var elt:ZPP_Body;
      
      public function ZNPNode_ZPP_Body()
      {
      }
   }
}
