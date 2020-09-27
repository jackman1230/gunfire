/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_GoodsItem extends fgui.GComponent {

	public m_ctl:fgui.Controller;
	public m_icon:fgui.GLoader;
	public m_info:fgui.GTextField;
	public m_coin:fgui.GTextField;
	public m_n12:fgui.GImage;
	public m_ani:fgui.Transition;
	public static URL:string = "ui://bq3h5insso8uxx3";

	public static createInstance():WXFUI_GoodsItem {
		return <WXFUI_GoodsItem>(fgui.UIPackage.createObject("Game", "GoodsItem"));
	}

	protected onConstruct():void {
		this.m_ctl = this.getController("ctl");
		this.m_icon = <fgui.GLoader>(this.getChild("icon"));
		this.m_info = <fgui.GTextField>(this.getChild("info"));
		this.m_coin = <fgui.GTextField>(this.getChild("coin"));
		this.m_n12 = <fgui.GImage>(this.getChild("n12"));
		this.m_ani = this.getTransition("ani");
	}
}