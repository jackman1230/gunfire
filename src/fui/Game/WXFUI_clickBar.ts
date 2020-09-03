/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_clickBar extends fgui.GProgressBar {

	public m_n0:fgui.GImage;
	public m_bar:fgui.GImage;
	public static URL:string = "ui://bq3h5insm5yyxvk";

	public static createInstance():WXFUI_clickBar {
		return <WXFUI_clickBar>(fgui.UIPackage.createObject("Game", "clickBar"));
	}

	protected onConstruct():void {
		this.m_n0 = <fgui.GImage>(this.getChild("n0"));
		this.m_bar = <fgui.GImage>(this.getChild("bar"));
	}
}