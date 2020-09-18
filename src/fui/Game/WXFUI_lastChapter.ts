/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_lastChapter extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n7:fairygui.GImage;

	public static URL:string = "ui://bq3h5insdr1tnz";

	public static createInstance():WXFUI_lastChapter {
		return <WXFUI_lastChapter><any>(fairygui.UIPackage.createObject("Game","lastChapter"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n7 = <fairygui.GImage><any>(this.getChild("n7"));
	}
}