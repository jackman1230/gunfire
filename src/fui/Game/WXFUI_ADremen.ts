/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_ADremen extends fgui.GComponent {

	public m_n2:fgui.GImage;
	public m_ani_1:fgui.Transition;
	public m_ani_2:fgui.Transition;
	public static URL:string = "ui://bq3h5inss2x8xs7";

	public static createInstance():WXFUI_ADremen {
		return <WXFUI_ADremen>(fgui.UIPackage.createObject("Game", "ADremen"));
	}

	protected onConstruct():void {
		this.m_n2 = <fgui.GImage>(this.getChild("n2"));
		this.m_ani_1 = this.getTransition("ani_1");
		this.m_ani_2 = this.getTransition("ani_2");
	}
}