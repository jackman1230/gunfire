/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy12 extends fairygui.GComponent {

	public m_load:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insdx35l5";

	public static createInstance():WXFUI_enemy12 {
		return <WXFUI_enemy12><any>(fairygui.UIPackage.createObject("Game","enemy12"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_load = <fairygui.GLoader><any>(this.getChild("load"));
	}
}