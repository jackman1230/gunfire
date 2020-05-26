/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy_fire_5 extends fairygui.GComponent {

	public m_mor:fairygui.GMovieClip;
	public m_people:fairygui.GMovieClip;

	public static URL:string = "ui://bq3h5insdhktej";

	public static createInstance():WXFUI_enemy_fire_5 {
		return <WXFUI_enemy_fire_5><any>(fairygui.UIPackage.createObject("Game","enemy_fire_5"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_mor = <fairygui.GMovieClip><any>(this.getChildAt(0));
		this.m_people = <fairygui.GMovieClip><any>(this.getChildAt(1));
	}
}