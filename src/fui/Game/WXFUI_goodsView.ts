/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_goodsView extends fairygui.GComponent {

	public m_load:fairygui.GLoader;

	public static URL:string = "ui://bq3h5insqz5ukq";

	public static createInstance():WXFUI_goodsView {
		return <WXFUI_goodsView><any>(fairygui.UIPackage.createObject("Game","goodsView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_load = <fairygui.GLoader><any>(this.getChild("load"));
	}
}