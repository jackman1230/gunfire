/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_ADListHor extends fairygui.GComponent {

	public m_list:fairygui.GList;
	public m_n4:fairygui.GGraph;

	public static URL:string = "ui://bq3h5inss2x8xs6";

	public static createInstance():WXFUI_ADListHor {
		return <WXFUI_ADListHor><any>(fairygui.UIPackage.createObject("Game","ADListHor"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_list = <fairygui.GList><any>(this.getChild("list"));
		this.m_n4 = <fairygui.GGraph><any>(this.getChild("n4"));
	}
}