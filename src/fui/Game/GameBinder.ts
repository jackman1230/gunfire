/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_BtnCtlView from "./WXFUI_BtnCtlView";
import WXFUI_dirCtl from "./WXFUI_dirCtl";
import WXFUI_funCtl from "./WXFUI_funCtl";
import WXFUI_jumpBtn from "./WXFUI_jumpBtn";
import WXFUI_fireBtn from "./WXFUI_fireBtn";
import WXFUI_throwBtn from "./WXFUI_throwBtn";
import WXFUI_weaponBtn from "./WXFUI_weaponBtn";
import WXFUI_BackGround from "./WXFUI_BackGround";
import WXFUI_Player from "./WXFUI_Player";

export default class GameBinder{
	public static bindAll():void {
		fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_BtnCtlView.URL, WXFUI_BtnCtlView);
		fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_dirCtl.URL, WXFUI_dirCtl);
		fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_funCtl.URL, WXFUI_funCtl);
		fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_jumpBtn.URL, WXFUI_jumpBtn);
		fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_fireBtn.URL, WXFUI_fireBtn);
		fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_throwBtn.URL, WXFUI_throwBtn);
		fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_weaponBtn.URL, WXFUI_weaponBtn);
		fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_BackGround.URL, WXFUI_BackGround);
		fairygui.UIObjectFactory.setPackageItemExtension(WXFUI_Player.URL, WXFUI_Player);
	}
}