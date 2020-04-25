stop();
if(_root.game_level < 1)
{
   _root.add_enemys01("enemy01",1699,83,1000,6,0);
   _root.add_enemys01("enemy01",2113,172,1000,4,0);
   _root.add_prisoner("prisoner01",2146,285,3,1,"h");
}
else
{
   if(_root.game_level == 1)
   {
      _root.add_enemys01("enemy01",2130,283,1000,4,0);
   }
   else
   {
      _root.add_enemys01("enemy01",1755,311,1000,2,0);
      _root.add_enemys01("enemy01",1805,311,1000,2,0);
      _root.add_enemys01("enemy01",1880,310,1000,3,0);
      _root.add_enemys01("enemy01",1970,312,1000,3,0);
      _root.add_enemys10("enemy10",2130,283);
   }
   _root.add_enemys01("enemy01",1699,83,1000,6,0);
   _root.add_enemys01("enemy01",1760,82,1000,6,0);
   _root.add_enemys01("enemy01",2113,172,1000,4,0);
   _root.add_enemys01("enemy01",2154,172,1000,4,0);
   _root.add_enemys01("enemy01",2189,172,1000,4,0);
}
_root.add_deadAction(_root.add_blocks("03",2053,327),6);
