/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_quedingBtn from "./WXFUI_quedingBtn";

export default class WXFUI_RewardView extends fgui.GComponent {

	public m_n12:fgui.GGraph;
	public m_n6:fgui.GImage;
	public m_n7:fgui.GImage;
	public m_btn:WXFUI_quedingBtn;
	public m_n10:fgui.GLoader;
	public m_n11:fgui.GTextField;
	public static URL:string = "ui://bq3h5insbuh7xvr";

	public static createInstance():WXFUI_RewardView {
		return <WXFUI_RewardView>(fgui.UIPackage.createObject("Game", "RewardView"));
	}

	protected onConstruct():void {
		this.m_n12 = <fgui.GGraph>(this.getChild("n12"));
		this.m_n6 = <fgui.GImage>(this.getChild("n6"));
		this.m_n7 = <fgui.GImage>(this.getChild("n7"));
		this.m_btn = <WXFUI_quedingBtn>(this.getChild("btn"));
		this.m_n10 = <fgui.GLoader>(this.getChild("n10"));
		this.m_n11 = <fgui.GTextField>(this.getChild("n11"));
	}
}