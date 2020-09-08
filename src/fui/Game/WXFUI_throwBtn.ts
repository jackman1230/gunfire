/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_throwBtn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n3:fairygui.GImage;
	public m_n4:fairygui.GImage;

	public static URL:string = "ui://bq3h5inscqp93p";

	public static createInstance():WXFUI_throwBtn {
		return <WXFUI_throwBtn><any>(fairygui.UIPackage.createObject("Game","throwBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n3 = <fairygui.GImage><any>(this.getChild("n3"));
		this.m_n4 = <fairygui.GImage><any>(this.getChild("n4"));
	}
}