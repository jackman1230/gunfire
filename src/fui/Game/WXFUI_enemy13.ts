/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy13 extends fairygui.GComponent {

	public m_load:fairygui.GLoader;

	public static URL:string = "ui://bq3h5instvmxxot";

	public static createInstance():WXFUI_enemy13 {
		return <WXFUI_enemy13><any>(fairygui.UIPackage.createObject("Game","enemy13"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_load = <fairygui.GLoader><any>(this.getChild("load"));
	}
}