function startAction()
{
   if(this._x < 7900)
   {
      this.onEnterFrame = function()
      {
         _root.active_map_drawer = this;
         _root.active_object_speed = speed;
         play();
         this._x = this._x + speed;
         if(_root.main.player.g.hitTest(this))
         {
            if(_root.main.player.can_with)
            {
               _root.main.player._x = _root.main.player._x + speed * 2;
            }
         }
         if(this._x >= 7900)
         {
            stop();
            _root.active_object_speed = 0;
            _root.active_map_drawer = "main.player";
            delete this.onEnterFrame;
         }
      };
   }
}
No = 2;
stop();
g._visible = 0;
speed = 2;
