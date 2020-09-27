/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_blood extends fgui.GComponent {

	public m_ctl:fgui.Controller;
	public m_n0:fgui.GImage;
	public m_n1:fgui.GImage;
	public m_n4:fgui.GImage;
	public static URL:string = "ui://bq3h5instckhxvn";

	public static createInstance():WXFUI_blood {
		return <WXFUI_blood>(fgui.UIPackage.createObject("Game", "blood"));
	}

	protected onConstruct():void {
		this.m_ctl = this.getController("ctl");
		this.m_n0 = <fgui.GImage>(this.getChild("n0"));
		this.m_n1 = <fgui.GImage>(this.getChild("n1"));
		this.m_n4 = <fgui.GImage>(this.getChild("n4"));
	}
}