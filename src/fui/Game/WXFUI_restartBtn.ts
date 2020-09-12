/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_restartBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n5:fgui.GImage;
	public m_n4:fgui.GImage;
	public static URL:string = "ui://bq3h5insdr1tnj";

	public static createInstance():WXFUI_restartBtn {
		return <WXFUI_restartBtn>(fgui.UIPackage.createObject("Game", "restartBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n5 = <fgui.GImage>(this.getChild("n5"));
		this.m_n4 = <fgui.GImage>(this.getChild("n4"));
	}
}