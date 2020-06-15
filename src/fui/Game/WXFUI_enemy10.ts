/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy10 extends fairygui.GComponent {

	public m_load:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insqz5ukr";

	public static createInstance():WXFUI_enemy10 {
		return <WXFUI_enemy10><any>(fairygui.UIPackage.createObject("Game","enemy10"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_load = <fairygui.GLoader><any>(this.getChild("load"));
	}
}