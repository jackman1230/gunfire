/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_GoodsItem extends fairygui.GComponent {

	public m_ctl:fairygui.Controller;
	public m_icon:fairygui.GLoader;
	public m_info:fairygui.GTextField;
	public m_coin:fairygui.GTextField;
	public m_n12:fairygui.GImage;
	public m_ani:fairygui.Transition;

	public static URL:string = "ui://bq3h5insso8uxx3";

	public static createInstance():WXFUI_GoodsItem {
		return <WXFUI_GoodsItem><any>(fairygui.UIPackage.createObject("Game","GoodsItem"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_ctl = this.getController("ctl");
		this.m_icon = <fairygui.GLoader><any>(this.getChild("icon"));
		this.m_info = <fairygui.GTextField><any>(this.getChild("info"));
		this.m_coin = <fairygui.GTextField><any>(this.getChild("coin"));
		this.m_n12 = <fairygui.GImage><any>(this.getChild("n12"));
		this.m_ani = this.getTransition("ani");
	}
}