/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_nextBtn extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n0:fairygui.GImage;

	public static URL:string = "ui://bq3h5insk6saxwy";

	public static createInstance():WXFUI_nextBtn {
		return <WXFUI_nextBtn><any>(fairygui.UIPackage.createObject("Game","nextBtn"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n0 = <fairygui.GImage><any>(this.getChild("n0"));
	}
}