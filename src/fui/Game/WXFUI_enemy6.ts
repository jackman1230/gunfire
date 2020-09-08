/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy6 extends fairygui.GComponent {

	public m_en:fairygui.GLoader;

	public static URL:string = "ui://bq3h5instvmxxoo";

	public static createInstance():WXFUI_enemy6 {
		return <WXFUI_enemy6><any>(fairygui.UIPackage.createObject("Game","enemy6"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_en = <fairygui.GLoader><any>(this.getChild("en"));
	}
}