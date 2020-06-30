/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy_fire_12 extends fairygui.GComponent {

	public m_tank:fairygui.GLoader;
	public m_fire:fairygui.GMovieClip;

	public static URL:string = "ui://bq3h5insqz5ukt";

	public static createInstance():WXFUI_enemy_fire_12 {
		return <WXFUI_enemy_fire_12><any>(fairygui.UIPackage.createObject("Game","enemy_fire_12"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_tank = <fairygui.GLoader><any>(this.getChild("tank"));
		this.m_fire = <fairygui.GMovieClip><any>(this.getChild("fire"));
	}
}