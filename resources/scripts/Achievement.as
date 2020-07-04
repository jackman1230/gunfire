package
{
   public class Achievement
   {
       
      
      public var index:int;
      
      public var name:String;
      
      public var description:String;
      
      public var complete:Boolean;
      
      public function Achievement(param1:int, param2:String, param3:String, param4:Boolean)
      {
         super();
         this.index = param1;
         this.name = param2;
         this.description = param3;
         this.complete = param4;
      }
   }
}
