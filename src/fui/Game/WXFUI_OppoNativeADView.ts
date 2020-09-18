/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_seeAdBtn from "./WXFUI_seeAdBtn";
import WXFUI_continueBtn2 from "./WXFUI_continueBtn2";
import WXFUI_nativeClose from "./WXFUI_nativeClose";

export default class WXFUI_OppoNativeADView extends fairygui.GComponent {

	public m_ctl:fairygui.Controller;
	public m_see:WXFUI_seeAdBtn;
	public m_pass:WXFUI_continueBtn2;
	public m_n14:fairygui.GImage;
	public m_load:fairygui.GLoader;
	public m_close:WXFUI_nativeClose;
	public m_n20:fairygui.GTextField;
	public m_n21:fairygui.GGroup;

	public static URL:string = "ui://bq3h5inslpi5xxd";

	public static createInstance():WXFUI_OppoNativeADView {
		return <WXFUI_OppoNativeADView><any>(fairygui.UIPackage.createObject("Game","OppoNativeADView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_ctl = this.getController("ctl");
		this.m_see = <WXFUI_seeAdBtn><any>(this.getChild("see"));
		this.m_pass = <WXFUI_continueBtn2><any>(this.getChild("pass"));
		this.m_n14 = <fairygui.GImage><any>(this.getChild("n14"));
		this.m_load = <fairygui.GLoader><any>(this.getChild("load"));
		this.m_close = <WXFUI_nativeClose><any>(this.getChild("close"));
		this.m_n20 = <fairygui.GTextField><any>(this.getChild("n20"));
		this.m_n21 = <fairygui.GGroup><any>(this.getChild("n21"));
	}
}