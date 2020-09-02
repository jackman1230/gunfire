/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_ADListHorBig2 extends fgui.GComponent {

	public m_list:fgui.GList;
	public m_n4:fgui.GGraph;
	public static URL:string = "ui://bq3h5insihitxur";

	public static createInstance():WXFUI_ADListHorBig2 {
		return <WXFUI_ADListHorBig2>(fgui.UIPackage.createObject("Game", "ADListHorBig2"));
	}

	protected onConstruct():void {
		this.m_list = <fgui.GList>(this.getChild("list"));
		this.m_n4 = <fgui.GGraph>(this.getChild("n4"));
	}
}