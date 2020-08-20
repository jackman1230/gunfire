/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_ADremen extends fairygui.GComponent {

	public m_n2:fairygui.GImage;
	public m_ani_1:fairygui.Transition;
	public m_ani_2:fairygui.Transition;

	public static URL:string = "ui://bq3h5inss2x8xs7";

	public static createInstance():WXFUI_ADremen {
		return <WXFUI_ADremen><any>(fairygui.UIPackage.createObject("Game","ADremen"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n2 = <fairygui.GImage><any>(this.getChild("n2"));
		this.m_ani_1 = this.getTransition("ani_1");
		this.m_ani_2 = this.getTransition("ani_2");
	}
}