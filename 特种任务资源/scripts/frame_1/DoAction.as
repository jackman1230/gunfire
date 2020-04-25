function loadingAction()
{
   this.attachMovie("loading_clip","loading_clip",this.getNextHighestDepth());
   loading_clip.onEnterFrame = function()
   {
      var _loc2_ = getBytesLoaded();
      var _loc3_ = getBytesTotal();
      var _loc4_ = int(_loc2_ / _loc3_ * 100);
      this.bar._xscale = _loc4_ + random(2) / 2;
      if(_loc2_ == _loc3_)
      {
         gotoAndStop("gameframe");
         this.removeMovieClip();
      }
   };
}
loadingAction();
this._lockroot = true;
