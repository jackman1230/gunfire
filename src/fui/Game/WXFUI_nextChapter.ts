/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_nextChapter extends fairygui.GButton {

	public m_button:fairygui.Controller;
	public m_n7:fairygui.GImage;

	public static URL:string = "ui://bq3h5insdr1to0";

	public static createInstance():WXFUI_nextChapter {
		return <WXFUI_nextChapter><any>(fairygui.UIPackage.createObject("Game","nextChapter"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_button = this.getController("button");
		this.m_n7 = <fairygui.GImage><any>(this.getChild("n7"));
	}
}