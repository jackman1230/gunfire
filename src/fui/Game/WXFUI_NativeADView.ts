/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_nativeClose from "./WXFUI_nativeClose";
import WXFUI_passBtn from "./WXFUI_passBtn";
import WXFUI_seeAdBtn from "./WXFUI_seeAdBtn";

export default class WXFUI_NativeADView extends fairygui.GComponent {

	public m_ctl:fairygui.Controller;
	public m_n14:fairygui.GImage;
	public m_load:fairygui.GLoader;
	public m_close:WXFUI_nativeClose;
	public m_pass:WXFUI_passBtn;
	public m_n20:fairygui.GTextField;
	public m_see:WXFUI_seeAdBtn;
	public m_n19:fairygui.GGroup;

	public static URL:string = "ui://bq3h5insmnewxx9";

	public static createInstance():WXFUI_NativeADView {
		return <WXFUI_NativeADView><any>(fairygui.UIPackage.createObject("Game","NativeADView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_ctl = this.getController("ctl");
		this.m_n14 = <fairygui.GImage><any>(this.getChild("n14"));
		this.m_load = <fairygui.GLoader><any>(this.getChild("load"));
		this.m_close = <WXFUI_nativeClose><any>(this.getChild("close"));
		this.m_pass = <WXFUI_passBtn><any>(this.getChild("pass"));
		this.m_n20 = <fairygui.GTextField><any>(this.getChild("n20"));
		this.m_see = <WXFUI_seeAdBtn><any>(this.getChild("see"));
		this.m_n19 = <fairygui.GGroup><any>(this.getChild("n19"));
	}
}