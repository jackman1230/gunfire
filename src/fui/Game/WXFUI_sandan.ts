/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_sandan extends fgui.GComponent {

	public m_zidan:fgui.GLoader;
	public static URL:string = "ui://bq3h5insvmpqxud";

	public static createInstance():WXFUI_sandan {
		return <WXFUI_sandan>(fgui.UIPackage.createObject("Game", "sandan"));
	}

	protected onConstruct():void {
		this.m_zidan = <fgui.GLoader>(this.getChild("zidan"));
	}
}