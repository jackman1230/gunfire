/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_ADListHor extends fgui.GComponent {

	public m_list:fgui.GList;
	public m_n4:fgui.GGraph;
	public static URL:string = "ui://bq3h5inss2x8xs6";

	public static createInstance():WXFUI_ADListHor {
		return <WXFUI_ADListHor>(fgui.UIPackage.createObject("Game", "ADListHor"));
	}

	protected onConstruct():void {
		this.m_list = <fgui.GList>(this.getChild("list"));
		this.m_n4 = <fgui.GGraph>(this.getChild("n4"));
	}
}