/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_ADremen2 extends fairygui.GComponent {

	public m_n3:fairygui.GImage;
	public m_n4:fairygui.GImage;
	public m_ani:fairygui.Transition;

	public static URL:string = "ui://bq3h5insko37xuk";

	public static createInstance():WXFUI_ADremen2 {
		return <WXFUI_ADremen2><any>(fairygui.UIPackage.createObject("Game","ADremen2"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n3 = <fairygui.GImage><any>(this.getChild("n3"));
		this.m_n4 = <fairygui.GImage><any>(this.getChild("n4"));
		this.m_ani = this.getTransition("ani");
	}
}