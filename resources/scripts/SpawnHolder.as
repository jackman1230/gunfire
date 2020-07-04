package
{
   public class SpawnHolder
   {
       
      
      public var myClass:Class;
      
      public var frequency:int = 1;
      
      public var max:int = 0;
      
      public var spawnY:Number = 1;
      
      public var spawnX:Number = 0;
      
      public function SpawnHolder(param1:Class, param2:int = 1, param3:int = 0, param4:Number = 1, param5:Number = 0)
      {
         super();
         this.myClass = param1;
         this.frequency = param2;
         this.max = param3;
         this.spawnY = param4;
         this.spawnX = param5;
      }
   }
}
