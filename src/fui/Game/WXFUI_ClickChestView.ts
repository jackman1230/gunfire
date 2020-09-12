/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_loadingBar from "./WXFUI_loadingBar";
import WXFUI_openChestBtn from "./WXFUI_openChestBtn";

export default class WXFUI_ClickChestView extends fgui.GComponent {

	public m_box:fgui.GLoader;
	public m_bar:WXFUI_loadingBar;
	public m_n18:fgui.GTextField;
	public m_clickBtn:WXFUI_openChestBtn;
	public m_t0:fgui.Transition;
	public static URL:string = "ui://bq3h5insvmpqxu4";

	public static createInstance():WXFUI_ClickChestView {
		return <WXFUI_ClickChestView>(fgui.UIPackage.createObject("Game", "ClickChestView"));
	}

	protected onConstruct():void {
		this.m_box = <fgui.GLoader>(this.getChild("box"));
		this.m_bar = <WXFUI_loadingBar>(this.getChild("bar"));
		this.m_n18 = <fgui.GTextField>(this.getChild("n18"));
		this.m_clickBtn = <WXFUI_openChestBtn>(this.getChild("clickBtn"));
		this.m_t0 = this.getTransition("t0");
	}
}