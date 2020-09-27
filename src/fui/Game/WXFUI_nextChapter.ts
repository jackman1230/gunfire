/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_nextChapter extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n7:fgui.GImage;
	public static URL:string = "ui://bq3h5insdr1to0";

	public static createInstance():WXFUI_nextChapter {
		return <WXFUI_nextChapter>(fgui.UIPackage.createObject("Game", "nextChapter"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n7 = <fgui.GImage>(this.getChild("n7"));
	}
}