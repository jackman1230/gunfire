/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_volume extends fairygui.GComponent {

	public m_n3:fairygui.GImage;

	public static URL:string = "ui://bq3h5insugvixpi";

	public static createInstance():WXFUI_volume {
		return <WXFUI_volume><any>(fairygui.UIPackage.createObject("Game","volume"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n3 = <fairygui.GImage><any>(this.getChild("n3"));
	}
}