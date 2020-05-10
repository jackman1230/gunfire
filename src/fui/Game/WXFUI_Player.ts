/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_Player extends fairygui.GComponent {

	public m_firePos:fairygui.Controller;
	public m_fireType:fairygui.Controller;
	public m_body:fairygui.GLoader;
	public m_firePos1:fairygui.GLoader;
	public m_firePos2:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insmsdc6j";

	public static createInstance():WXFUI_Player {
		return <WXFUI_Player><any>(fairygui.UIPackage.createObject("Game","Player"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_firePos = this.getControllerAt(0);
		this.m_fireType = this.getControllerAt(1);
		this.m_body = <fairygui.GLoader><any>(this.getChildAt(0));
		this.m_firePos1 = <fairygui.GLoader><any>(this.getChildAt(1));
		this.m_firePos2 = <fairygui.GLoader><any>(this.getChildAt(2));
	}
}