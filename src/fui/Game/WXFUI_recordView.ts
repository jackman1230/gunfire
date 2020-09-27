/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_guanbiBtn from "./WXFUI_guanbiBtn";

export default class WXFUI_recordView extends fgui.GComponent {

	public m_n33:fgui.GImage;
	public m_guanbi:WXFUI_guanbiBtn;
	public m_n36:fgui.GImage;
	public m_n37:fgui.GTextField;
	public m_clickArea:fgui.GLoader;
	public static URL:string = "ui://bq3h5insk6saxwx";

	public static createInstance():WXFUI_recordView {
		return <WXFUI_recordView>(fgui.UIPackage.createObject("Game", "recordView"));
	}

	protected onConstruct():void {
		this.m_n33 = <fgui.GImage>(this.getChild("n33"));
		this.m_guanbi = <WXFUI_guanbiBtn>(this.getChild("guanbi"));
		this.m_n36 = <fgui.GImage>(this.getChild("n36"));
		this.m_n37 = <fgui.GTextField>(this.getChild("n37"));
		this.m_clickArea = <fgui.GLoader>(this.getChild("clickArea"));
	}
}