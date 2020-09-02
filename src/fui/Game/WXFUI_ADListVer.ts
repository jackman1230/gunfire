/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_ADListVer extends fgui.GComponent {

	public m_list:fgui.GList;
	public m_n4:fgui.GGraph;
	public static URL:string = "ui://bq3h5inss2x8xs5";

	public static createInstance():WXFUI_ADListVer {
		return <WXFUI_ADListVer>(fgui.UIPackage.createObject("Game", "ADListVer"));
	}

	protected onConstruct():void {
		this.m_list = <fgui.GList>(this.getChild("list"));
		this.m_n4 = <fgui.GGraph>(this.getChild("n4"));
	}
}