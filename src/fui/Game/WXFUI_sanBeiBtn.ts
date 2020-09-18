/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_sanBeiBtn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n0:fairygui.GImage;

	public static URL:string = "ui://bq3h5inslpi5xxf";

	public static createInstance():WXFUI_sanBeiBtn {
		return <WXFUI_sanBeiBtn><any>(fairygui.UIPackage.createObject("Game","sanBeiBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n0 = <fairygui.GImage><any>(this.getChild("n0"));
	}
}