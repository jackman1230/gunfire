/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_fireBtn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n0:fairygui.GImage;
	public m_n1:fairygui.GImage;
	public m_title:fairygui.GTextField;

	public static URL:string = "ui://bq3h5inscqp93o";

	public static createInstance():WXFUI_fireBtn {
		return <WXFUI_fireBtn><any>(fairygui.UIPackage.createObject("Game","fireBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getControllerAt(0);
		this.m_n0 = <fairygui.GImage><any>(this.getChildAt(0));
		this.m_n1 = <fairygui.GImage><any>(this.getChildAt(1));
		this.m_title = <fairygui.GTextField><any>(this.getChildAt(2));
	}
}