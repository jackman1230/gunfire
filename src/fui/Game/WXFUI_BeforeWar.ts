/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_buyItem from "./WXFUI_buyItem";
import WXFUI_enterBtn from "./WXFUI_enterBtn";
import WXFUI_ADListVer from "./WXFUI_ADListVer";

export default class WXFUI_BeforeWar extends fairygui.GComponent {

	public m_bg:fairygui.GImage;
	public m_item_1:WXFUI_buyItem;
	public m_item_2:WXFUI_buyItem;
	public m_item_3:WXFUI_buyItem;
	public m_item_4:WXFUI_buyItem;
	public m_enter:WXFUI_enterBtn;
	public m_n17:fairygui.GImage;
	public m_n19:fairygui.GImage;
	public m_n20:fairygui.GImage;
	public m_n21:fairygui.GImage;
	public m_coin:fairygui.GTextField;
	public m_bulletNum:fairygui.GTextField;
	public m_bombNum:fairygui.GTextField;
	public m_ad1:WXFUI_ADListVer;
	public m_ad2:WXFUI_ADListVer;

	public static URL:string = "ui://bq3h5insdr1tnl";

	public static createInstance():WXFUI_BeforeWar {
		return <WXFUI_BeforeWar><any>(fairygui.UIPackage.createObject("Game","BeforeWar"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_bg = <fairygui.GImage><any>(this.getChild("bg"));
		this.m_item_1 = <WXFUI_buyItem><any>(this.getChild("item_1"));
		this.m_item_2 = <WXFUI_buyItem><any>(this.getChild("item_2"));
		this.m_item_3 = <WXFUI_buyItem><any>(this.getChild("item_3"));
		this.m_item_4 = <WXFUI_buyItem><any>(this.getChild("item_4"));
		this.m_enter = <WXFUI_enterBtn><any>(this.getChild("enter"));
		this.m_n17 = <fairygui.GImage><any>(this.getChild("n17"));
		this.m_n19 = <fairygui.GImage><any>(this.getChild("n19"));
		this.m_n20 = <fairygui.GImage><any>(this.getChild("n20"));
		this.m_n21 = <fairygui.GImage><any>(this.getChild("n21"));
		this.m_coin = <fairygui.GTextField><any>(this.getChild("coin"));
		this.m_bulletNum = <fairygui.GTextField><any>(this.getChild("bulletNum"));
		this.m_bombNum = <fairygui.GTextField><any>(this.getChild("bombNum"));
		this.m_ad1 = <WXFUI_ADListVer><any>(this.getChild("ad1"));
		this.m_ad2 = <WXFUI_ADListVer><any>(this.getChild("ad2"));
	}
}