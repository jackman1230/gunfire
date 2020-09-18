/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_guanbiBtn from "./WXFUI_guanbiBtn";

export default class WXFUI_recordView extends fairygui.GComponent {

	public m_n33:fairygui.GImage;
	public m_guanbi:WXFUI_guanbiBtn;
	public m_n36:fairygui.GImage;
	public m_n37:fairygui.GTextField;
	public m_clickArea:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insk6saxwx";

	public static createInstance():WXFUI_recordView {
		return <WXFUI_recordView><any>(fairygui.UIPackage.createObject("Game","recordView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n33 = <fairygui.GImage><any>(this.getChild("n33"));
		this.m_guanbi = <WXFUI_guanbiBtn><any>(this.getChild("guanbi"));
		this.m_n36 = <fairygui.GImage><any>(this.getChild("n36"));
		this.m_n37 = <fairygui.GTextField><any>(this.getChild("n37"));
		this.m_clickArea = <fairygui.GLoader><any>(this.getChild("clickArea"));
	}
}