/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy11 extends fairygui.GComponent {

	public m_load:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insdx35l4";

	public static createInstance():WXFUI_enemy11 {
		return <WXFUI_enemy11><any>(fairygui.UIPackage.createObject("Game","enemy11"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_load = <fairygui.GLoader><any>(this.getChild("load"));
	}
}