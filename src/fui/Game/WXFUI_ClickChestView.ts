/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_loadingBar from "./WXFUI_loadingBar";
import WXFUI_openChestBtn from "./WXFUI_openChestBtn";

export default class WXFUI_ClickChestView extends fairygui.GComponent {

	public m_box:fairygui.GLoader;
	public m_bar:WXFUI_loadingBar;
	public m_n18:fairygui.GTextField;
	public m_clickBtn:WXFUI_openChestBtn;
	public m_t0:fairygui.Transition;

	public static URL:string = "ui://bq3h5insvmpqxu4";

	public static createInstance():WXFUI_ClickChestView {
		return <WXFUI_ClickChestView><any>(fairygui.UIPackage.createObject("Game","ClickChestView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_box = <fairygui.GLoader><any>(this.getChild("box"));
		this.m_bar = <WXFUI_loadingBar><any>(this.getChild("bar"));
		this.m_n18 = <fairygui.GTextField><any>(this.getChild("n18"));
		this.m_clickBtn = <WXFUI_openChestBtn><any>(this.getChild("clickBtn"));
		this.m_t0 = this.getTransition("t0");
	}
}