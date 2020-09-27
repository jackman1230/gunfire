/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_volume extends fgui.GComponent {

	public m_ctl:fgui.Controller;
	public m_n4:fgui.GImage;
	public m_n5:fgui.GImage;
	public m_n6:fgui.GImage;
	public static URL:string = "ui://bq3h5insugvixpi";

	public static createInstance():WXFUI_volume {
		return <WXFUI_volume>(fgui.UIPackage.createObject("Game", "volume"));
	}

	protected onConstruct():void {
		this.m_ctl = this.getController("ctl");
		this.m_n4 = <fgui.GImage>(this.getChild("n4"));
		this.m_n5 = <fgui.GImage>(this.getChild("n5"));
		this.m_n6 = <fgui.GImage>(this.getChild("n6"));
	}
}