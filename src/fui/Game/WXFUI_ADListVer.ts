/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_ADListVer extends fairygui.GComponent {

	public m_list:fairygui.GList;
	public m_n4:fairygui.GGraph;

	public static URL:string = "ui://bq3h5inss2x8xs5";

	public static createInstance():WXFUI_ADListVer {
		return <WXFUI_ADListVer><any>(fairygui.UIPackage.createObject("Game","ADListVer"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_list = <fairygui.GList><any>(this.getChild("list"));
		this.m_n4 = <fairygui.GGraph><any>(this.getChild("n4"));
	}
}