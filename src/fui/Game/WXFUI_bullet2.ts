/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_bullet2 extends fairygui.GComponent {

	public m_n3:fairygui.GImage;
	public m_n4:fairygui.GImage;

	public static URL:string = "ui://bq3h5insyqv7au";

	public static createInstance():WXFUI_bullet2 {
		return <WXFUI_bullet2><any>(fairygui.UIPackage.createObject("Game","bullet2"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n3 = <fairygui.GImage><any>(this.getChildAt(0));
		this.m_n4 = <fairygui.GImage><any>(this.getChildAt(1));
	}
}