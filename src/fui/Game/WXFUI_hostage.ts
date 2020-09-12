/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_hostage extends fgui.GComponent {

	public m_en:fgui.GLoader;
	public static URL:string = "ui://bq3h5insvmpqxtc";

	public static createInstance():WXFUI_hostage {
		return <WXFUI_hostage>(fgui.UIPackage.createObject("Game", "hostage"));
	}

	protected onConstruct():void {
		this.m_en = <fgui.GLoader>(this.getChild("en"));
	}
}