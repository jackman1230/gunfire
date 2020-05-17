/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_enemy5 extends fairygui.GComponent {

	public m_en:fairygui.GLoader;
	public m_firePos:fairygui.GTextField;
	public m_people:fairygui.GMovieClip;

	public static URL:string = "ui://bq3h5insyqv7b8";

	public static createInstance():WXFUI_enemy5 {
		return <WXFUI_enemy5><any>(fairygui.UIPackage.createObject("Game","enemy5"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_en = <fairygui.GLoader><any>(this.getChildAt(0));
		this.m_firePos = <fairygui.GTextField><any>(this.getChildAt(1));
		this.m_people = <fairygui.GMovieClip><any>(this.getChildAt(2));
	}
}