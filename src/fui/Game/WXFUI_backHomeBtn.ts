/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_backHomeBtn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n5:fairygui.GImage;
	public m_n4:fairygui.GImage;

	public static URL:string = "ui://bq3h5insdr1tni";

	public static createInstance():WXFUI_backHomeBtn {
		return <WXFUI_backHomeBtn><any>(fairygui.UIPackage.createObject("Game","backHomeBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n5 = <fairygui.GImage><any>(this.getChild("n5"));
		this.m_n4 = <fairygui.GImage><any>(this.getChild("n4"));
	}
}