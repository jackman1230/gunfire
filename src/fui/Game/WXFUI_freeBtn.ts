/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_freeBtn extends fgui.GButton {

	public m_button:fgui.Controller;
	public m_n6:fgui.GImage;
	public m_t0:fgui.Transition;
	public static URL:string = "ui://bq3h5insdr1tnp";

	public static createInstance():WXFUI_freeBtn {
		return <WXFUI_freeBtn>(fgui.UIPackage.createObject("Game", "freeBtn"));
	}

	protected onConstruct():void {
		this.m_button = this.getController("button");
		this.m_n6 = <fgui.GImage>(this.getChild("n6"));
		this.m_t0 = this.getTransition("t0");
	}
}