/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_buyBtn from "./WXFUI_buyBtn";
import WXFUI_freeBtn from "./WXFUI_freeBtn";

export default class WXFUI_buyItem extends fairygui.GComponent {

	public m_n2:fairygui.GImage;
	public m_n4:fairygui.GImage;
	public m_n5:fairygui.GImage;
	public m_buy:WXFUI_buyBtn;
	public m_coin:fairygui.GTextField;
	public m_free:WXFUI_freeBtn;
	public m_icon:fairygui.GLoader;
	public m_info:fairygui.GTextField;

	public static URL:string = "ui://bq3h5insdr1tnm";

	public static createInstance():WXFUI_buyItem {
		return <WXFUI_buyItem><any>(fairygui.UIPackage.createObject("Game","buyItem"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n2 = <fairygui.GImage><any>(this.getChild("n2"));
		this.m_n4 = <fairygui.GImage><any>(this.getChild("n4"));
		this.m_n5 = <fairygui.GImage><any>(this.getChild("n5"));
		this.m_buy = <WXFUI_buyBtn><any>(this.getChild("buy"));
		this.m_coin = <fairygui.GTextField><any>(this.getChild("coin"));
		this.m_free = <WXFUI_freeBtn><any>(this.getChild("free"));
		this.m_icon = <fairygui.GLoader><any>(this.getChild("icon"));
		this.m_info = <fairygui.GTextField><any>(this.getChild("info"));
	}
}