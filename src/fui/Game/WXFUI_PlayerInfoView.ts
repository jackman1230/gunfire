/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_blood from "./WXFUI_blood";
import WXFUI_susBtn from "./WXFUI_susBtn";
import WXFUI_GoodsItem from "./WXFUI_GoodsItem";

export default class WXFUI_PlayerInfoView extends fgui.GComponent {

	public m_blood_1:WXFUI_blood;
	public m_blood_2:WXFUI_blood;
	public m_blood_3:WXFUI_blood;
	public m_n7:fgui.GImage;
	public m_pause:WXFUI_susBtn;
	public m_coin:fgui.GTextField;
	public m_bullet:fgui.GTextField;
	public m_gre:fgui.GTextField;
	public m_level:fgui.GTextField;
	public m_n13:fgui.GImage;
	public m_n14:fgui.GImage;
	public m_item_1:WXFUI_GoodsItem;
	public m_item_2:WXFUI_GoodsItem;
	public m_item_3:WXFUI_GoodsItem;
	public static URL:string = "ui://bq3h5insiasdkz";

	public static createInstance():WXFUI_PlayerInfoView {
		return <WXFUI_PlayerInfoView>(fgui.UIPackage.createObject("Game", "PlayerInfoView"));
	}

	protected onConstruct():void {
		this.m_blood_1 = <WXFUI_blood>(this.getChild("blood_1"));
		this.m_blood_2 = <WXFUI_blood>(this.getChild("blood_2"));
		this.m_blood_3 = <WXFUI_blood>(this.getChild("blood_3"));
		this.m_n7 = <fgui.GImage>(this.getChild("n7"));
		this.m_pause = <WXFUI_susBtn>(this.getChild("pause"));
		this.m_coin = <fgui.GTextField>(this.getChild("coin"));
		this.m_bullet = <fgui.GTextField>(this.getChild("bullet"));
		this.m_gre = <fgui.GTextField>(this.getChild("gre"));
		this.m_level = <fgui.GTextField>(this.getChild("level"));
		this.m_n13 = <fgui.GImage>(this.getChild("n13"));
		this.m_n14 = <fgui.GImage>(this.getChild("n14"));
		this.m_item_1 = <WXFUI_GoodsItem>(this.getChild("item_1"));
		this.m_item_2 = <WXFUI_GoodsItem>(this.getChild("item_2"));
		this.m_item_3 = <WXFUI_GoodsItem>(this.getChild("item_3"));
	}
}