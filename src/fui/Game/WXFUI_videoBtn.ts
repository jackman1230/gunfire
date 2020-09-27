/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_videoBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n0:fgui.GImage;
	public m_n1:fgui.GImage;
	public static URL:string = "ui://bq3h5insk6saxwn";

	public static createInstance():WXFUI_videoBtn {
		return <WXFUI_videoBtn>(fgui.UIPackage.createObject("Game", "videoBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n0 = <fgui.GImage>(this.getChild("n0"));
		this.m_n1 = <fgui.GImage>(this.getChild("n1"));
	}
}