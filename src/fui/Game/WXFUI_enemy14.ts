/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy14 extends fairygui.GComponent {

	public m_load:fairygui.GLoader;

	public static URL:string = "ui://bq3h5instvmxxou";

	public static createInstance():WXFUI_enemy14 {
		return <WXFUI_enemy14><any>(fairygui.UIPackage.createObject("Game","enemy14"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_load = <fairygui.GLoader><any>(this.getChild("load"));
	}
}