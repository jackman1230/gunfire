/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_star from "./WXFUI_star";

export default class WXFUI_LevelItem extends fgui.GComponent {

	public m_ctl:fgui.Controller;
	public m_n12:fgui.GImage;
	public m_n13:fgui.GImage;
	public m_n14:fgui.GImage;
	public m_n15:fgui.GImage;
	public m_star:WXFUI_star;
	public m_numF:fgui.GTextField;
	public static URL:string = "ui://bq3h5insdr1tnx";

	public static createInstance():WXFUI_LevelItem {
		return <WXFUI_LevelItem>(fgui.UIPackage.createObject("Game", "LevelItem"));
	}

	protected onConstruct():void {
		this.m_ctl = this.getController("ctl");
		this.m_n12 = <fgui.GImage>(this.getChild("n12"));
		this.m_n13 = <fgui.GImage>(this.getChild("n13"));
		this.m_n14 = <fgui.GImage>(this.getChild("n14"));
		this.m_n15 = <fgui.GImage>(this.getChild("n15"));
		this.m_star = <WXFUI_star>(this.getChild("star"));
		this.m_numF = <fgui.GTextField>(this.getChild("numF"));
	}
}