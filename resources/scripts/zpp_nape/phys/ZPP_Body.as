package zpp_nape.phys
{
   import flash.Boot;
   import flash.display.DisplayObject;
   import nape.constraint.ConstraintList;
   import nape.dynamics.ArbiterList;
   import nape.geom.Vec2;
   import nape.geom.Vec3;
   import nape.phys.Body;
   import nape.phys.BodyList;
   import nape.phys.BodyType;
   import nape.shape.Shape;
   import nape.shape.ShapeList;
   import zpp_nape.constraint.ZPP_Constraint;
   import zpp_nape.dynamics.ZPP_Arbiter;
   import zpp_nape.geom.ZPP_AABB;
   import zpp_nape.geom.ZPP_Vec2;
   import zpp_nape.shape.ZPP_Circle;
   import zpp_nape.shape.ZPP_Polygon;
   import zpp_nape.shape.ZPP_Shape;
   import zpp_nape.space.ZPP_AABBPair;
   import zpp_nape.space.ZPP_Component;
   import zpp_nape.space.ZPP_Space;
   import zpp_nape.util.ZNPList_ZPP_Arbiter;
   import zpp_nape.util.ZNPList_ZPP_Body;
   import zpp_nape.util.ZNPList_ZPP_Constraint;
   import zpp_nape.util.ZNPList_ZPP_Shape;
   import zpp_nape.util.ZNPNode_ZPP_Arbiter;
   import zpp_nape.util.ZNPNode_ZPP_Body;
   import zpp_nape.util.ZNPNode_ZPP_Constraint;
   import zpp_nape.util.ZNPNode_ZPP_Shape;
   import zpp_nape.util.ZPP_Flags;
   import zpp_nape.util.ZPP_Set_ZPP_Body;
   import zpp_nape.util.ZPP_ShapeList;
   
   public class ZPP_Body extends ZPP_Interactor
   {
      
      public static var bodystack:ZNPList_ZPP_Body = null;
      
      public static var bodyset:ZPP_Set_ZPP_Body = null;
      
      public static var cur_graph_depth:int;
       
      
      public var zip_worldCOM:Boolean;
      
      public var zip_mass:Boolean;
      
      public var zip_localCOM:Boolean;
      
      public var zip_inertia:Boolean;
      
      public var zip_gravMassScale:Boolean;
      
      public var zip_gravMass:Boolean;
      
      public var zip_axis:Boolean;
      
      public var zip_aabb:Boolean;
      
      public var wrapcvel:Vec3;
      
      public var wrap_worldCOM:Vec2;
      
      public var wrap_vel:Vec2;
      
      public var wrap_svel:Vec2;
      
      public var wrap_shapes:ShapeList;
      
      public var wrap_pos:Vec2;
      
      public var wrap_localCOM:Vec2;
      
      public var wrap_kinvel:Vec2;
      
      public var wrap_force:Vec2;
      
      public var wrap_constraints:ConstraintList;
      
      public var wrap_arbiters:ArbiterList;
      
      public var worldCOMy:Number;
      
      public var worldCOMx:Number;
      
      public var world:Boolean;
      
      public var vely:Number;
      
      public var velx:Number;
      
      public var type:int;
      
      public var torque:Number;
      
      public var svely:Number;
      
      public var svelx:Number;
      
      public var space:ZPP_Space;
      
      public var smass:Number;
      
      public var sinertia:Number;
      
      public var shapes:ZNPList_ZPP_Shape;
      
      public var rot:Number;
      
      public var pre_rot:Number;
      
      public var pre_posy:Number;
      
      public var pre_posx:Number;
      
      public var posy:Number;
      
      public var posx:Number;
      
      public var outer:Body;
      
      public var norotate:Boolean;
      
      public var nomove:Boolean;
      
      public var massMode:int;
      
      public var mass:Number;
      
      public var localCOMy:Number;
      
      public var localCOMx:Number;
      
      public var kinvely:Number;
      
      public var kinvelx:Number;
      
      public var kinangvel:Number;
      
      public var inertiaMode:int;
      
      public var inertia:Number;
      
      public var imass:Number;
      
      public var iinertia:Number;
      
      public var gravMassScale:Number;
      
      public var gravMassMode:int;
      
      public var gravMass:Number;
      
      public var graphicUpdate:Function;
      
      public var graphicOffset:Vec2;
      
      public var graphic;
      
      public var graph_depth:int;
      
      public var forcey:Number;
      
      public var forcex:Number;
      
      public var flashgraphic:Boolean;
      
      public var constraints:ZNPList_ZPP_Constraint;
      
      public var compound:ZPP_Compound;
      
      public var component:ZPP_Component;
      
      public var cmass:Number;
      
      public var cinertia:Number;
      
      public var axisy:Number;
      
      public var axisx:Number;
      
      public var arbiters:ZNPList_ZPP_Arbiter;
      
      public var angvel:Number;
      
      public var aabb:ZPP_AABB;
      
      public function ZPP_Body()
      {
         var _loc3_:* = null as ZPP_AABB;
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         ibody = this;
         world = false;
         nomove = false;
         norotate = false;
         posx = 0;
         posy = 0;
         rot = 0;
         axisx = 0;
         axisy = 1;
         svelx = 0;
         svely = 0;
         velx = 0;
         vely = 0;
         kinvelx = 0;
         kinvely = 0;
         forcex = 0;
         forcey = 0;
         var _loc2_:Number = 0;
         kinangvel = _loc2_;
         _loc2_ = _loc2_;
         angvel = _loc2_;
         torque = _loc2_;
         pre_posx = 1.79e308;
         pre_posy = 1.79e308;
         pre_rot = 1.79e308;
         localCOMx = 0;
         localCOMy = 0;
         worldCOMx = 0;
         worldCOMy = 0;
         zip_aabb = true;
         §§push();
         if(ZPP_AABB.zpp_pool == null)
         {
            _loc3_ = new ZPP_AABB();
         }
         else
         {
            _loc3_ = ZPP_AABB.zpp_pool;
            ZPP_AABB.zpp_pool = _loc3_.next;
            _loc3_.next = null;
         }
         null;
         _loc3_.minx = 0;
         _loc3_.miny = 0;
         _loc3_.maxx = 0;
         _loc3_.maxy = 0;
         §§pop().aabb = _loc3_;
         aabb._immutable = true;
         aabb._validate = aabb_validate;
         massMode = ZPP_Flags.id_MassMode_DEFAULT;
         gravMassMode = ZPP_Flags.id_GravMassMode_DEFAULT;
         gravMassScale = 1;
         inertiaMode = ZPP_Flags.id_InertiaMode_DEFAULT;
         arbiters = new ZNPList_ZPP_Arbiter();
         constraints = new ZNPList_ZPP_Constraint();
         shapes = new ZNPList_ZPP_Shape();
         wrap_shapes = ZPP_ShapeList.get(shapes);
         wrap_shapes.zpp_inner.adder = shapes_adder;
         wrap_shapes.zpp_inner.subber = shapes_subber;
         wrap_shapes.zpp_inner._invalidate = shapes_invalidate;
         graphicOffset = Vec2.get(0,0);
         graphicOffset.zpp_inner._inuse = true;
      }
      
      public static function bodysetlt(param1:ZPP_Body, param2:ZPP_Body) : Boolean
      {
         return param1.id < param2.id;
      }
      
      public static function __static() : Body
      {
         §§push();
         if(ZPP_Flags.BodyType_STATIC == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.BodyType_STATIC = new BodyType();
            ZPP_Flags.§internal§ = false;
         }
         var _loc1_:Body = new §§pop().Body(ZPP_Flags.BodyType_STATIC);
         var _loc2_:ZPP_Body = _loc1_.zpp_inner;
         _loc2_.world = true;
         _loc2_.wrap_shapes.zpp_inner.immutable = true;
         var _loc3_:Number = 0;
         _loc2_.gravMass = _loc3_;
         _loc3_ = _loc3_;
         _loc2_.mass = _loc3_;
         _loc3_ = _loc3_;
         _loc2_.cmass = _loc3_;
         _loc3_ = _loc3_;
         _loc2_.imass = _loc3_;
         _loc2_.smass = _loc3_;
         _loc3_ = 0;
         _loc2_.inertia = _loc3_;
         _loc3_ = _loc3_;
         _loc2_.cinertia = _loc3_;
         _loc3_ = _loc3_;
         _loc2_.iinertia = _loc3_;
         _loc2_.sinertia = _loc3_;
         _loc2_.cbTypes.clear();
         return _loc1_;
      }
      
      public function vel_validate() : void
      {
         wrap_vel.zpp_inner.x = velx;
         wrap_vel.zpp_inner.y = vely;
      }
      
      public function vel_invalidate(param1:ZPP_Vec2) : void
      {
         velx = param1.x;
         vely = param1.y;
         invalidate_wake();
      }
      
      public function validate_worldCOM() : void
      {
         if(zip_worldCOM)
         {
            zip_worldCOM = false;
            validate_localCOM();
            if(zip_axis)
            {
               zip_axis = false;
               axisx = Number(Math.sin(rot));
               axisy = Number(Math.cos(rot));
               null;
            }
            worldCOMx = Number(posx + (axisy * localCOMx - axisx * localCOMy));
            worldCOMy = Number(posy + (Number(localCOMx * axisx + localCOMy * axisy)));
            if(wrap_worldCOM != null)
            {
               wrap_worldCOM.zpp_inner.x = worldCOMx;
               wrap_worldCOM.zpp_inner.y = worldCOMy;
            }
         }
      }
      
      public function validate_mass() : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_Shape;
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:Number = NaN;
      }
      
      public function validate_localCOM() : void
      {
         var _loc1_:Number = NaN;
         var _loc2_:Number = NaN;
         var _loc3_:Number = NaN;
         var _loc4_:* = null as ZNPNode_ZPP_Shape;
         var _loc5_:* = null as ZPP_Shape;
         var _loc6_:* = null as ZPP_Polygon;
         var _loc7_:Number = NaN;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:* = null as ZPP_Vec2;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:Number = NaN;
         var _loc13_:* = null as ZPP_Vec2;
         if(zip_localCOM)
         {
            zip_localCOM = false;
            _loc1_ = 0;
            _loc2_ = 0;
            _loc3_ = 0;
            _loc4_ = shapes.head;
            while(_loc4_ != null)
            {
               _loc5_ = _loc4_.elt;
               if(_loc5_.zip_localCOM)
               {
                  _loc5_.zip_localCOM = false;
                  if(_loc5_.type == ZPP_Flags.id_ShapeType_POLYGON)
                  {
                     _loc6_ = _loc5_.polygon;
                     if(_loc6_.lverts.next.next == null)
                     {
                        _loc6_.localCOMx = _loc6_.lverts.next.x;
                        _loc6_.localCOMy = _loc6_.lverts.next.y;
                        null;
                     }
                     else if(_loc6_.lverts.next.next.next == null)
                     {
                        _loc6_.localCOMx = _loc6_.lverts.next.x;
                        _loc6_.localCOMy = _loc6_.lverts.next.y;
                        _loc7_ = 1;
                        _loc6_.localCOMx = Number(_loc6_.localCOMx + _loc6_.lverts.next.next.x * _loc7_);
                        _loc6_.localCOMy = Number(_loc6_.localCOMy + _loc6_.lverts.next.next.y * _loc7_);
                        _loc7_ = 0.5;
                        _loc6_.localCOMx = _loc6_.localCOMx * _loc7_;
                        _loc6_.localCOMy = _loc6_.localCOMy * _loc7_;
                     }
                     else
                     {
                        _loc6_.localCOMx = 0;
                        _loc6_.localCOMy = 0;
                        _loc7_ = 0;
                        _loc8_ = _loc6_.lverts.next;
                        _loc9_ = _loc8_;
                        _loc8_ = _loc8_.next;
                        _loc10_ = _loc8_;
                        _loc8_ = _loc8_.next;
                        while(_loc8_ != null)
                        {
                           _loc11_ = _loc8_;
                           _loc7_ = Number(_loc7_ + _loc10_.x * (_loc11_.y - _loc9_.y));
                           _loc12_ = _loc11_.y * _loc10_.x - _loc11_.x * _loc10_.y;
                           _loc6_.localCOMx = Number(_loc6_.localCOMx + (_loc10_.x + _loc11_.x) * _loc12_);
                           _loc6_.localCOMy = Number(_loc6_.localCOMy + (_loc10_.y + _loc11_.y) * _loc12_);
                           _loc9_ = _loc10_;
                           _loc10_ = _loc11_;
                           _loc8_ = _loc8_.next;
                        }
                        _loc8_ = _loc6_.lverts.next;
                        _loc11_ = _loc8_;
                        _loc7_ = Number(_loc7_ + _loc10_.x * (_loc11_.y - _loc9_.y));
                        _loc12_ = _loc11_.y * _loc10_.x - _loc11_.x * _loc10_.y;
                        _loc6_.localCOMx = Number(_loc6_.localCOMx + (_loc10_.x + _loc11_.x) * _loc12_);
                        _loc6_.localCOMy = Number(_loc6_.localCOMy + (_loc10_.y + _loc11_.y) * _loc12_);
                        _loc9_ = _loc10_;
                        _loc10_ = _loc11_;
                        _loc8_ = _loc8_.next;
                        _loc13_ = _loc8_;
                        _loc7_ = Number(_loc7_ + _loc10_.x * (_loc13_.y - _loc9_.y));
                        _loc12_ = _loc13_.y * _loc10_.x - _loc13_.x * _loc10_.y;
                        _loc6_.localCOMx = Number(_loc6_.localCOMx + (_loc10_.x + _loc13_.x) * _loc12_);
                        _loc6_.localCOMy = Number(_loc6_.localCOMy + (_loc10_.y + _loc13_.y) * _loc12_);
                        _loc7_ = 1 / (3 * _loc7_);
                        _loc12_ = _loc7_;
                        _loc6_.localCOMx = _loc6_.localCOMx * _loc12_;
                        _loc6_.localCOMy = _loc6_.localCOMy * _loc12_;
                     }
                  }
                  if(_loc5_.wrap_localCOM != null)
                  {
                     _loc5_.wrap_localCOM.zpp_inner.x = _loc5_.localCOMx;
                     _loc5_.wrap_localCOM.zpp_inner.y = _loc5_.localCOMy;
                  }
               }
               _loc5_.validate_area_inertia();
               _loc7_ = _loc5_.area * _loc5_.material.density;
               _loc1_ = Number(_loc1_ + _loc5_.localCOMx * _loc7_);
               _loc2_ = Number(_loc2_ + _loc5_.localCOMy * _loc7_);
               _loc3_ = Number(_loc3_ + _loc5_.area * _loc5_.material.density);
               _loc4_ = _loc4_.next;
            }
            _loc7_ = 1 / _loc3_;
            localCOMx = _loc1_ * _loc7_;
            localCOMy = _loc2_ * _loc7_;
            if(wrap_localCOM != null)
            {
               wrap_localCOM.zpp_inner.x = localCOMx;
               wrap_localCOM.zpp_inner.y = localCOMy;
            }
            if(!!zip_mass && massMode == ZPP_Flags.id_MassMode_DEFAULT)
            {
               zip_mass = false;
               cmass = _loc3_;
               if(type == ZPP_Flags.id_BodyType_DYNAMIC)
               {
                  mass = cmass;
                  _loc7_ = 1 / mass;
                  smass = _loc7_;
                  imass = _loc7_;
               }
               else
               {
                  mass = 1.79e308;
                  _loc7_ = 0;
                  smass = _loc7_;
                  imass = _loc7_;
               }
            }
         }
      }
      
      public function validate_inertia() : void
      {
         var _loc2_:* = null as ZNPNode_ZPP_Shape;
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:Number = NaN;
      }
      
      public function validate_gravMassScale() : void
      {
         if(zip_gravMassScale)
         {
            zip_gravMassScale = false;
            if(gravMassMode == ZPP_Flags.id_GravMassMode_DEFAULT)
            {
               gravMassScale = 1;
            }
            else if(gravMassMode == ZPP_Flags.id_GravMassMode_FIXED)
            {
               validate_mass();
               gravMassScale = gravMass / cmass;
            }
         }
      }
      
      public function validate_gravMass() : void
      {
         if(zip_gravMass)
         {
            zip_gravMass = false;
            validate_mass();
            if(gravMassMode == ZPP_Flags.id_GravMassMode_DEFAULT)
            {
               validate_mass();
               gravMass = cmass;
            }
            else if(gravMassMode == ZPP_Flags.id_GravMassMode_SCALED)
            {
               validate_mass();
               gravMass = cmass * gravMassScale;
            }
         }
      }
      
      public function validate_graphic() : void
      {
         var _loc1_:* = null as DisplayObject;
         var _loc2_:* = null as Vec2;
         var _loc3_:* = null as ZPP_Vec2;
         var _loc4_:Number = NaN;
         if(graphicUpdate != null)
         {
            graphicUpdate(outer);
         }
         else if(graphic != null && flashgraphic)
         {
            _loc1_ = graphic;
            _loc1_.rotation = (rot + outer.graphicAngleOffset) * 180 / Math.PI % 360;
            _loc2_ = graphicOffset;
            _loc3_ = _loc2_.zpp_inner;
            §§push(_loc1_);
            §§push(axisy);
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            _loc2_ = graphicOffset;
            _loc3_ = _loc2_.zpp_inner;
            §§push(§§pop() * _loc2_.zpp_inner.x);
            §§push(axisx);
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            §§pop().x = §§pop() - §§pop() * _loc2_.zpp_inner.y;
            _loc2_ = graphicOffset;
            _loc3_ = _loc2_.zpp_inner;
            §§push(_loc1_);
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            _loc2_ = graphicOffset;
            _loc3_ = _loc2_.zpp_inner;
            §§push(_loc2_.zpp_inner.x * axisx);
            if(_loc3_._validate != null)
            {
               _loc3_._validate();
            }
            §§pop().y = Number(§§pop() + _loc2_.zpp_inner.y * axisy);
            _loc4_ = 1;
            _loc1_.x = Number(_loc1_.x + posx * _loc4_);
            _loc1_.y = Number(_loc1_.y + posy * _loc4_);
         }
      }
      
      public function validate_aabb() : void
      {
         var _loc1_:* = null as ZNPNode_ZPP_Shape;
         var _loc2_:* = null as ZPP_Shape;
         var _loc3_:* = null as ZPP_Circle;
         var _loc4_:* = null as ZPP_Polygon;
         var _loc5_:Number = NaN;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZPP_Body;
         var _loc13_:* = null as ZPP_AABB;
         var _loc14_:* = null as ZPP_AABB;
         if(zip_aabb)
         {
            zip_aabb = false;
            aabb.minx = 1.79e308;
            aabb.miny = 1.79e308;
            aabb.maxx = -1.79e308;
            aabb.maxy = -1.79e308;
            _loc1_ = shapes.head;
            while(_loc1_ != null)
            {
               _loc2_ = _loc1_.elt;
               if(_loc2_.zip_aabb)
               {
                  if(_loc2_.body != null)
                  {
                     _loc2_.zip_aabb = false;
                     if(_loc2_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        _loc3_ = _loc2_.circle;
                        if(_loc3_.zip_worldCOM)
                        {
                           if(_loc3_.body != null)
                           {
                              _loc3_.zip_worldCOM = false;
                              if(_loc3_.zip_localCOM)
                              {
                                 _loc3_.zip_localCOM = false;
                                 if(_loc3_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                 {
                                    _loc4_ = _loc3_.polygon;
                                    if(_loc4_.lverts.next.next == null)
                                    {
                                       _loc4_.localCOMx = _loc4_.lverts.next.x;
                                       _loc4_.localCOMy = _loc4_.lverts.next.y;
                                       null;
                                    }
                                    else if(_loc4_.lverts.next.next.next == null)
                                    {
                                       _loc4_.localCOMx = _loc4_.lverts.next.x;
                                       _loc4_.localCOMy = _loc4_.lverts.next.y;
                                       _loc5_ = 1;
                                       _loc4_.localCOMx = Number(_loc4_.localCOMx + _loc4_.lverts.next.next.x * _loc5_);
                                       _loc4_.localCOMy = Number(_loc4_.localCOMy + _loc4_.lverts.next.next.y * _loc5_);
                                       _loc5_ = 0.5;
                                       _loc4_.localCOMx = _loc4_.localCOMx * _loc5_;
                                       _loc4_.localCOMy = _loc4_.localCOMy * _loc5_;
                                    }
                                    else
                                    {
                                       _loc4_.localCOMx = 0;
                                       _loc4_.localCOMy = 0;
                                       _loc5_ = 0;
                                       _loc6_ = _loc4_.lverts.next;
                                       _loc7_ = _loc6_;
                                       _loc6_ = _loc6_.next;
                                       _loc8_ = _loc6_;
                                       _loc6_ = _loc6_.next;
                                       while(_loc6_ != null)
                                       {
                                          _loc9_ = _loc6_;
                                          _loc5_ = Number(_loc5_ + _loc8_.x * (_loc9_.y - _loc7_.y));
                                          _loc10_ = _loc9_.y * _loc8_.x - _loc9_.x * _loc8_.y;
                                          _loc4_.localCOMx = Number(_loc4_.localCOMx + (_loc8_.x + _loc9_.x) * _loc10_);
                                          _loc4_.localCOMy = Number(_loc4_.localCOMy + (_loc8_.y + _loc9_.y) * _loc10_);
                                          _loc7_ = _loc8_;
                                          _loc8_ = _loc9_;
                                          _loc6_ = _loc6_.next;
                                       }
                                       _loc6_ = _loc4_.lverts.next;
                                       _loc9_ = _loc6_;
                                       _loc5_ = Number(_loc5_ + _loc8_.x * (_loc9_.y - _loc7_.y));
                                       _loc10_ = _loc9_.y * _loc8_.x - _loc9_.x * _loc8_.y;
                                       _loc4_.localCOMx = Number(_loc4_.localCOMx + (_loc8_.x + _loc9_.x) * _loc10_);
                                       _loc4_.localCOMy = Number(_loc4_.localCOMy + (_loc8_.y + _loc9_.y) * _loc10_);
                                       _loc7_ = _loc8_;
                                       _loc8_ = _loc9_;
                                       _loc6_ = _loc6_.next;
                                       _loc11_ = _loc6_;
                                       _loc5_ = Number(_loc5_ + _loc8_.x * (_loc11_.y - _loc7_.y));
                                       _loc10_ = _loc11_.y * _loc8_.x - _loc11_.x * _loc8_.y;
                                       _loc4_.localCOMx = Number(_loc4_.localCOMx + (_loc8_.x + _loc11_.x) * _loc10_);
                                       _loc4_.localCOMy = Number(_loc4_.localCOMy + (_loc8_.y + _loc11_.y) * _loc10_);
                                       _loc5_ = 1 / (3 * _loc5_);
                                       _loc10_ = _loc5_;
                                       _loc4_.localCOMx = _loc4_.localCOMx * _loc10_;
                                       _loc4_.localCOMy = _loc4_.localCOMy * _loc10_;
                                    }
                                 }
                                 if(_loc3_.wrap_localCOM != null)
                                 {
                                    _loc3_.wrap_localCOM.zpp_inner.x = _loc3_.localCOMx;
                                    _loc3_.wrap_localCOM.zpp_inner.y = _loc3_.localCOMy;
                                 }
                              }
                              _loc12_ = _loc3_.body;
                              if(_loc12_.zip_axis)
                              {
                                 _loc12_.zip_axis = false;
                                 _loc12_.axisx = Number(Math.sin(_loc12_.rot));
                                 _loc12_.axisy = Number(Math.cos(_loc12_.rot));
                                 null;
                              }
                              _loc3_.worldCOMx = Number(_loc3_.body.posx + (_loc3_.body.axisy * _loc3_.localCOMx - _loc3_.body.axisx * _loc3_.localCOMy));
                              _loc3_.worldCOMy = Number(_loc3_.body.posy + (Number(_loc3_.localCOMx * _loc3_.body.axisx + _loc3_.localCOMy * _loc3_.body.axisy)));
                              if(_loc3_.wrap_worldCOM != null)
                              {
                                 _loc3_.wrap_worldCOM.zpp_inner.x = _loc3_.worldCOMx;
                                 _loc3_.wrap_worldCOM.zpp_inner.y = _loc3_.worldCOMy;
                              }
                           }
                        }
                        _loc5_ = _loc3_.radius;
                        _loc10_ = _loc3_.radius;
                        _loc3_.aabb.minx = _loc3_.worldCOMx - _loc5_;
                        _loc3_.aabb.miny = _loc3_.worldCOMy - _loc10_;
                        _loc3_.aabb.maxx = Number(_loc3_.worldCOMx + _loc5_);
                        _loc3_.aabb.maxy = Number(_loc3_.worldCOMy + _loc10_);
                     }
                     else
                     {
                        _loc4_ = _loc2_.polygon;
                        if(_loc4_.zip_gverts)
                        {
                           if(_loc4_.body != null)
                           {
                              _loc4_.zip_gverts = false;
                              _loc4_.validate_lverts();
                              _loc12_ = _loc4_.body;
                              if(_loc12_.zip_axis)
                              {
                                 _loc12_.zip_axis = false;
                                 _loc12_.axisx = Number(Math.sin(_loc12_.rot));
                                 _loc12_.axisy = Number(Math.cos(_loc12_.rot));
                                 null;
                              }
                              _loc6_ = _loc4_.lverts.next;
                              _loc7_ = _loc4_.gverts.next;
                              while(_loc7_ != null)
                              {
                                 _loc8_ = _loc7_;
                                 _loc9_ = _loc6_;
                                 _loc6_ = _loc6_.next;
                                 _loc8_.x = Number(_loc4_.body.posx + (_loc4_.body.axisy * _loc9_.x - _loc4_.body.axisx * _loc9_.y));
                                 _loc8_.y = Number(_loc4_.body.posy + (Number(_loc9_.x * _loc4_.body.axisx + _loc9_.y * _loc4_.body.axisy)));
                                 _loc7_ = _loc7_.next;
                              }
                           }
                        }
                        _loc6_ = _loc4_.gverts.next;
                        _loc4_.aabb.minx = _loc6_.x;
                        _loc4_.aabb.miny = _loc6_.y;
                        _loc4_.aabb.maxx = _loc6_.x;
                        _loc4_.aabb.maxy = _loc6_.y;
                        _loc7_ = _loc4_.gverts.next.next;
                        while(_loc7_ != null)
                        {
                           _loc8_ = _loc7_;
                           if(_loc8_.x < _loc4_.aabb.minx)
                           {
                              _loc4_.aabb.minx = _loc8_.x;
                           }
                           if(_loc8_.x > _loc4_.aabb.maxx)
                           {
                              _loc4_.aabb.maxx = _loc8_.x;
                           }
                           if(_loc8_.y < _loc4_.aabb.miny)
                           {
                              _loc4_.aabb.miny = _loc8_.y;
                           }
                           if(_loc8_.y > _loc4_.aabb.maxy)
                           {
                              _loc4_.aabb.maxy = _loc8_.y;
                           }
                           _loc7_ = _loc7_.next;
                        }
                     }
                  }
               }
               _loc13_ = aabb;
               _loc14_ = _loc2_.aabb;
               if(_loc14_.minx < _loc13_.minx)
               {
                  _loc13_.minx = _loc14_.minx;
               }
               if(_loc14_.maxx > _loc13_.maxx)
               {
                  _loc13_.maxx = _loc14_.maxx;
               }
               if(_loc14_.miny < _loc13_.miny)
               {
                  _loc13_.miny = _loc14_.miny;
               }
               if(_loc14_.maxy > _loc13_.maxy)
               {
                  _loc13_.maxy = _loc14_.maxy;
               }
               _loc1_ = _loc1_.next;
            }
         }
      }
      
      public function svel_validate() : void
      {
         wrap_svel.zpp_inner.x = svelx;
         wrap_svel.zpp_inner.y = svely;
      }
      
      public function svel_invalidate(param1:ZPP_Vec2) : void
      {
         svelx = param1.x;
         svely = param1.y;
         invalidate_wake();
      }
      
      public function shapes_subber(param1:Shape) : void
      {
         if(space != null)
         {
            space.removed_shape(param1.zpp_inner);
         }
         param1.zpp_inner.body = null;
         param1.zpp_inner.removedFromBody();
      }
      
      public function shapes_invalidate(param1:ZPP_ShapeList) : void
      {
         invalidate_shapes();
      }
      
      public function shapes_adder(param1:Shape) : Boolean
      {
         var _loc2_:* = null as ZPP_Space;
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:Boolean = false;
         var _loc5_:* = null as ZPP_Body;
         if(param1.zpp_inner.body != this)
         {
            if(param1.zpp_inner.body != null)
            {
               param1.zpp_inner.body.wrap_shapes.remove(param1);
            }
            param1.zpp_inner.body = this;
            param1.zpp_inner.addedToBody();
            if(space != null)
            {
               _loc2_ = space;
               _loc3_ = param1.zpp_inner;
               _loc4_ = false;
               if(!_loc4_)
               {
                  _loc5_ = _loc3_.body;
                  if(!_loc5_.world)
                  {
                     _loc5_.component.waket = _loc2_.stamp + (!!_loc2_.midstep?0:1);
                     if(_loc5_.component.sleeping)
                     {
                        _loc2_.really_wake(_loc5_,false);
                     }
                  }
               }
               _loc2_.bphase.insert(_loc3_);
               _loc3_.addedToSpace();
            }
            return true;
         }
         return false;
      }
      
      public function setupsvel() : void
      {
         wrap_svel = Vec2.get(svelx,svely);
         wrap_svel.zpp_inner._inuse = true;
         if(world)
         {
            wrap_svel.zpp_inner._immutable = true;
         }
         else
         {
            wrap_svel.zpp_inner._invalidate = svel_invalidate;
            wrap_svel.zpp_inner._validate = svel_validate;
         }
      }
      
      public function setupkinvel() : void
      {
         wrap_kinvel = Vec2.get(kinvelx,kinvely);
         wrap_kinvel.zpp_inner._inuse = true;
         if(world)
         {
            wrap_kinvel.zpp_inner._immutable = true;
         }
         else
         {
            wrap_kinvel.zpp_inner._invalidate = kinvel_invalidate;
            wrap_kinvel.zpp_inner._validate = kinvel_validate;
         }
      }
      
      public function setup_cvel() : void
      {
         wrapcvel = Vec3.get();
         wrapcvel.zpp_inner.immutable = true;
         wrapcvel.zpp_inner._validate = cvel_validate;
      }
      
      public function setupVelocity() : void
      {
         wrap_vel = Vec2.get(velx,vely);
         wrap_vel.zpp_inner._inuse = true;
         if(world)
         {
            wrap_vel.zpp_inner._immutable = true;
         }
         else
         {
            wrap_vel.zpp_inner._invalidate = vel_invalidate;
            wrap_vel.zpp_inner._validate = vel_validate;
         }
      }
      
      public function setupPosition() : void
      {
         wrap_pos = Vec2.get(posx,posy);
         wrap_pos.zpp_inner._inuse = true;
         if(world)
         {
            wrap_pos.zpp_inner._immutable = true;
         }
         else
         {
            wrap_pos.zpp_inner._invalidate = pos_invalidate;
            wrap_pos.zpp_inner._validate = pos_validate;
         }
      }
      
      public function setupForce() : void
      {
         wrap_force = Vec2.get(forcex,forcey);
         wrap_force.zpp_inner._inuse = true;
         if(world)
         {
            wrap_force.zpp_inner._immutable = true;
         }
         else
         {
            wrap_force.zpp_inner._invalidate = force_invalidate;
            wrap_force.zpp_inner._validate = force_validate;
         }
      }
      
      public function removedFromSpace() : void
      {
         var _loc1_:* = null as ZPP_Arbiter;
         var _loc2_:* = null as ZNPList_ZPP_Arbiter;
         var _loc3_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc4_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc5_:Boolean = false;
         var _loc6_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc7_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc8_:* = null as ZNPNode_ZPP_Arbiter;
         while(arbiters.head != null)
         {
            _loc1_ = arbiters.pop_unsafe();
            _loc1_.cleared = true;
            if(_loc1_.b2 == this)
            {
               _loc2_ = _loc1_.b1.arbiters;
               _loc3_ = null;
               _loc4_ = _loc2_.head;
               _loc5_ = false;
               while(_loc4_ != null)
               {
                  if(_loc4_.elt == _loc1_)
                  {
                     if(_loc3_ == null)
                     {
                        _loc6_ = _loc2_.head;
                        _loc7_ = _loc6_.next;
                        _loc2_.head = _loc7_;
                        if(_loc2_.head == null)
                        {
                           _loc2_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc6_ = _loc3_.next;
                        _loc7_ = _loc6_.next;
                        _loc3_.next = _loc7_;
                        if(_loc7_ == null)
                        {
                           _loc2_.pushmod = true;
                        }
                     }
                     _loc8_ = _loc6_;
                     _loc8_.elt = null;
                     _loc8_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc8_;
                     _loc2_.modified = true;
                     _loc2_.length = _loc2_.length - 1;
                     _loc2_.pushmod = true;
                     _loc7_;
                     _loc5_ = true;
                     break;
                  }
                  _loc3_ = _loc4_;
                  _loc4_ = _loc4_.next;
               }
               _loc5_;
            }
            if(_loc1_.b1 == this)
            {
               _loc2_ = _loc1_.b2.arbiters;
               _loc3_ = null;
               _loc4_ = _loc2_.head;
               _loc5_ = false;
               while(_loc4_ != null)
               {
                  if(_loc4_.elt == _loc1_)
                  {
                     if(_loc3_ == null)
                     {
                        _loc6_ = _loc2_.head;
                        _loc7_ = _loc6_.next;
                        _loc2_.head = _loc7_;
                        if(_loc2_.head == null)
                        {
                           _loc2_.pushmod = true;
                        }
                     }
                     else
                     {
                        _loc6_ = _loc3_.next;
                        _loc7_ = _loc6_.next;
                        _loc3_.next = _loc7_;
                        if(_loc7_ == null)
                        {
                           _loc2_.pushmod = true;
                        }
                     }
                     _loc8_ = _loc6_;
                     _loc8_.elt = null;
                     _loc8_.next = ZNPNode_ZPP_Arbiter.zpp_pool;
                     ZNPNode_ZPP_Arbiter.zpp_pool = _loc8_;
                     _loc2_.modified = true;
                     _loc2_.length = _loc2_.length - 1;
                     _loc2_.pushmod = true;
                     _loc7_;
                     _loc5_ = true;
                     break;
                  }
                  _loc3_ = _loc4_;
                  _loc4_ = _loc4_.next;
               }
               _loc5_;
            }
            if(_loc1_.pair != null)
            {
               _loc1_.pair.arb = null;
               _loc1_.pair = null;
            }
            _loc1_.active = false;
            space.f_arbiters.modified = true;
         }
         var _loc9_:ZPP_Component = component;
         _loc9_.body = null;
         _loc9_.constraint = null;
         null;
         _loc9_.next = ZPP_Component.zpp_pool;
         ZPP_Component.zpp_pool = _loc9_;
         component = null;
         __iremovedFromSpace();
      }
      
      public function refreshArbiters() : void
      {
         var _loc2_:* = null as ZPP_Arbiter;
         var _loc1_:ZNPNode_ZPP_Arbiter = arbiters.head;
         while(_loc1_ != null)
         {
            _loc2_ = _loc1_.elt;
            _loc2_.invalidated = true;
            _loc1_ = _loc1_.next;
         }
      }
      
      public function pos_validate() : void
      {
         wrap_pos.zpp_inner.x = posx;
         wrap_pos.zpp_inner.y = posy;
      }
      
      public function pos_invalidate(param1:ZPP_Vec2) : void
      {
         var _loc2_:Boolean = false;
         var _loc3_:* = null as ZNPNode_ZPP_Shape;
         var _loc4_:* = null as ZPP_Shape;
         immutable_midstep("Body::position");
         if(!(posx == param1.x && posy == param1.y))
         {
            posx = param1.x;
            posy = param1.y;
            _loc2_ = false;
            _loc3_ = shapes.head;
            while(_loc3_ != null)
            {
               _loc4_ = _loc3_.elt;
               if(_loc4_.type == ZPP_Flags.id_ShapeType_POLYGON)
               {
                  _loc4_.polygon.invalidate_gverts();
                  _loc4_.polygon.invalidate_gaxi();
               }
               _loc4_.invalidate_worldCOM();
               _loc3_ = _loc3_.next;
            }
            invalidate_worldCOM();
            if(!_loc2_)
            {
               validate_graphic();
            }
            wake();
         }
      }
      
      public function kinvel_validate() : void
      {
         wrap_kinvel.zpp_inner.x = kinvelx;
         wrap_kinvel.zpp_inner.y = kinvely;
      }
      
      public function kinvel_invalidate(param1:ZPP_Vec2) : void
      {
         kinvelx = param1.x;
         kinvely = param1.y;
         invalidate_wake();
      }
      
      public function invalidate_worldCOM() : void
      {
         zip_worldCOM = true;
      }
      
      public function invalidate_wake() : void
      {
         wake();
      }
      
      public function invalidate_type() : void
      {
         invalidate_mass();
         invalidate_inertia();
      }
      
      public function invalidate_shapes() : void
      {
         invalidate_aabb();
         invalidate_localCOM();
         invalidate_mass();
         invalidate_inertia();
      }
      
      public function invalidate_mass() : void
      {
         if(massMode == ZPP_Flags.id_MassMode_DEFAULT)
         {
            zip_mass = true;
         }
         invalidate_gravMass();
      }
      
      public function invalidate_localCOM() : void
      {
         zip_localCOM = true;
         invalidate_worldCOM();
      }
      
      public function invalidate_inertia() : void
      {
         if(inertiaMode != ZPP_Flags.id_InertiaMode_FIXED)
         {
            zip_inertia = true;
         }
         wake();
      }
      
      public function invalidate_gravMassScale() : void
      {
         if(gravMassMode != ZPP_Flags.id_GravMassMode_SCALED)
         {
            zip_gravMassScale = true;
         }
         else
         {
            invalidate_gravMass();
         }
      }
      
      public function invalidate_gravMass() : void
      {
         if(gravMassMode != ZPP_Flags.id_GravMassMode_FIXED)
         {
            zip_gravMass = true;
         }
         if(gravMassMode != ZPP_Flags.id_GravMassMode_SCALED)
         {
            zip_gravMassScale = true;
         }
         wake();
      }
      
      public function invalidate_aabb() : void
      {
         zip_aabb = true;
      }
      
      public function interactingBodies(param1:int, param2:int) : BodyList
      {
         var _loc4_:* = null as ZPP_Body;
         var _loc5_:* = null as ZNPNode_ZPP_Arbiter;
         var _loc6_:* = null as ZPP_Arbiter;
         var _loc7_:* = null as ZPP_Body;
         var _loc9_:* = null as ZPP_Set_ZPP_Body;
         var _loc10_:* = null as ZPP_Set_ZPP_Body;
         if(ZPP_Body.bodyset == null)
         {
            ZPP_Body.bodyset = new ZPP_Set_ZPP_Body();
            ZPP_Body.bodyset.lt = ZPP_Body.bodysetlt;
            ZPP_Body.bodystack = new ZNPList_ZPP_Body();
         }
         null;
         var _loc3_:BodyList = new BodyList();
         ZPP_Body.bodyset.insert(this);
         ZPP_Body.bodystack.add(this);
         graph_depth = 0;
         while(ZPP_Body.bodystack.head != null)
         {
            _loc4_ = ZPP_Body.bodystack.pop_unsafe();
            if(_loc4_.graph_depth != param2)
            {
               _loc5_ = _loc4_.arbiters.head;
               while(_loc5_ != null)
               {
                  _loc6_ = _loc5_.elt;
                  if((_loc6_.type & param1) != 0)
                  {
                     _loc7_ = _loc6_.b1 == _loc4_?_loc6_.b2:_loc6_.b1;
                     if(ZPP_Body.bodyset.try_insert_bool(_loc7_))
                     {
                        ZPP_Body.bodystack.add(_loc7_);
                        _loc7_.graph_depth = _loc4_.graph_depth + 1;
                     }
                  }
                  _loc5_ = _loc5_.next;
               }
               continue;
            }
         }
         var _loc8_:ZPP_Set_ZPP_Body = ZPP_Body.bodyset;
         if(_loc8_.parent == null)
         {
            null;
         }
         else
         {
            _loc9_ = _loc8_.parent;
            while(_loc9_ != null)
            {
               if(_loc9_.prev != null)
               {
                  §§push(_loc9_.prev);
               }
               else if(_loc9_.next != null)
               {
                  §§push(_loc9_.next);
               }
               else
               {
                  _loc3_.add(_loc9_.data.outer);
                  _loc10_ = _loc9_.parent;
                  if(_loc10_ != null)
                  {
                     if(_loc9_ == _loc10_.prev)
                     {
                        _loc10_.prev = null;
                     }
                     else
                     {
                        _loc10_.next = null;
                     }
                     _loc9_.parent = null;
                  }
                  §§push(_loc10_);
               }
               _loc9_ = §§pop();
            }
            _loc8_.parent = null;
         }
         return _loc3_;
      }
      
      public function init_bodysetlist() : void
      {
         if(ZPP_Body.bodyset == null)
         {
            ZPP_Body.bodyset = new ZPP_Set_ZPP_Body();
            ZPP_Body.bodyset.lt = ZPP_Body.bodysetlt;
            ZPP_Body.bodystack = new ZNPList_ZPP_Body();
         }
      }
      
      public function getworldCOM() : void
      {
         validate_worldCOM();
      }
      
      public function getlocalCOM() : void
      {
         validate_localCOM();
      }
      
      public function force_validate() : void
      {
         wrap_force.zpp_inner.x = forcex;
         wrap_force.zpp_inner.y = forcey;
      }
      
      public function force_invalidate(param1:ZPP_Vec2) : void
      {
         forcex = param1.x;
         forcey = param1.y;
         if(type == ZPP_Flags.id_BodyType_DYNAMIC)
         {
            invalidate_wake();
         }
      }
      
      public function cvel_validate() : void
      {
         wrapcvel.zpp_inner.x = Number(velx + kinvelx);
         wrapcvel.zpp_inner.y = Number(vely + kinvely);
         wrapcvel.zpp_inner.z = Number(angvel + kinangvel);
      }
      
      public function copy() : Body
      {
         var _loc2_:* = null as ZNPNode_ZPP_Shape;
         var _loc3_:* = null as ZPP_Shape;
         var _loc4_:* = null as Shape;
         var _loc5_:Boolean = false;
         var _loc1_:ZPP_Body = new Body().zpp_inner;
         _loc1_.type = type;
         _loc2_ = shapes.head;
         while(_loc2_ != null)
         {
            _loc3_ = _loc2_.elt;
            _loc4_ = Shape.copy(_loc3_.outer);
            _loc1_.outer.zpp_inner.wrap_shapes.add(_loc4_);
            _loc2_ = _loc2_.next;
         }
         _loc1_.posx = posx;
         _loc1_.posy = posy;
         _loc1_.velx = velx;
         _loc1_.vely = vely;
         _loc1_.forcex = forcex;
         _loc1_.forcey = forcey;
         _loc1_.rot = rot;
         _loc1_.angvel = angvel;
         _loc1_.torque = torque;
         _loc1_.kinvelx = kinvelx;
         _loc1_.kinvely = kinvely;
         _loc1_.kinangvel = kinangvel;
         _loc1_.svelx = svelx;
         _loc1_.svely = svely;
         if(!zip_axis)
         {
            _loc1_.axisx = axisx;
            _loc1_.axisy = axisy;
         }
         else
         {
            _loc5_ = false;
            _loc1_.zip_axis = true;
            _loc2_ = _loc1_.shapes.head;
            while(_loc2_ != null)
            {
               _loc3_ = _loc2_.elt;
               if(_loc3_.type == ZPP_Flags.id_ShapeType_POLYGON)
               {
                  _loc3_.polygon.invalidate_gverts();
                  _loc3_.polygon.invalidate_gaxi();
               }
               _loc3_.invalidate_worldCOM();
               _loc2_ = _loc2_.next;
            }
            _loc1_.invalidate_worldCOM();
            if(!_loc5_)
            {
               _loc1_.validate_graphic();
            }
         }
         _loc1_.rot = rot;
         _loc1_.massMode = massMode;
         _loc1_.gravMassMode = gravMassMode;
         _loc1_.inertiaMode = inertiaMode;
         if(!zip_mass)
         {
            _loc1_.mass = mass;
         }
         else
         {
            _loc1_.invalidate_mass();
         }
         if(!zip_gravMass)
         {
            _loc1_.gravMass = gravMass;
         }
         else
         {
            _loc1_.invalidate_gravMass();
         }
         if(!zip_gravMassScale)
         {
            _loc1_.gravMassScale = gravMassScale;
         }
         else
         {
            _loc1_.invalidate_gravMassScale();
         }
         if(!zip_inertia)
         {
            _loc1_.inertia = inertia;
         }
         else
         {
            _loc1_.invalidate_inertia();
         }
         if(!zip_aabb)
         {
            _loc1_.aabb.minx = aabb.minx;
            _loc1_.aabb.miny = aabb.miny;
            _loc1_.aabb.maxx = aabb.maxx;
            _loc1_.aabb.maxy = aabb.maxy;
         }
         else
         {
            _loc1_.invalidate_aabb();
         }
         if(!zip_localCOM)
         {
            _loc1_.localCOMx = localCOMx;
            _loc1_.localCOMy = localCOMy;
         }
         else
         {
            _loc1_.invalidate_localCOM();
         }
         if(!zip_worldCOM)
         {
            _loc1_.worldCOMx = worldCOMx;
            _loc1_.worldCOMy = worldCOMy;
         }
         else
         {
            _loc1_.invalidate_worldCOM();
         }
         copyto(_loc1_.outer);
         return _loc1_.outer;
      }
      
      public function connectedBodies_cont(param1:Body) : void
      {
         if(ZPP_Body.bodyset.try_insert_bool(param1.zpp_inner))
         {
            ZPP_Body.bodystack.add(param1.zpp_inner);
            param1.zpp_inner.graph_depth = ZPP_Body.cur_graph_depth + 1;
         }
      }
      
      public function connectedBodies(param1:int) : BodyList
      {
         var _loc3_:* = null as ZPP_Body;
         var _loc4_:* = null as ZNPNode_ZPP_Constraint;
         var _loc5_:* = null as ZPP_Constraint;
         var _loc7_:* = null as ZPP_Set_ZPP_Body;
         var _loc8_:* = null as ZPP_Set_ZPP_Body;
         if(ZPP_Body.bodyset == null)
         {
            ZPP_Body.bodyset = new ZPP_Set_ZPP_Body();
            ZPP_Body.bodyset.lt = ZPP_Body.bodysetlt;
            ZPP_Body.bodystack = new ZNPList_ZPP_Body();
         }
         null;
         var _loc2_:BodyList = new BodyList();
         ZPP_Body.bodystack.add(this);
         ZPP_Body.bodyset.insert(this);
         graph_depth = 0;
         while(ZPP_Body.bodystack.head != null)
         {
            _loc3_ = ZPP_Body.bodystack.pop_unsafe();
            if(_loc3_.graph_depth != param1)
            {
               ZPP_Body.cur_graph_depth = _loc3_.graph_depth;
               _loc4_ = _loc3_.constraints.head;
               while(_loc4_ != null)
               {
                  _loc5_ = _loc4_.elt;
                  _loc5_.outer.visitBodies(connectedBodies_cont);
                  _loc4_ = _loc4_.next;
               }
               continue;
            }
         }
         var _loc6_:ZPP_Set_ZPP_Body = ZPP_Body.bodyset;
         if(_loc6_.parent == null)
         {
            null;
         }
         else
         {
            _loc7_ = _loc6_.parent;
            while(_loc7_ != null)
            {
               if(_loc7_.prev != null)
               {
                  §§push(_loc7_.prev);
               }
               else if(_loc7_.next != null)
               {
                  §§push(_loc7_.next);
               }
               else
               {
                  _loc2_.add(_loc7_.data.outer);
                  _loc8_ = _loc7_.parent;
                  if(_loc8_ != null)
                  {
                     if(_loc7_ == _loc8_.prev)
                     {
                        _loc8_.prev = null;
                     }
                     else
                     {
                        _loc8_.next = null;
                     }
                     _loc7_.parent = null;
                  }
                  §§push(_loc8_);
               }
               _loc7_ = §§pop();
            }
            _loc6_.parent = null;
         }
         return _loc2_;
      }
      
      public function clear() : void
      {
         var _loc1_:* = null as ZPP_Shape;
         while(shapes.head != null)
         {
            _loc1_ = shapes.pop_unsafe();
            _loc1_.removedFromBody();
            _loc1_.body = null;
         }
         invalidate_shapes();
         pre_posx = 0;
         pre_posy = 0;
         posx = 0;
         posy = 0;
         velx = 0;
         vely = 0;
         forcex = 0;
         forcey = 0;
         kinvelx = 0;
         kinvely = 0;
         svelx = 0;
         svely = 0;
         var _loc2_:Number = 0;
         rot = _loc2_;
         _loc2_ = _loc2_;
         pre_rot = _loc2_;
         _loc2_ = _loc2_;
         kinangvel = _loc2_;
         _loc2_ = _loc2_;
         torque = _loc2_;
         angvel = _loc2_;
         var _loc3_:Boolean = false;
         var _loc4_:ZNPNode_ZPP_Shape = shapes.head;
         while(_loc4_ != null)
         {
            _loc1_ = _loc4_.elt;
            if(_loc1_.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               _loc1_.polygon.invalidate_gverts();
               _loc1_.polygon.invalidate_gaxi();
            }
            _loc1_.invalidate_worldCOM();
            _loc4_ = _loc4_.next;
         }
         invalidate_worldCOM();
         if(!_loc3_)
         {
            validate_graphic();
         }
         _loc3_ = false;
         zip_axis = true;
         _loc4_ = shapes.head;
         while(_loc4_ != null)
         {
            _loc1_ = _loc4_.elt;
            if(_loc1_.type == ZPP_Flags.id_ShapeType_POLYGON)
            {
               _loc1_.polygon.invalidate_gverts();
               _loc1_.polygon.invalidate_gaxi();
            }
            _loc1_.invalidate_worldCOM();
            _loc4_ = _loc4_.next;
         }
         invalidate_worldCOM();
         if(!_loc3_)
         {
            validate_graphic();
         }
         axisx = 0;
         axisy = 1;
         zip_axis = false;
         massMode = ZPP_Flags.id_MassMode_DEFAULT;
         gravMassMode = ZPP_Flags.id_GravMassMode_DEFAULT;
         gravMassScale = 1;
         inertiaMode = ZPP_Flags.id_InertiaMode_DEFAULT;
         norotate = false;
         nomove = false;
         graphic = null;
         graphicUpdate = null;
      }
      
      public function atRest(param1:Number) : Boolean
      {
         var _loc2_:Boolean = false;
         var _loc3_:Number = NaN;
         var _loc4_:Number = NaN;
         var _loc5_:Number = NaN;
         var _loc6_:Number = NaN;
         if(type != ZPP_Flags.id_BodyType_DYNAMIC)
         {
            return component.sleeping;
         }
         if(Number(velx * velx + vely * vely) > 0.2)
         {
            §§push(false);
         }
         else
         {
            _loc3_ = posx - pre_posx;
            _loc4_ = posy - pre_posy;
            if(Number(_loc3_ * _loc3_ + _loc4_ * _loc4_) > 0.05 * param1 * param1)
            {
               §§push(false);
            }
            else
            {
               _loc3_ = aabb.maxx - aabb.minx;
               _loc4_ = aabb.maxy - aabb.miny;
               _loc5_ = Number(_loc3_ * _loc3_ + _loc4_ * _loc4_);
               if(4 * angvel * angvel * _loc5_ > 0.4)
               {
                  §§push(false);
               }
               else
               {
                  _loc6_ = rot - pre_rot;
                  §§push(_loc6_ * _loc6_ * _loc5_ > 0.4 * param1 * param1?false:true);
               }
            }
         }
         _loc2_ = §§pop();
         if(!_loc2_)
         {
            component.waket = space.stamp;
         }
         return component.waket + 60 < space.stamp;
      }
      
      public function addedToSpace() : void
      {
         if(ZPP_Component.zpp_pool == null)
         {
            component = new ZPP_Component();
         }
         else
         {
            component = ZPP_Component.zpp_pool;
            ZPP_Component.zpp_pool = component.next;
            component.next = null;
         }
         null;
         component.isBody = true;
         component.body = this;
         __iaddedToSpace();
      }
      
      public function aabb_validate() : void
      {
         var _loc1_:* = null as ZNPNode_ZPP_Shape;
         var _loc2_:* = null as ZPP_Shape;
         var _loc3_:* = null as ZPP_Circle;
         var _loc4_:* = null as ZPP_Polygon;
         var _loc5_:Number = NaN;
         var _loc6_:* = null as ZPP_Vec2;
         var _loc7_:* = null as ZPP_Vec2;
         var _loc8_:* = null as ZPP_Vec2;
         var _loc9_:* = null as ZPP_Vec2;
         var _loc10_:Number = NaN;
         var _loc11_:* = null as ZPP_Vec2;
         var _loc12_:* = null as ZPP_Body;
         var _loc13_:* = null as ZPP_AABB;
         var _loc14_:* = null as ZPP_AABB;
         if(zip_aabb)
         {
            zip_aabb = false;
            aabb.minx = 1.79e308;
            aabb.miny = 1.79e308;
            aabb.maxx = -1.79e308;
            aabb.maxy = -1.79e308;
            _loc1_ = shapes.head;
            while(_loc1_ != null)
            {
               _loc2_ = _loc1_.elt;
               if(_loc2_.zip_aabb)
               {
                  if(_loc2_.body != null)
                  {
                     _loc2_.zip_aabb = false;
                     if(_loc2_.type == ZPP_Flags.id_ShapeType_CIRCLE)
                     {
                        _loc3_ = _loc2_.circle;
                        if(_loc3_.zip_worldCOM)
                        {
                           if(_loc3_.body != null)
                           {
                              _loc3_.zip_worldCOM = false;
                              if(_loc3_.zip_localCOM)
                              {
                                 _loc3_.zip_localCOM = false;
                                 if(_loc3_.type == ZPP_Flags.id_ShapeType_POLYGON)
                                 {
                                    _loc4_ = _loc3_.polygon;
                                    if(_loc4_.lverts.next.next == null)
                                    {
                                       _loc4_.localCOMx = _loc4_.lverts.next.x;
                                       _loc4_.localCOMy = _loc4_.lverts.next.y;
                                       null;
                                    }
                                    else if(_loc4_.lverts.next.next.next == null)
                                    {
                                       _loc4_.localCOMx = _loc4_.lverts.next.x;
                                       _loc4_.localCOMy = _loc4_.lverts.next.y;
                                       _loc5_ = 1;
                                       _loc4_.localCOMx = Number(_loc4_.localCOMx + _loc4_.lverts.next.next.x * _loc5_);
                                       _loc4_.localCOMy = Number(_loc4_.localCOMy + _loc4_.lverts.next.next.y * _loc5_);
                                       _loc5_ = 0.5;
                                       _loc4_.localCOMx = _loc4_.localCOMx * _loc5_;
                                       _loc4_.localCOMy = _loc4_.localCOMy * _loc5_;
                                    }
                                    else
                                    {
                                       _loc4_.localCOMx = 0;
                                       _loc4_.localCOMy = 0;
                                       _loc5_ = 0;
                                       _loc6_ = _loc4_.lverts.next;
                                       _loc7_ = _loc6_;
                                       _loc6_ = _loc6_.next;
                                       _loc8_ = _loc6_;
                                       _loc6_ = _loc6_.next;
                                       while(_loc6_ != null)
                                       {
                                          _loc9_ = _loc6_;
                                          _loc5_ = Number(_loc5_ + _loc8_.x * (_loc9_.y - _loc7_.y));
                                          _loc10_ = _loc9_.y * _loc8_.x - _loc9_.x * _loc8_.y;
                                          _loc4_.localCOMx = Number(_loc4_.localCOMx + (_loc8_.x + _loc9_.x) * _loc10_);
                                          _loc4_.localCOMy = Number(_loc4_.localCOMy + (_loc8_.y + _loc9_.y) * _loc10_);
                                          _loc7_ = _loc8_;
                                          _loc8_ = _loc9_;
                                          _loc6_ = _loc6_.next;
                                       }
                                       _loc6_ = _loc4_.lverts.next;
                                       _loc9_ = _loc6_;
                                       _loc5_ = Number(_loc5_ + _loc8_.x * (_loc9_.y - _loc7_.y));
                                       _loc10_ = _loc9_.y * _loc8_.x - _loc9_.x * _loc8_.y;
                                       _loc4_.localCOMx = Number(_loc4_.localCOMx + (_loc8_.x + _loc9_.x) * _loc10_);
                                       _loc4_.localCOMy = Number(_loc4_.localCOMy + (_loc8_.y + _loc9_.y) * _loc10_);
                                       _loc7_ = _loc8_;
                                       _loc8_ = _loc9_;
                                       _loc6_ = _loc6_.next;
                                       _loc11_ = _loc6_;
                                       _loc5_ = Number(_loc5_ + _loc8_.x * (_loc11_.y - _loc7_.y));
                                       _loc10_ = _loc11_.y * _loc8_.x - _loc11_.x * _loc8_.y;
                                       _loc4_.localCOMx = Number(_loc4_.localCOMx + (_loc8_.x + _loc11_.x) * _loc10_);
                                       _loc4_.localCOMy = Number(_loc4_.localCOMy + (_loc8_.y + _loc11_.y) * _loc10_);
                                       _loc5_ = 1 / (3 * _loc5_);
                                       _loc10_ = _loc5_;
                                       _loc4_.localCOMx = _loc4_.localCOMx * _loc10_;
                                       _loc4_.localCOMy = _loc4_.localCOMy * _loc10_;
                                    }
                                 }
                                 if(_loc3_.wrap_localCOM != null)
                                 {
                                    _loc3_.wrap_localCOM.zpp_inner.x = _loc3_.localCOMx;
                                    _loc3_.wrap_localCOM.zpp_inner.y = _loc3_.localCOMy;
                                 }
                              }
                              _loc12_ = _loc3_.body;
                              if(_loc12_.zip_axis)
                              {
                                 _loc12_.zip_axis = false;
                                 _loc12_.axisx = Number(Math.sin(_loc12_.rot));
                                 _loc12_.axisy = Number(Math.cos(_loc12_.rot));
                                 null;
                              }
                              _loc3_.worldCOMx = Number(_loc3_.body.posx + (_loc3_.body.axisy * _loc3_.localCOMx - _loc3_.body.axisx * _loc3_.localCOMy));
                              _loc3_.worldCOMy = Number(_loc3_.body.posy + (Number(_loc3_.localCOMx * _loc3_.body.axisx + _loc3_.localCOMy * _loc3_.body.axisy)));
                              if(_loc3_.wrap_worldCOM != null)
                              {
                                 _loc3_.wrap_worldCOM.zpp_inner.x = _loc3_.worldCOMx;
                                 _loc3_.wrap_worldCOM.zpp_inner.y = _loc3_.worldCOMy;
                              }
                           }
                        }
                        _loc5_ = _loc3_.radius;
                        _loc10_ = _loc3_.radius;
                        _loc3_.aabb.minx = _loc3_.worldCOMx - _loc5_;
                        _loc3_.aabb.miny = _loc3_.worldCOMy - _loc10_;
                        _loc3_.aabb.maxx = Number(_loc3_.worldCOMx + _loc5_);
                        _loc3_.aabb.maxy = Number(_loc3_.worldCOMy + _loc10_);
                     }
                     else
                     {
                        _loc4_ = _loc2_.polygon;
                        if(_loc4_.zip_gverts)
                        {
                           if(_loc4_.body != null)
                           {
                              _loc4_.zip_gverts = false;
                              _loc4_.validate_lverts();
                              _loc12_ = _loc4_.body;
                              if(_loc12_.zip_axis)
                              {
                                 _loc12_.zip_axis = false;
                                 _loc12_.axisx = Number(Math.sin(_loc12_.rot));
                                 _loc12_.axisy = Number(Math.cos(_loc12_.rot));
                                 null;
                              }
                              _loc6_ = _loc4_.lverts.next;
                              _loc7_ = _loc4_.gverts.next;
                              while(_loc7_ != null)
                              {
                                 _loc8_ = _loc7_;
                                 _loc9_ = _loc6_;
                                 _loc6_ = _loc6_.next;
                                 _loc8_.x = Number(_loc4_.body.posx + (_loc4_.body.axisy * _loc9_.x - _loc4_.body.axisx * _loc9_.y));
                                 _loc8_.y = Number(_loc4_.body.posy + (Number(_loc9_.x * _loc4_.body.axisx + _loc9_.y * _loc4_.body.axisy)));
                                 _loc7_ = _loc7_.next;
                              }
                           }
                        }
                        _loc6_ = _loc4_.gverts.next;
                        _loc4_.aabb.minx = _loc6_.x;
                        _loc4_.aabb.miny = _loc6_.y;
                        _loc4_.aabb.maxx = _loc6_.x;
                        _loc4_.aabb.maxy = _loc6_.y;
                        _loc7_ = _loc4_.gverts.next.next;
                        while(_loc7_ != null)
                        {
                           _loc8_ = _loc7_;
                           if(_loc8_.x < _loc4_.aabb.minx)
                           {
                              _loc4_.aabb.minx = _loc8_.x;
                           }
                           if(_loc8_.x > _loc4_.aabb.maxx)
                           {
                              _loc4_.aabb.maxx = _loc8_.x;
                           }
                           if(_loc8_.y < _loc4_.aabb.miny)
                           {
                              _loc4_.aabb.miny = _loc8_.y;
                           }
                           if(_loc8_.y > _loc4_.aabb.maxy)
                           {
                              _loc4_.aabb.maxy = _loc8_.y;
                           }
                           _loc7_ = _loc7_.next;
                        }
                     }
                  }
               }
               _loc13_ = aabb;
               _loc14_ = _loc2_.aabb;
               if(_loc14_.minx < _loc13_.minx)
               {
                  _loc13_.minx = _loc14_.minx;
               }
               if(_loc14_.maxx > _loc13_.maxx)
               {
                  _loc13_.maxx = _loc14_.maxx;
               }
               if(_loc14_.miny < _loc13_.miny)
               {
                  _loc13_.miny = _loc14_.miny;
               }
               if(_loc14_.maxy > _loc13_.maxy)
               {
                  _loc13_.maxy = _loc14_.maxy;
               }
               _loc1_ = _loc1_.next;
            }
         }
      }
      
      public function __immutable_midstep(param1:String) : void
      {
      }
   }
}
