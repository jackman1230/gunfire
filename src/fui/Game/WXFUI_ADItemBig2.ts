/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_ADItemBig2 extends fgui.GComponent {

	public m_n0:fgui.GImage;
	public m_icon:fgui.GLoader;
	public m_name:fgui.GTextField;
	public static URL:string = "ui://bq3h5insihitxus";

	public static createInstance():WXFUI_ADItemBig2 {
		return <WXFUI_ADItemBig2>(fgui.UIPackage.createObject("Game", "ADItemBig2"));
	}

	protected onConstruct():void {
		this.m_n0 = <fgui.GImage>(this.getChild("n0"));
		this.m_icon = <fgui.GLoader>(this.getChild("icon"));
		this.m_name = <fgui.GTextField>(this.getChild("name"));
	}
}