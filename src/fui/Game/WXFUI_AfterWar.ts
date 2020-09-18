/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_abandon from "./WXFUI_abandon";
import WXFUI_continueBtn2 from "./WXFUI_continueBtn2";
import WXFUI_continueBtn4 from "./WXFUI_continueBtn4";
import WXFUI_continueBtn3 from "./WXFUI_continueBtn3";
import WXFUI_backBtn from "./WXFUI_backBtn";
import WXFUI_ADListVer from "./WXFUI_ADListVer";
import WXFUI_ADReMenList from "./WXFUI_ADReMenList";
import WXFUI_nextBtn from "./WXFUI_nextBtn";
import WXFUI_videoBtn from "./WXFUI_videoBtn";
import WXFUI_NativeADView from "./WXFUI_NativeADView";
import WXFUI_OppoNativeADView from "./WXFUI_OppoNativeADView";
import WXFUI_sanBeiBtn from "./WXFUI_sanBeiBtn";
import WXFUI_nextBtn2 from "./WXFUI_nextBtn2";

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
	public m_adHot:WXFUI_ADReMenList;
	public m_n37:fairygui.GImage;
	public m_nextBtn:WXFUI_nextBtn;
	public m_gou:WXFUI_videoBtn;
	public m_n42:fairygui.GImage;
	public m_nativeAD:WXFUI_NativeADView;
	public m_oppoNative:WXFUI_OppoNativeADView;
	public m_sanbei:WXFUI_sanBeiBtn;
	public m_nextBtn2:WXFUI_nextBtn2;

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
		this.m_adHot = <WXFUI_ADReMenList><any>(this.getChild("adHot"));
		this.m_n37 = <fairygui.GImage><any>(this.getChild("n37"));
		this.m_nextBtn = <WXFUI_nextBtn><any>(this.getChild("nextBtn"));
		this.m_gou = <WXFUI_videoBtn><any>(this.getChild("gou"));
		this.m_n42 = <fairygui.GImage><any>(this.getChild("n42"));
		this.m_nativeAD = <WXFUI_NativeADView><any>(this.getChild("nativeAD"));
		this.m_oppoNative = <WXFUI_OppoNativeADView><any>(this.getChild("oppoNative"));
		this.m_sanbei = <WXFUI_sanBeiBtn><any>(this.getChild("sanbei"));
		this.m_nextBtn2 = <WXFUI_nextBtn2><any>(this.getChild("nextBtn2"));
	}
}