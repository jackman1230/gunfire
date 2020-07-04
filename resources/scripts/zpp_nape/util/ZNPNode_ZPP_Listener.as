package zpp_nape.util
{
   import zpp_nape.callbacks.ZPP_Listener;
   
   public class ZNPNode_ZPP_Listener
   {
      
      public static var zpp_pool:ZNPNode_ZPP_Listener;
       
      
      public var next:ZNPNode_ZPP_Listener;
      
      public var elt:ZPP_Listener;
      
      public function ZNPNode_ZPP_Listener()
      {
      }
   }
}
