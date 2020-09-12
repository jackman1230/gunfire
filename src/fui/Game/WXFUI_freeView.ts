/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_videoBtn from "./WXFUI_videoBtn";
import WXFUI_lingquBtn from "./WXFUI_lingquBtn";
import WXFUI_fangqiBtn from "./WXFUI_fangqiBtn";
import WXFUI_chaBtn from "./WXFUI_chaBtn";

export default class WXFUI_freeView extends fgui.GComponent {

	public m_ctl:fgui.Controller;
	public m_n25:fgui.GImage;
	public m_n27:fgui.GImage;
	public m_n28:fgui.GImage;
	public m_gou:WXFUI_videoBtn;
	public m_n30:fgui.GImage;
	public m_lingqu:WXFUI_lingquBtn;
	public m_fangqi:WXFUI_fangqiBtn;
	public m_cha:WXFUI_chaBtn;
	public static URL:string = "ui://bq3h5insk6saxwm";

	public static createInstance():WXFUI_freeView {
		return <WXFUI_freeView>(fgui.UIPackage.createObject("Game", "freeView"));
	}

	protected onConstruct():void {
		this.m_ctl = this.getController("ctl");
		this.m_n25 = <fgui.GImage>(this.getChild("n25"));
		this.m_n27 = <fgui.GImage>(this.getChild("n27"));
		this.m_n28 = <fgui.GImage>(this.getChild("n28"));
		this.m_gou = <WXFUI_videoBtn>(this.getChild("gou"));
		this.m_n30 = <fgui.GImage>(this.getChild("n30"));
		this.m_lingqu = <WXFUI_lingquBtn>(this.getChild("lingqu"));
		this.m_fangqi = <WXFUI_fangqiBtn>(this.getChild("fangqi"));
		this.m_cha = <WXFUI_chaBtn>(this.getChild("cha"));
	}
}