/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_chaBtn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n0:fairygui.GImage;

	public static URL:string = "ui://bq3h5insk6saxwz";

	public static createInstance():WXFUI_chaBtn {
		return <WXFUI_chaBtn><any>(fairygui.UIPackage.createObject("Game","chaBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n0 = <fairygui.GImage><any>(this.getChild("n0"));
	}
}