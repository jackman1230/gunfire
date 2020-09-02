/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_abandon from "./WXFUI_abandon";
import WXFUI_continueBtn2 from "./WXFUI_continueBtn2";
import WXFUI_continueBtn4 from "./WXFUI_continueBtn4";
import WXFUI_continueBtn3 from "./WXFUI_continueBtn3";
import WXFUI_backBtn from "./WXFUI_backBtn";
import WXFUI_ADListVer from "./WXFUI_ADListVer";
import WXFUI_ADReMenList from "./WXFUI_ADReMenList";

export default class WXFUI_AfterWar extends fairygui.GComponent {

	public m_ctl:fairygui.Controller;
	public m_n20:fairygui.GImage;
	public m_coin:fairygui.GTextField;
	public m_n24:fairygui.GImage;
	public m_n26:fairygui.GImage;
	public m_abandon:WXFUI_abandon;
	public m_continue_1:WXFUI_continueBtn2;
	public m_continue_2:WXFUI_continueBtn4;
	public m_continue_3:WXFUI_continueBtn3;
	public m_return:WXFUI_backBtn;
	public m_ad_1:WXFUI_ADListVer;
	public m_ad_2:WXFUI_ADListVer;
	public m_ad_3:WXFUI_ADListVer;
	public m_ad_4:WXFUI_ADListVer;
	public m_adHot:WXFUI_ADReMenList;

	public static URL:string = "ui://bq3h5insdr1tnq";

	public static createInstance():WXFUI_AfterWar {
		return <WXFUI_AfterWar><any>(fairygui.UIPackage.createObject("Game","AfterWar"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_ctl = this.getController("ctl");
		this.m_n20 = <fairygui.GImage><any>(this.getChild("n20"));
		this.m_coin = <fairygui.GTextField><any>(this.getChild("coin"));
		this.m_n24 = <fairygui.GImage><any>(this.getChild("n24"));
		this.m_n26 = <fairygui.GImage><any>(this.getChild("n26"));
		this.m_abandon = <WXFUI_abandon><any>(this.getChild("abandon"));
		this.m_continue_1 = <WXFUI_continueBtn2><any>(this.getChild("continue_1"));
		this.m_continue_2 = <WXFUI_continueBtn4><any>(this.getChild("continue_2"));
		this.m_continue_3 = <WXFUI_continueBtn3><any>(this.getChild("continue_3"));
		this.m_return = <WXFUI_backBtn><any>(this.getChild("return"));
		this.m_ad_1 = <WXFUI_ADListVer><any>(this.getChild("ad_1"));
		this.m_ad_2 = <WXFUI_ADListVer><any>(this.getChild("ad_2"));
		this.m_ad_3 = <WXFUI_ADListVer><any>(this.getChild("ad_3"));
		this.m_ad_4 = <WXFUI_ADListVer><any>(this.getChild("ad_4"));
		this.m_adHot = <WXFUI_ADReMenList><any>(this.getChild("adHot"));
	}
}