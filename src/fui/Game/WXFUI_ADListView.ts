/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_ADListHorBig2 from "./WXFUI_ADListHorBig2";
import WXFUI_continueBtn from "./WXFUI_continueBtn";

export default class WXFUI_ADListView extends fairygui.GComponent {

	public m_ctl:fairygui.Controller;
	public m_n6:fairygui.GGraph;
	public m_ad_1:WXFUI_ADListHorBig2;
	public m_ad_2:WXFUI_ADListHorBig2;
	public m_jixu:WXFUI_continueBtn;
	public m_n12:fairygui.GTextField;
	public m_time:fairygui.GTextField;

	public static URL:string = "ui://bq3h5insvmpqxua";

	public static createInstance():WXFUI_ADListView {
		return <WXFUI_ADListView><any>(fairygui.UIPackage.createObject("Game","ADListView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_ctl = this.getController("ctl");
		this.m_n6 = <fairygui.GGraph><any>(this.getChild("n6"));
		this.m_ad_1 = <WXFUI_ADListHorBig2><any>(this.getChild("ad_1"));
		this.m_ad_2 = <WXFUI_ADListHorBig2><any>(this.getChild("ad_2"));
		this.m_jixu = <WXFUI_continueBtn><any>(this.getChild("jixu"));
		this.m_n12 = <fairygui.GTextField><any>(this.getChild("n12"));
		this.m_time = <fairygui.GTextField><any>(this.getChild("time"));
	}
}