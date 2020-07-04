package
{
   import nape.geom.Vec2;
   
   public class EContactList
   {
       
      
      public var contacts:Vector.<Boner>;
      
      public var carContacts:Vector.<Boner>;
      
      public var groundContacts:Vector.<Boner>;
      
      public var velos:Vector.<Vec2>;
      
      public var carVelos:Vector.<Vec2>;
      
      public var carLinearVelos:Vector.<Number>;
      
      public var groundVelos:Vector.<Vec2>;
      
      public function EContactList()
      {
         this.contacts = new Vector.<Boner>();
         this.carContacts = new Vector.<Boner>();
         this.groundContacts = new Vector.<Boner>();
         this.velos = new Vector.<Vec2>();
         this.carVelos = new Vector.<Vec2>();
         this.carLinearVelos = new Vector.<Number>();
         this.groundVelos = new Vector.<Vec2>();
         super();
      }
      
      public function getCarConnections() : Boner
      {
         return this.carContacts.length > 0?this.carContacts[0]:null;
      }
      
      public function getCarVelocities() : Vec2
      {
         return this.carContacts.length > 0?this.carVelos[0]:new Vec2(0,0);
      }
      
      public function getCarLinearVelocities() : Number
      {
         return this.carContacts.length > 0?Number(this.carLinearVelos[0]):Number(0);
      }
      
      public function getFollowObjConnection() : Boolean
      {
         var _loc1_:int = 0;
         if(this.carContacts.length > 0)
         {
            _loc1_ = 0;
            while(_loc1_ < this.carContacts.length)
            {
               if(this.carContacts[_loc1_].userData.userData.owner != null && World.followObj != null && this.carContacts[_loc1_].userData.owner == World.followObj)
               {
                  return true;
               }
               _loc1_++;
            }
         }
         return false;
      }
      
      public function getGroundConnection() : Boner
      {
         return this.groundContacts.length > 0?this.groundContacts[0]:null;
      }
      
      public function add(param1:Boner, param2:Vec2 = null) : Boolean
      {
         var _loc3_:int = 0;
         if(param2 == null)
         {
            param2 = new Vec2(0,0);
         }
         var _loc4_:Boolean = false;
         _loc3_ = this.contacts.indexOf(param1);
         if(_loc3_ == -1)
         {
            this.contacts.push(param1);
            this.velos.push(param2);
            _loc4_ = true;
         }
         _loc3_ = this.carContacts.indexOf(param1);
         if(_loc3_ == -1 && param1.userData.owner != null && param1.userData.owner.isCar)
         {
            this.carContacts.push(param1);
            this.carVelos.push(param2);
            this.carLinearVelos.push(param1.velocity.copy(false));
         }
         _loc3_ = this.groundContacts.indexOf(param1);
         if(_loc3_ == -1)
         {
            this.groundContacts.push(param1);
            this.groundVelos.push(param2);
         }
         return _loc4_;
      }
      
      public function remove(param1:Boner) : void
      {
         var _loc2_:int = 0;
         _loc2_ = this.contacts.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.contacts.splice(_loc2_,1);
            this.velos.splice(_loc2_,1);
         }
         _loc2_ = this.carContacts.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.carContacts.splice(_loc2_,1);
            this.carVelos.splice(_loc2_,1);
            this.carLinearVelos.splice(_loc2_,1);
         }
         _loc2_ = this.groundContacts.indexOf(param1);
         if(_loc2_ != -1)
         {
            this.groundContacts.splice(_loc2_,1);
            this.groundVelos.splice(_loc2_,1);
         }
      }
      
      public function clear() : void
      {
         this.contacts = new Vector.<Boner>();
         this.carContacts = new Vector.<Boner>();
         this.groundContacts = new Vector.<Boner>();
         this.velos = new Vector.<Vec2>();
         this.carVelos = new Vector.<Vec2>();
         this.groundVelos = new Vector.<Vec2>();
         this.carLinearVelos = new Vector.<Number>();
      }
      
      public function contains(param1:Boner) : Boolean
      {
         var _loc2_:int = this.contacts.indexOf(param1);
         if(_loc2_ == -1)
         {
            return false;
         }
         return true;
      }
      
      public function size() : int
      {
         return this.contacts.length;
      }
      
      public function get(param1:int) : Boner
      {
         return this.contacts[param1];
      }
   }
}
