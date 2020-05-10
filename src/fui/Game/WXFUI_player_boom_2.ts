/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_player_boom_2 extends fairygui.GComponent {

	public m_xs:fairygui.GLoader;
	public m_ss:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insmsdc6l";

	public static createInstance():WXFUI_player_boom_2 {
		return <WXFUI_player_boom_2><any>(fairygui.UIPackage.createObject("Game","player_boom_2"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_xs = <fairygui.GLoader><any>(this.getChildAt(0));
		this.m_ss = <fairygui.GLoader><any>(this.getChildAt(1));
	}
}