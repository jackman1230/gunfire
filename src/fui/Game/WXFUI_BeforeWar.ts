/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_buyItem from "./WXFUI_buyItem";
import WXFUI_enterBtn from "./WXFUI_enterBtn";
import WXFUI_ADListHor from "./WXFUI_ADListHor";

export default class WXFUI_BeforeWar extends fgui.GComponent {

	public m_bg:fgui.GImage;
	public m_item_1:WXFUI_buyItem;
	public m_item_2:WXFUI_buyItem;
	public m_item_3:WXFUI_buyItem;
	public m_item_4:WXFUI_buyItem;
	public m_enter:WXFUI_enterBtn;
	public m_n17:fgui.GImage;
	public m_ad:WXFUI_ADListHor;
	public m_n19:fgui.GImage;
	public m_n20:fgui.GImage;
	public m_n21:fgui.GImage;
	public m_coin:fgui.GTextField;
	public m_bulletNum:fgui.GTextField;
	public m_bombNum:fgui.GTextField;
	public static URL:string = "ui://bq3h5insdr1tnl";

	public static createInstance():WXFUI_BeforeWar {
		return <WXFUI_BeforeWar>(fgui.UIPackage.createObject("Game", "BeforeWar"));
	}

	protected onConstruct():void {
		this.m_bg = <fgui.GImage>(this.getChild("bg"));
		this.m_item_1 = <WXFUI_buyItem>(this.getChild("item_1"));
		this.m_item_2 = <WXFUI_buyItem>(this.getChild("item_2"));
		this.m_item_3 = <WXFUI_buyItem>(this.getChild("item_3"));
		this.m_item_4 = <WXFUI_buyItem>(this.getChild("item_4"));
		this.m_enter = <WXFUI_enterBtn>(this.getChild("enter"));
		this.m_n17 = <fgui.GImage>(this.getChild("n17"));
		this.m_ad = <WXFUI_ADListHor>(this.getChild("ad"));
		this.m_n19 = <fgui.GImage>(this.getChild("n19"));
		this.m_n20 = <fgui.GImage>(this.getChild("n20"));
		this.m_n21 = <fgui.GImage>(this.getChild("n21"));
		this.m_coin = <fgui.GTextField>(this.getChild("coin"));
		this.m_bulletNum = <fgui.GTextField>(this.getChild("bulletNum"));
		this.m_bombNum = <fgui.GTextField>(this.getChild("bombNum"));
	}
}