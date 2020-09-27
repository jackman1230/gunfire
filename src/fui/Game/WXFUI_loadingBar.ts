/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_loadingBar extends fgui.GProgressBar {

	public m_n0:fgui.GImage;
	public m_bar:fgui.GImage;
	public m_title:fgui.GTextField;
	public static URL:string = "ui://bq3h5insvmpqxu5";

	public static createInstance():WXFUI_loadingBar {
		return <WXFUI_loadingBar>(fgui.UIPackage.createObject("Game", "loadingBar"));
	}

	protected onConstruct():void {
		this.m_n0 = <fgui.GImage>(this.getChild("n0"));
		this.m_bar = <fgui.GImage>(this.getChild("bar"));
		this.m_title = <fgui.GTextField>(this.getChild("title"));
	}
}