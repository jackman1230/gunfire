/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_star from "./WXFUI_star";

export default class WXFUI_LevelItem extends fairygui.GComponent {

	public m_ctl:fairygui.Controller;
	public m_n12:fairygui.GImage;
	public m_n13:fairygui.GImage;
	public m_n14:fairygui.GImage;
	public m_n15:fairygui.GImage;
	public m_star:WXFUI_star;
	public m_numF:fairygui.GTextField;

	public static URL:string = "ui://bq3h5insdr1tnx";

	public static createInstance():WXFUI_LevelItem {
		return <WXFUI_LevelItem><any>(fairygui.UIPackage.createObject("Game","LevelItem"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_ctl = this.getController("ctl");
		this.m_n12 = <fairygui.GImage><any>(this.getChild("n12"));
		this.m_n13 = <fairygui.GImage><any>(this.getChild("n13"));
		this.m_n14 = <fairygui.GImage><any>(this.getChild("n14"));
		this.m_n15 = <fairygui.GImage><any>(this.getChild("n15"));
		this.m_star = <WXFUI_star><any>(this.getChild("star"));
		this.m_numF = <fairygui.GTextField><any>(this.getChild("numF"));
	}
}