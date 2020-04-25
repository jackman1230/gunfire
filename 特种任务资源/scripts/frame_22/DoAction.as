function play_soundAction(what)
{
   if(game_sounds)
   {
      this[what].start();
   }
}
function play_music(what)
{
   if(game_sounds)
   {
      this[what].start(0,10000);
   }
}
function set_keyAction(code)
{
   var _loc1_ = 0;
   while(_loc1_ < keycodes.length)
   {
      if(keycodes[_loc1_][1] == code)
      {
         return keycodes[_loc1_][0];
      }
      _loc1_ = _loc1_ + 1;
   }
   return "非法键位";
}
function set_current_key()
{
   start_end.clip.clip.wcode.what = set_keyAction(Wcode);
   start_end.clip.clip.scode.what = set_keyAction(Scode);
   start_end.clip.clip.acode.what = set_keyAction(Acode);
   start_end.clip.clip.dcode.what = set_keyAction(Dcode);
   start_end.clip.clip.jcode.what = set_keyAction(Jcode);
   start_end.clip.clip.kcode.what = set_keyAction(Kcode);
   start_end.clip.clip.lcode.what = set_keyAction(Lcode);
}
function reset_org_key()
{
   Wcode = org_Wcode;
   Scode = org_Scode;
   Acode = org_Acode;
   Dcode = org_Dcode;
   Jcode = org_Jcode;
   Kcode = org_Kcode;
   Lcode = org_Lcode;
   start_end.clip.clip.wcode.what = set_keyAction(org_Wcode);
   start_end.clip.clip.scode.what = set_keyAction(org_Scode);
   start_end.clip.clip.acode.what = set_keyAction(org_Acode);
   start_end.clip.clip.dcode.what = set_keyAction(org_Dcode);
   start_end.clip.clip.jcode.what = set_keyAction(org_Jcode);
   start_end.clip.clip.kcode.what = set_keyAction(org_Kcode);
   start_end.clip.clip.lcode.what = set_keyAction(org_Lcode);
   start_set_key(1,"wcode");
}
function start_set_key(order, which)
{
   end_set_key();
   key_set_order = order;
   key_set_pressed = false;
   keyListener = new Object();
   keyListener.onKeyDown = function()
   {
      set_this_key(Key.getCode());
   };
   keyListener.onKeyUp = function()
   {
      set_next_key(Key.getCode());
   };
   Key.addListener(keyListener);
   start_end.clip.clip.light._visible = 1;
   start_end.clip.clip.light._y = start_end.clip.clip[which]._y;
}
function end_set_key()
{
   start_end.clip.clip.light._visible = 0;
   Key.removeListener(keyListener);
   delete keyListener;
}
function set_this_key(code)
{
   if(!key_set_pressed)
   {
      if(key_set_order == 1)
      {
         Wcode = code;
         start_end.clip.clip.wcode.what = set_keyAction(code);
      }
      else if(key_set_order == 2)
      {
         Scode = code;
         start_end.clip.clip.scode.what = set_keyAction(code);
      }
      else if(key_set_order == 3)
      {
         Acode = code;
         start_end.clip.clip.acode.what = set_keyAction(code);
      }
      else if(key_set_order == 4)
      {
         Dcode = code;
         start_end.clip.clip.dcode.what = set_keyAction(code);
      }
      else if(key_set_order == 5)
      {
         Jcode = code;
         start_end.clip.clip.jcode.what = set_keyAction(code);
      }
      else if(key_set_order == 6)
      {
         Kcode = code;
         start_end.clip.clip.kcode.what = set_keyAction(code);
      }
      else if(key_set_order == 7)
      {
         Lcode = code;
         start_end.clip.clip.lcode.what = set_keyAction(code);
      }
      key_set_pressed = true;
   }
}
function set_next_key(code)
{
   if(set_keyAction(code) != "非法键位")
   {
      if(key_set_order <= 6)
      {
         key_set_order++;
         start_end.clip.clip.light._y = start_end.clip.clip.light._y + 38.5;
      }
      else
      {
         end_set_key();
      }
   }
   key_set_pressed = false;
}
function check_correct()
{
   if(start_end.clip.clip.wcode.what == "非法键位")
   {
      start_set_key(1,"wcode");
      return "wcode";
   }
   if(start_end.clip.clip.scode.what == "非法键位")
   {
      start_set_key(2,"scode");
      return "scode";
   }
   if(start_end.clip.clip.acode.what == "非法键位")
   {
      start_set_key(3,"acode");
      return "acode";
   }
   if(start_end.clip.clip.dcode.what == "非法键位")
   {
      start_set_key(4,"dcode");
      return "dcode";
   }
   if(start_end.clip.clip.jcode.what == "非法键位")
   {
      start_set_key(5,"jcode");
      return "jcode";
   }
   if(start_end.clip.clip.kcode.what == "非法键位")
   {
      start_set_key(6,"kcode");
      return "kcode";
   }
   if(start_end.clip.clip.lcode.what == "非法键位")
   {
      start_set_key(7,"lcode");
      return "lcode";
   }
   var _loc3_ = [Wcode,Scode,Acode,Dcode,Jcode,Kcode,Lcode];
   var _loc4_ = ["wcode","scode","acode","dcode","jcode","kcode","lcode"];
   var _loc1_ = 0;
   while(_loc1_ < _loc3_.length - 1)
   {
      var _loc2_ = _loc1_ + 1;
      while(_loc2_ < _loc3_.length)
      {
         if(_loc3_[_loc1_] == _loc3_[_loc2_])
         {
            start_set_key(_loc1_ + 1,_loc4_[_loc1_]);
            return _loc4_[_loc1_];
         }
         _loc2_ = _loc2_ + 1;
      }
      _loc1_ = _loc1_ + 1;
   }
   return true;
}
function moveAction(who, speed)
{
   var _loc6_ = new Object();
   _loc6_.x = who._x;
   _loc6_.y = who._y;
   main.localToGlobal(_loc6_);
   if(_loc6_.x + speed > 10 && _loc6_.x + speed < 550)
   {
      var _loc3_ = false;
      var _loc4_ = who._x + main._x + speed;
      if(who.states != "jump")
      {
         var _loc2_ = who._y + main._y - who.heights / 3;
      }
      else
      {
         _loc2_ = who._y + main._y;
      }
      §§enumerate(_root.main.bg);
      while(true)
      {
         if((var _loc0_ = §§pop()) != null)
         {
            grounds = _loc0_;
            if(_root.main.bg[grounds].g.hitTest(_loc4_,_loc2_,true))
            {
               _loc3_ = true;
            }
            else if(_root.main.bg[grounds].d.hitTest(_loc4_,_loc2_,true))
            {
               _loc3_ = true;
            }
            else
            {
               continue;
            }
            §§enumerate(_root.main.objects);
            break;
         }
         §§enumerate(_root.main.objects);
         break;
      }
      while(true)
      {
         if((_loc0_ = §§pop()) != null)
         {
            grounds = _loc0_;
            if(_root.main.objects[grounds].can_block)
            {
               if(_root.main.objects[grounds].g.hitTest(_loc4_,_loc2_,true))
               {
                  if(who.No != _root.main.objects[grounds].No)
                  {
                     _loc3_ = true;
                     §§enumerate(_root.main.enemys);
                     break;
                  }
               }
            }
            continue;
         }
         §§enumerate(_root.main.enemys);
         break;
      }
      while(true)
      {
         if((_loc0_ = §§pop()) != null)
         {
            what = _loc0_;
            if(_root.main.enemys[what].can_block)
            {
               if(_root.main.enemys[what].g != undefined)
               {
                  if(_root.main.enemys[what].g.hitTest(_loc4_,_loc2_,true))
                  {
                     _loc3_ = true;
                     if(_loc3_)
                     {
                     }
                     break;
                  }
               }
            }
            continue;
         }
         if(_loc3_)
         {
         }
         break;
         who._x = who._x + speed;
         break;
      }
   }
   else if(Math.abs(_loc6_.x - 275) > 325)
   {
      player_born();
   }
   adjustAction1(who);
}
function adjustAction1(who)
{
   var _loc4_ = false;
   §§enumerate(_root.main.objects);
   loop0:
   while(true)
   {
      if((var _loc0_ = §§pop()) != null)
      {
         grounds = _loc0_;
         if(_root.main.objects[grounds].hitTest(who._x + main._x,who._y + main._y,true))
         {
            if(who.No != _root.main.objects[grounds].No)
            {
               adjustAction2(who,_root.main.objects[grounds].g);
               _loc4_ = true;
               var _loc3_ = false;
               if(_loc4_)
               {
               }
               break;
            }
         }
         continue;
      }
      _loc3_ = false;
      if(_loc4_)
      {
      }
      break;
      §§enumerate(_root.main.bg);
      while(true)
      {
         if((_loc0_ = §§pop()) != null)
         {
            grounds = _loc0_;
            if(_root.main.bg[grounds].d.hitTest(who._x + main._x,who._y + main._y,true))
            {
               player_die(who,_root.main.bg[grounds].d.type);
               _loc3_ = true;
            }
            else
            {
               if(_root.main.bg[grounds].hitTest(who._x + main._x,who._y + main._y,true))
               {
                  if(_root.main.bg[grounds].g != undefined)
                  {
                     adjustAction2(who,_root.main.bg[grounds].g);
                     _loc3_ = true;
                  }
               }
               continue;
            }
            §§push(!_loc4_);
            if(!_loc4_)
            {
               addr203:
               §§pop();
               §§push(!_loc3_);
               break;
            }
            break;
         }
         break loop0;
      }
      if(§§pop())
      {
         if(who.states != "jump")
         {
            forceFrame(who,"down","fall");
         }
      }
   }
   §§push(!_loc4_);
   if(!_loc4_)
   {
      §§goto(addr203);
   }
   §§goto(addr206);
}
function adjustAction2(who, where)
{
   if(where != undefined)
   {
      if(who.states != "jump")
      {
         if(!where.hitTest(who._x + main._x,who._y + main._y + 15,true))
         {
            justFrame(who,"down","fall");
         }
         else
         {
            adjustY(who,where);
         }
      }
   }
}
function adjustY(who, where)
{
   var _loc2_ = 5;
   while(_loc2_ >= 1)
   {
      if(!where.hitTest(who._x + main._x,who._y + main._y + _loc2_ - 1,true))
      {
         who._y = who._y + _loc2_;
      }
      _loc2_ = _loc2_ - 1;
   }
   var _loc3_ = 5;
   while(_loc3_ >= 1)
   {
      if(where.hitTest(who._x + main._x,who._y + main._y - _loc3_,true))
      {
         who._y = who._y - _loc3_;
      }
      _loc3_ = _loc3_ - 1;
   }
}
function moveAction2(who, speedx, speedy)
{
   who.gotoAndStop(who.updown + "_" + who.lright);
   var _loc2_ = new Object();
   _loc2_.x = who._x;
   _loc2_.y = who._y;
   main.localToGlobal(_loc2_);
   if(_loc2_.x >= 50 - speedx && _loc2_.x <= 490 - speedx)
   {
      if(_loc2_.y > 30 - speedy && _loc2_.y < 380 - speedy)
      {
         who._x = who._x + speedx;
         who._y = who._y + speedy;
      }
   }
}
function adjustAction3(who, where)
{
   while(where.hitTest(who._x + main._x,who._y + main._y,true))
   {
      who._x = who._x - 5 * Math.cos(who._rotation * 0.01745);
      who._y = who._y - 5 * Math.sin(who._rotation * 0.01745);
      if(who._x > 560 - main._x || who._x < - main._x || (who._y > 400 - main._y || who._y < - main._y))
      {
         break;
      }
   }
}
function add_object(what, temp_x, temp_y)
{
   for(grounds in _root.main.objects)
   {
      var _loc2_ = new Object();
      _loc2_.x = main.objects[grounds]._x;
      _loc2_.y = main.objects[grounds]._y;
      main.localToGlobal(_loc2_);
      if(_loc2_.x < -280)
      {
         main.objects[grounds].removeMovieClip();
      }
   }
   var _loc3_ = main.objects.getNextHighestDepth();
   main.objects.attachMovie(what,what + "_" + _loc3_,_loc3_);
   main.objects[what + "_" + _loc3_]._x = temp_x;
   main.objects[what + "_" + _loc3_]._y = temp_y;
}
function effect_Action(main_x, main_y)
{
   if(this["effect_array" + stages + "_" + stages_section] != undefined)
   {
      var _loc2_ = 0;
      while(_loc2_ < this["effect_array" + stages + "_" + stages_section].length)
      {
         if(this["effect_array" + stages + "_" + stages_section][_loc2_][2] == false)
         {
            if(main_x < this["effect_array" + stages + "_" + stages_section][_loc2_][0])
            {
               this["effect_array" + stages + "_" + stages_section][_loc2_][2] = true;
               add_effect(this["effect_array" + stages + "_" + stages_section][_loc2_][1]);
               break;
            }
         }
         _loc2_ = _loc2_ + 1;
      }
   }
}
function add_effect(what)
{
   if(what[0] == "add")
   {
      effect_clip.attachMovie(what[1],"effect",effect_clip.getNextHighestDepth());
   }
   else
   {
      for(i in effect_clip)
      {
         effect_clip[i].remove_me();
      }
   }
}
function gameControl(who)
{
   if(control_able && who.dead == false)
   {
      if(who.my_type == "man")
      {
         gameControl01(who);
      }
      else if(who.my_type == "plane")
      {
         gameControl02(who);
      }
      else if(who.my_type == "man_fly")
      {
         gameControl03(who);
      }
      else if(who.my_type == "gun")
      {
         gameControl04(who);
      }
   }
   if(game_testing)
   {
      if(Key.isDown(37))
      {
         _root.main._x = _root.main._x - 5;
         trace(main.player._x + "                          " + main._x + "         " + main._y);
      }
      else if(Key.isDown(39))
      {
         _root.main._x = _root.main._x + 5;
         trace(main.player._x + "                          " + main._x + "         " + main._y);
      }
      else if(Key.isDown(38))
      {
         _root.main._y = _root.main._y - 5;
         trace(main.player._x + "                          " + main._x + "         " + main._y);
      }
      else if(Key.isDown(40))
      {
         _root.main._y = _root.main._y + 5;
         trace(main.player._x + "                          " + main._x + "         " + main._y);
      }
      else if(Key.isDown(32))
      {
         trace(main.objects._xmouse + "      " + main.objects._ymouse);
      }
      else if(Key.isDown(90))
      {
         for(grounds in _root.main.bg)
         {
            _root.main.bg[grounds].g._visible = 1;
         }
      }
      else if(Key.isDown(88))
      {
         for(grounds in _root.main.bg)
         {
            _root.main.bg[grounds].g._visible = 0;
         }
      }
   }
}
function gameControl01(who)
{
   if(Key.isDown(Scode))
   {
      key_S_Action(who);
   }
   else
   {
      normalAction_S(who);
      if(Key.isDown(Wcode))
      {
         key_W_Action(who);
      }
      else
      {
         normalAction_W(who);
      }
   }
   if(Key.isDown(Acode))
   {
      key_AD_Action(who,-100);
   }
   else if(Key.isDown(Dcode))
   {
      key_AD_Action(who,100);
   }
   else
   {
      normalAction_AD(who);
   }
   if(Key.isDown(Jcode))
   {
      if(!Jcode_pressed)
      {
         Jcode_pressed = true;
         key_J_Action(who);
      }
   }
   else
   {
      Jcode_pressed = false;
   }
   if(Key.isDown(Kcode))
   {
      if(!Kcode_pressed)
      {
         Kcode_pressed = true;
         key_K_Action(who);
      }
   }
   else
   {
      Kcode_pressed = false;
   }
   if(Key.isDown(Lcode))
   {
      if(!Lcode_pressed)
      {
         Lcode_pressed = true;
         key_L_Action(who);
      }
   }
   else
   {
      Lcode_pressed = false;
   }
   moveAction(who,who.player_speed * who.speed_rate * Math.abs(who._xscale) / who._xscale);
}
function gameControl02(who)
{
   if(Key.isDown(Scode))
   {
      key_WS_Action2(who,"down");
   }
   else if(Key.isDown(Wcode))
   {
      key_WS_Action2(who,"up");
   }
   else
   {
      normalAction_WS2(who);
   }
   if(Key.isDown(Acode))
   {
      key_AD_Action2(who,"back");
   }
   else if(Key.isDown(Dcode))
   {
      key_AD_Action2(who,"front");
   }
   else
   {
      normalAction_AD2(who);
   }
   if(Key.isDown(Jcode))
   {
      if(!Jcode_pressed)
      {
         Jcode_pressed = true;
         key_J_Action2(who);
      }
   }
   else
   {
      Jcode_pressed = false;
   }
   if(Key.isDown(Kcode))
   {
      if(!Kcode_pressed)
      {
         Kcode_pressed = true;
         key_K_Action2(who);
      }
   }
   else
   {
      Kcode_pressed = false;
   }
   if(Key.isDown(Lcode))
   {
      if(!Lcode_pressed)
      {
         Lcode_pressed = true;
         key_L_Action2(who);
      }
   }
   else
   {
      Lcode_pressed = false;
   }
   moveAction2(who,who.speedx,who.speedy);
}
function gameControl03(who)
{
   if(Key.isDown(Scode))
   {
      key_S_Action3(who);
   }
   else
   {
      normalAction_S3(who);
      if(Key.isDown(Wcode))
      {
         key_W_Action3(who);
      }
      else
      {
         normalAction_W3(who);
      }
   }
   if(Key.isDown(Acode))
   {
      key_AD_Action3(who,-100);
   }
   else if(Key.isDown(Dcode))
   {
      key_AD_Action3(who,100);
   }
   else
   {
      normalAction_AD3(who);
   }
   if(Key.isDown(Jcode))
   {
      if(!Jcode_pressed)
      {
         Jcode_pressed = true;
         key_J_Action3(who);
      }
   }
   else
   {
      Jcode_pressed = false;
   }
   if(Key.isDown(Kcode))
   {
      if(!Kcode_pressed)
      {
         Kcode_pressed = true;
         key_K_Action3(who);
      }
   }
   else
   {
      Kcode_pressed = false;
   }
   if(Key.isDown(Lcode))
   {
      if(!Lcode_pressed)
      {
         Lcode_pressed = true;
         key_L_Action3(who);
      }
   }
   else
   {
      Lcode_pressed = false;
   }
   moveAction2(who,who.speedx,who.speedy);
}
function gameControl04(who)
{
   if(Key.isDown(Acode))
   {
      key_AD_Action4(who,-100);
   }
   else if(Key.isDown(Dcode))
   {
      key_AD_Action4(who,100);
   }
   else
   {
      normalAction_AD4(who);
   }
   if(Key.isDown(Jcode))
   {
      if(!Jcode_pressed)
      {
         Jcode_pressed = true;
         key_J_Action4(who);
      }
   }
   else
   {
      Jcode_pressed = false;
   }
   if(Key.isDown(Kcode))
   {
      if(!Kcode_pressed)
      {
         Kcode_pressed = true;
         key_K_Action4(who);
      }
   }
   else
   {
      Kcode_pressed = false;
   }
}
function gotoFrame(who, part, where)
{
   if(!who.shooting && !who.turning)
   {
      justFrame(who,part,where);
   }
}
function forceFrame(who, part, where)
{
   if(who.ready && !who.turning)
   {
      justFrame(who,part,where);
   }
}
function justFrame(who, part, where)
{
   if(who[part].frame != where)
   {
      who.ready = true;
      who.shooting = false;
      who.turning = false;
      who[part].gotoAndStop(where);
   }
}
function changeFrame(who, part, where)
{
   if(who[part].frame != where)
   {
      who[part].gotoAndStop(where);
   }
}
function shootFrame(who, part, where)
{
   if(slug_left > 0)
   {
      if(who.ready)
      {
         if(who[part].frame != where)
         {
            who[part].gotoAndStop(where);
         }
         else
         {
            who[part].clip.gotoAndPlay(1);
         }
      }
   }
   else
   {
      who.gun_type = "pistol";
      who.gun = 0;
      who.gun_shoot = "single";
      slug_left = 999999;
      adjust_amr(slug_left);
      if(who.states == "stand")
      {
         changeFrame(who,"up","get_pistol");
         changeFrame(who,"down","stand");
         play_soundAction("手枪上子弹");
      }
   }
}
function key_W_Action(who)
{
   if(who.states != "crouch")
   {
      if(who.gun == 1 && who.shooting)
      {
         if(!who.near)
         {
            if(who.up.frame != "machinegun_up_running")
            {
               changeFrame(who,"up","s_to_u");
            }
         }
      }
      else if(who.gun_direction != "up")
      {
         forceFrame(who,"up",who.gun_type + "_lookup");
      }
   }
}
function key_S_Action(who)
{
   if(who.states == "stand")
   {
      who.states = "crouch";
      justFrame(who,"up",who.gun_type + "_crouch");
      justFrame(who,"down","crouch");
   }
   else if(who.states == "jump")
   {
      if(who.gun == 1 && who.shooting)
      {
         if(who.up.frame != "machinegun_down_running")
         {
            changeFrame(who,"up","s_to_d");
         }
      }
      else
      {
         gotoFrame(who,"up",who.gun_type + "_down");
      }
   }
}
function key_AD_Action(who, directions)
{
   if(who.states == "stand")
   {
      if(directions != who._xscale)
      {
         forceFrame(who,"up",who.gun_type + "_" + who.states + "_turn");
      }
      else
      {
         if(!Key.isDown(Wcode))
         {
            gotoFrame(who,"up",who.gun_type + "_" + who.states + "_run");
         }
         forceFrame(who,"down",who.states + "_run");
      }
   }
   else if(who.states == "crouch")
   {
      if(directions != who._xscale)
      {
         forceFrame(who,"up",who.gun_type + "_" + who.states + "_turn");
      }
      else
      {
         gotoFrame(who,"up",who.gun_type + "_" + who.states);
         gotoFrame(who,"down",who.states + "_run");
      }
   }
   else if(who.states == "jump")
   {
      who._xscale = directions;
      if(who.speed_rate == 0)
      {
         who.speed_rate = 1;
      }
   }
}
function normalAction_S(who)
{
   if(who.states == "jump")
   {
      if(who.gun == 1 && who.shooting)
      {
         if(who.gun_direction == "down")
         {
            if(who.up.frame != "machinegun_straight_running")
            {
               changeFrame(who,"up","d_to_s");
            }
         }
      }
      else if(!Key.isDown(Wcode))
      {
         who.gun_direction = "straight";
         gotoFrame(who,"up",who.gun_type + "_jump");
      }
   }
   else if(who.states == "crouch")
   {
      forceFrame(who,"up",who.gun_type + "_stand");
      forceFrame(who,"down","stand");
   }
}
function normalAction_W(who)
{
   if(who.states == "stand")
   {
      if(who.gun == 1 && who.shooting)
      {
         if(who.gun_direction == "up")
         {
            if(who.up.frame != "machinegun_straight_running")
            {
               changeFrame(who,"up","u_to_s");
            }
         }
      }
      else
      {
         who.gun_direction = "straight";
      }
   }
   else if(who.states == "jump")
   {
      if(!Key.isDown(Scode))
      {
         if(who.gun == 1 && who.shooting)
         {
            if(who.gun_direction == "up")
            {
               if(who.up.frame != "machinegun_straight_running")
               {
                  changeFrame(who,"up","u_to_s");
               }
            }
         }
         else
         {
            gotoFrame(who,"up",who.gun_type + "_jump");
         }
      }
   }
}
function normalAction_AD(who)
{
   if(who.states == "stand")
   {
      if(!Key.isDown(Wcode))
      {
         if(!(who.gun == 1 && who.shooting))
         {
            gotoFrame(who,"up",who.gun_type + "_stand");
         }
      }
      forceFrame(who,"down","stand");
   }
   else if(who.states == "crouch")
   {
      gotoFrame(who,"up",who.gun_type + "_crouch");
      gotoFrame(who,"down","crouch");
   }
}
function key_J_Action(who)
{
   who.near = false;
   §§enumerate(main.enemys);
   while(true)
   {
      if((var _loc0_ = §§pop()) != null)
      {
         enemy = _loc0_;
         if(main.enemys[enemy].g.hitTest(who))
         {
            if(main.enemys[enemy].can_kill)
            {
               who.near = true;
               if(!who.near)
               {
                  break;
               }
            }
         }
         continue;
      }
      if(!who.near)
      {
         break;
      }
      if(who.states == "crouch")
      {
         forceFrame(who,"up","attack_crouch1");
      }
      else
      {
         forceFrame(who,"up","attack_stand" + (random(2) + 1));
      }
   }
   var _loc2_ = true;
   if(who.gun == 2)
   {
      if(main["shoot" + (slug_left + 2)] != undefined)
      {
         _loc2_ = false;
      }
   }
   else if(who.gun == 3)
   {
      if(main["shoot" + (slug_left + 1)] != undefined)
      {
         _loc2_ = false;
      }
   }
   if(_loc2_)
   {
      if(who.ready)
      {
         if(who.states == "stand")
         {
            shootFrame(who,"up",who.gun_type + "_" + who.gun_direction + "_" + who.gun_shoot);
         }
         else if(who.states == "crouch")
         {
            shootFrame(who,"up",who.gun_type + "_crouch_" + who.gun_shoot);
            forceFrame(who,"down","crouch_shoot");
         }
         else if(who.states == "jump")
         {
            shootFrame(who,"up",who.gun_type + "_" + who.gun_direction + "_" + who.gun_shoot);
         }
      }
   }
}
function key_K_Action(who)
{
   if(who.states != "jump")
   {
      forceFrame(who,"up",who.gun_type + "_jump");
      justFrame(who,"down","jump");
   }
}
function key_L_Action(who)
{
   if(who.states != "jump")
   {
      forceFrame(who,"up",who.gun_type + "_" + who.states + "_bomb");
      if(who.states == "crouch")
      {
         forceFrame(who,"down","crouch_shoot");
      }
   }
   else
   {
      forceFrame(who,"up",who.gun_type + "_stand_bomb");
   }
}
function key_WS_Action2(who, updown)
{
   who.updown = updown;
}
function key_AD_Action2(who, lright)
{
   who.lright = lright;
}
function normalAction_WS2(who)
{
   who.updown = "NA";
}
function normalAction_AD2(who)
{
   who.lright = "NA";
}
function key_J_Action2(who)
{
}
function key_K_Action2(who)
{
}
function key_L_Action2(who)
{
}
function key_W_Action3(who)
{
}
function key_S_Action3(who)
{
}
function key_AD_Action3(who, directions)
{
}
function normalAction_W3(who)
{
}
function normalAction_S3(who)
{
}
function normalAction_AD3(who)
{
}
function key_J_Action3(who)
{
}
function key_K_Action3(who)
{
}
function key_L_Action3(who)
{
}
function key_S_Action4(who)
{
}
function key_AD_Action4(who, directions)
{
}
function normalAction_S4(who)
{
}
function normalAction_AD4(who)
{
}
function key_J_Action4(who)
{
}
function key_K_Action4(who)
{
}
function player_born()
{
   if(game_life > 1)
   {
      game_life--;
      adjust_life();
      main.player.removeMovieClip();
      if(this["stg_type_" + stages + "_" + stages_section] == "man")
      {
         var _loc4_ = false;
         var _loc3_ = 50;
         while(_loc3_ <= 540)
         {
            var _loc5_ = 100;
            loop1:
            while(_loc5_ <= 380)
            {
               §§enumerate(_root.main.objects);
               while(true)
               {
                  if((var _loc0_ = §§pop()) != null)
                  {
                     grounds = _loc0_;
                     if(_root.main.objects[grounds].g.hitTest(_loc3_,_loc5_,true))
                     {
                        if(_root.main.objects[grounds].g.hitTest(_loc3_ - 25,_loc5_,true))
                        {
                           if(_root.main.objects[grounds].g.hitTest(_loc3_ + 25,_loc5_,true))
                           {
                              _loc4_ = true;
                              §§enumerate(_root.main.bg);
                              break;
                           }
                        }
                     }
                     continue;
                  }
                  §§enumerate(_root.main.bg);
                  break;
               }
               while(true)
               {
                  if((_loc0_ = §§pop()) != null)
                  {
                     grounds = _loc0_;
                     if(_root.main.bg[grounds].g.hitTest(_loc3_,_loc5_,true))
                     {
                        if(_root.main.bg[grounds].g.hitTest(_loc3_ - 25,_loc5_,true))
                        {
                           if(_root.main.bg[grounds].g.hitTest(_loc3_ + 25,_loc5_,true))
                           {
                              _loc4_ = true;
                              if(!_loc4_)
                              {
                                 break;
                              }
                           }
                        }
                     }
                     continue;
                  }
                  if(!_loc4_)
                  {
                     break;
                  }
                  break loop1;
               }
               _loc5_ = _loc5_ + 10;
            }
            if(_loc4_)
            {
               break;
            }
            _loc3_ = _loc3_ + 10;
         }
         main.attachMovie("player_life","player",main.getNextHighestDepth());
         main.player._x = _loc3_ - main._x;
         main.player._y = 50 - main._y;
         main.player.dead = true;
         main.player.speed = 40;
         main.player.onEnterFrame = function()
         {
            this._y = this._y + this.speed;
            var _loc3_ = false;
            for(grounds in _root.main.objects)
            {
               if(_root.main.objects[grounds].g.hitTest(this._x + main._x,this._y + main._y,true))
               {
                  _loc3_ = true;
                  _root.main.objects[grounds].startAction();
                  add_player("man",this._x,this._y);
               }
            }
            if(!_loc3_)
            {
               for(grounds in _root.main.bg)
               {
                  if(_root.main.bg[grounds].g.hitTest(this._x + main._x,this._y + this.speed + main._y,true))
                  {
                     add_player("man",this._x,this._y);
                  }
               }
            }
         };
      }
      else if(this["stg_type_" + stages + "_" + stages_section] == "plane")
      {
      }
   }
   else
   {
      game_over();
   }
}
function add_player(what, temp_x, temp_y)
{
   main.player.removeMovieClip();
   if(what == "man")
   {
      main.attachMovie("player","player",main.getNextHighestDepth());
      main.player.states = "stand";
      main.player.gun_direction = "straight";
      main.player.turning = false;
      main.player.player_speed = 9;
   }
   else if(what == "plane")
   {
      main.attachMovie("player_plane","player",main.getNextHighestDepth());
      main.player.player_speed = 9;
   }
   main.player._x = temp_x;
   main.player._y = temp_y;
   main.player.gun_type = "pistol";
   main.player.gun = 0;
   main.player.gun_shoot = "single";
   slug_left = 999999;
   adjust_amr(slug_left);
   bomb_left = 10;
   adjust_bomb(bomb_left);
   main.player.shooting = false;
   main.player.ready = true;
   main.player.heights = main.player._height;
   main.player.my_type = what;
   main.player.dead = false;
   main.player.unbreak = true;
   main.player.No = 0;
   main.player.near = false;
   control_able = true;
   main.player.unbreak_start = 0;
   main.player.onEnterFrame = function()
   {
      this.unbreak_start = this.unbreak_start + 1;
      if(this.unbreak_start % 18 <= 9)
      {
         this._alpha = 50;
      }
      else
      {
         this._alpha = 100;
      }
      if(this.unbreak_start > 60)
      {
         this._alpha = 100;
         delete this.onEnterFrame;
         delete this.unbreak_start;
         main.player.unbreak = false;
      }
   };
}
function player_die(who, how)
{
   if(!boss_killed)
   {
      if(!who.dead)
      {
         if(how == "water")
         {
            control_able = false;
            who.dead = true;
            who.up.gotoAndStop("die03");
            play_soundAction("落水");
         }
         else if(how == "kill" and !who.unbreak and !game_testing)
         {
            control_able = false;
            who.dead = true;
            who.up.gotoAndStop("die02");
            play_soundAction("主角死亡");
         }
         else if(how == "shoot" and !who.unbreak and !game_testing)
         {
            control_able = false;
            who.dead = true;
            who.up.gotoAndStop("die01");
            play_soundAction("主角死亡");
         }
         else if(how == "h2so4")
         {
            control_able = false;
            who.dead = true;
            who.up.gotoAndStop("die04");
            play_soundAction("落水");
         }
         game_prisoner = 0;
         adjust_prisoner();
      }
   }
}
function jump_Action(where, lives)
{
   where.onEnterFrame = function()
   {
      if(Math.abs(this.y_speed) < 20)
      {
         this.y_speed = this.y_speed - 1.35;
      }
      this._parent._y = this._parent._y - this.y_speed;
      if(this._parent._y + main._y > 500)
      {
         player_born();
         this._parent.removeMovieClip();
         return undefined;
      }
      if(this.y_speed <= 0)
      {
         var _loc3_ = false;
         §§enumerate(_root.main.objects);
         loop0:
         while(true)
         {
            if((var _loc0_ = §§pop()) != null)
            {
               grounds = _loc0_;
               if(_root.main.objects[grounds].g.hitTest(this._parent._x + _root.main._x,this._parent._y + _root.main._y - this.y_speed,true))
               {
                  _loc3_ = true;
                  delete this.onEnterFrame;
                  if(lives)
                  {
                     _root.landAction(this._parent);
                     _root.main.objects[grounds].startAction();
                  }
                  else
                  {
                     this.clip.play();
                     this.clip.can_play = true;
                  }
                  if(_loc3_)
                  {
                  }
                  break;
               }
               continue;
            }
            if(_loc3_)
            {
            }
            break;
            §§enumerate(_root.main.bg);
            while(true)
            {
               if((_loc0_ = §§pop()) != null)
               {
                  grounds = _loc0_;
                  if(_root.main.bg[grounds].g.hitTest(this._parent._x + _root.main._x,this._parent._y + _root.main._y - this.y_speed,true))
                  {
                     delete this.onEnterFrame;
                     if(lives)
                     {
                        _root.landAction(this._parent);
                     }
                     else
                     {
                        this.clip.play();
                        this.clip.can_play = true;
                     }
                     while(true)
                     {
                        if(!§§pop())
                        {
                           break loop0;
                        }
                     }
                  }
                  else
                  {
                     continue;
                  }
               }
               break loop0;
            }
         }
      }
   };
}
function landAction(who)
{
   who.up.gotoAndStop(_parent.gun_type + "_Stand");
   who.down.gotoAndStop("stand");
   who.shooting = false;
   who.ready = true;
}
function kill_player(who)
{
   who.removeMovieClip();
}
function get_shoot_point(which)
{
   var _loc1_ = new Object();
   _loc1_.x = which._x;
   _loc1_.y = which._y;
   which._parent.localToGlobal(_loc1_);
   var _loc2_ = [];
   _loc2_[0] = _loc1_.x - main._x;
   _loc2_[1] = _loc1_.y - main._y;
   return _loc2_;
}
function attackAction(which)
{
   for(enemy in _root.main.enemys)
   {
      if(_root.main.enemys[enemy].g.hitTest(which))
      {
         _root.main.enemys[enemy].to_die("shoot",5);
         play_soundAction("锅打中");
         game_score = game_score + 350;
         adjust_score();
         var _loc2_ = main.getNextHighestDepth();
         main.attachMovie("attack_effect","attack_effect" + _loc2_,_loc2_);
         main["attack_effect" + _loc2_]._x = get_shoot_point(which)[0];
         main["attack_effect" + _loc2_]._y = get_shoot_point(which)[1];
      }
   }
}
function shootAction()
{
   if(slug_left > 0)
   {
      var _loc4_ = main.attachMovie("shoot" + main.player.gun,"shoot" + slug_left,main.getNextHighestDepth());
      _loc4_.type = main.player.gun;
      _loc4_._x = get_shoot_point(main.player.up.clip.point)[0];
      _loc4_._y = get_shoot_point(main.player.up.clip.point)[1];
      var _loc6_ = Math.abs(main.player._xscale) / main.player._xscale;
      var _loc5_ = main.player.gun_direction;
      if(_loc5_ == "straight")
      {
         _loc4_._rotation = Math.abs(_loc6_ - 1) * 90;
      }
      else if(_loc5_ == "up")
      {
         _loc4_._rotation = -90;
      }
      else if(_loc5_ == "down")
      {
         _loc4_._rotation = 90;
      }
      else if(_loc6_ == 1)
      {
         if(_loc5_ > 0)
         {
            _loc4_._rotation = _loc5_;
         }
         else if(_loc5_ < 0)
         {
            _loc4_._rotation = _loc5_;
         }
      }
      else if(_loc6_ == -1)
      {
         if(_loc5_ > 0)
         {
            _loc4_._rotation = 180 - _loc5_;
         }
         else if(_loc5_ < 0)
         {
            _loc4_._rotation = -180 - _loc5_;
         }
      }
      if(main.player.gun == 0)
      {
         _loc4_.kill_num = 1;
         if(game_testing)
         {
            _loc4_.kill_num = _loc4_.kill_num * 500;
         }
      }
      else if(main.player.gun == 1)
      {
         _loc4_.kill_num = 1;
      }
      else if(main.player.gun == 2)
      {
         _loc4_.kill_num = 0;
         _loc4_.exploding = function()
         {
            this.power = 50;
            loop0:
            for(enemy in _root.main.enemys)
            {
               if(_root.main.enemys[enemy].g.hitTest(this))
               {
                  this.power = this.power - 12;
                  _root.main.enemys[enemy].to_die("blow",12);
                  _root.game_score = _root.game_score + 150;
                  _root.adjust_score();
               }
               if(this.power <= 0)
               {
                  while(true)
                  {
                     if(!§§pop())
                     {
                        break loop0;
                     }
                  }
               }
               else
               {
                  continue;
               }
            }
         };
      }
      else if(main.player.gun == 3)
      {
         _loc4_.kill_num = 35;
         main.attachMovie("shine_cover","shine_cover",main.getNextHighestDepth());
         main.shine_cover._x = - main._x;
         main.shine_cover._y = - main._y;
      }
      _loc4_.onEnterFrame = function()
      {
         var _loc5_ = active_object_speed;
         if(this._x > - main._x && this._x < 560 - main._x && (this._y > - main._y && this._y < 400 - main._y))
         {
            if(this.can_go)
            {
               this._x = this._x + (this.speed * Math.cos(this._rotation * 0.01745) + _loc5_);
               this._y = this._y + this.speed * Math.sin(this._rotation * 0.01745);
            }
            else if(main.player.up.clip.point != undefined)
            {
               this._x = get_shoot_point(main.player.up.clip.point)[0] + _loc5_;
               this._y = get_shoot_point(main.player.up.clip.point)[1];
            }
         }
         else
         {
            this.removeMovieClip();
         }
         if(this.can_go)
         {
            if(this.can_go)
            {
               var _loc3_ = false;
               if(this.type <= 2)
               {
                  §§enumerate(_root.main.bg);
                  while(true)
                  {
                     if((var _loc0_ = §§pop()) != null)
                     {
                        grounds = _loc0_;
                        if(_root.main.bg[grounds].d.hitTest(this._x + main._x,this._y + main._y,true))
                        {
                           adjustAction3(this,_root.main.bg[grounds].g);
                           this._rotation = 0;
                           this.gotoAndStop(main.bg[grounds].d.type);
                           _loc3_ = true;
                           delete this.onEnterFrame;
                        }
                        else if(_root.main.bg[grounds].g.hitTest(this._x + main._x,this._y + main._y,true))
                        {
                           adjustAction3(this,_root.main.bg[grounds].g);
                           this.gotoAndPlay("fired");
                           if(this.type == 0)
                           {
                              play_soundAction("手枪击中");
                           }
                           else if(this.type == 1)
                           {
                              play_soundAction("H弹击中");
                           }
                           else if(this.type == 2)
                           {
                              play_soundAction("R弹爆炸");
                           }
                           _loc3_ = true;
                           delete this.onEnterFrame;
                        }
                        else
                        {
                           continue;
                        }
                        if(this.type == 2)
                        {
                        }
                        break;
                     }
                     addr318:
                     this.speed = this.speed + 1;
                     break;
                  }
                  var _loc4_ = false;
                  if(!_loc3_)
                  {
                     for(enemy in _root.main.enemys)
                     {
                        if(this.type <= 2)
                        {
                           if(_root.main.enemys[enemy].g.hitTest(this._x + main._x,this._y + main._y,true))
                           {
                              _root.main.enemys[enemy].to_die("shoot",this.kill_num);
                              _loc4_ = true;
                              game_score = game_score + 100;
                              adjust_score();
                              break;
                           }
                        }
                        else if(this.type == 3)
                        {
                           if(_root.main.enemys[enemy].g.hitTest(this))
                           {
                              _root.main.enemys[enemy].to_die("fly",this.kill_num,this._rotation);
                              _loc4_ = true;
                              game_score = game_score + 200;
                              adjust_score();
                           }
                        }
                     }
                  }
                  else if(this.type == 2)
                  {
                     this._rotation = 0;
                  }
                  if(_loc4_)
                  {
                     this.gotoAndStop("hit");
                     if(this.type == 0)
                     {
                        play_soundAction("手枪击中");
                     }
                     else if(this.type == 1)
                     {
                        play_soundAction("H弹击中");
                     }
                     else if(this.type == 2)
                     {
                        play_soundAction("R弹爆炸");
                     }
                     delete this.onEnterFrame;
                     if(this.type == 2)
                     {
                        this._rotation = 0;
                     }
                  }
               }
               if(this.type == 2)
               {
                  §§goto(addr318);
               }
               §§goto(addr323);
            }
         }
      };
      adjust_amr(--slug_left);
      if(_local3.type == 0)
      {
         play_soundAction("手枪发射");
      }
      else if(_local3.type == 1)
      {
         play_soundAction("H弹发射");
      }
      else if(_local3.type == 2)
      {
         play_soundAction("R弹发射");
      }
      else if(_local3.type == 3)
      {
         play_soundAction("S弹发射");
      }
   }
}
function throwAction()
{
   if(bomb_left > 0)
   {
      var _loc4_ = main.attachMovie("bomb01","bomb01" + bomb_left,main.getNextHighestDepth());
      var _loc5_ = new Object();
      _loc5_.x = main.player.up.clip.point._x;
      _loc5_.y = main.player.up.clip.point._y;
      main.player.up.clip.localToGlobal(_loc5_);
      _loc4_._x = _loc5_.x - main._x;
      _loc4_._y = _loc5_.y - main._y;
      _loc4_.x_direciton = Math.abs(main.player._xscale) / main.player._xscale;
      if(_loc4_.x_direciton * active_object_speed > 0)
      {
         var _loc6_ = active_object_speed;
      }
      else
      {
         _loc6_ = - active_object_speed;
      }
      _loc4_.x_speed = 12 + main.player.player_speed * main.player.speed_rate / 2 + _loc6_;
      _loc4_.y_speed = -20;
      _loc4_.y_add = 4;
      _loc4_.jumped = 0;
      _loc4_.power = 60;
      _loc4_.exploding = function()
      {
         loop0:
         for(enemy in _root.main.enemys)
         {
            if(_root.main.enemys[enemy].g.hitTest(this))
            {
               this.power = this.power - 20;
               _root.main.enemys[enemy].to_die("blow",20);
               _root.game_score = _root.game_score + 200;
               _root.adjust_score();
            }
            if(this.power <= 0)
            {
               while(true)
               {
                  if(!§§pop())
                  {
                     break loop0;
                  }
               }
            }
            else
            {
               continue;
            }
         }
      };
      _loc4_.onEnterFrame = function()
      {
         if(this._x > - main._x && this._x < 560 - main._x)
         {
            this._rotation = this._rotation + 10;
            this._x = this._x + this.x_speed * this.x_direciton;
            this._y = this._y + this.y_speed;
            if(Math.abs(this.y_speed) <= 20)
            {
               this.y_speed = this.y_speed + this.y_add;
            }
         }
         else
         {
            this.removeMovieClip();
         }
         var _loc3_ = false;
         §§enumerate(_root.main.bg);
         loop0:
         while(true)
         {
            if((var _loc0_ = §§pop()) != null)
            {
               grounds = _loc0_;
               if(_root.main.bg[grounds].d.hitTest(this._x + main._x,this._y + main._y,true))
               {
                  adjustAction2(this,main.bg[grounds].d);
                  this._rotation = 0;
                  this.gotoAndStop(main.bg[grounds].d.type);
                  _loc3_ = true;
                  delete this.onEnterFrame;
               }
               else if(_root.main.bg[grounds].g.hitTest(this._x + main._x,this._y + main._y,true))
               {
                  if(!_root.main.bg[grounds].g.hitTest(this._x + main._x,this._y + main._y - this._height,true))
                  {
                     adjustAction2(this,main.bg[grounds].g);
                     if(this.jumped >= 1)
                     {
                        this._rotation = 0;
                        this.gotoAndStop("explode");
                        play_soundAction("手雷爆炸");
                        _loc3_ = true;
                        delete this.onEnterFrame;
                     }
                     else
                     {
                        this.jumped = this.jumped + 1;
                        this.x_speed = 0.6 * this.x_speed;
                        this.y_speed = -0.6 * this.y_speed;
                     }
                  }
                  else
                  {
                     this._rotation = 0;
                     this.gotoAndStop("explode");
                     play_soundAction("手雷爆炸");
                     _loc3_ = true;
                     delete this.onEnterFrame;
                  }
               }
               else
               {
                  continue;
               }
               var _loc4_ = false;
               if(_loc3_)
               {
               }
               break;
            }
            _loc4_ = false;
            if(_loc3_)
            {
            }
            break;
            §§enumerate(_root.main.enemys);
            while(true)
            {
               if((_loc0_ = §§pop()) != null)
               {
                  enemy = _loc0_;
                  if(_root.main.enemys[enemy].g.hitTest(this.g))
                  {
                     this._rotation = 0;
                     this.gotoAndStop("explode");
                     play_soundAction("手雷爆炸");
                     _loc4_ = true;
                     delete this.onEnterFrame;
                     while(true)
                     {
                        if(!§§pop())
                        {
                           break loop0;
                        }
                     }
                  }
                  else
                  {
                     continue;
                  }
               }
               break loop0;
            }
         }
      };
      adjust_bomb(--bomb_left);
   }
}
function get_map_infor(stg, sec, type, direct, array, width, end)
{
   this["stg_type_" + stg + "_" + sec] = type;
   this["stg_direct_" + stg + "_" + sec] = direct;
   this["stg_array_" + stg + "_" + sec] = array;
   this["stg_width_" + stg + "_" + sec] = width;
   this["stg_end_" + stg + "_" + sec] = end;
}
function draw_map_start(stg, sec)
{
   clean_stage();
   main.player._x = 10;
   main.player._y = 300;
   main._x = 0;
   main._y = 0;
   main.bg.attachMovie("bg_stage" + stg + "_" + sec,"bg1",main.bg.getNextHighestDepth());
}
function change_sence()
{
   if(stages_section != this["stg_array_" + stages])
   {
      if(this.pass_cover == undefined)
      {
         this.attachMovie("pass_cover","pass_cover",this.getNextHighestDepth());
      }
   }
}
function draw_map(stg, sec, which)
{
   if(stg == 1)
   {
      draw_map01(which);
   }
   else if(stg == 2)
   {
      if(sec == 1)
      {
         draw_map01(which);
      }
      else if(sec == 2)
      {
         draw_map02(2);
      }
   }
   else if(stg == 3)
   {
      draw_map01(which);
   }
   modify_XY(main._x,main._y);
   effect_Action(main._x,main._y);
}
function draw_map01(which)
{
   if(which != undefined)
   {
      var _loc3_ = new Object();
      _loc3_.x = which._x;
      _loc3_.y = which._y;
      which._parent.localToGlobal(_loc3_);
      if(main._x > - this["stg_width_" + stages + "_" + stages_section])
      {
         if(_loc3_.x >= 200)
         {
            if(main._x > this["allow_area_array" + stages])
            {
               if(active_map_drawer == "main.player")
               {
                  if(main.player.player_speed * main.player.speed_rate != 0)
                  {
                     main._x = main._x - main.player.player_speed * main.player.speed_rate;
                  }
                  else
                  {
                     main._x = main._x - 5;
                  }
               }
               else
               {
                  main._x = main._x - active_object_speed;
               }
            }
         }
      }
      else
      {
         main._x = - this["stg_width_" + stages + "_" + stages_section];
         if(_loc3_.x > this["stg_end_" + stages + "_" + stages_section])
         {
            change_sence();
         }
      }
      loop0:
      for(grounds in _root.main.bg)
      {
         _loc3_ = new Object();
         _loc3_.x = main.bg[grounds]._x;
         _loc3_.y = main.bg[grounds]._y;
         main.bg.localToGlobal(_loc3_);
         if(draw_map_a(_loc3_.x,_loc3_.y,grounds))
         {
            while(true)
            {
               if(!§§pop())
               {
                  break loop0;
               }
            }
         }
         else
         {
            continue;
         }
      }
   }
}
function draw_map02(speed)
{
   main._x = main._x - speed;
   if(main.player != undefined)
   {
      main.player._x = main.player._x + speed;
   }
   loop0:
   for(grounds in _root.main.bg)
   {
      var _loc2_ = new Object();
      _loc2_.x = main.bg[grounds]._x;
      _loc2_.y = main.bg[grounds]._y;
      main.bg.localToGlobal(_loc2_);
      if(draw_map_b(_loc2_.x,grounds))
      {
         while(true)
         {
            if(!§§pop())
            {
               break loop0;
            }
         }
      }
      else
      {
         continue;
      }
   }
}
function adjust_map_a(poz_x, poz_y)
{
   var _loc2_ = this["stg_direct_" + stages + "_" + stages_section];
   if(_loc2_ == 0)
   {
      if(poz_x < -50)
      {
         return "remove";
      }
      if(poz_x <= 50)
      {
         return "add";
      }
   }
   else if(_loc2_ == 1)
   {
      if(poz_y < 350)
      {
         return "remove";
      }
      if(poz_y <= 450)
      {
         return "add";
      }
   }
}
function draw_map_a(poz_x, poz_y, grounds)
{
   if(adjust_map_a(poz_x,poz_y) == "remove")
   {
      var _loc2_ = main.bg["bg" + (Number(grounds.slice(2)) - 1)];
      if(_loc2_ != undefined)
      {
         var _loc3_ = new Object();
         _loc3_.x = _loc2_._x;
         _loc3_.y = _loc2_._y;
         _loc2_._parent.localToGlobal(_loc3_);
         if(Math.abs(_loc3_.x) > _loc2_._width || Math.abs(_loc3_.y) > _loc2_._height)
         {
            _loc2_.removeMovieClip();
            return true;
         }
      }
   }
   else if(adjust_map_a(poz_x,poz_y) == "add")
   {
      if(this["stg_array_" + stages + "_" + stages_section] > stages_part)
      {
         if(main.bg["bg" + (Number(grounds.slice(2)) + 1)] == undefined)
         {
            stages_part++;
            main.bg.attachMovie("bg_stage" + stages + "_" + stages_section,"bg" + stages_part,main.bg.getNextHighestDepth());
            var _loc4_ = this["stg" + stages + "_" + stages_section + "_map_xy"][stages_part - 2];
            main.bg["bg" + stages_part]._x = main.bg["bg" + (stages_part - 1)]._x + _loc4_[0];
            main.bg["bg" + stages_part]._y = main.bg["bg" + (stages_part - 1)]._y + _loc4_[1];
            main.bg["bg" + stages_part].gotoAndStop(stages_part);
            return true;
         }
      }
   }
   return false;
}
function draw_map_b(poz_x, grounds)
{
   if(poz_x < -50)
   {
      if(main.bg["bg" + (Number(grounds.slice(2)) - 1)] != undefined)
      {
         main.bg["bg" + (Number(grounds.slice(2)) - 1)].removeMovieClip();
         return true;
      }
   }
   else if(poz_x <= 50)
   {
      if(main.bg["bg" + (Number(grounds.slice(2)) + 1)] == undefined)
      {
         stages_part++;
         main.bg.attachMovie("bg_stage" + stages + "_" + stages_section,"bg" + stages_part,main.bg.getNextHighestDepth());
         main.bg["bg" + stages_part]._x = 560 * (stages_part - 1);
         main.bg["bg" + stages_part]._y = 0;
         main.bg["bg" + stages_part].gotoAndStop(2 - stages_part % 2);
         return true;
      }
   }
   return false;
}
function modify_XY(main_x, main_y)
{
   if(this["modify_XY_array" + stages + "_" + stages_section] != undefined)
   {
      var _loc2_ = 0;
      while(_loc2_ < this["modify_XY_array" + stages + "_" + stages_section].length)
      {
         if(this["modify_XY_array" + stages + "_" + stages_section][_loc2_][2] == false)
         {
            if(main_x < this["modify_XY_array" + stages + "_" + stages_section][_loc2_][0])
            {
               this["modify_XY_array" + stages + "_" + stages_section][_loc2_][2] = true;
               main_move_Y(0,this["modify_XY_array" + stages + "_" + stages_section][_loc2_][1]);
               break;
            }
         }
         _loc2_ = _loc2_ + 1;
      }
   }
}
function main_move_Y(targetX, targetY)
{
   main.targetX = targetX;
   main.targetY = targetY;
   main.onEnterFrame = function()
   {
      if(Math.abs(this._y - this.targetY) > 5)
      {
         if(this.targetX != 0)
         {
            this._x = this._x + (this.targetX - this._x) / 20;
         }
         this._y = this._y + (this.targetY - this._y) / 20;
         effect_clip._y = effect_clip._y + (this.targetY - this._y) / 20;
      }
      else
      {
         delete this.onEnterFrame;
      }
   };
}
function enemysAction02(who, x, y)
{
   var my_number = main.enemys.getNextHighestDepth();
   var this_mc = main.enemys.attachMovie(who,who + my_number,my_number);
   this_mc.blood = _root.game_level * 80;
   this_mc.type = 7;
   this_mc._x = x;
   this_mc._y = y;
   this_mc.targeter = "_root.main.player";
   this_mc.attacked = 0;
   this_mc.dead = false;
   this_mc.moves = function()
   {
      this.counts = 0;
      this.shooting = false;
      this.gotoAndStop("move");
      this.onEnterFrame = function()
      {
         this.target = eval(this.targeter);
         if(this.target != undefined)
         {
            if(Math.abs(this.target._x - this._x) > 20)
            {
               this._x = this._x + (this.target._x - this._x) / 20;
            }
            this.counts = this.counts + 1;
            if(this.counts == 30)
            {
               this.counts = 0;
               this.shoot();
            }
            var tempy = this.target._y - 200;
            if(Math.abs(tempy - this._y) > 20)
            {
               this._y = this._y + (tempy - this._y) / 20;
            }
         }
      };
   };
   this_mc.shoot = function()
   {
      if(!this.shooting)
      {
         this.shooting = true;
         this.gotoAndPlay("shoot");
      }
   };
   this_mc.shootAction = function()
   {
      play_soundAction("轰炸机落弹");
      var depth = main.getNextHighestDepth();
      main.attachMovie("npc_shoot0" + this.type,"npc_shoot" + depth,depth);
      main["npc_shoot" + depth]._x = get_shoot_point(this.point)[0];
      main["npc_shoot" + depth]._y = get_shoot_point(this.point)[1];
      main["npc_shoot" + depth].targeter = this.targeter;
      main["npc_shoot" + depth].yspeed = 4 + Math.floor(_root.game_level);
      main["npc_shoot" + depth].onEnterFrame = function()
      {
         if(this._x > - main._x && this._x < 560 - main._x && (this._y > - main._y - 200 && this._y < 600 - main._y))
         {
            this.yspeed = this.yspeed + 0.25;
            this._y = this._y + this.yspeed;
         }
         else
         {
            this.removeMovieClip();
         }
         var hit_ground = false;
         §§enumerate(main.bg);
         while(true)
         {
            if((var _loc0_ = §§pop()) != null)
            {
               grounds = _loc0_;
               if(main.bg[grounds].g.hitTest(this._x + main._x,this._y + main._y,true))
               {
                  if(!main.bg[grounds].g.hitTest(this._x + main._x,this._y + main._y - this._height,true))
                  {
                     adjustAction2(this,main.bg[grounds].g);
                     this.gotoAndStop("explode");
                     play_soundAction("手雷爆炸");
                     hit_ground = true;
                     delete this.onEnterFrame;
                     var hit_enemys = false;
                     if(hit_ground)
                     {
                     }
                     break;
                  }
               }
               continue;
            }
            var hit_enemys = false;
            if(hit_ground)
            {
            }
            break;
            this.target = eval(this.targeter);
            if(this.target != undefined)
            {
               if(this.target.g.hitTest(this))
               {
                  this.gotoAndStop("explode");
                  play_soundAction("手雷爆炸");
                  hit_enemys = true;
                  delete this.onEnterFrame;
                  player_die(this.target,"shoot");
                  break;
               }
               break;
            }
            break;
         }
      };
   };
   this_mc.check_point = function()
   {
      this.attacked = this.attacked + 1;
      if(this.attacked - Math.floor(game_level) >= 2)
      {
         this.attacked = 0;
         this.moves();
      }
      else
      {
         this.gotoAndPlay("shoot");
      }
   };
   this_mc.to_die = function(how, much)
   {
      this.blood = this.blood - much;
      if(this.blood <= 0)
      {
         this.fall();
      }
      else
      {
         this.body.gotoAndPlay("hit");
      }
   };
   this_mc.fall = function()
   {
      this.gotoAndPlay("die");
      this.onEnterFrame = function()
      {
         this._y = this._y + 15;
         §§enumerate(_root.main.bg);
         while(true)
         {
            if((var _loc0_ = §§pop()) != null)
            {
               grounds = _loc0_;
               if(_root.main.bg[grounds].g.hitTest(this._x + main._x,this._y + main._y,true))
               {
                  add_present(this);
                  this.deadAction();
                  if(get_shoot_point(this)[1] > 650)
                  {
                  }
                  break;
               }
               continue;
            }
            if(get_shoot_point(this)[1] > 650)
            {
            }
            break;
            this.deadAction();
            break;
         }
      };
   };
   this_mc.deadAction = function()
   {
      this.dead = true;
      delete this.onEnterFrame;
      this.gotoAndPlay("explode");
      play_soundAction("大爆炸");
      if(this.dieEvents != undefined)
      {
         this.dieEvents();
      }
   };
   this_mc.moves();
   return this_mc;
}
function enemysAction03(who, x, y, moves)
{
   var my_number = main.enemys.getNextHighestDepth();
   var this_mc = main.enemys.attachMovie(who,who + my_number,my_number);
   this_mc.blood = _root.game_level * 100;
   this_mc.type = 8;
   this_mc._x = x;
   this_mc._y = y;
   this_mc.moves = moves;
   this_mc.targeter = "_root.main.player";
   this_mc.can_block = true;
   this_mc.attacked = 0;
   this_mc.dead = false;
   this_mc.stand = function()
   {
      if(this.frame != "stand")
      {
         this.body.gotoAndPlay("stand");
      }
      this.shooting = false;
      this.onEnterFrame = function()
      {
         this.target = eval(this.targeter);
         if(this.target != undefined)
         {
            if(Math.abs(this.target._x - this._x) > 350)
            {
               if(this.moves)
               {
                  if(this.frame != "move")
                  {
                     this.body.gotoAndPlay("move");
                     play_soundAction("坦克运行");
                  }
                  enemy_move(this,(this.target._x - this._x) / 350);
               }
            }
            else
            {
               this.shoot();
            }
         }
      };
   };
   this_mc.get_blocked = function()
   {
      this.stand();
   };
   this_mc.shoot = function()
   {
      if(!this.shooting)
      {
         if(!random(35))
         {
            delete this.onEnterFrame;
            this.shooting = true;
            this.body.gotoAndPlay("shoot");
            play_soundAction("坦克射击");
         }
      }
   };
   this_mc.shootAction = function()
   {
      var depth = main.getNextHighestDepth();
      main.attachMovie("npc_shoot0" + this.type,"npc_shoot" + depth,depth);
      main["npc_shoot" + depth]._x = get_shoot_point(this.body.point)[0];
      main["npc_shoot" + depth]._y = get_shoot_point(this.body.point)[1];
      main["npc_shoot" + depth].targeter = this.targeter;
      main["npc_shoot" + depth].onEnterFrame = function()
      {
         if(this._x > - main._x && this._x < 560 - main._x && (this._y > - main._y - 200 && this._y < 600 - main._y))
         {
            this._x = this._x + this.speed;
         }
         else
         {
            this.removeMovieClip();
         }
         §§enumerate(main.bg);
         while(true)
         {
            if((var _loc0_ = §§pop()) != null)
            {
               grounds = _loc0_;
               if(main.bg[grounds].g.hitTest(this._x + main._x,this._y + main._y,true))
               {
                  this.gotoAndStop("hit");
                  play_soundAction("手雷爆炸");
                  delete this.onEnterFrame;
                  this.target = eval(this.targeter);
                  if(this.target != undefined)
                  {
                  }
                  break;
               }
               continue;
            }
            this.target = eval(this.targeter);
            if(this.target != undefined)
            {
            }
            break;
            if(this.target.g.hitTest(this))
            {
               this.gotoAndStop("hit");
               play_soundAction("手雷爆炸");
               delete this.onEnterFrame;
               player_die(this.target,"shoot");
               break;
            }
            break;
         }
      };
   };
   this_mc.check_point = function()
   {
      this.attacked = this.attacked + 1;
      if(this.attacked - Math.floor(game_level) >= 1)
      {
         this.attacked = 0;
      }
      else
      {
         this.shooting = true;
         this.body.gotoAndPlay("shoot");
         play_soundAction("坦克射击");
      }
   };
   this_mc.to_die = function(how, much)
   {
      this.blood = this.blood - much;
      if(this.blood <= 0)
      {
         add_present(this);
         this.dead = true;
         delete this.onEnterFrame;
         this.gotoAndPlay("explode");
         if(this.dieEvents != undefined)
         {
            this.dieEvents();
         }
      }
      else
      {
         this.gotoAndPlay("hit");
      }
   };
   this_mc.stand();
   return this_mc;
}
function enemysAction04(who, x, y)
{
   var my_number = main.enemys.getNextHighestDepth();
   var this_mc = main.enemys.attachMovie(who,who + my_number,my_number);
   this_mc.blood = _root.game_level * 2;
   this_mc._x = x;
   this_mc._y = y;
   this_mc.targeter = "_root.main.player";
   this_mc.can_kill = true;
   this_mc.dead = false;
   this_mc.moves = function()
   {
      this.onEnterFrame = function()
      {
         this.target = eval(this.targeter);
         if(this.target != undefined)
         {
            if(this.target._x - this._x > 0)
            {
               this._xscale = 100;
            }
            else
            {
               this._xscale = -100;
            }
            this.gotoAndPlay("come");
            play_soundAction("出水");
            delete this.onEnterFrame;
         }
      };
   };
   this_mc.comes = function()
   {
      this.onEnterFrame = function()
      {
         if(this._x > - main._x && this._x < 560 - main._x && (this._y > - main._y - 200 && this._y < 600 - main._y))
         {
            this._x = this._x + this._xscale / 20;
            this.target = eval(this.targeter);
            if(this.target != undefined)
            {
               if(this.target.g.hitTest(this.g))
               {
                  player_die(this.target,"kill");
               }
            }
            for(grounds in main.bg)
            {
               if(main.bg[grounds].g.hitTest(this._x + main._x,this._y + main._y,true))
               {
                  this.to_die("shoot",this.blood);
                  if(this.dieEvents != undefined)
                  {
                     this.dieEvents();
                  }
                  delete this.onEnterFrame;
                  break;
               }
            }
         }
         else
         {
            this.removeMovieClip();
         }
      };
   };
   this_mc.to_die = function(how, much)
   {
      this.blood = this.blood - much;
      if(this.blood <= 0)
      {
         this.dead = true;
         delete this.onEnterFrame;
         this.gotoAndPlay("die");
         play_soundAction("落水");
         if(this.dieEvents != undefined)
         {
            this.dieEvents();
         }
      }
      else
      {
         this.gotoAndPlay("hit");
      }
   };
   this_mc.moves();
   return this_mc;
}
function enemysAction05(who, x, y)
{
   var my_number = main.enemys.getNextHighestDepth();
   var this_mc = main.enemys.attachMovie(who,who + my_number,my_number);
   this_mc.blood = _root.game_level * 5;
   this_mc._x = x;
   this_mc._y = y;
   this_mc.targeter = "_root.main.player";
   this_mc.dead = false;
   this_mc.start_shoot = function()
   {
      this.onEnterFrame = function()
      {
         this.target = eval(this.targeter);
         if(this.target != undefined)
         {
            if(this.shooter.hitTest(this.target.g))
            {
               player_die(this.target,"shoot");
            }
         }
         if(!random(50))
         {
            play_soundAction("电网");
         }
      };
   };
   this_mc.to_die = function(how, much)
   {
      this.blood = this.blood - much;
      if(this.blood <= 0)
      {
         this.dead = true;
         this.gotoAndPlay("explode");
      }
      else
      {
         this.gotoAndPlay("hit");
      }
   };
   this_mc.stop_shoot = function()
   {
      delete this.onEnterFrame;
   };
   this_mc.start_shoot();
   return this_mc;
}
function enemysAction06(who, x, y)
{
   var my_number = main.enemys.getNextHighestDepth();
   var this_mc = main.enemys.attachMovie(who,who + my_number,my_number);
   this_mc.blood = 1;
   this_mc._x = x;
   this_mc._y = y;
   this_mc.targeter = "_root.main.player";
   this_mc.dead = false;
   this_mc.start_shoot = function()
   {
      this.onEnterFrame = function()
      {
         this.target = eval(this.targeter);
         if(this.target != undefined)
         {
            if(this.g.hitTest(this.target.g))
            {
               player_die(this.target,"shoot");
               this.to_die("blow",20);
            }
         }
      };
   };
   this_mc.to_die = function(how, much)
   {
      this.dead = true;
      delete this.onEnterFrame;
      this.gotoAndPlay("explode");
      play_soundAction("手雷爆炸");
   };
   this_mc.stop_shoot = function()
   {
      for(enemy in _root.main.enemys)
      {
         if(_root.main.enemys[enemy].g.hitTest(this))
         {
            _root.main.enemys[enemy].to_die("blow",20);
         }
      }
   };
   this_mc.start_shoot();
   return this_mc;
}
function enemysAction07(who, x, y, moves)
{
   var my_number = main.enemys.getNextHighestDepth();
   var this_mc = main.enemys.attachMovie(who,who + my_number,my_number);
   this_mc.blood = _root.game_level * 15;
   this_mc.speed = -6;
   this_mc.type = 9;
   this_mc._x = x;
   this_mc._y = y;
   this_mc.moves = moves;
   this_mc.targeter = "_root.main.player";
   this_mc.can_kill = true;
   this_mc.can_block = true;
   this_mc.dead = false;
   this_mc.eating = false;
   this_mc.stand = function()
   {
      this.eating = false;
      this.gotoAndStop("stand");
      this.onEnterFrame = function()
      {
         this.target = eval(this.targeter);
         if(this.target.dead == false)
         {
            if(this._x < this.target._x - 10)
            {
               if(this._xscale == 100)
               {
                  this._xscale = -100;
               }
            }
            else if(this._x > this.target._x + 10)
            {
               if(this._xscale == -100)
               {
                  this._xscale = 100;
               }
            }
            var temp1 = Math.abs(this._x - this.target._x);
            var temp2 = Math.abs(this._y - this.target._y);
            var distance = Math.sqrt(temp1 * temp1 + temp2 * temp2);
            if(distance > 1200)
            {
               this.removeMovieClip();
            }
            else if(distance > 580 && distance < 660)
            {
               if(!random(50))
               {
                  this.move_me();
               }
            }
            else if(distance < 580 && distance > 200)
            {
               if(!random(70))
               {
                  this.shoot();
               }
               if(!random(50))
               {
                  this.move_me();
               }
            }
            else if(distance < 200 && distance > 60)
            {
               if(!random(50))
               {
                  this.shoot();
               }
               if(!random(50))
               {
                  this.move_me();
               }
            }
            else if(distance < 60)
            {
               this.attack();
            }
         }
      };
   };
   this_mc.move_me = function()
   {
      if(this.moves)
      {
         this.gotoAndStop("move");
         this.onEnterFrame = function()
         {
            var _loc3_ = this.speed * Math.abs(this._xscale) / this._xscale;
            if(enemy_move(this,_loc3_))
            {
               if(!random(40))
               {
                  this.stand();
               }
               var _loc2_ = new Object();
               _loc2_.x = this._x;
               _loc2_.y = this._y;
               this._parent.localToGlobal(_loc2_);
               if(Math.abs(_loc2_.x) > 530 || Math.abs(_loc2_.x) < 30)
               {
                  this.stand();
               }
               if(Math.abs(this._x - this.target._x) < 60)
               {
                  this.stand();
               }
               if(this.target == undefined)
               {
                  this.stand();
               }
            }
         };
      }
   };
   this_mc.get_blocked = function()
   {
      this.stand();
   };
   this_mc.shoot = function()
   {
      var _loc2_ = new Object();
      _loc2_.x = this._x;
      _loc2_.y = this._y;
      this._parent.localToGlobal(_loc2_);
      if(Math.abs(_loc2_.x - 280) < 280 && Math.abs(_loc2_.y - 200) < 200)
      {
         delete this.onEnterFrame;
         this.gotoAndPlay("shoot");
      }
   };
   this_mc.shootAction = function(yspeed)
   {
      var depth = main.enemys.getNextHighestDepth();
      var shoot_mc = main.enemys.attachMovie("npc_shoot0" + this.type,"npc_shoot" + depth,depth);
      shoot_mc._x = get_shoot_point(this.point)[0];
      shoot_mc._y = get_shoot_point(this.point)[1];
      shoot_mc.targeter = this.targeter;
      shoot_mc._xscale = this._xscale;
      shoot_mc.xspeed = (- this._xscale) / 50;
      shoot_mc.yspeed = yspeed;
      shoot_mc.blood = _root.game_level;
      shoot_mc.can_kill = true;
      shoot_mc.onEnterFrame = function()
      {
         if(this._x > - main._x && this._x < 560 - main._x && (this._y > - main._y - 200 && this._y < 600 - main._y))
         {
            this._rotation = this._rotation + 30;
            this._x = this._x + this.xspeed;
            this._y = this._y + this.yspeed;
         }
         else
         {
            this.removeMovieClip();
         }
         §§enumerate(main.bg);
         while(true)
         {
            if((var _loc0_ = §§pop()) != null)
            {
               grounds = _loc0_;
               if(main.bg[grounds].g.hitTest(this._x + main._x,this._y + main._y,true))
               {
                  this.to_die();
                  this.target = eval(this.targeter);
                  if(this.target != undefined)
                  {
                  }
                  break;
               }
               continue;
            }
            this.target = eval(this.targeter);
            if(this.target != undefined)
            {
            }
            break;
            if(this.target.g.hitTest(this._x + main._x,this._y + main._y,true))
            {
               this.to_die();
               player_die(this.target,"shoot");
               break;
            }
            break;
         }
      };
      shoot_mc.to_die = function()
      {
         this._rotation = 0;
         delete this.onEnterFrame;
         this.gotoAndStop("hit");
      };
   };
   this_mc.attack = function()
   {
      delete this.onEnterFrame;
      this.gotoAndPlay("attack");
   };
   this_mc.attackAction = function()
   {
      if(this.target != undefined)
      {
         if(!this.target.unbreak)
         {
            if(this.point.hitTest(this.target.g))
            {
               this.eating = true;
               this.target.removeMovieClip();
               this.gotoAndPlay("get");
            }
         }
      }
   };
   this_mc.to_die = function(how, much)
   {
      if(!this.eating)
      {
         this.blood = this.blood - much;
         if(this.blood <= 0)
         {
            this.dead = true;
            delete this.onEnterFrame;
            this.gotoAndPlay("die");
            play_soundAction("食人花死亡");
            if(this.dieEvents != undefined)
            {
               this.dieEvents();
            }
         }
      }
   };
   this_mc.stand();
   return this_mc;
}
function enemysAction08(who, x, y, min_x, max_x, moves)
{
   var my_number = main.enemys.getNextHighestDepth();
   var this_mc = main.enemys.attachMovie(who,"leader01   ",my_number);
   this_mc.blood = _root.game_level * 25;
   this_mc.speed = -3;
   this_mc.min_x = min_x;
   this_mc.max_x = max_x;
   this_mc.moves = moves;
   this_mc.temp_dir = 1;
   this_mc._x = x;
   this_mc._y = y;
   this_mc.targeter = "_root.main.player";
   this_mc.dead = false;
   this_mc.stand = function()
   {
      this.gotoAndStop("stand");
      this.onEnterFrame = function()
      {
         if(!random(50))
         {
            this.move_me();
         }
      };
   };
   this_mc.move_me = function()
   {
      if(this.moves)
      {
         this.gotoAndStop("move");
         this.onEnterFrame = function()
         {
            this.target = eval(this.targeter);
            if(this.target.dead == false)
            {
               if(this._x < this.target._x - 10)
               {
                  if(this._xscale == 100)
                  {
                     this._xscale = -100;
                  }
               }
               else if(this._x > this.target._x + 10)
               {
                  if(this._xscale == -100)
                  {
                     this._xscale = 100;
                  }
               }
            }
            if(this._x < this.min_x)
            {
               this.temp_dir = -1;
            }
            else if(this._x > this.max_x)
            {
               this.temp_dir = 1;
            }
            var tempspeed = this.speed * this.temp_dir;
            if(enemy_move(this,tempspeed))
            {
               if(!random(40))
               {
                  this.stand();
               }
            }
         };
      }
   };
   this_mc.get_blocked = function()
   {
      this.stand();
   };
   this_mc.to_die = function(how, much)
   {
      this.blood = this.blood - much;
      if(this.blood <= 0)
      {
         this.dead = true;
         delete this.onEnterFrame;
         this.gotoAndStop("break");
      }
   };
   this_mc.run_away = function()
   {
      this._xscale = -100;
      this.gotoAndStop("run");
      this.onEnterFrame = function()
      {
         var _loc3_ = (- this.speed) * 2.5;
         enemy_move(this,_loc3_);
         var _loc2_ = new Object();
         _loc2_.x = this._x;
         _loc2_.y = this._y;
         this._parent.localToGlobal(_loc2_);
         if(_loc2_.x > 600)
         {
            if(this.dieEvents != undefined)
            {
               this.dieEvents();
            }
            this.removeMovieClip();
         }
      };
   };
   this_mc.stand();
   return this_mc;
}
function enemysAction09(who, x, y)
{
   var my_number = main.enemys.getNextHighestDepth();
   var this_mc = main.enemys.attachMovie(who,"boss",my_number);
   this_mc.blood = _root.game_level * 700;
   this_mc._x = x;
   this_mc._y = y;
   this_mc.xspeed = 2;
   this_mc.x_dir = 1;
   this_mc.yspeed = 10;
   this_mc.targeter = "_root.main.player";
   this_mc.count_time = 150;
   this_mc.myTransform1 = {ra:100,rb:0,ga:100,gb:0,ba:100,bb:0,aa:100,ab:0};
   this_mc.myTransform2 = {ra:0,rb:255,ga:0,gb:255,ba:0,bb:255,aa:100,ab:0};
   this_mc.dead = false;
   this_mc.fall = function()
   {
      this.gotoAndPlay("fall");
      this.onEnterFrame = function()
      {
         this._y = this._y + this.yspeed;
         this.yspeed = this.yspeed + 1;
         loop0:
         for(grounds in _root.main.bg)
         {
            if(_root.main.bg[grounds].g.hitTest(this._x + main._x,this._y + main._y,true))
            {
               delete this.onEnterFrame;
               this.stand();
               while(true)
               {
                  if(!§§pop())
                  {
                     break loop0;
                  }
               }
            }
            else
            {
               continue;
            }
         }
      };
   };
   this_mc.stand = function()
   {
      if(this.dead)
      {
         this.gotoAndPlay("explode");
      }
      else
      {
         this.gotoAndPlay("normal");
         this.count_time = 15;
         this.onEnterFrame = function()
         {
            this.count_time = this.count_time - 1;
            if(this.count_time <= 0)
            {
               delete this.onEnterFrame;
               if(!random(3))
               {
                  this.moves();
               }
               else
               {
                  this.shoot();
               }
            }
         };
      }
   };
   this_mc.get_blocked = function()
   {
      this.stand();
   };
   this_mc.moves = function()
   {
      this.x_dir = this.x_dir * -1;
      if(this.x_dir == -1)
      {
         this.gotoAndPlay("walk_f");
      }
      else
      {
         this.gotoAndPlay("walk_b");
      }
      this.onEnterFrame = function()
      {
         var _loc2_ = this.xspeed * this.x_dir;
         enemy_move(this,_loc2_);
      };
   };
   this_mc.shoot = function()
   {
      this.onEnterFrame = function()
      {
         delete this.onEnterFrame;
         this.gotoAndPlay("shoot0" + (random(5) + 1));
      };
   };
   this_mc.shootAction = function(type, nums)
   {
      if(type == 1)
      {
         this.point.onEnterFrame = function()
         {
            this.target = eval(this._parent.targeter);
            if(this.target.dead == false)
            {
               if(this.hitTest(this.target.g))
               {
                  player_die(this.target,"shoot");
               }
            }
         };
      }
      else if(type == 2)
      {
         var depth = main.getNextHighestDepth();
         var shoot_mc = main.attachMovie("boss01_shoot02","npc_shoot" + depth,depth);
         shoot_mc._x = get_shoot_point(this.point)[0];
         shoot_mc._y = get_shoot_point(this.point)[1];
         shoot_mc.targeter = this.targeter;
         shoot_mc.xspeed = nums * 2;
         shoot_mc.get_blocked = function()
         {
            this._rotation = 0;
            this.gotoAndStop("hit");
            play_soundAction("手雷爆炸");
            delete this.onEnterFrame;
         };
         shoot_mc.onEnterFrame = function()
         {
            if(this._x > - main._x && this._x < 560 - main._x && (this._y > - main._y - 200 && this._y < 600 - main._y))
            {
               var temp = Math.abs(this.xspeed) / this.xspeed;
               this._rotation = this._rotation + temp * 10;
               enemy_move(this,this.xspeed);
            }
            else
            {
               this.removeMovieClip();
            }
            this.target = eval(this.targeter);
            if(this.target != undefined)
            {
               if(this.target.g.hitTest(this))
               {
                  player_die(this.target,"shoot");
                  this.get_blocked();
               }
            }
         };
      }
      else if(type == 3)
      {
         var depth = main.getNextHighestDepth();
         var shoot_mc = main.attachMovie("boss01_shoot02","npc_shoot" + depth,depth);
         shoot_mc._x = get_shoot_point(this.point)[0];
         shoot_mc._y = get_shoot_point(this.point)[1];
         shoot_mc.targeter = this.targeter;
         this.target = eval(this.targeter);
         if(this.target != undefined)
         {
            var tempxspeed = (- shoot_mc._x - this.target._x) / 35 + nums;
         }
         else
         {
            var tempxspeed = -1;
         }
         shoot_mc.xspeed = tempxspeed;
         shoot_mc.yspeed = -3;
         shoot_mc.get_blocked = function()
         {
            this._rotation = 0;
            this.gotoAndStop("hit");
            play_soundAction("R弹爆炸");
            delete this.onEnterFrame;
         };
         shoot_mc.onEnterFrame = function()
         {
            if(this._x > - main._x && this._x < 560 - main._x && (this._y > - main._y - 200 && this._y < 600 - main._y))
            {
               this._rotation = this._rotation + 10;
               this._x = this._x + this.xspeed;
               this.yspeed = this.yspeed + 0.5;
               this._y = this._y + this.yspeed;
            }
            else
            {
               this.removeMovieClip();
            }
            §§enumerate(main.bg);
            while(true)
            {
               if((var _loc0_ = §§pop()) != null)
               {
                  grounds = _loc0_;
                  if(main.bg[grounds].g.hitTest(this._x + main._x,this._y + main._y,true))
                  {
                     this.get_blocked();
                     this.target = eval(this.targeter);
                     if(this.target != undefined)
                     {
                     }
                     break;
                  }
                  continue;
               }
               this.target = eval(this.targeter);
               if(this.target != undefined)
               {
               }
               break;
               if(this.target.g.hitTest(this))
               {
                  player_die(this.target,"shoot");
                  this.get_blocked();
                  break;
               }
               break;
            }
         };
      }
      else if(type == 4)
      {
         var depth = main.enemys.getNextHighestDepth();
         var shoot_mc = main.enemys.attachMovie("boss01_shoot03","npc_shoot" + depth,depth);
         shoot_mc._x = get_shoot_point(this.point)[0];
         shoot_mc._y = get_shoot_point(this.point)[1];
         shoot_mc.can_kill = true;
         tracerAction(shoot_mc,"_root.main.player",2,5);
      }
   };
   this_mc.to_die = function(how, much)
   {
      this.blood = this.blood - much;
      if(this.blood <= 0)
      {
         this.dead = true;
         delete this.onEnterFrame;
         this.gotoAndPlay("explode");
         play_soundAction("大爆炸");
         if(this.dieEvents != undefined)
         {
            this.dieEvents();
         }
      }
      else
      {
         this.shine();
      }
   };
   this_mc.shine = function()
   {
      if(this.shine_mc == undefined)
      {
         this.createEmptyMovieClip("shine_mc",1000);
      }
      this.shine_mc.count_time = 2;
      var _loc2_ = new Color(this);
      _loc2_.setTransform(this.myTransform2);
      this.shine_mc.onEnterFrame = function()
      {
         this.count_time = this.count_time - 1;
         if(this.count_time <= 0)
         {
            var _loc2_ = new Color(this._parent);
            _loc2_.setTransform(this._parent.myTransform1);
            this.removeMovieClip();
         }
      };
   };
   this_mc.fall();
   return this_mc;
}
function tracerAction(tracer, targeter, speed, trace_rate)
{
   tracer.targeter = targeter;
   tracer.speed = speed + random(5) / 4;
   tracer.borders = borders;
   tracer.trace_rate = trace_rate;
   tracer.get_blocked = function()
   {
      this._rotation = 0;
      this.gotoAndStop("hit");
      play_soundAction("R弹爆炸");
      delete this.onEnterFrame;
   };
   tracer.to_die = function(how, much)
   {
      this.get_blocked();
   };
   tracer.onEnterFrame = function()
   {
      this.target = eval(this.targeter);
      if(this.target != undefined)
      {
         var target_rotation = Math.atan2(this.target._y - 35 - this._y,this.target._x - this._x) / 0.01745;
         if(Math.abs(target_rotation - this._rotation) > 5)
         {
            if(target_rotation * this._rotation >= 0)
            {
               this._rotation = this._rotation + this.trace_rate * Math.abs(target_rotation - this._rotation) / (target_rotation - this._rotation);
            }
            else
            {
               var t_angle1 = Math.abs(target_rotation);
               var t_angle2 = 180 - Math.abs(target_rotation);
               var m_angle1 = Math.abs(this._rotation);
               var m_angle2 = 180 - Math.abs(this._rotation);
               var direction1 = t_angle1 + m_angle1;
               var direction2 = t_angle2 + m_angle2;
               var temp = Math.abs(target_rotation - this._rotation) / (target_rotation - this._rotation);
               if(direction1 >= direction2)
               {
                  this._rotation = this._rotation - this.trace_rate * temp;
               }
               else
               {
                  this._rotation = this._rotation + this.trace_rate * temp;
               }
            }
         }
      }
      if(this._x > - main._x && this._x < 560 - main._x && (this._y > - main._y - 200 && this._y < 600 - main._y))
      {
         this._y = this._y + this.speed * Math.sin(this._rotation * 0.01745);
         this._x = this._x + this.speed * Math.cos(this._rotation * 0.01745);
      }
      else
      {
         this.removeMovieClip();
      }
      §§enumerate(main.bg);
      while(true)
      {
         if((var _loc0_ = §§pop()) != null)
         {
            grounds = _loc0_;
            if(main.bg[grounds].g.hitTest(this._x + main._x,this._y + main._y,true))
            {
               this.get_blocked();
               this.target = eval(this.targeter);
               if(this.target != undefined)
               {
               }
               break;
            }
            continue;
         }
         this.target = eval(this.targeter);
         if(this.target != undefined)
         {
         }
         break;
         if(this.target.g.hitTest(this))
         {
            player_die(this.target,"shoot");
            this.get_blocked();
            break;
         }
         break;
      }
   };
}
function enemysAction10(who, x, y)
{
   var my_number = main.enemys.getNextHighestDepth();
   var this_mc = main.enemys.attachMovie(who,who + my_number,my_number);
   this_mc.blood = _root.game_level;
   this_mc.type = 10;
   this_mc._x = x;
   this_mc._y = y;
   this_mc.targeter = "_root.main.player";
   this_mc.can_kill = true;
   this_mc.can_block = true;
   this_mc.dead = false;
   this_mc.stand = function()
   {
      this.gotoAndStop("stand");
      this.onEnterFrame = function()
      {
         this.target = eval(this.targeter);
         if(this.target.dead == false)
         {
            var temp1 = Math.abs(this._x - this.target._x);
            var temp2 = Math.abs(this._y - this.target._y);
            var distance = Math.sqrt(temp1 * temp1 + temp2 * temp2);
            if(distance > 1200)
            {
               this.removeMovieClip();
            }
            else if(distance < 560)
            {
               if(!random(50))
               {
                  this.shoot();
               }
            }
         }
      };
   };
   this_mc.shoot = function()
   {
      var _loc2_ = new Object();
      _loc2_.x = this._x;
      _loc2_.y = this._y;
      this._parent.localToGlobal(_loc2_);
      if(Math.abs(_loc2_.x - 280) < 280 && Math.abs(_loc2_.y - 200) < 200)
      {
         delete this.onEnterFrame;
         this.gotoAndPlay("shoot");
      }
   };
   this_mc.shootAction = function(yspeed)
   {
      var _loc3_ = main.enemys.getNextHighestDepth();
      var _loc2_ = main.enemys.attachMovie("npc_shoot" + this.type,"npc_shoot" + _loc3_,_loc3_);
      _loc2_._x = get_shoot_point(this.point)[0];
      _loc2_._y = get_shoot_point(this.point)[1];
      _loc2_._rotation = -120;
      tracerAction(_loc2_,"_root.main.player",2,3);
   };
   this_mc.to_die = function(how, much)
   {
      this.blood = this.blood - much;
      if(this.blood <= 0)
      {
         this.dead = true;
         delete this.onEnterFrame;
         if(how == "blow")
         {
            this.gotoAndStop("die4");
            play_soundAction("敌兵死亡04");
         }
         else
         {
            this.gotoAndStop("die" + (random(3) + 1));
            play_soundAction("敌兵死亡0" + (random(3) + 1));
         }
         if(this.dieEvents != undefined)
         {
            this.dieEvents();
         }
      }
   };
   this_mc.stand();
   return this_mc;
}
function add_enemys01(who, its_x, its_y, attacks, type, moves)
{
   return enemysAction01(who,its_x,its_y,attacks,type,moves);
}
function add_enemys02(who, its_x, its_y)
{
   return enemysAction02(who,its_x,its_y);
}
function add_enemys03(who, its_x, its_y, moves)
{
   return enemysAction03(who,its_x,its_y,moves);
}
function add_enemys04(who, its_x, its_y)
{
   return enemysAction04(who,its_x,its_y);
}
function add_enemys05(who, its_x, its_y)
{
   return enemysAction05(who,its_x,its_y);
}
function add_enemys06(who, its_x, its_y)
{
   return enemysAction06(who,its_x,its_y);
}
function add_enemys07(who, its_x, its_y, moves)
{
   return enemysAction07(who,its_x,its_y,moves);
}
function add_enemys08(who, its_x, its_y, min_x, max_x, moves)
{
   return enemysAction08(who,its_x,its_y,min_x,max_x,moves);
}
function add_enemys09(who, its_x, its_y, min_x, max_x)
{
   return enemysAction09(who,its_x,its_y,min_x,max_x);
}
function add_enemys10(who, its_x, its_y)
{
   return enemysAction10(who,its_x,its_y);
}
function add_blocks(type, its_x, its_y)
{
   if(type == "01")
   {
      blood = 30;
   }
   else if(type == "02")
   {
      blood = 1;
   }
   else if(type == "03")
   {
      blood = 50;
   }
   else if(type == "04")
   {
      blood = 24;
   }
   return blocksAction(type,its_x,its_y,blood);
}
function add_deadAction(what, order)
{
   what.dieEvents = function()
   {
      add_events(order);
   };
}
function enemy_move(who, speed)
{
   var _loc4_ = who._x + main._x;
   var _loc6_ = who._y + main._y + 15;
   var _loc5_ = who._x + main._x + speed;
   var _loc7_ = who._y + main._y - who._height / 3;
   var _loc2_ = false;
   §§enumerate(main.bg);
   while(true)
   {
      if((var _loc0_ = §§pop()) != null)
      {
         grounds = _loc0_;
         if(main.bg[grounds].g.hitTest(_loc4_,_loc6_,true))
         {
            _loc2_ = true;
            adjustY(who,main.bg[grounds].g);
            var _loc3_ = false;
            §§enumerate(main.bg);
            break;
         }
         continue;
      }
      _loc3_ = false;
      §§enumerate(main.bg);
      break;
   }
   while(true)
   {
      if((_loc0_ = §§pop()) != null)
      {
         grounds = _loc0_;
         if(main.bg[grounds].g.hitTest(_loc5_,_loc7_,true))
         {
            _loc3_ = true;
            if(!_loc3_)
            {
               break;
            }
         }
         else
         {
            continue;
         }
      }
      else if(!_loc3_)
      {
         break;
      }
      who.get_blocked();
      addr144:
      if(!_loc2_)
      {
         who._y = who._y + 10;
         if(who._y + main._y > 500)
         {
            if(who.dieEvents != undefined)
            {
               who.dieEvents();
            }
            who.removeMovieClip();
         }
         who.states = "jump";
      }
      else
      {
         who.states = "stand";
      }
      return _loc2_;
   }
   if(_loc2_)
   {
      who._x = who._x + speed;
   }
   §§goto(addr144);
}
function enemy_fly(who, xspeed, yspeed)
{
   var _loc2_ = who._x + main._x;
   var _loc3_ = who._y + main._y - who._height / 2;
   for(grounds in main.bg)
   {
      if(main.bg[grounds].g.hitTest(_loc2_,_loc3_,true))
      {
         return true;
      }
   }
   if(who._x > - main._x && who._x < 560 - main._x && (who._y > - main._y - 200 && who._y < 600 - main._y))
   {
      who._x = who._x + xspeed;
      who._y = who._y + yspeed;
   }
   return false;
}
function add_events(order)
{
   if(order == 1)
   {
      add_deadAction(add_enemys02("enemy03",2200,-280),2);
   }
   else if(order == 2)
   {
      allow_area_array1 = -2251;
   }
   else if(order == 3)
   {
      allow_area_array1 = -4337;
   }
   else if(order == 4)
   {
      allow_area_array1 = -5000;
   }
   else if(order == 5)
   {
      allow_area_array1 = -5040;
   }
   else if(order == 6)
   {
      allow_area_array1 = -5313;
   }
   else if(order == 7)
   {
      add_deadAction(add_enemys02("enemy03",5760,-91),8);
   }
   else if(order == 8)
   {
      allow_area_array1 = -7840;
   }
   else if(order == 9)
   {
      add_deadAction(add_enemys09("boss01",1593,-7),10);
   }
   else if(order == 10)
   {
      kill_boss();
   }
}
function kill_boss()
{
   boss_killed = true;
   justFrame(main.player,"up",main.player.gun_type + "_stand");
   justFrame(main.player,"down","stand");
   var _loc3_ = this.attachMovie("level_pass_count","level_pass_count",this.getNextHighestDepth());
   _loc3_.count_times = 6;
   _loc3_.adjust_score = function()
   {
      var _loc2_ = 100000000 + game_score;
      var _loc3_ = Number(_loc2_.toString().slice(8,9)) + 1;
      var _loc4_ = Number(_loc2_.toString().slice(7,8)) + 1;
      var _loc5_ = Number(_loc2_.toString().slice(6,7)) + 1;
      var _loc6_ = Number(_loc2_.toString().slice(5,6)) + 1;
      var _loc7_ = Number(_loc2_.toString().slice(4,5)) + 1;
      var _loc8_ = Number(_loc2_.toString().slice(3,4)) + 1;
      var _loc9_ = Number(_loc2_.toString().slice(2,3)) + 1;
      var _loc10_ = Number(_loc2_.toString().slice(1,2)) + 1;
      this.showpad.num1.gotoAndStop(_loc3_);
      this.showpad.num10.gotoAndStop(_loc4_);
      this.showpad.num100.gotoAndStop(_loc5_);
      this.showpad.num1000.gotoAndStop(_loc6_);
      this.showpad.num10000.gotoAndStop(_loc7_);
      this.showpad.num100000.gotoAndStop(_loc8_);
      this.showpad.num1000000.gotoAndStop(_loc9_);
      this.showpad.num10000000.gotoAndStop(_loc10_);
   };
   _loc3_.count_prisoner = function()
   {
      this.showpad.btn01._visible = 0;
      this.showpad.btn02._visible = 0;
      this.adjust_score();
      this.onEnterFrame = function()
      {
         this.count_times = this.count_times - 1;
         if(this.count_times == 3)
         {
            var _loc2_ = 100 + game_prisoner;
            this.showpad.number10.gotoAndStop(Number(_loc2_.toString().slice(1,2)) + 1);
            this.showpad.number1.gotoAndStop(Number(_loc2_.toString().slice(2,3)) + 1);
            game_prisoner--;
            game_score = game_score + 3000;
         }
         else if(this.count_times == 0)
         {
            play_soundAction("记分音效");
            this.adjust_score();
            this.count_times = 6;
            if(game_prisoner < 0)
            {
               delete this.onEnterFrame;
               this.showpad.play();
            }
         }
      };
   };
   _loc3_.count_bomb = function()
   {
      this.adjust_score();
      this.onEnterFrame = function()
      {
         this.count_times = this.count_times - 1;
         if(this.count_times == 3)
         {
            var _loc2_ = 100 + bomb_left;
            this.showpad.number10.gotoAndStop(Number(_loc2_.toString().slice(1,2)) + 1);
            this.showpad.number1.gotoAndStop(Number(_loc2_.toString().slice(2,3)) + 1);
            bomb_left--;
            game_score = game_score + 1000;
         }
         else if(this.count_times == 0)
         {
            play_soundAction("记分音效");
            this.adjust_score();
            this.count_times = 6;
            if(bomb_left < 0)
            {
               delete this.onEnterFrame;
               this.showpad.play();
            }
         }
      };
   };
   _loc3_.count_time = function()
   {
      this.adjust_score();
      this.onEnterFrame = function()
      {
         this.count_times = this.count_times - 1;
         if(this.count_times == 3)
         {
            var _loc3_ = 100 + game_time;
            this.showpad.number10.gotoAndStop(Number(_loc3_.toString().slice(1,2)) + 1);
            this.showpad.number1.gotoAndStop(Number(_loc3_.toString().slice(2,3)) + 1);
            game_time--;
            game_score = game_score + 500;
         }
         else if(this.count_times == 0)
         {
            play_soundAction("记分音效");
            this.adjust_score();
            this.count_times = 6;
            if(game_time < 0)
            {
               delete this.onEnterFrame;
               this.showpad.btn01._visible = 1;
               this.showpad.btn02._visible = 1;
               _root.end_game(game_score);
            }
         }
      };
   };
}
function add_prisoner(who, x, y, typ, moves, give_item)
{
   var my_number = main.enemys.getNextHighestDepth();
   var this_mc = main.enemys.attachMovie(who,who + my_number,my_number);
   this_mc.blood = 1;
   this_mc.speed = -9;
   this_mc._x = x;
   this_mc._y = y;
   this_mc.min_x = x - 80;
   this_mc.max_x = x + 80;
   this_mc.type = typ;
   this_mc.moves = moves;
   this_mc.give_item = give_item;
   this_mc.targeter = "_root.main.player";
   this_mc.can_kill = true;
   this_mc.res_ed = false;
   this_mc.given = false;
   this_mc.temp_dir = 1;
   this_mc.my_name = "prisoner";
   this_mc.stand = function()
   {
      this.gotoAndStop("get_" + this.type + "0");
      if(this.type == 1)
      {
         this.onEnterFrame = function()
         {
            if(!random(100))
            {
               delete this.onEnterFrame;
               this.gotoAndStop("get_" + this.type + (random(2) + 1));
            }
            this.target = eval(this.targeter);
            if(this.target != undefined)
            {
               var temp1 = Math.abs(this._x - this.target._x);
               var temp2 = Math.abs(this._y - this.target._y);
               var distance = Math.sqrt(temp1 * temp1 + temp2 * temp2);
               if(distance > 1200)
               {
                  this.removeMovieClip();
               }
            }
         };
      }
   };
   this_mc.to_die = function(how, much)
   {
      this.blood = this.blood - much;
      if(this.blood <= 0)
      {
         delete this.onEnterFrame;
         play_soundAction("解开绳子");
         this.gotoAndStop("res_" + this.type + "0");
         if(this.type == 2)
         {
            this.onEnterFrame = function()
            {
               this._y = this._y + 10;
               loop0:
               for(grounds in main.bg)
               {
                  if(_root.main.bg[grounds].d.hitTest(who._x + main._x,who._y + main._y,true))
                  {
                     delete this.onEnterFrame;
                     gotoAndStop("die_" + _root.main.bg[grounds].d.type);
                  }
                  else if(main.bg[grounds].g.hitTest(this._x + main._x,this._y + main._y,true))
                  {
                     delete this.onEnterFrame;
                     this.moves();
                  }
                  else
                  {
                     continue;
                  }
                  while(true)
                  {
                     if(!§§pop())
                     {
                        break loop0;
                     }
                  }
               }
            };
         }
      }
   };
   this_mc.moves = function()
   {
      this.res_ed = true;
      this.gotoAndStop("walk");
      this.onEnterFrame = function()
      {
         if(this._x < this.min_x)
         {
            this.temp_dir = -1;
            this._xscale = -100;
         }
         else if(this._x > this.max_x)
         {
            this.temp_dir = 1;
            this._xscale = 100;
         }
         var tempspeed = this.speed * this.temp_dir / 3;
         enemy_move(this,tempspeed);
         if(this.states == "stand")
         {
            if(this.hitTest(eval(this.targeter)))
            {
               this.gives();
            }
         }
      };
   };
   this_mc.gives = function()
   {
      game_prisoner++;
      adjust_prisoner();
      this.given = true;
      delete this.onEnterFrame;
      this.gotoAndStop("give");
   };
   this_mc.giveAction = function()
   {
      if(this.give_item != "p")
      {
         add_weapon(this,this.give_item);
      }
      else
      {
         add_present(this);
      }
   };
   this_mc.show_me = function()
   {
      this.gotoAndStop("show");
   };
   this_mc.run_away = function()
   {
      this.gotoAndStop("run");
      this.onEnterFrame = function()
      {
         enemy_move(this,this.speed * Math.abs(this._xscale) / this._xscale);
         var _loc2_ = new Object();
         _loc2_.x = this._x;
         _loc2_.y = this._y;
         this._parent.localToGlobal(_loc2_);
         if(Math.abs(_loc2_.x - 290) > 290 || Math.abs(_loc2_.y - 210) > 210)
         {
            this.removeMovieClip();
         }
      };
   };
   this_mc.get_blocked = function()
   {
      if(this.given)
      {
         this.onEnterFrame = function()
         {
            this._alpha = this._alpha - 5;
            if(this._alpha <= 5)
            {
               this.removeMovieClip();
            }
         };
      }
      else
      {
         this.temp_dir = this.temp_dir * -1;
         this._xscale = this._xscale * -1;
      }
   };
   this_mc.stand();
   return this_mc;
}
function add_weapon(where, what)
{
   var my_number = main.tools.getNextHighestDepth();
   var this_mc = main.tools.attachMovie("weapons","weapons" + my_number,my_number);
   this_mc._x = Math.round(where._x);
   this_mc._y = Math.round(where._y);
   this_mc.type = what;
   this_mc.targeter = "_root.main.player";
   this_mc.find_player = function()
   {
      this.onEnterFrame = function()
      {
         var player = eval(this.targeter);
         if(player.dead == false)
         {
            if(this.hitTest(player))
            {
               if(this.type == "h")
               {
                  if(player.gun != 1)
                  {
                     slug_left = 200;
                  }
                  else if(slug_left <= 799)
                  {
                     slug_left = slug_left + 200;
                  }
                  else
                  {
                     slug_left = 999;
                  }
                  player.gun_type = "machinegun";
                  player.gun = 1;
                  player.gun_shoot = "running";
                  adjust_amr(slug_left);
               }
               else if(this.type == "r")
               {
                  if(player.gun != 2)
                  {
                     slug_left = 30;
                  }
                  else if(slug_left <= 969)
                  {
                     slug_left = slug_left + 30;
                  }
                  else
                  {
                     slug_left = 999;
                  }
                  player.gun_type = "machinegun";
                  player.gun = 2;
                  player.gun_shoot = "single";
                  adjust_amr(slug_left);
               }
               else if(this.type == "s")
               {
                  if(player.gun != 3)
                  {
                     slug_left = 15;
                  }
                  else if(slug_left <= 984)
                  {
                     slug_left = slug_left + 15;
                  }
                  else
                  {
                     slug_left = 984;
                  }
                  player.gun_type = "machinegun";
                  player.gun = 3;
                  player.gun_shoot = "single";
                  adjust_amr(slug_left);
               }
               else if(this.type == "b")
               {
                  if(bomb_left <= 89)
                  {
                     bomb_left = bomb_left + 10;
                  }
                  else
                  {
                     bomb_left = 99;
                  }
                  adjust_bomb(bomb_left);
               }
               player.shooting = false;
               player.ready = true;
               delete this.onEnterFrame;
               this.gotoAndPlay("get");
               play_soundAction("补充弹药");
            }
         }
      };
   };
}
function add_present(where)
{
   if(!where.dead)
   {
      var my_number = main.tools.getNextHighestDepth();
      var this_mc = main.tools.attachMovie("present","present" + my_number,my_number);
      this_mc._x = where._x;
      this_mc._y = where._y;
      this_mc.targeter = "_root.main.player";
      this_mc.find_player = function()
      {
         this.onEnterFrame = function()
         {
            var player = eval(this.targeter);
            if(player != undefined)
            {
               if(this.hitTest(player.g))
               {
                  game_score = game_score + Number(this.numbers);
                  adjust_score();
                  play_soundAction("捡到分数");
                  delete this.onEnterFrame;
                  this.gotoAndPlay("get");
               }
            }
         };
      };
      this_mc.show_score = function(which)
      {
         var _loc3_ = 100000 + this.numbers;
         var _loc4_ = this.numbers.toString().length;
         if(which > _loc4_)
         {
            this.b["num" + which]._visible = 0;
         }
         else
         {
            var _loc5_ = Number(_loc3_.toString().slice(6 - which,7 - which));
            this.b["num" + which].gotoAndStop(_loc5_ + 1);
         }
      };
   }
}
function adjust_score()
{
   var _loc2_ = 100000000 + game_score;
   var _loc3_ = Number(_loc2_.toString().slice(8,9)) + 1;
   var _loc4_ = Number(_loc2_.toString().slice(7,8)) + 1;
   var _loc5_ = Number(_loc2_.toString().slice(6,7)) + 1;
   var _loc6_ = Number(_loc2_.toString().slice(5,6)) + 1;
   var _loc7_ = Number(_loc2_.toString().slice(4,5)) + 1;
   var _loc8_ = Number(_loc2_.toString().slice(3,4)) + 1;
   var _loc9_ = Number(_loc2_.toString().slice(2,3)) + 1;
   var _loc10_ = Number(_loc2_.toString().slice(1,2)) + 1;
   this.game_UI.scorepad.num1.gotoAndStop(_loc3_);
   this.game_UI.scorepad.num10.gotoAndStop(_loc4_);
   this.game_UI.scorepad.num100.gotoAndStop(_loc5_);
   this.game_UI.scorepad.num1000.gotoAndStop(_loc6_);
   this.game_UI.scorepad.num10000.gotoAndStop(_loc7_);
   this.game_UI.scorepad.num100000.gotoAndStop(_loc8_);
   this.game_UI.scorepad.num1000000.gotoAndStop(_loc9_);
   this.game_UI.scorepad.num10000000.gotoAndStop(_loc10_);
}
function adjust_prisoner()
{
   this.game_UI.prisoner_pad.gotoAndStop(game_prisoner + 1);
}
function adjust_time()
{
   this.game_UI.time_pad.onEnterFrame = function()
   {
      if(game_time >= 0.005)
      {
         game_time = game_time - 0.005;
      }
      else
      {
         game_time = 0;
         delete this.onEnterFrame;
      }
      var _loc2_ = 100 + Math.floor(game_time);
      var _loc3_ = Number(_loc2_.toString().slice(2,3)) + 1;
      var _loc4_ = Number(_loc2_.toString().slice(1,2)) + 1;
      this.num1.gotoAndStop(_loc3_);
      this.num10.gotoAndStop(_loc4_);
   };
}
function adjust_life()
{
   this.game_UI.life.gotoAndStop(game_life);
}
function adjust_amr(my_slug_left)
{
   if(my_slug_left > 999)
   {
      this.game_UI.amr.gotoAndStop("very");
   }
   else
   {
      this.game_UI.amr.gotoAndStop("some");
      var _loc2_ = 1000 + my_slug_left;
      var _loc3_ = Number(_loc2_.toString().slice(3,4)) + 1;
      var _loc4_ = Number(_loc2_.toString().slice(2,3)) + 1;
      var _loc5_ = Number(_loc2_.toString().slice(1,2)) + 1;
      this.game_UI.amr.amr1.gotoAndStop(_loc3_);
      this.game_UI.amr.amr10.gotoAndStop(_loc4_);
      this.game_UI.amr.amr100.gotoAndStop(_loc5_);
   }
}
function adjust_bomb(my_bomb_left)
{
   var _loc2_ = 100 + my_bomb_left;
   var _loc3_ = Number(_loc2_.toString().slice(2,3)) + 1;
   var _loc4_ = Number(_loc2_.toString().slice(1,2)) + 1;
   this.game_UI.bomb.bomb1.gotoAndStop(_loc3_);
   this.game_UI.bomb.bomb10.gotoAndStop(_loc4_);
}
function adjust_item()
{
}
function clean_stage()
{
   for(i in game_effect)
   {
      game_effect[i].removeMovieClip();
   }
   for(i in main.bg)
   {
      main.bg[i].removeMovieClip();
   }
   for(i in main.enemys)
   {
      main.enemys[i].removeMovieClip();
   }
   for(i in main.objects)
   {
      main.objects[i].removeMovieClip();
   }
   for(i in main.tools)
   {
      main.tools[i].removeMovieClip();
   }
   boss_killed = false;
   delete i;
}
function game_start()
{
   recover_all();
   this.createEmptyMovieClip("main",this.getNextHighestDepth());
   this.createEmptyMovieClip("effect_clip",this.getNextHighestDepth());
   this.attachMovie("game_UI","game_UI",this.getNextHighestDepth());
   this.attachMovie("gameMask","gameMask",this.getNextHighestDepth());
   this.main.setMask(this.gameMask);
   main.createEmptyMovieClip("bg",main.getNextHighestDepth());
   main.bg._y = 400;
   main.createEmptyMovieClip("objects",main.getNextHighestDepth());
   main.createEmptyMovieClip("enemys",main.getNextHighestDepth());
   main.createEmptyMovieClip("tools",main.getNextHighestDepth());
   next_sence();
   if(stages_section == 1)
   {
      main.attachMovie("start_ani" + stages,"start_ani",main.getNextHighestDepth());
   }
   this.onEnterFrame = function()
   {
      gameControl(main.player);
      draw_map(stages,stages_section,eval(active_map_drawer));
      updateAfterEvent();
   };
   _root.start_game();
}
function next_sence()
{
   clean_stage();
   stages_part = 1;
   stages_section++;
   draw_map_start(stages,stages_section);
   if(stages_section > 1)
   {
      if(main.player.my_type == this["stg_type_" + stages + "_" + stages_section])
      {
         main.player._x = 10;
         main.player._y = 300;
         if(main.player.my_type == "man")
         {
            justFrame(main.player,"up",main.player.gun_type + "_" + main.player.states + "_run");
            justFrame(main.player,"down","stand_run");
         }
      }
      else
      {
         active_object_speed = 0;
         active_map_drawer = "main.player";
         add_player(this["stg_type_" + stages + "_" + stages_section],50,200);
      }
   }
}
function level_start()
{
   if(stages == 1)
   {
      add_player("man",50,295);
      play_music("第一关音乐");
   }
   else if(stages == 2)
   {
      add_player("man",190,170);
      add_object("player_car01",292,338);
   }
   else if(stages == 3)
   {
      add_player("man",120,283);
   }
   active_object_speed = 0;
   active_map_drawer = "main.player";
   adjust_score();
   adjust_prisoner();
   adjust_time();
   adjust_life();
   adjust_item();
}
function level_pass()
{
   recover_all();
   stages++;
   stages_section = 0;
   stage_clear = true;
   game_start();
}
function play_game()
{
   stopAllSounds();
   this.attachMovie("start_end","start_end",this.getNextHighestDepth());
   start_end.gotoAndStop("start");
   stages = 1;
   stages_section = 0;
   modify_XY_array1_1 = [[-1315,60,false],[-1710,220,false],[-1880,285,false],[-2380,470,false],[-3000,235,false],[-3480,90,false],[-3760,0,false]];
   modify_XY_array2_1 = [[-850,150,false],[-53000,0,false]];
   modify_XY_array3_1 = [[-1080,120,false],[-1640,250,false],[-2200,330,false],[-3880,420,false]];
   modify_XY_array3_3 = [[-400,-230,false],[-605,-300,false],[-740,-440,false],[-870,-595,false],[-1015,-730,false],[-1200,-905,false],[-1380,-1085,false],[-1500,-1220,false],[-1650,-1420,false],[-1858,-1545,false],[-1970,-1695,false],[-2150,-1865,false],[-2285,-2005,false],[-2457,-2175,false],[-2628,-2345,false],[-2772,-2495,false],[-2925,-2630,false],[-3090,-2730,false],[-3750,-2960,false]];
   effect_array2_1 = [[-15000,["add","effect_rain"],false],[-53000,["remove"],false]];
   allow_area_array1 = -1836;
   allow_area_array2 = -55960;
   allow_area_array3 = -6907;
   game_score = 0;
   game_life = 3;
}
function restart_game()
{
   recover_all();
   play_game();
}
function show_credits()
{
   recover_all();
   this.attachMovie("start_end","start_end",this.getNextHighestDepth());
   this.start_end.gotoAndStop("win");
}
function recover_all()
{
   this.start_end.removeMovieClip();
   this.main.removeMovieClip();
   this.effect_clip.removeMovieClip();
   this.game_UI.removeMovieClip();
   this.gameMask.removeMovieClip();
   this.level_pass_count.removeMovieClip();
   delete this.onEnterFrame;
   game_time = 80;
   game_prisoner = 0;
   slug_left = 999999;
   bomb_left = 10;
}
function clean_fire()
{
   this.main.removeMovieClip();
   this.effect_clip.removeMovieClip();
   this.game_UI.removeMovieClip();
   this.gameMask.removeMovieClip();
   this.level_pass_count.removeMovieClip();
   delete this.onEnterFrame;
}
function game_over()
{
   delete this.onEnterFrame;
   this.attachMovie("start_end","start_end",this.getNextHighestDepth());
   this.start_end.gotoAndStop("lose");
   this.start_end.count_score = function()
   {
      var _loc2_ = 100000000 + game_score;
      var _loc10_ = Number(_loc2_.toString().slice(8,9)) + 1;
      var _loc3_ = Number(_loc2_.toString().slice(7,8)) + 1;
      var _loc4_ = Number(_loc2_.toString().slice(6,7)) + 1;
      var _loc5_ = Number(_loc2_.toString().slice(5,6)) + 1;
      var _loc6_ = Number(_loc2_.toString().slice(4,5)) + 1;
      var _loc7_ = Number(_loc2_.toString().slice(3,4)) + 1;
      var _loc8_ = Number(_loc2_.toString().slice(2,3)) + 1;
      var _loc9_ = Number(_loc2_.toString().slice(1,2)) + 1;
      this.clip.scorepad.num1.gotoAndStop(_loc10_);
      this.clip.scorepad.num10.gotoAndStop(_loc3_);
      this.clip.scorepad.num100.gotoAndStop(_loc4_);
      this.clip.scorepad.num1000.gotoAndStop(_loc5_);
      this.clip.scorepad.num10000.gotoAndStop(_loc6_);
      this.clip.scorepad.num100000.gotoAndStop(_loc7_);
      this.clip.scorepad.num1000000.gotoAndStop(_loc8_);
      this.clip.scorepad.num10000000.gotoAndStop(_loc9_);
   };
   _root.end_game(game_score);
}
第一关音乐 = new Sound(_root);
第一关音乐.attachSound("第一关音乐");
H弹发射 = new Sound(_root);
H弹发射.attachSound("H弹发射");
H弹击中 = new Sound(_root);
H弹击中.attachSound("H弹击中");
R弹爆炸 = new Sound(_root);
R弹爆炸.attachSound("R弹爆炸");
R弹发射 = new Sound(_root);
R弹发射.attachSound("R弹发射");
S弹发射 = new Sound(_root);
S弹发射.attachSound("S弹发射");
补充弹药 = new Sound();
补充弹药.attachSound("补充弹药");
大爆炸 = new Sound(_root);
大爆炸.attachSound("大爆炸");
手雷爆炸 = new Sound(_root);
手雷爆炸.attachSound("手雷爆炸");
手枪发射 = new Sound(_root);
手枪发射.attachSound("手枪发射");
手枪击中 = new Sound(_root);
手枪击中.attachSound("手枪击中");
手枪上子弹 = new Sound(_root);
手枪上子弹.attachSound("手枪上子弹");
子弹打中油桶 = new Sound(_root);
子弹打中油桶.attachSound("子弹打中油桶");
锅打中 = new Sound(_root);
锅打中.attachSound("锅打中");
食人花死亡 = new Sound(_root);
食人花死亡.attachSound("食人花死亡");
坦克运行 = new Sound(_root);
坦克运行.attachSound("坦克运行");
主角死亡 = new Sound(_root);
主角死亡.attachSound("主角死亡");
出水 = new Sound(_root);
出水.attachSound("出水");
敌兵死亡01 = new Sound(_root);
敌兵死亡01.attachSound("敌兵死亡01");
敌兵死亡02 = new Sound(_root);
敌兵死亡02.attachSound("敌兵死亡02");
敌兵死亡03 = new Sound(_root);
敌兵死亡03.attachSound("敌兵死亡03");
敌兵死亡04 = new Sound(_root);
敌兵死亡04.attachSound("敌兵死亡04");
电网 = new Sound(_root);
电网.attachSound("电网");
轰炸机落弹 = new Sound(_root);
轰炸机落弹.attachSound("轰炸机落弹");
记分音效 = new Sound(_root);
记分音效.attachSound("记分音效");
捡到分数 = new Sound(_root);
捡到分数.attachSound("捡到分数");
解开绳子 = new Sound(_root);
解开绳子.attachSound("解开绳子");
开始打字音效 = new Sound(_root);
开始打字音效.attachSound("开始打字音效");
落水 = new Sound(_root);
落水.attachSound("落水");
士兵受惊 = new Sound(_root);
士兵受惊.attachSound("士兵受惊");
坦克射击 = new Sound(_root);
坦克射击.attachSound("坦克射击");
卡车开动 = new Sound(_root);
卡车开动.attachSound("卡车开动");
卡车刹车 = new Sound(_root);
卡车刹车.attachSound("卡车刹车");
人质敬礼 = new Sound(_root);
人质敬礼.attachSound("人质敬礼");
游戏结束 = new Sound(_root);
游戏结束.attachSound("游戏结束");
keycodes = [["A",65],["B",66],["C",67],["D",68],["E",69],["F",70],["G",71],["H",72],["I",73],["J",74],["K",75],["L",76],["M",77],["N",78],["O",79],["P",80],["Q",81],["R",82],["S",83],["T",84],["U",85],["V",86],["W",87],["X",88],["Y",89],["Z",90],["0",48],["1",49],["2",50],["3",51],["4",52],["5",53],["6",54],["7",55],["8",56],["9",57],["数字键盘 0",96],["数字键盘 1",97],["数字键盘 2",98],["数字键盘 3",99],["数字键盘 4",100],["数字键盘 5",101],["数字键盘 6",102],["数字键盘 7",103],["数字键盘 8",104],["数字键盘 9",105],["乘号",106],["加号",107],["减号",109],["小数点",110],["除号",111][112],["F2",113],["F3",114],["F4",115],["F5",116],["F6",117],["F7",118],["F8",119],["F9",120],["F11",122],["F12",123][8],["Tab",9],["Enter",13],["Shift",16],["Control",17],["Caps Lock",20],["Esc",27],["空格键",32],["Page Up",33],["Page Down",34],["End",35],["Home",36],["左箭头",37],["向上箭头",38],["右箭头",39],["向下箭头",40],["Insert",45],["Delete",46],["Num Lock",144],["ScrLk",145],["Pause/Break",19],["; :",186],["= +",187],["- _",189],["/ ?",191],["` ~",192],["[ {",219],["\\|",220],["] }",221],["” ’",222],[", <",188],[". >",190]];
Stage.scaleMode = "noScale";
stop();
game_testing = false;
game_level = 1;
game_sounds = true;
Wcode = 87;
Scode = 83;
Acode = 65;
Dcode = 68;
Jcode = 74;
Kcode = 75;
Lcode = 76;
org_Wcode = 87;
org_Scode = 83;
org_Acode = 65;
org_Dcode = 68;
org_Jcode = 74;
org_Kcode = 75;
org_Lcode = 76;
Jcode_pressed = false;
Kcode_pressed = false;
Lcode_pressed = false;
stg_array_1 = 4;
get_map_infor(1,1,"man",0,10,5040,500);
get_map_infor(1,2,"man",0,15,7840,400);
get_map_infor(1,3,"man",0,1,520,450);
get_map_infor(1,4,"man",0,3,1150,500);
stg_array_2 = 2;
get_map_infor(2,1,"man",0,100,55960,600);
get_map_infor(2,2,"plane",0,100,55440,600);
stg_array_3 = 6;
get_map_infor(3,1,"man",0,13,6907,600);
get_map_infor(3,2,"man",0,1,140,500);
get_map_infor(3,3,"man",1,15,4220,500);
get_map_infor(3,4,"man",1,5,1635,600);
stg1_1_map_xy = [[560,0],[560,0],[560,0],[560,-103],[560,103],[560,0],[560,0],[560,0],[560,0]];
stg1_2_map_xy = [[560,0],[560,0],[560,0],[560,0],[560,0],[560,0],[560,0],[560,0],[560,0],[560,0],[560,0],[560,0],[560,0],[560,0]];
stg1_3_map_xy = [];
stg1_4_map_xy = [[560,0],[560,0]];
stg2_1_map_xy = [[863,0]];
var i = 1;
while(i < 100)
{
   stg2_1_map_xy[i] = [560,0];
   i++;
}
stg3_1_map_xy = [[560,0],[560,0],[560,-130],[560,-133],[560,-83],[560,0],[560,0],[560,-93],[560,0],[560,0],[560,0],[560,0]];
stg3_2_map_xy = [];
stg3_3_map_xy = [[560,0],[201,456],[456,456],[456,456],[456,456],[456,456],[456,461],[694,0],[348,409],[0,409],[0,409],[0,409],[0,409],[0,547]];
stg3_4_map_xy = [[560,0],[560,0],[560,0],[0,400]];
enemysAction01 = function(who, x, y, atk, typ, moves)
{
   var my_number = main.enemys.getNextHighestDepth();
   var this_mc = main.enemys.attachMovie(who,who + my_number,my_number);
   this_mc.blood = _root.game_level;
   this_mc.speed = -6;
   this_mc._x = x;
   this_mc._y = y;
   this_mc.attacks = atk;
   this_mc.type = typ;
   this_mc.moves = moves;
   this_mc.targeter = "_root.main.player";
   this_mc.can_kill = true;
   this_mc.can_block = true;
   this_mc.dead = false;
   this_mc.stand = function()
   {
      if(this.moves <= 50)
      {
         this.gotoAndStop("stand" + this.type);
         this.onEnterFrame = function()
         {
            this.target = eval(this.targeter);
            if(this.target.dead == false)
            {
               if(this._x < this.target._x - 10)
               {
                  if(this._xscale == 100)
                  {
                     this._xscale = -100;
                  }
               }
               else if(this._x > this.target._x + 10)
               {
                  if(this._xscale == -100)
                  {
                     this._xscale = 100;
                  }
               }
               var temp1 = Math.abs(this._x - this.target._x);
               var temp2 = Math.abs(this._y - this.target._y);
               var distance = Math.sqrt(temp1 * temp1 + temp2 * temp2);
               if(distance > 1200)
               {
                  this.removeMovieClip();
               }
               else if(distance > 590 && distance < 660)
               {
                  if(!random(50))
                  {
                     this.move_me();
                  }
               }
               else if(distance < 590 && distance > 200)
               {
                  if(!random(80))
                  {
                     this.shoot();
                  }
                  if(!random(40))
                  {
                     this.move_me();
                  }
               }
               else if(distance < 200 && distance > 50)
               {
                  if(!random(15))
                  {
                     this.shoot();
                  }
               }
               else if(distance < 50)
               {
                  this.attack();
               }
            }
         };
      }
      else if(this.moves > 50)
      {
         if(this.moves == 51)
         {
            this.gotoAndStop("talk02");
         }
         else if(this.moves == 52)
         {
            this.gotoAndStop("stand1");
         }
         else if(this.moves == 53)
         {
            this.gotoAndStop("stand2");
         }
         else if(this.moves == 54)
         {
            this.gotoAndStop("stand4");
         }
         else if(this.moves == 55)
         {
            this.gotoAndStop("talk03");
         }
         this.onEnterFrame = function()
         {
            this.target = eval(this.targeter);
            if(this.target.dead == false)
            {
               var temp1 = Math.abs(this._x - this.target._x);
               var temp2 = Math.abs(this._y - this.target._y);
               var distance = Math.sqrt(temp1 * temp1 + temp2 * temp2);
               if(distance > 1200)
               {
                  this.removeMovieClip();
               }
               else if(distance < 250)
               {
                  this.get_shocked();
               }
            }
         };
      }
   };
   this_mc.get_shocked = function()
   {
      delete this.onEnterFrame;
      this.gotoAndStop("shocked");
      play_soundAction("士兵受惊");
      this.moves = 1;
   };
   this_mc.get_blocked = function()
   {
      this.gotoAndStop("talk01");
      this.onEnterFrame = function()
      {
         if(!random(50))
         {
            this.stand();
         }
      };
   };
   this_mc.attack = function()
   {
      delete this.onEnterFrame;
      this.gotoAndStop("attack");
   };
   this_mc.attackAction = function()
   {
      if(this.target != undefined)
      {
         if(this.m.point.hitTest(this.target.g))
         {
            player_die(this.target,"kill");
         }
      }
   };
   this_mc.move_me = function()
   {
      if(this.moves)
      {
         if(this.moves == 2)
         {
            this.gotoAndStop("walk01");
         }
         else
         {
            this.gotoAndStop("run" + this.type);
         }
         this.onEnterFrame = function()
         {
            if(this.moves == 2)
            {
               var _loc3_ = this.speed * Math.abs(this._xscale) / this._xscale / 2;
            }
            else
            {
               _loc3_ = this.speed * Math.abs(this._xscale) / this._xscale;
            }
            if(enemy_move(this,_loc3_))
            {
               if(!random(40))
               {
                  this.stand();
               }
               var _loc2_ = new Object();
               _loc2_.x = this._x;
               _loc2_.y = this._y;
               this._parent.localToGlobal(_loc2_);
               if(Math.abs(_loc2_.x) > 530 || Math.abs(_loc2_.x) < 30)
               {
                  this.stand();
               }
               if(Math.abs(this._x - this.target._x) < 10)
               {
                  this.stand();
               }
               if(this.target == undefined)
               {
                  this.stand();
               }
            }
         };
      }
   };
   this_mc.shoot = function()
   {
      if(this.moves == 3)
      {
         if(!random(50))
         {
            this.run_away();
         }
      }
      else
      {
         var _loc2_ = new Object();
         _loc2_.x = this._x;
         _loc2_.y = this._y;
         this._parent.localToGlobal(_loc2_);
         if(Math.abs(_loc2_.x - 280) < 280 && Math.abs(_loc2_.y - 200) < 200)
         {
            delete this.onEnterFrame;
            if(this.attacks > 0)
            {
               this.attacks = this.attacks - 1;
               if(this.type != 2)
               {
                  this.gotoAndStop("shoot" + this.type);
               }
               else
               {
                  this.gotoAndStop("shoot2");
                  if(game_level <= 1)
                  {
                     this.m.gotoAndPlay("stand_shoot");
                  }
                  else if(this.target.states == "crouch")
                  {
                     this.m.gotoAndPlay("crouch_shoot");
                  }
                  else
                  {
                     this.m.gotoAndPlay("stand_shoot");
                  }
               }
            }
            else
            {
               this.run_away();
            }
         }
      }
   };
   this_mc.shootAction = function()
   {
      if(this.type == 1)
      {
         play_soundAction("手枪发射");
      }
      else if(this.type == 2)
      {
         play_soundAction("H弹发射");
      }
      else if(this.type == 3)
      {
         play_soundAction("坦克射击");
      }
      else if(this.type == 5)
      {
         play_soundAction("坦克射击");
      }
      var depth = main.getNextHighestDepth();
      var shoot_mc = main.attachMovie("npc_shoot0" + this.type,"npc_shoot" + depth,depth);
      shoot_mc._x = get_shoot_point(this.m.point)[0];
      shoot_mc._y = get_shoot_point(this.m.point)[1];
      shoot_mc.targeter = this.targeter;
      shoot_mc._rotation = 90 * (1 - Math.abs(this._xscale) / this._xscale);
      shoot_mc.type = this.type;
      if(this.target != undefined)
      {
         var tempxspeed = (- shoot_mc._x - this.target._x) / 62;
         if(game_level <= 1)
         {
            if(Math.abs(tempxspeed) > 3)
            {
               tempxspeed = -4 * (Math.abs(shoot_mc._x - this.target._x) / (shoot_mc._x - this.target._x));
            }
         }
      }
      else
      {
         var tempxspeed = -1;
      }
      shoot_mc.xspeed = tempxspeed;
      shoot_mc.yspeed = -10;
      shoot_mc.get_blocked = function()
      {
         this._rotation = 0;
         this.gotoAndStop("hit");
         delete this.onEnterFrame;
         if(this.type == 1)
         {
            play_soundAction("手枪击中");
         }
         else if(this.type == 2)
         {
            play_soundAction("H弹击中");
         }
         else if(this.type == 3)
         {
            play_soundAction("手雷爆炸");
         }
         else if(this.type == 4)
         {
            play_soundAction("手雷爆炸");
         }
         else if(this.type == 5)
         {
            play_soundAction("手雷爆炸");
         }
         else if(this.type == 6)
         {
            play_soundAction("手雷爆炸");
         }
      };
      shoot_mc.onEnterFrame = function()
      {
         if(this._x > - main._x && this._x < 560 - main._x && (this._y > - main._y - 200 && this._y < 600 - main._y))
         {
            if(this.can_go)
            {
               if(this.type == 4)
               {
                  this._rotation = this._rotation + 10;
                  this._x = this._x + this.xspeed;
                  this.yspeed = this.yspeed + 0.35;
                  this._y = this._y + this.yspeed;
               }
               else if(this.type == 6)
               {
                  var temp = Math.abs(this.xspeed) / this.xspeed;
                  this._rotation = this._rotation + temp * 10;
                  enemy_move(this,(- temp) * this.speed);
               }
               else
               {
                  this._x = this._x + this.speed * Math.cos(this._rotation * 0.01745);
                  this._y = this._y + this.speed * Math.sin(this._rotation * 0.01745);
               }
            }
         }
         else
         {
            this.removeMovieClip();
         }
         if(this.can_go)
         {
            if(this.type != 6)
            {
               §§enumerate(main.bg);
               while(true)
               {
                  if((var _loc0_ = §§pop()) != null)
                  {
                     grounds = _loc0_;
                     if(main.bg[grounds].g.hitTest(this._x + main._x,this._y + main._y,true))
                     {
                        this.get_blocked();
                        this.target = eval(this.targeter);
                        if(this.target != undefined)
                        {
                        }
                        break;
                     }
                     continue;
                  }
                  addr298:
                  if(this.target.g.hitTest(this))
                  {
                     player_die(this.target,"shoot");
                     this.get_blocked();
                     break;
                  }
                  break;
               }
            }
            this.target = eval(this.targeter);
            if(this.target != undefined)
            {
               §§goto(addr298);
            }
         }
      };
   };
   this_mc.to_die = function(how, much, dir)
   {
      this.blood = this.blood - much;
      if(this.blood <= 0)
      {
         this.dead = true;
         if(this.states != "jump")
         {
            delete this.onEnterFrame;
            if(how == "blow")
            {
               this.gotoAndStop("die4");
               play_soundAction("敌兵死亡04");
            }
            else if(how == "fly")
            {
               this.gotoAndStop("die5");
               play_soundAction("敌兵死亡02");
               var _loc2_ = main.enemys.getNextHighestDepth();
               var _loc3_ = main.enemys.attachMovie("flower05","flower05" + _loc2_,_loc2_);
               _loc3_._x = this._x;
               _loc3_._y = this._y;
               if(dir == 0)
               {
                  this.fly_xspeed = 20;
                  this.fly_yspeed = 0;
               }
               else if(dir == 180)
               {
                  this.fly_xspeed = -20;
                  this.fly_yspeed = 0;
               }
               else if(dir == -90)
               {
                  this.fly_xspeed = 0;
                  this.fly_yspeed = -20;
               }
               else if(dir == 90)
               {
                  this.fly_xspeed = 0;
                  this.fly_yspeed = 0;
               }
               this.onEnterFrame = function()
               {
                  if(enemy_fly(this,this.fly_xspeed,this.fly_yspeed))
                  {
                     delete this.onEnterFrame;
                  }
               };
            }
            else
            {
               this.gotoAndStop("die" + (random(3) + 1));
               play_soundAction("敌兵死亡0" + (random(3) + 1));
            }
            if(this.dieEvents != undefined)
            {
               this.dieEvents();
            }
         }
         else
         {
            this.gotoAndStop("die5");
            this.clip.stop();
            play_soundAction("敌兵死亡0" + (random(3) + 1));
            this.onEnterFrame = function()
            {
               if(enemy_move(this,0))
               {
                  this.clip.play();
                  delete this.onEnterFrame;
               }
            };
         }
      }
   };
   this_mc.run_away = function()
   {
      if(this._x < this.target._x)
      {
         this._xscale = 100;
      }
      else
      {
         this._xscale = -100;
      }
      this.gotoAndStop("run" + this.type);
      this.onEnterFrame = function()
      {
         _root.enemy_move(this,this.speed * Math.abs(this._xscale) / this._xscale);
         var _loc3_ = new Object();
         _loc3_.x = this._x;
         _loc3_.y = this._y;
         this._parent.localToGlobal(_loc3_);
         if(Math.abs(_loc3_.x - 290) > 290 || Math.abs(_loc3_.y - 210) > 210)
         {
            if(this.dieEvents != undefined)
            {
               this.dieEvents();
            }
            this.removeMovieClip();
         }
      };
   };
   this_mc.stand();
   return this_mc;
};
blocksAction = function(type, x, y, blood)
{
   var _loc4_ = main.enemys.getNextHighestDepth();
   var _loc3_ = main.enemys.attachMovie("block" + type,"block" + type + _loc4_,_loc4_);
   _loc3_.blood = _root.game_level * blood;
   _loc3_.org_blood = _loc3_.blood;
   _loc3_._x = x;
   _loc3_._y = y;
   _loc3_.type = type;
   _loc3_.can_kill = true;
   _loc3_.can_block = true;
   _loc3_.dead = false;
   _loc3_.exploding = function()
   {
      for(enemy in _root.main.enemys)
      {
         if(_root.main.enemys[enemy].g.hitTest(this))
         {
            _root.main.enemys[enemy].to_die("blow",20);
         }
      }
   };
   _loc3_.to_die = function(how, much)
   {
      this.blood = this.blood - much;
      if(this.blood <= 0)
      {
         if(this.type == "01")
         {
            play_soundAction("手雷爆炸");
         }
         else if(this.type == "02")
         {
            play_soundAction("大爆炸");
         }
         else if(this.type == "03")
         {
            play_soundAction("手雷爆炸");
         }
         else if(this.type == "04")
         {
            play_soundAction("手雷爆炸");
         }
         add_present(this);
         this.dead = true;
         this.gotoAndPlay("explode");
         if(this.dieEvents != undefined)
         {
            this.dieEvents();
         }
      }
      else
      {
         this.gotoAndPlay("hit");
         if(this.type == "04")
         {
            var _loc2_ = this.org_blood - this.blood;
            var _loc3_ = this.org_blood / 3;
            var _loc4_ = Math.floor(_loc2_ / _loc3_) + 1;
            this.g.gotoAndStop(_loc4_);
         }
      }
   };
   return _loc3_;
};
play_game();
