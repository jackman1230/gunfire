/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_seeAdBtn from "./WXFUI_seeAdBtn";
import WXFUI_continueBtn2 from "./WXFUI_continueBtn2";
import WXFUI_nativeClose from "./WXFUI_nativeClose";

export default class WXFUI_OppoNativeADView extends fgui.GComponent {

	public m_ctl:fgui.Controller;
	public m_see:WXFUI_seeAdBtn;
	public m_pass:WXFUI_continueBtn2;
	public m_n14:fgui.GImage;
	public m_load:fgui.GLoader;
	public m_close:WXFUI_nativeClose;
	public m_n20:fgui.GTextField;
	public m_n21:fgui.GGroup;
	public static URL:string = "ui://bq3h5inslpi5xxd";

	public static createInstance():WXFUI_OppoNativeADView {
		return <WXFUI_OppoNativeADView>(fgui.UIPackage.createObject("Game", "OppoNativeADView"));
	}

	protected onConstruct():void {
		this.m_ctl = this.getController("ctl");
		this.m_see = <WXFUI_seeAdBtn>(this.getChild("see"));
		this.m_pass = <WXFUI_continueBtn2>(this.getChild("pass"));
		this.m_n14 = <fgui.GImage>(this.getChild("n14"));
		this.m_load = <fgui.GLoader>(this.getChild("load"));
		this.m_close = <WXFUI_nativeClose>(this.getChild("close"));
		this.m_n20 = <fgui.GTextField>(this.getChild("n20"));
		this.m_n21 = <fgui.GGroup>(this.getChild("n21"));
	}
}