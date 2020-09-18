/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_lingquBtn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n0:fairygui.GImage;
	public m_n1:fairygui.GImage;

	public static URL:string = "ui://bq3h5insk6saxwo";

	public static createInstance():WXFUI_lingquBtn {
		return <WXFUI_lingquBtn><any>(fairygui.UIPackage.createObject("Game","lingquBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n0 = <fairygui.GImage><any>(this.getChild("n0"));
		this.m_n1 = <fairygui.GImage><any>(this.getChild("n1"));
	}
}