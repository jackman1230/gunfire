package
{
   import nape.constraint.Constraint;
   import nape.constraint.DistanceJoint;
   import nape.constraint.LineJoint;
   import nape.constraint.MotorJoint;
   import nape.constraint.PivotJoint;
   import nape.constraint.WeldJoint;
   import nape.geom.Vec2;
   import nape.phys.Body;
   import nape.phys.BodyType;
   import nape.phys.Material;
   import nape.shape.Circle;
   import nape.shape.Polygon;
   import nape.shape.Shape;
   import nape.space.Space;
   
   public class BoxUtils
   {
      
      public static var m_world:Space;
      
      public static var lastShape:Shape;
      
      public static var isWeak:Boolean = false;
      
      public static var noAdd:Boolean = false;
       
      
      public function BoxUtils()
      {
         super();
      }
      
      public static function groundMaterial() : Material
      {
         return new Material();
      }
      
      public static function NewBox(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Boolean, param7:int = 1, param8:uint = 1, param9:Number = 0.8) : Boner
      {
         var _loc10_:Boner = new Boner(param5 == 0?BodyType.STATIC:BodyType.DYNAMIC,new Vec2(param1,param2));
         var _loc11_:Polygon = new Polygon(Polygon.box(param3,param4,isWeak));
         _loc11_.body = _loc10_;
         _loc11_.filter.collisionGroup = param7;
         _loc11_.filter.collisionMask = param8;
         _loc10_.setShapeMaterials(new Material(0,param9,2,param5 == 0?Number(10):Number(param5)));
         if(!noAdd)
         {
            _loc10_.space = m_world;
         }
         else
         {
            noAdd = false;
         }
         lastShape = _loc11_;
         return _loc10_;
      }
      
      public static function NewOBox(param1:Number, param2:Number, param3:Number, param4:Number, param5:Number, param6:Boolean, param7:Number, param8:int = 1, param9:uint = 1, param10:Number = 0.8) : Boner
      {
         var _loc11_:Boner = new Boner(BodyType.DYNAMIC,new Vec2(param1,param2));
         var _loc12_:Polygon = new Polygon(Polygon.box(param3,param4,isWeak));
         _loc12_.body = _loc11_;
         _loc12_.filter.collisionGroup = param8;
         _loc12_.filter.collisionMask = param9;
         _loc11_.setShapeMaterials(new Material(0,param10,2,param5));
         if(!noAdd)
         {
            _loc11_.space = m_world;
         }
         else
         {
            noAdd = false;
         }
         _loc11_.rotation = param7;
         lastShape = _loc12_;
         return _loc11_;
      }
      
      public static function NewCircle(param1:Number, param2:Number, param3:Number, param4:Number, param5:Boolean, param6:uint = 1, param7:uint = 1, param8:Number = 10, param9:Number = 0.0) : Boner
      {
         var _loc10_:Boner = new Boner(BodyType.DYNAMIC,new Vec2(param1,param2));
         var _loc11_:Circle = new Circle(param3);
         _loc11_.body = _loc10_;
         _loc11_.filter.collisionGroup = param6;
         _loc11_.filter.collisionMask = param7;
         _loc10_.setShapeMaterials(new Material(0,param8,2,param4));
         if(!noAdd)
         {
            _loc10_.space = m_world;
         }
         else
         {
            noAdd = false;
         }
         lastShape = _loc11_;
         return _loc10_;
      }
      
      public static function defineBody(param1:Number, param2:Number, param3:Number, param4:Boolean, param5:uint, param6:uint, param7:Array, param8:Number = 1, param9:Number = 1) : Boner
      {
         var _loc10_:Boner = new Boner(BodyType.DYNAMIC,new Vec2(param1,param2));
         var _loc11_:Polygon = defineShape(param3,param4,param7,param5,param6,param8,false,param9);
         _loc11_.body = _loc10_;
         lastShape = _loc11_;
         if(param3 == 0)
         {
            _loc10_.type = BodyType.STATIC;
         }
         if(!param4)
         {
            _loc10_.type = BodyType.KINEMATIC;
         }
         if(!noAdd)
         {
            _loc10_.space = m_world;
         }
         else
         {
            noAdd = false;
         }
         return _loc10_;
      }
      
      public static function defineShape(param1:Number, param2:Boolean, param3:Array, param4:int, param5:int, param6:Number = 1, param7:Boolean = false, param8:Number = 1) : Polygon
      {
         lastShape = null;
         var _loc9_:Array = new Array(param3.length / 2);
         var _loc10_:int = 0;
         var _loc11_:int = 0;
         if(param7)
         {
            _loc11_ = 0;
            _loc10_ = 10;
         }
         var _loc12_:Number = 0;
         var _loc13_:Number = 0;
         var _loc14_:int = param6 > 0?1:-1;
         var _loc15_:int = param6 > 0?0:int(param3.length / 2 - 1);
         var _loc16_:int = param6 > 0?int(param3.length / 2):-1;
         var _loc17_:int = 0;
         if(param6 < 0)
         {
         }
         var _loc18_:int = _loc15_;
         while(_loc18_ != _loc16_)
         {
            if(param6 >= 0)
            {
               _loc12_ = (param3[_loc18_ * 2] + _loc11_) / World.gameScale * param6;
               _loc13_ = (param3[_loc18_ * 2 + 1] + _loc10_) / World.gameScale * param6;
            }
            else
            {
               _loc12_ = (param3[_loc18_ * 2] + _loc11_) / World.gameScale * param6;
               _loc13_ = (param3[_loc18_ * 2 + 1] + _loc10_) / World.gameScale * Math.abs(param6);
            }
            _loc9_[_loc17_] = new Vec2(_loc12_,_loc13_);
            _loc17_++;
            _loc18_ = _loc18_ + _loc14_;
         }
         var _loc19_:Polygon = new Polygon(_loc9_);
         _loc19_.filter.collisionGroup = param4;
         _loc19_.filter.collisionMask = param5;
         _loc19_.material = new Material(0,param8,2,param1 > 0?Number(param1):Number(0.1));
         if(!param2)
         {
            _loc19_.filter.collisionGroup = !!param2?int(param4):int(Filters.fuckall);
            _loc19_.filter.collisionMask = !!param2?int(param5):int(Filters.fuckallMask);
         }
         return _loc19_;
      }
      
      public static function NewMotorJoint(param1:Boner, param2:Boner, param3:Number = 0, param4:Number = 0, param5:Boolean = false, param6:Boolean = false, param7:Number = 0, param8:Number = 0) : Constraint
      {
         var _loc9_:MotorJoint = new MotorJoint(param1,param2,0,1);
         _loc9_.space = m_world;
         _loc9_.ignore = !param6;
         _loc9_.stiff = true;
         return _loc9_;
      }
      
      public static function NewDistanceJoint(param1:Boner, param2:Boner, param3:Boolean = true, param4:Boolean = false, param5:Number = 0, param6:Number = 0, param7:Number = 0, param8:Number = 0) : DistanceJoint
      {
         var _loc9_:Vec2 = param2.position.copy().subeq(param1.position);
         var _loc10_:Number = Math.sqrt(_loc9_.lsq());
         var _loc11_:Vec2 = midpoint(param1,param2);
         var _loc12_:DistanceJoint = new DistanceJoint(param1,param2,param1.worldToLocal(param1.position),param2.worldToLocal(param2.position),_loc10_,_loc10_);
         _loc12_.ignore = true;
         _loc12_.stiff = false;
         _loc12_.frequency = 2.4;
         _loc12_.damping = 0.75;
         _loc12_.space = m_world;
         return _loc12_;
      }
      
      public static function NewLineJoint(param1:Boner, param2:Boner, param3:Boolean = true, param4:Boolean = false, param5:Number = 0, param6:Number = 0, param7:Number = 0, param8:Number = 0) : LineJoint
      {
         var _loc9_:Vec2 = param2.position.copy().subeq(param1.position);
         var _loc10_:Vec2 = midpoint(param1,param2);
         var _loc11_:LineJoint = new LineJoint(param1,param2,param1.worldToLocal(param2.position),param2.worldToLocal(param2.position),new Vec2(0,1),-20,20);
         _loc11_.ignore = true;
         _loc11_.stiff = true;
         _loc11_.frequency = 30;
         _loc11_.space = m_world;
         return _loc11_;
      }
      
      public static function NewRevJoint(param1:Body, param2:Boner, param3:Number = 0, param4:Number = 0, param5:Boolean = false, param6:Boolean = false, param7:Number = 0, param8:Number = 0) : Constraint
      {
         var _loc9_:PivotJoint = new PivotJoint(param1,param2,param1.worldToLocal(param2.position),param2.worldToLocal(param2.position));
         _loc9_.frequency = 0.01;
         _loc9_.ignore = !param6;
         _loc9_.stiff = true;
         _loc9_.space = m_world;
         return _loc9_;
      }
      
      public static function midpoint(param1:Boner, param2:Boner) : Vec2
      {
         var _loc3_:Vec2 = param1.position.copy().subeq(param2.position).muleq(0.5).addeq(param1.position);
         return _loc3_;
      }
      
      public static function NewSolJoint(param1:Boner, param2:Boner, param3:Number = 0, param4:Number = 0, param5:Boolean = true, param6:Boolean = false, param7:Number = 0, param8:Number = 0) : Constraint
      {
         var _loc9_:* = midpoint(param1,param2);
         var _loc10_:WeldJoint = new WeldJoint(param1,param2,param1.worldToLocal(_loc9_),param2.worldToLocal(_loc9_));
         _loc10_.stiff = true;
         _loc10_.space = m_world;
         return _loc10_;
      }
   }
}
