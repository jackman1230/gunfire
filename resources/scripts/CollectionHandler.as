package
{
   import flash.display.Sprite;
   
   public class CollectionHandler extends Sprite
   {
      
      public static var collectionArray:Vector.<Collection> = new Vector.<Collection>();
      
      public static var completeArray:Vector.<Collection> = new Vector.<Collection>();
      
      public static var slotStart:int = 130;
      
      public static var slotHeight:int = 30;
      
      public static var myParent:Sprite;
      
      public static var self:CollectionHandler;
       
      
      public function CollectionHandler(param1:Sprite)
      {
         super();
         myParent = param1;
         self = this;
      }
      
      public static function cleanup() : void
      {
         collectionArray = new Vector.<Collection>();
         completeArray = new Vector.<Collection>();
      }
      
      public static function collection(param1:String, param2:int) : *
      {
      }
      
      public static function addCollection(param1:String, param2:int) : *
      {
      }
      
      public static function getTargetY(param1:int = 0) : *
      {
         return param1 * slotHeight + slotStart;
      }
      
      public static function resyncSlots() : *
      {
         var _loc1_:int = 0;
         while(_loc1_ < collectionArray.length)
         {
            collectionArray[_loc1_].targetY = getTargetY(_loc1_);
            _loc1_++;
         }
      }
      
      public static function notifyDestruction(param1:Collection) : *
      {
         if(collectionArray.indexOf(param1) > -1)
         {
            collectionArray.splice(collectionArray.indexOf(param1),1);
         }
         resyncSlots();
      }
   }
}
