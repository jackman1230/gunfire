/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_zidan extends fgui.GComponent {

	public m_zidan:fgui.GLoader;
	public static URL:string = "ui://bq3h5insyqv7ax";

	public static createInstance():WXFUI_zidan {
		return <WXFUI_zidan>(fgui.UIPackage.createObject("Game", "zidan"));
	}

	protected onConstruct():void {
		this.m_zidan = <fgui.GLoader>(this.getChild("zidan"));
	}
}