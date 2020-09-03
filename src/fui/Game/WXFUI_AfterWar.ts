/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_abandon from "./WXFUI_abandon";
import WXFUI_continueBtn2 from "./WXFUI_continueBtn2";
import WXFUI_continueBtn4 from "./WXFUI_continueBtn4";
import WXFUI_continueBtn3 from "./WXFUI_continueBtn3";
import WXFUI_backBtn from "./WXFUI_backBtn";
import WXFUI_ADListVer from "./WXFUI_ADListVer";
import WXFUI_ADReMenList from "./WXFUI_ADReMenList";

export default class WXFUI_AfterWar extends fgui.GComponent {

	public m_ctl:fgui.Controller;
	public m_n20:fgui.GImage;
	public m_coin:fgui.GTextField;
	public m_n24:fgui.GImage;
	public m_n26:fgui.GImage;
	public m_abandon:WXFUI_abandon;
	public m_continue_1:WXFUI_continueBtn2;
	public m_continue_2:WXFUI_continueBtn4;
	public m_continue_3:WXFUI_continueBtn3;
	public m_return:WXFUI_backBtn;
	public m_ad_1:WXFUI_ADListVer;
	public m_ad_2:WXFUI_ADListVer;
	public m_adHot:WXFUI_ADReMenList;
	public static URL:string = "ui://bq3h5insdr1tnq";

	public static createInstance():WXFUI_AfterWar {
		return <WXFUI_AfterWar>(fgui.UIPackage.createObject("Game", "AfterWar"));
	}

	protected onConstruct():void {
		this.m_ctl = this.getController("ctl");
		this.m_n20 = <fgui.GImage>(this.getChild("n20"));
		this.m_coin = <fgui.GTextField>(this.getChild("coin"));
		this.m_n24 = <fgui.GImage>(this.getChild("n24"));
		this.m_n26 = <fgui.GImage>(this.getChild("n26"));
		this.m_abandon = <WXFUI_abandon>(this.getChild("abandon"));
		this.m_continue_1 = <WXFUI_continueBtn2>(this.getChild("continue_1"));
		this.m_continue_2 = <WXFUI_continueBtn4>(this.getChild("continue_2"));
		this.m_continue_3 = <WXFUI_continueBtn3>(this.getChild("continue_3"));
		this.m_return = <WXFUI_backBtn>(this.getChild("return"));
		this.m_ad_1 = <WXFUI_ADListVer>(this.getChild("ad_1"));
		this.m_ad_2 = <WXFUI_ADListVer>(this.getChild("ad_2"));
		this.m_adHot = <WXFUI_ADReMenList>(this.getChild("adHot"));
	}
}