package zpp_nape.space
{
   import zpp_nape.dynamics.ZPP_Arbiter;
   
   public class ZPP_AABBPair
   {
      
      public static var zpp_pool:ZPP_AABBPair;
       
      
      public var sleeping:Boolean;
      
      public var next:ZPP_AABBPair;
      
      public var n2:ZPP_AABBNode;
      
      public var n1:ZPP_AABBNode;
      
      public var id:int;
      
      public var first:Boolean;
      
      public var di:int;
      
      public var arb:ZPP_Arbiter;
      
      public function ZPP_AABBPair()
      {
      }
   }
}
