package
{
   import nape.callbacks.CbEvent;
   import nape.callbacks.CbType;
   import nape.callbacks.InteractionCallback;
   import nape.callbacks.InteractionListener;
   import nape.callbacks.InteractionType;
   import nape.geom.Vec2;
   
   public class EContactListener
   {
      
      public static var localPoint:Vec2 = new Vec2();
      
      public static var impulse:Vec2 = new Vec2();
       
      
      public function EContactListener()
      {
         super();
      }
      
      public static function donkeyBoner() : void
      {
         BoxUtils.m_world.listeners.add(new InteractionListener(CbEvent.BEGIN,InteractionType.ANY,CbType.ANY_BODY,CbType.ANY_BODY,EContactListener.BeginContact));
         BoxUtils.m_world.listeners.add(new InteractionListener(CbEvent.END,InteractionType.COLLISION,CbType.ANY_BODY,CbType.ANY_BODY,EContactListener.EndContact));
      }
      
      public static function BeginContact(param1:InteractionCallback) : void
      {
         var _loc2_:Boner = param1.int1.castBody as Boner;
         var _loc3_:Boner = param1.int2.castBody as Boner;
         localPoint.x = _loc2_.position.x;
         localPoint.y = _loc2_.position.y;
         impulse.x = _loc2_.normalImpulse(_loc3_,true).x;
         impulse.y = _loc2_.normalImpulse(_loc3_,true).y;
         if(_loc2_.userData.contactList)
         {
            if(_loc2_.userData.contactTrigger && bothShapesHaveValidOwners(_loc2_,_loc3_))
            {
               _loc2_.userData.owner.contact(impulse,localPoint,_loc3_,_loc2_);
            }
         }
         if(_loc3_.userData.contactList)
         {
            if(_loc3_.userData.contactTrigger && bothShapesHaveValidOwners(_loc2_,_loc3_))
            {
               _loc3_.userData.owner.contact(impulse,localPoint,_loc2_,_loc3_);
            }
         }
         bleh(_loc2_,_loc3_,true);
      }
      
      public static function bleh(param1:Boner, param2:Boner, param3:Boolean = false) : void
      {
         if(checkhead(param1,param2))
         {
            param1.userData.owner.myHandler.roofConnected = param3;
         }
         if(checkhead(param2,param1))
         {
            param2.userData.owner.myHandler.roofConnected = param3;
         }
         param1.userData.groundObject = null;
         param2.userData.groundObject = null;
         if(checkWheel(param1,param2) && !param2.userData.neutralGround)
         {
            param1.userData.groundConnected = param3;
            if(param3 == true)
            {
               param1.userData.groundObject = param2;
            }
         }
         if(checkWheel(param2,param1) && !param1.userData.neutralGround)
         {
            param2.userData.groundConnected = param3;
            if(param3 == true)
            {
               param2.userData.groundObject = param1;
            }
         }
      }
      
      public static function checkWheel(param1:Boner, param2:Boner) : Boolean
      {
         return param1.userData.isWheel && (param2.userData.isGround || param2.isGround);
      }
      
      public static function checkhead(param1:Boner, param2:Boner) : Boolean
      {
         return param1.userData.isHead && (param2.userData.isGround || param2.isGround);
      }
      
      public static function bothShapesHaveValidOwners(param1:Boner, param2:Boner) : *
      {
         return param1 != null && param2 != null && param1.userData.owner != null && param2.userData.owner != null;
      }
      
      public static function EndContact(param1:InteractionCallback) : void
      {
         var _loc2_:Boner = param1.int1.castBody as Boner;
         var _loc3_:Boner = param1.int2.castBody as Boner;
         if(_loc2_.userData.contactList != null)
         {
            _loc2_.userData.contactList.remove(_loc3_);
         }
         if(_loc3_.userData.contactList != null)
         {
            _loc3_.userData.contactList.remove(_loc2_);
         }
         bleh(_loc2_,_loc3_,false);
      }
      
      public function EcontactListener() : *
      {
      }
   }
}
