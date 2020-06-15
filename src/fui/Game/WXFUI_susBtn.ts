/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_susBtn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n3:fairygui.GImage;

	public static URL:string = "ui://bq3h5insiasdl3";

	public static createInstance():WXFUI_susBtn {
		return <WXFUI_susBtn><any>(fairygui.UIPackage.createObject("Game","susBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n3 = <fairygui.GImage><any>(this.getChild("n3"));
	}
}