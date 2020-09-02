/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_ADListHorBig extends fairygui.GComponent {

	public m_list:fairygui.GList;
	public m_n4:fairygui.GGraph;

	public static URL:string = "ui://bq3h5insko37xup";

	public static createInstance():WXFUI_ADListHorBig {
		return <WXFUI_ADListHorBig><any>(fairygui.UIPackage.createObject("Game","ADListHorBig"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_list = <fairygui.GList><any>(this.getChild("list"));
		this.m_n4 = <fairygui.GGraph><any>(this.getChild("n4"));
	}
}