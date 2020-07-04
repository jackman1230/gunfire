package nape.callbacks
{
   import flash.Boot;
   import zpp_nape.callbacks.ZPP_ConstraintListener;
   import zpp_nape.callbacks.ZPP_OptionType;
   import zpp_nape.util.ZPP_Flags;
   
   public class ConstraintListener extends Listener
   {
       
      
      public var zpp_inner_zn:ZPP_ConstraintListener;
      
      public function ConstraintListener(param1:CbEvent, param2:*, param3:Function, param4:int = 0)
      {
         if(Boot.skip_constructor)
         {
            return;
         }
         super();
         var _loc5_:int = -1;
         §§push(param1);
         if(ZPP_Flags.CbEvent_WAKE == null)
         {
            ZPP_Flags.§internal§ = true;
            ZPP_Flags.CbEvent_WAKE = new CbEvent();
            ZPP_Flags.§internal§ = false;
         }
         if(§§pop() == ZPP_Flags.CbEvent_WAKE)
         {
            _loc5_ = ZPP_Flags.id_CbEvent_WAKE;
         }
         else
         {
            §§push(param1);
            if(ZPP_Flags.CbEvent_SLEEP == null)
            {
               ZPP_Flags.§internal§ = true;
               ZPP_Flags.CbEvent_SLEEP = new CbEvent();
               ZPP_Flags.§internal§ = false;
            }
            if(§§pop() == ZPP_Flags.CbEvent_SLEEP)
            {
               _loc5_ = ZPP_Flags.id_CbEvent_SLEEP;
            }
            else
            {
               §§push(param1);
               if(ZPP_Flags.CbEvent_BREAK == null)
               {
                  ZPP_Flags.§internal§ = true;
                  ZPP_Flags.CbEvent_BREAK = new CbEvent();
                  ZPP_Flags.§internal§ = false;
               }
               if(§§pop() == ZPP_Flags.CbEvent_BREAK)
               {
                  _loc5_ = ZPP_Flags.id_CbEvent_BREAK;
               }
            }
         }
         zpp_inner_zn = new ZPP_ConstraintListener(ZPP_OptionType.argument(param2),_loc5_,param3);
         zpp_inner = zpp_inner_zn;
         zpp_inner.outer = this;
         zpp_inner_zn.outer_zn = this;
         zpp_inner.precedence = param4;
      }
      
      public function set options(param1:OptionType) : OptionType
      {
         zpp_inner_zn.options.set(param1.zpp_inner);
         return zpp_inner_zn.options.outer;
      }
      
      public function set handler(param1:Function) : Function
      {
         zpp_inner_zn.handler = param1;
         return zpp_inner_zn.handler;
      }
      
      public function get options() : OptionType
      {
         return zpp_inner_zn.options.outer;
      }
      
      public function get handler() : Function
      {
         return zpp_inner_zn.handler;
      }
   }
}
