stop();
g._visible = 0;
_root.add_enemys05("enemy06",802,133);
if(_root.game_level < 1)
{
   _root.add_blocks("04",164,311);
   _root.add_enemys01("enemy01",319,311,1000,1,51);
   _root.add_enemys01("enemy01",399,311,1000,2,53);
   _root.add_enemys01("enemy01",449,311,1000,2,53);
   _root.add_enemys01("enemy01",499,311,1000,2,53);
   _root.add_enemys01("enemy01",549,311,1000,1,53);
   _root.add_blocks("04",665,311);
   _root.add_enemys01("enemy01",715,311,1000,4,55);
   _root.add_enemys01("enemy01",790,311,1000,4,54);
}
else
{
   _root.add_enemys07("enemy08",319,311,1);
   _root.add_enemys07("enemy08",399,311,1);
   _root.add_enemys07("enemy08",449,311,1);
   _root.add_enemys07("enemy08",499,311,1);
   _root.add_enemys07("enemy08",549,311,1);
   _root.add_enemys07("enemy08",715,311,1);
   _root.add_enemys07("enemy08",790,311,1);
   _root.add_prisoner("prisoner01",72,106,2,1,"b");
   _root.add_prisoner("prisoner01",311,119,2,1,"p");
   _root.add_prisoner("prisoner01",418,171,2,1,"p");
   _root.add_prisoner("prisoner01",504,134,2,1,"p");
   _root.add_prisoner("prisoner01",603,312,3,1,"b");
   if(_root.game_level == 1)
   {
      _root.add_prisoner("prisoner01",606,167,2,1,"h");
   }
   else if(_root.game_level == 2)
   {
      _root.add_prisoner("prisoner01",606,167,2,1,"s");
   }
}
