stop();
_parent.count_prisoner();
btn01.onPress = function()
{
   _root.show_credits();
};
btn02.onPress = function()
{
   _root.restart_game();
};
discuss_btn.onPress = function()
{
   getURL(_root.discussURL,"_blank","POST");
};
