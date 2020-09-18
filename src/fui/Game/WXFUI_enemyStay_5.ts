/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemyStay_5 extends fairygui.GComponent {

	public m_en:fairygui.GLoader;
	public m_people:fairygui.GMovieClip;

	public static URL:string = "ui://bq3h5insdhktei";

	public static createInstance():WXFUI_enemyStay_5 {
		return <WXFUI_enemyStay_5><any>(fairygui.UIPackage.createObject("Game","enemyStay_5"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_en = <fairygui.GLoader><any>(this.getChild("en"));
		this.m_people = <fairygui.GMovieClip><any>(this.getChild("people"));
	}
}