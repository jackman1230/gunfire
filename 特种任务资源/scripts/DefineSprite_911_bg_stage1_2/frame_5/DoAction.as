stop();
_root.add_object("boat01",2580,305);
d.type = "water";
if(_root.game_level < 1)
{
   _root.add_enemys01("enemy01",2283,332,1000,4,3);
}
else
{
   _root.add_prisoner("prisoner01",2283,332,1,1,"h");
}
