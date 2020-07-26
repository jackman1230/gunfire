/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_hostage extends fairygui.GComponent {

	public m_en:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insvmpqxtc";

	public static createInstance():WXFUI_hostage {
		return <WXFUI_hostage><any>(fairygui.UIPackage.createObject("Game","hostage"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_en = <fairygui.GLoader><any>(this.getChild("en"));
	}
}