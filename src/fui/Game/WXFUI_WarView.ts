/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_WarView extends fgui.GComponent {

	public m_bg:fgui.GLoader;
	public m_bg2:fgui.GLoader;
	public static URL:string = "ui://bq3h5insoqgwam";

	public static createInstance():WXFUI_WarView {
		return <WXFUI_WarView>(fgui.UIPackage.createObject("Game", "WarView"));
	}

	protected onConstruct():void {
		this.m_bg = <fgui.GLoader>(this.getChild("bg"));
		this.m_bg2 = <fgui.GLoader>(this.getChild("bg2"));
	}
}