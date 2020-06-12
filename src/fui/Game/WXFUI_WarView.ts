/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_WarView extends fairygui.GComponent {

	public m_bg:fairygui.GLoader;
	public m_box2:fairygui.GGraph;

	public static URL:string = "ui://bq3h5insoqgwam";

	public static createInstance():WXFUI_WarView {
		return <WXFUI_WarView><any>(fairygui.UIPackage.createObject("Game","WarView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_bg = <fairygui.GLoader><any>(this.getChild("bg"));
		this.m_box2 = <fairygui.GGraph><any>(this.getChild("box2"));
	}
}