/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_lastChapter extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n7:fgui.GImage;
	public static URL:string = "ui://bq3h5insdr1tnz";

	public static createInstance():WXFUI_lastChapter {
		return <WXFUI_lastChapter>(fgui.UIPackage.createObject("Game", "lastChapter"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n7 = <fgui.GImage>(this.getChild("n7"));
	}
}