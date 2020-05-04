/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_dirCtl extends fairygui.GComponent {

	public m_n0:fairygui.GGraph;
	public m_n5:fairygui.GImage;
	public m_n6:fairygui.GImage;

	public static URL:string = "ui://bq3h5inscqp93k";

	public static createInstance():WXFUI_dirCtl {
		return <WXFUI_dirCtl><any>(fairygui.UIPackage.createObject("Game","dirCtl"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n0 = <fairygui.GGraph><any>(this.getChildAt(0));
		this.m_n5 = <fairygui.GImage><any>(this.getChildAt(1));
		this.m_n6 = <fairygui.GImage><any>(this.getChildAt(2));
	}
}