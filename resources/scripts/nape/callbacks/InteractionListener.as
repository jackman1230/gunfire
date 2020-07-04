package nape.callbacks
{
   import flash.Boot;
   import zpp_nape.callbacks.ZPP_InteractionListener;
   import zpp_nape.callbacks.ZPP_OptionType;
   import zpp_nape.util.ZPP_Flags;
   
   public class InteractionListener extends Listener
   {
       
      
      public var zpp_inner_zn:ZPP_InteractionListener;
      
      public function InteractionListener(param1:CbEvent, param2:InteractionType, param3:*, param4:*, param5:Function, param6:int = 0)
      {
         var _loc8_:int = 0;
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         var _loc7_:int = -1;
         §§push(param1);
         if(ZPP_Flags.CbEvent_BEGIN == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.CbEvent_BEGIN = new CbEvent();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.CbEvent_BEGIN)
         {
            _loc7_ = ZPP_Flags.id_CbEvent_BEGIN;
         }
         else
         {
            §§push(param1);
            if(ZPP_Flags.CbEvent_END == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.CbEvent_END = new CbEvent();
               ZPP_Flags.§internal§ = false;
            }
            if(§§pop() == ZPP_Flags.CbEvent_END)
            {
               _loc7_ = ZPP_Flags.id_CbEvent_END;
            }
            else
            {
               §§push(param1);
               if(ZPP_Flags.CbEvent_ONGOING == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.CbEvent_ONGOING = new CbEvent();
                  ZPP_Flags.§internal§ = false;
               }
               if(§§pop() == ZPP_Flags.CbEvent_ONGOING)
               {
                  _loc7_ = ZPP_Flags.id_CbEvent_ONGOING;
               }
            }
         }
         zpp_inner_zn = new ZPP_InteractionListener(ZPP_OptionType.argument(param3),ZPP_OptionType.argument(param4),_loc7_,ZPP_Flags.id_ListenerType_INTERACTION);
         zpp_inner = zpp_inner_zn;
         zpp_inner.outer = this;
         zpp_inner_zn.outer_zni = this;
         zpp_inner.precedence = param6;
         zpp_inner_zn.handleri = param5;
         _loc8_ = zpp_inner_zn.itype;
         if(_loc8_ == ZPP_Flags.id_InteractionType_COLLISION)
         {
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_COLLISION);
         }
         else if(_loc8_ == ZPP_Flags.id_InteractionType_SENSOR)
         {
            if(ZPP_Flags.InteractionType_SENSOR == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_SENSOR = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_SENSOR);
         }
         else if(_loc8_ == ZPP_Flags.id_InteractionType_FLUID)
         {
            if(ZPP_Flags.InteractionType_FLUID == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_FLUID = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_FLUID);
         }
         else if(_loc8_ == ZPP_Flags.id_InteractionType_ANY)
         {
            if(ZPP_Flags.InteractionType_ANY == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_ANY = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_ANY);
         }
         else
         {
            §§push(null);
         }
         if(§§pop() != param2)
         {
            §§push(param2);
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            if(§§pop() == ZPP_Flags.InteractionType_COLLISION)
            {
               §§push(ZPP_Flags.id_InteractionType_COLLISION);
            }
            else
            {
               §§push(param2);
               if(ZPP_Flags.InteractionType_SENSOR == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                  ZPP_Flags.§internal§ = false;
               }
               if(§§pop() == ZPP_Flags.InteractionType_SENSOR)
               {
                  §§push(ZPP_Flags.id_InteractionType_SENSOR);
               }
               else
               {
                  §§push(param2);
                  if(ZPP_Flags.InteractionType_FLUID == null)
                  {
                     ZPP_Flags.§internal§ = true;
                     ZPP_Flags.InteractionType_FLUID = new InteractionType();
                     ZPP_Flags.§internal§ = false;
                  }
                  §§push(§§pop() == ZPP_Flags.InteractionType_FLUID?ZPP_Flags.id_InteractionType_FLUID:ZPP_Flags.id_InteractionType_ANY);
               }
            }
            _loc8_ = §§pop();
            zpp_inner_zn.itype = _loc8_;
         }
         _loc8_ = zpp_inner_zn.itype;
         if(_loc8_ == ZPP_Flags.id_InteractionType_COLLISION)
         {
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            ZPP_Flags.InteractionType_COLLISION;
         }
         else if(_loc8_ == ZPP_Flags.id_InteractionType_SENSOR)
         {
            if(ZPP_Flags.InteractionType_SENSOR == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_SENSOR = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            ZPP_Flags.InteractionType_SENSOR;
         }
         else if(_loc8_ == ZPP_Flags.id_InteractionType_FLUID)
         {
            if(ZPP_Flags.InteractionType_FLUID == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_FLUID = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            ZPP_Flags.InteractionType_FLUID;
         }
         else if(_loc8_ == ZPP_Flags.id_InteractionType_ANY)
         {
            if(ZPP_Flags.InteractionType_ANY == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_ANY = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            ZPP_Flags.InteractionType_ANY;
         }
         else
         {
            null;
         }
      }
      
      public function set options2(param1:OptionType) : OptionType
      {
         zpp_inner_zn.options2.set(param1.zpp_inner);
         return zpp_inner_zn.options2.outer;
      }
      
      public function set options1(param1:OptionType) : OptionType
      {
         zpp_inner_zn.options1.set(param1.zpp_inner);
         return zpp_inner_zn.options1.outer;
      }
      
      public function set interactionType(param1:InteractionType) : InteractionType
      {
         var _loc2_:int = 0;
         _loc2_ = zpp_inner_zn.itype;
         if(_loc2_ == ZPP_Flags.id_InteractionType_COLLISION)
         {
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_COLLISION);
         }
         else if(_loc2_ == ZPP_Flags.id_InteractionType_SENSOR)
         {
            if(ZPP_Flags.InteractionType_SENSOR == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_SENSOR = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_SENSOR);
         }
         else if(_loc2_ == ZPP_Flags.id_InteractionType_FLUID)
         {
            if(ZPP_Flags.InteractionType_FLUID == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_FLUID = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_FLUID);
         }
         else if(_loc2_ == ZPP_Flags.id_InteractionType_ANY)
         {
            if(ZPP_Flags.InteractionType_ANY == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_ANY = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_ANY);
         }
         else
         {
            §§push(null);
         }
         if(§§pop() != param1)
         {
            §§push(param1);
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            if(§§pop() == ZPP_Flags.InteractionType_COLLISION)
            {
               §§push(ZPP_Flags.id_InteractionType_COLLISION);
            }
            else
            {
               §§push(param1);
               if(ZPP_Flags.InteractionType_SENSOR == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.InteractionType_SENSOR = new InteractionType();
                  ZPP_Flags.§internal§ = false;
               }
               if(§§pop() == ZPP_Flags.InteractionType_SENSOR)
               {
                  §§push(ZPP_Flags.id_InteractionType_SENSOR);
               }
               else
               {
                  §§push(param1);
                  if(ZPP_Flags.InteractionType_FLUID == null)
                  {
                     ZPP_Flags.§internal§ = true;
                     ZPP_Flags.InteractionType_FLUID = new InteractionType();
                     ZPP_Flags.§internal§ = false;
                  }
                  §§push(§§pop() == ZPP_Flags.InteractionType_FLUID?ZPP_Flags.id_InteractionType_FLUID:ZPP_Flags.id_InteractionType_ANY);
               }
            }
            _loc2_ = §§pop();
            zpp_inner_zn.itype = _loc2_;
         }
         _loc2_ = zpp_inner_zn.itype;
         if(_loc2_ == ZPP_Flags.id_InteractionType_COLLISION)
         {
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_COLLISION);
         }
         else if(_loc2_ == ZPP_Flags.id_InteractionType_SENSOR)
         {
            if(ZPP_Flags.InteractionType_SENSOR == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_SENSOR = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_SENSOR);
         }
         else if(_loc2_ == ZPP_Flags.id_InteractionType_FLUID)
         {
            if(ZPP_Flags.InteractionType_FLUID == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_FLUID = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_FLUID);
         }
         else if(_loc2_ == ZPP_Flags.id_InteractionType_ANY)
         {
            if(ZPP_Flags.InteractionType_ANY == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_ANY = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_ANY);
         }
         else
         {
            §§push(null);
         }
         return §§pop();
      }
      
      public function set handler(param1:Function) : Function
      {
         zpp_inner_zn.handleri = param1;
         return zpp_inner_zn.handleri;
      }
      
      public function get options2() : OptionType
      {
         return zpp_inner_zn.options2.outer;
      }
      
      public function get options1() : OptionType
      {
         return zpp_inner_zn.options1.outer;
      }
      
      public function get interactionType() : InteractionType
      {
         var _loc1_:int = zpp_inner_zn.itype;
         if(_loc1_ == ZPP_Flags.id_InteractionType_COLLISION)
         {
            if(ZPP_Flags.InteractionType_COLLISION == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_COLLISION = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_COLLISION);
         }
         else if(_loc1_ == ZPP_Flags.id_InteractionType_SENSOR)
         {
            if(ZPP_Flags.InteractionType_SENSOR == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_SENSOR = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_SENSOR);
         }
         else if(_loc1_ == ZPP_Flags.id_InteractionType_FLUID)
         {
            if(ZPP_Flags.InteractionType_FLUID == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_FLUID = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_FLUID);
         }
         else if(_loc1_ == ZPP_Flags.id_InteractionType_ANY)
         {
            if(ZPP_Flags.InteractionType_ANY == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.InteractionType_ANY = new InteractionType();
               ZPP_Flags.§internal§ = false;
            }
            §§push(ZPP_Flags.InteractionType_ANY);
         }
         else
         {
            §§push(null);
         }
         return §§pop();
      }
      
      public function get handler() : Function
      {
         return zpp_inner_zn.handleri;
      }
   }
}
