package
{
   import nape.geom.AABB;
   import nape.geom.Vec2;
   import nape.phys.BodyList;
   import objects.cCar;
   import objects.cObject;
   
   public class QueryHandler
   {
      
      public static var markedBodies:Vector.<Boner> = new Vector.<Boner>();
      
      public static var markedObjects:Vector.<cObject> = new Vector.<cObject>();
      
      public static var carConnected:cObject = null;
      
      public static var groundFound:Boolean = false;
      
      public static var railReturn:Boolean = false;
      
      public static var mouseBody:Boner;
      
      public static var originalBody:Boner;
      
      public static var returnCar:cCar;
      
      public static var railBody:Boner = null;
       
      
      public function QueryHandler()
      {
         super();
      }
      
      public static function clearMarkedBodies() : void
      {
         markedBodies.splice(0,markedBodies.length);
         markedObjects.splice(0,markedObjects.length);
         carConnected = null;
         groundFound = false;
         mouseBody = null;
         railBody = null;
      }
      
      public static function AABBfromBody(param1:Boner, param2:Boolean = false) : AABB
      {
         var _loc4_:Vec2 = null;
         var _loc3_:AABB = new AABB();
         if(param1 != null)
         {
            _loc4_ = param1.position;
            carConnected = null;
            if(param1.userData.owner == null || param1.userData.owner.aabbWidth < 0 || param2)
            {
               _loc3_ = param1.bounds;
            }
            else
            {
               _loc3_.x = _loc4_.x;
               _loc3_.y = _loc4_.y;
               _loc3_.width = param1.userData.owner.aabbWidth * 2;
               _loc3_.height = param1.userData.owner.aabbHeight * 2;
            }
         }
         return _loc3_;
      }
      
      public static function getCloseBodies(param1:Boner) : Boolean
      {
         originalBody = param1;
         clearMarkedBodies();
         var _loc2_:BodyList = World.m_world.bodiesInAABB(AABBfromBody(param1));
         var _loc3_:int = 0;
         while(_loc3_ < _loc2_.length)
         {
            closeBodiesCallback(_loc2_.at(_loc3_) as Boner);
            _loc3_++;
         }
         return true;
      }
      
      public static function closeBodiesCallback(param1:Boner) : Boolean
      {
         if(param1.userData.owner != null && param1 != originalBody)
         {
            if(param1.userData.owner != originalBody.userData.owner)
            {
               if(param1.userData.owner.isCar)
               {
                  carConnected = param1.userData.owner;
               }
               if(markedObjects.indexOf(param1.userData.owner) < 0)
               {
                  markedObjects.push(param1.userData.owner);
               }
            }
         }
         return true;
      }
      
      public static function carInsideMe(param1:Boner, param2:Boolean = false) : cCar
      {
         var _loc5_:Boner = null;
         returnCar = null;
         var _loc3_:BodyList = World.m_world.bodiesInAABB(param1.bounds);
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_.at(_loc4_) as Boner;
            if(_loc5_.userData.owner != null && _loc5_.userData.owner != param1.userData.owner && _loc5_.userData.owner.isCar)
            {
               returnCar = _loc5_.userData.owner;
               break;
            }
            _loc4_++;
         }
         return returnCar;
      }
      
      public static function getGroundConnection(param1:Boner, param2:Boolean = false) : Boolean
      {
         originalBody = param1;
         clearMarkedBodies();
         var _loc3_:BodyList = World.m_world.bodiesInAABB(AABBfromBody(param1,param2));
         if(_loc3_.length == 0 || _loc3_.length == 1 && _loc3_.at(0) == param1)
         {
            return false;
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            getGroundConnectionCallback(_loc3_.at(0) as Boner);
            _loc4_++;
         }
         originalBody = null;
         return groundFound;
      }
      
      public static function getGroundConnectionCallback(param1:Boner) : Boolean
      {
         if(param1.userData.owner != null && param1.userData.owner != originalBody.userData.owner && param1.userData.owner.isGround || param1.userData.isGround || (param1 as Boner).isGround)
         {
            groundFound = true;
            return false;
         }
         return true;
      }
      
      public static function getBodyAtMouse(param1:Boolean = true) : Boner
      {
         var _loc5_:Boner = null;
         mouseBody = null;
         var _loc2_:Vec2 = new Vec2(Camera.mouseTransX,Camera.mouseTransY);
         var _loc3_:BodyList = World.m_world.bodiesUnderPoint(_loc2_);
         if(_loc3_.length > 0 && _loc3_.at(0) != null)
         {
         }
         if(_loc3_.length > 1 && _loc3_.at(0) != null)
         {
         }
         var _loc4_:int = 0;
         while(_loc4_ < _loc3_.length)
         {
            _loc5_ = _loc3_.at(_loc4_) as Boner;
            if(_loc5_.isDynamic)
            {
               mouseBody = _loc5_;
               break;
            }
            _loc4_++;
         }
         return mouseBody;
      }
      
      public static function getRailConnection(param1:Boner) : Boolean
      {
         var _loc2_:Boner = null;
         railReturn = false;
         railBody = null;
         clearMarkedBodies();
         for each(_loc2_ in World.m_world.bodiesInAABB(AABBfromBody(param1)))
         {
            getGroundConnectionCallback(_loc2_);
         }
         return railReturn;
      }
      
      public static function getRailConnectionCallback(param1:Boner) : Boolean
      {
         if(param1.userData.isRail)
         {
            railReturn = true;
            railBody = param1;
            return false;
         }
         return true;
      }
   }
}
