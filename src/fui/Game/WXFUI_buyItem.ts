/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_buyBtn from "./WXFUI_buyBtn";
import WXFUI_freeBtn from "./WXFUI_freeBtn";

export default class WXFUI_buyItem extends fgui.GComponent {

	public m_n2:fgui.GImage;
	public m_n4:fgui.GImage;
	public m_n5:fgui.GImage;
	public m_buy:WXFUI_buyBtn;
	public m_coin:fgui.GTextField;
	public m_free:WXFUI_freeBtn;
	public m_icon:fgui.GLoader;
	public m_info:fgui.GTextField;
	public m_ani:fgui.Transition;
	public static URL:string = "ui://bq3h5insdr1tnm";

	public static createInstance():WXFUI_buyItem {
		return <WXFUI_buyItem>(fgui.UIPackage.createObject("Game", "buyItem"));
	}

	protected onConstruct():void {
		this.m_n2 = <fgui.GImage>(this.getChild("n2"));
		this.m_n4 = <fgui.GImage>(this.getChild("n4"));
		this.m_n5 = <fgui.GImage>(this.getChild("n5"));
		this.m_buy = <WXFUI_buyBtn>(this.getChild("buy"));
		this.m_coin = <fgui.GTextField>(this.getChild("coin"));
		this.m_free = <WXFUI_freeBtn>(this.getChild("free"));
		this.m_icon = <fgui.GLoader>(this.getChild("icon"));
		this.m_info = <fgui.GTextField>(this.getChild("info"));
		this.m_ani = this.getTransition("ani");
	}
}