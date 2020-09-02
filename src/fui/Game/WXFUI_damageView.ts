/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_damageView extends fgui.GComponent {

	public m_num:fgui.GTextField;
	public m_ani:fgui.Transition;
	public static URL:string = "ui://bq3h5ins8mn4xsm";

	public static createInstance():WXFUI_damageView {
		return <WXFUI_damageView>(fgui.UIPackage.createObject("Game", "damageView"));
	}

	protected onConstruct():void {
		this.m_num = <fgui.GTextField>(this.getChild("num"));
		this.m_ani = this.getTransition("ani");
	}
}