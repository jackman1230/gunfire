/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_setBtn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n7:fairygui.GImage;

	public static URL:string = "ui://bq3h5insdr1to5";

	public static createInstance():WXFUI_setBtn {
		return <WXFUI_setBtn><any>(fairygui.UIPackage.createObject("Game","setBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n7 = <fairygui.GImage><any>(this.getChild("n7"));
	}
}