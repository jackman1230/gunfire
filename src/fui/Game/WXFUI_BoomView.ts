/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_BoomView extends fgui.GComponent {

	public m_boom:fgui.GLoader;
	public static URL:string = "ui://bq3h5inske5wdt";

	public static createInstance():WXFUI_BoomView {
		return <WXFUI_BoomView>(fgui.UIPackage.createObject("Game", "BoomView"));
	}

	protected onConstruct():void {
		this.m_boom = <fgui.GLoader>(this.getChild("boom"));
	}
}