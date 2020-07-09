/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_susBtn from "./WXFUI_susBtn";

export default class WXFUI_PlayerInfoView extends fairygui.GComponent {

	public m_n0:fairygui.GImage;
	public m_n2:fairygui.GImage;
	public m_n3:fairygui.GImage;
	public m_n4:fairygui.GImage;
	public m_blood_1:fairygui.GImage;
	public m_blood_2:fairygui.GImage;
	public m_blood_3:fairygui.GImage;
	public m_n7:fairygui.GImage;
	public m_pause:WXFUI_susBtn;
	public m_coin:fairygui.GTextField;
	public m_bullet:fairygui.GTextField;
	public m_gre:fairygui.GTextField;
	public m_level:fairygui.GTextField;

	public static URL:string = "ui://bq3h5insiasdkz";

	public static createInstance():WXFUI_PlayerInfoView {
		return <WXFUI_PlayerInfoView><any>(fairygui.UIPackage.createObject("Game","PlayerInfoView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n0 = <fairygui.GImage><any>(this.getChild("n0"));
		this.m_n2 = <fairygui.GImage><any>(this.getChild("n2"));
		this.m_n3 = <fairygui.GImage><any>(this.getChild("n3"));
		this.m_n4 = <fairygui.GImage><any>(this.getChild("n4"));
		this.m_blood_1 = <fairygui.GImage><any>(this.getChild("blood_1"));
		this.m_blood_2 = <fairygui.GImage><any>(this.getChild("blood_2"));
		this.m_blood_3 = <fairygui.GImage><any>(this.getChild("blood_3"));
		this.m_n7 = <fairygui.GImage><any>(this.getChild("n7"));
		this.m_pause = <WXFUI_susBtn><any>(this.getChild("pause"));
		this.m_coin = <fairygui.GTextField><any>(this.getChild("coin"));
		this.m_bullet = <fairygui.GTextField><any>(this.getChild("bullet"));
		this.m_gre = <fairygui.GTextField><any>(this.getChild("gre"));
		this.m_level = <fairygui.GTextField><any>(this.getChild("level"));
	}
}