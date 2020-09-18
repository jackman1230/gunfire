/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_nextBtn2 extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n1:fairygui.GImage;

	public static URL:string = "ui://bq3h5inslpi5xxg";

	public static createInstance():WXFUI_nextBtn2 {
		return <WXFUI_nextBtn2><any>(fairygui.UIPackage.createObject("Game","nextBtn2"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n1 = <fairygui.GImage><any>(this.getChild("n1"));
	}
}