/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_continueBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n4:fgui.GImage;
	public static URL:string = "ui://bq3h5insdr1tnk";

	public static createInstance():WXFUI_continueBtn {
		return <WXFUI_continueBtn>(fgui.UIPackage.createObject("Game", "continueBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n4 = <fgui.GImage>(this.getChild("n4"));
	}
}