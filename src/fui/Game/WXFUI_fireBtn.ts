/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_fireBtn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n3:fairygui.GImage;
	public m_n4:fairygui.GImage;
	public m_n5:fairygui.GImage;

	public static URL:string = "ui://bq3h5inscqp93o";

	public static createInstance():WXFUI_fireBtn {
		return <WXFUI_fireBtn><any>(fairygui.UIPackage.createObject("Game","fireBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n3 = <fairygui.GImage><any>(this.getChild("n3"));
		this.m_n4 = <fairygui.GImage><any>(this.getChild("n4"));
		this.m_n5 = <fairygui.GImage><any>(this.getChild("n5"));
	}
}