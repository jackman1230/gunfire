stop();
if(_root.game_level < 1)
{
   _root.add_enemys01("enemy01",3056,-189,2,4,3);
   _root.add_enemys01("enemy01",3074,-184,2,4,3);
   _root.add_enemys01("enemy01",3100,-177,2,4,3);
   _root.add_prisoner("prisoner01",3225,-139,3,1,"r");
}
else
{
   _root.add_enemys01("enemy01",3056,-189,5,4,1);
   _root.add_enemys01("enemy01",3074,-184,5,4,1);
   _root.add_enemys01("enemy01",3100,-177,5,4,1);
}
_root.add_prisoner("prisoner01",2872,-201,3,1,"b");
