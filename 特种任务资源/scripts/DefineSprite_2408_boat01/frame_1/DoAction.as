function startAction()
{
   if(this._x < 4300)
   {
      this.onEnterFrame = function()
      {
         _root.active_map_drawer = this;
         _root.active_object_speed = speed;
         old.play();
         this._x = this._x + speed;
         if(!random(40))
         {
            _root.add_enemys04("enemy05",this._x - 130,this._y + 75);
         }
         else if(!random(300))
         {
            _root.add_enemys04("enemy05",this._x + 280,this._y + 75);
         }
         if(_root.main.player.g.hitTest(this))
         {
            if(_root.main.player.can_with)
            {
               _root.main.player._x = _root.main.player._x + speed;
            }
         }
         if(this._x >= 4380)
         {
            _root.active_object_speed = 0;
            _root.active_map_drawer = "main.player";
            delete this.onEnterFrame;
            gotoAndStop("over");
            play();
         }
      };
   }
}
No = 1;
g._visible = 0;
speed = 1.5;
old.stop();
