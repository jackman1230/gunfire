/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_nextBtn2 extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n1:fgui.GImage;
	public static URL:string = "ui://bq3h5inslpi5xxg";

	public static createInstance():WXFUI_nextBtn2 {
		return <WXFUI_nextBtn2>(fgui.UIPackage.createObject("Game", "nextBtn2"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n1 = <fgui.GImage>(this.getChild("n1"));
	}
}