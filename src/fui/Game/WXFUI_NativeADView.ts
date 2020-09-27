/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_nativeClose from "./WXFUI_nativeClose";
import WXFUI_seeAdBtn from "./WXFUI_seeAdBtn";
import WXFUI_continueBtn2 from "./WXFUI_continueBtn2";

export default class WXFUI_NativeADView extends fgui.GComponent {

	public m_ctl:fgui.Controller;
	public m_n14:fgui.GImage;
	public m_load:fgui.GLoader;
	public m_close:WXFUI_nativeClose;
	public m_n20:fgui.GTextField;
	public m_see:WXFUI_seeAdBtn;
	public m_pass:WXFUI_continueBtn2;
	public m_n19:fgui.GGroup;
	public static URL:string = "ui://bq3h5insmnewxx9";

	public static createInstance():WXFUI_NativeADView {
		return <WXFUI_NativeADView>(fgui.UIPackage.createObject("Game", "NativeADView"));
	}

	protected onConstruct():void {
		this.m_ctl = this.getController("ctl");
		this.m_n14 = <fgui.GImage>(this.getChild("n14"));
		this.m_load = <fgui.GLoader>(this.getChild("load"));
		this.m_close = <WXFUI_nativeClose>(this.getChild("close"));
		this.m_n20 = <fgui.GTextField>(this.getChild("n20"));
		this.m_see = <WXFUI_seeAdBtn>(this.getChild("see"));
		this.m_pass = <WXFUI_continueBtn2>(this.getChild("pass"));
		this.m_n19 = <fgui.GGroup>(this.getChild("n19"));
	}
}