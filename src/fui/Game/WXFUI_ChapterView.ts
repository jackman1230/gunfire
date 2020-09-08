/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_LevelItem from "./WXFUI_LevelItem";
import WXFUI_volume from "./WXFUI_volume";
import WXFUI_ADmove from "./WXFUI_ADmove";
import WXFUI_ADremen2 from "./WXFUI_ADremen2";
import WXFUI_ADListHorBig from "./WXFUI_ADListHorBig";
import WXFUI_lastChapter from "./WXFUI_lastChapter";
import WXFUI_nextChapter from "./WXFUI_nextChapter";
import WXFUI_ADremen from "./WXFUI_ADremen";

export default class WXFUI_ChapterView extends fairygui.GComponent {

	public m_ctl:fairygui.Controller;
	public m_bg:fairygui.GImage;
	public m_n14:fairygui.GImage;
	public m_map:fairygui.GLoader;
	public m_level_1:WXFUI_LevelItem;
	public m_level_2:WXFUI_LevelItem;
	public m_level_3:WXFUI_LevelItem;
	public m_level_4:WXFUI_LevelItem;
	public m_level_5:WXFUI_LevelItem;
	public m_level_6:WXFUI_LevelItem;
	public m_level_7:WXFUI_LevelItem;
	public m_level_8:WXFUI_LevelItem;
	public m_title:fairygui.GLoader;
	public m_setView:WXFUI_volume;
	public m_ad_1:WXFUI_ADmove;
	public m_ad_2:WXFUI_ADmove;
	public m_ad_3:WXFUI_ADmove;
	public m_n41:fairygui.GImage;
	public m_ad_remen:WXFUI_ADremen2;
	public m_ad:WXFUI_ADListHorBig;
	public m_last:WXFUI_lastChapter;
	public m_next:WXFUI_nextChapter;
	public m_ad_remen2:WXFUI_ADremen;

	public static URL:string = "ui://bq3h5insdr1tnw";

	public static createInstance():WXFUI_ChapterView {
		return <WXFUI_ChapterView><any>(fairygui.UIPackage.createObject("Game","ChapterView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_ctl = this.getController("ctl");
		this.m_bg = <fairygui.GImage><any>(this.getChild("bg"));
		this.m_n14 = <fairygui.GImage><any>(this.getChild("n14"));
		this.m_map = <fairygui.GLoader><any>(this.getChild("map"));
		this.m_level_1 = <WXFUI_LevelItem><any>(this.getChild("level_1"));
		this.m_level_2 = <WXFUI_LevelItem><any>(this.getChild("level_2"));
		this.m_level_3 = <WXFUI_LevelItem><any>(this.getChild("level_3"));
		this.m_level_4 = <WXFUI_LevelItem><any>(this.getChild("level_4"));
		this.m_level_5 = <WXFUI_LevelItem><any>(this.getChild("level_5"));
		this.m_level_6 = <WXFUI_LevelItem><any>(this.getChild("level_6"));
		this.m_level_7 = <WXFUI_LevelItem><any>(this.getChild("level_7"));
		this.m_level_8 = <WXFUI_LevelItem><any>(this.getChild("level_8"));
		this.m_title = <fairygui.GLoader><any>(this.getChild("title"));
		this.m_setView = <WXFUI_volume><any>(this.getChild("setView"));
		this.m_ad_1 = <WXFUI_ADmove><any>(this.getChild("ad_1"));
		this.m_ad_2 = <WXFUI_ADmove><any>(this.getChild("ad_2"));
		this.m_ad_3 = <WXFUI_ADmove><any>(this.getChild("ad_3"));
		this.m_n41 = <fairygui.GImage><any>(this.getChild("n41"));
		this.m_ad_remen = <WXFUI_ADremen2><any>(this.getChild("ad_remen"));
		this.m_ad = <WXFUI_ADListHorBig><any>(this.getChild("ad"));
		this.m_last = <WXFUI_lastChapter><any>(this.getChild("last"));
		this.m_next = <WXFUI_nextChapter><any>(this.getChild("next"));
		this.m_ad_remen2 = <WXFUI_ADremen><any>(this.getChild("ad_remen2"));
	}
}