package
{
   public class Filters
   {
      
      public static var ground:uint = 2;
      
      public static var car:uint = 4;
      
      public static var wheel:uint = 8;
      
      public static var carryable:uint = 16;
      
      public static var object:uint = 32;
      
      public static var objectSelfNoCollide:uint = 64;
      
      public static var fuckall:uint = 128;
      
      public static var rail:uint = 128;
      
      public static var carB:uint = 256;
      
      public static var leftBlock:uint = 512;
      
      public static var groundMask = 65535 & ~ground & ~rail;
      
      public static var carMask = 65535 & ~car & ~wheel & ~fuckall;
      
      public static var wheelMask = 65535 & ~car & ~wheel & ~carryable & ~rail & ~fuckall & ~carB;
      
      public static var carryableMask = 65535 & ~wheel;
      
      public static var objectMask = 65535;
      
      public static var objectSelfNoCollideMask = 65535 & ~objectSelfNoCollide;
      
      public static var railMask = 65535 & ~ground & ~wheel & ~rail;
      
      public static var fuckallMask = 0;
      
      public static var carBMask = 65535 & ~wheel & ~fuckall & ~carB;
      
      public static var leftblockMask = 65535;
       
      
      public function Filters()
      {
         super();
      }
   }
}
