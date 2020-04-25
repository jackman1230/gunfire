function startAction()
{
   if(!running)
   {
      running = true;
      body1.play();
      body2.play();
      w1.play();
      w2.play();
      this.onEnterFrame = function()
      {
         _root.active_map_drawer = this;
         _root.active_object_speed = speed;
         if(this._x < 53800)
         {
            if(speed < 25)
            {
               speed = speed + 0.2;
            }
            else
            {
               speed = 25;
            }
         }
         else if(speed > 0)
         {
            speed = speed - 0.2;
         }
         else
         {
            speed = 0;
         }
         _root.moveAction(this,speed * Math.abs(this._xscale) / this._xscale);
         if(_root.main.player.can_with)
         {
            _root.main.player._x = _root.main.player._x + speed;
         }
         if(speed == 0)
         {
            _root.active_object_speed = 0;
            _root.active_map_drawer = "main.player";
            body1.stop();
            body2.stop();
            w1.stop();
            w2.stop();
            delete this.onEnterFrame;
         }
      };
   }
}
No = 3;
body1.stop();
body2.stop();
w1.stop();
w2.stop();
can_block = true;
g._visible = 0;
speed = 0;
heights = this._height;
