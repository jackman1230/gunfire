/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_Player extends fairygui.GComponent {

	public m_xs:fairygui.GLoader;
	public m_ss:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insmsdc6j";

	public static createInstance():WXFUI_Player {
		return <WXFUI_Player><any>(fairygui.UIPackage.createObject("Game","Player"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_xs = <fairygui.GLoader><any>(this.getChildAt(0));
		this.m_ss = <fairygui.GLoader><any>(this.getChildAt(1));
	}
}