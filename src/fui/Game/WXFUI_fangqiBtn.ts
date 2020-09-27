/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_guanbiBtn from "./WXFUI_guanbiBtn";

export default class WXFUI_fangqiBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_ctl:fgui.Controller;
	public m_n0:fgui.GImage;
	public m_n1:fgui.GImage;
	public m_guanbi:WXFUI_guanbiBtn;
	public static URL:string = "ui://bq3h5insk6saxwp";

	public static createInstance():WXFUI_fangqiBtn {
		return <WXFUI_fangqiBtn>(fgui.UIPackage.createObject("Game", "fangqiBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_ctl = this.getController("ctl");
		this.m_n0 = <fgui.GImage>(this.getChild("n0"));
		this.m_n1 = <fgui.GImage>(this.getChild("n1"));
		this.m_guanbi = <WXFUI_guanbiBtn>(this.getChild("guanbi"));
	}
}