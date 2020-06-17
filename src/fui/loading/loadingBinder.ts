/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_loadingView from "./WXFUI_loadingView";
import WXFUI_loadingBar from "./WXFUI_loadingBar";

export default class loadingBinder{
	public static bindAll():void {
		fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_loadingView.URL, WXFUI_loadingView);
		fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_loadingBar.URL, WXFUI_loadingBar);
	}
}