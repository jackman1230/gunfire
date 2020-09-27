/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_continueBtn3 extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n6:fgui.GImage;
	public static URL:string = "ui://bq3h5insdr1tnt";

	public static createInstance():WXFUI_continueBtn3 {
		return <WXFUI_continueBtn3>(fgui.UIPackage.createObject("Game", "continueBtn3"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n6 = <fgui.GImage>(this.getChild("n6"));
	}
}