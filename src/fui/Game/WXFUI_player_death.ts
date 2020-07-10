/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_player_death extends fairygui.GComponent {

	public m_xs:fairygui.GLoader;
	public m_ss:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insunfjxs1";

	public static createInstance():WXFUI_player_death {
		return <WXFUI_player_death><any>(fairygui.UIPackage.createObject("Game","player_death"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_xs = <fairygui.GLoader><any>(this.getChild("xs"));
		this.m_ss = <fairygui.GLoader><any>(this.getChild("ss"));
	}
}