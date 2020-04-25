if(!_parent.changing)
{
   _parent._parent.shooting = true;
   _parent._parent.ready = false;
   _root.shootAction();
}
else
{
   _parent.changing = false;
   _parent._parent.shooting = false;
   _parent._parent.ready = true;
}
