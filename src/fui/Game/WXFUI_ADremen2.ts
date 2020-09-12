/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_ADremen2 extends fgui.GComponent {

	public m_n3:fgui.GImage;
	public m_n4:fgui.GImage;
	public m_ani:fgui.Transition;
	public static URL:string = "ui://bq3h5insko37xuk";

	public static createInstance():WXFUI_ADremen2 {
		return <WXFUI_ADremen2>(fgui.UIPackage.createObject("Game", "ADremen2"));
	}

	protected onConstruct():void {
		this.m_n3 = <fgui.GImage>(this.getChild("n3"));
		this.m_n4 = <fgui.GImage>(this.getChild("n4"));
		this.m_ani = this.getTransition("ani");
	}
}