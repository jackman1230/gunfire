/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_backHomeBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n5:fgui.GImage;
	public m_n4:fgui.GImage;
	public static URL:string = "ui://bq3h5insdr1tni";

	public static createInstance():WXFUI_backHomeBtn {
		return <WXFUI_backHomeBtn>(fgui.UIPackage.createObject("Game", "backHomeBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n5 = <fgui.GImage>(this.getChild("n5"));
		this.m_n4 = <fgui.GImage>(this.getChild("n4"));
	}
}