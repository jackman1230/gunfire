stop();
if(_root.game_level < 1)
{
   _root.add_enemys01("enemy01",3514,-31,5,4,3);
   _root.add_enemys01("enemy01",3579,-5,5,4,3);
   _root.add_enemys01("enemy01",3712,46,5,4,3);
}
else
{
   _root.add_enemys01("enemy01",3514,-31,5,4,1);
   _root.add_enemys01("enemy01",3579,-5,5,4,1);
   _root.add_enemys01("enemy01",3712,46,5,4,1);
   _root.add_prisoner("prisoner01",3566,-176,2,1,"p");
   _root.add_prisoner("prisoner01",3655,-147,2,1,"r");
   _root.add_prisoner("prisoner01",3726,-122,2,1,"p");
}
