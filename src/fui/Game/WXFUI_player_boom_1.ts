/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_player_boom_1 extends fairygui.GComponent {

	public m_xs:fairygui.GLoader;
	public m_ss:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insmsdc6k";

	public static createInstance():WXFUI_player_boom_1 {
		return <WXFUI_player_boom_1><any>(fairygui.UIPackage.createObject("Game","player_boom_1"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_xs = <fairygui.GLoader><any>(this.getChild("xs"));
		this.m_ss = <fairygui.GLoader><any>(this.getChild("ss"));
	}
}