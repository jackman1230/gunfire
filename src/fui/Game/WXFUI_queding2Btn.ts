/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_queding2Btn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n0:fairygui.GImage;

	public static URL:string = "ui://bq3h5insk6saxwu";

	public static createInstance():WXFUI_queding2Btn {
		return <WXFUI_queding2Btn><any>(fairygui.UIPackage.createObject("Game","queding2Btn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n0 = <fairygui.GImage><any>(this.getChild("n0"));
	}
}