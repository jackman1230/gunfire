/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_volume extends fairygui.GComponent {

	public m_ctl:fairygui.Controller;
	public m_n4:fairygui.GImage;
	public m_n5:fairygui.GImage;
	public m_n6:fairygui.GImage;

	public static URL:string = "ui://bq3h5insugvixpi";

	public static createInstance():WXFUI_volume {
		return <WXFUI_volume><any>(fairygui.UIPackage.createObject("Game","volume"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_ctl = this.getController("ctl");
		this.m_n4 = <fairygui.GImage><any>(this.getChild("n4"));
		this.m_n5 = <fairygui.GImage><any>(this.getChild("n5"));
		this.m_n6 = <fairygui.GImage><any>(this.getChild("n6"));
	}
}