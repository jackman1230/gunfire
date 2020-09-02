/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_LevelItem from "./WXFUI_LevelItem";
import WXFUI_volume from "./WXFUI_volume";
import WXFUI_ADmove from "./WXFUI_ADmove";
import WXFUI_ADremen2 from "./WXFUI_ADremen2";
import WXFUI_ADListHorBig from "./WXFUI_ADListHorBig";
import WXFUI_lastChapter from "./WXFUI_lastChapter";
import WXFUI_nextChapter from "./WXFUI_nextChapter";

export default class WXFUI_ChapterView extends fgui.GComponent {

	public m_chapter:fgui.Controller;
	public m_bg:fgui.GImage;
	public m_n14:fgui.GImage;
	public m_map:fgui.GLoader;
	public m_level_1:WXFUI_LevelItem;
	public m_level_2:WXFUI_LevelItem;
	public m_level_3:WXFUI_LevelItem;
	public m_level_4:WXFUI_LevelItem;
	public m_level_5:WXFUI_LevelItem;
	public m_level_6:WXFUI_LevelItem;
	public m_level_7:WXFUI_LevelItem;
	public m_level_8:WXFUI_LevelItem;
	public m_title:fgui.GLoader;
	public m_setView:WXFUI_volume;
	public m_ad_1:WXFUI_ADmove;
	public m_ad_2:WXFUI_ADmove;
	public m_ad_3:WXFUI_ADmove;
	public m_n41:fgui.GImage;
	public m_ad_remen:WXFUI_ADremen2;
	public m_ad:WXFUI_ADListHorBig;
	public m_last:WXFUI_lastChapter;
	public m_next:WXFUI_nextChapter;
	public static URL:string = "ui://bq3h5insdr1tnw";

	public static createInstance():WXFUI_ChapterView {
		return <WXFUI_ChapterView>(fgui.UIPackage.createObject("Game", "ChapterView"));
	}

	protected onConstruct():void {
		this.m_chapter = this.getController("chapter");
		this.m_bg = <fgui.GImage>(this.getChild("bg"));
		this.m_n14 = <fgui.GImage>(this.getChild("n14"));
		this.m_map = <fgui.GLoader>(this.getChild("map"));
		this.m_level_1 = <WXFUI_LevelItem>(this.getChild("level_1"));
		this.m_level_2 = <WXFUI_LevelItem>(this.getChild("level_2"));
		this.m_level_3 = <WXFUI_LevelItem>(this.getChild("level_3"));
		this.m_level_4 = <WXFUI_LevelItem>(this.getChild("level_4"));
		this.m_level_5 = <WXFUI_LevelItem>(this.getChild("level_5"));
		this.m_level_6 = <WXFUI_LevelItem>(this.getChild("level_6"));
		this.m_level_7 = <WXFUI_LevelItem>(this.getChild("level_7"));
		this.m_level_8 = <WXFUI_LevelItem>(this.getChild("level_8"));
		this.m_title = <fgui.GLoader>(this.getChild("title"));
		this.m_setView = <WXFUI_volume>(this.getChild("setView"));
		this.m_ad_1 = <WXFUI_ADmove>(this.getChild("ad_1"));
		this.m_ad_2 = <WXFUI_ADmove>(this.getChild("ad_2"));
		this.m_ad_3 = <WXFUI_ADmove>(this.getChild("ad_3"));
		this.m_n41 = <fgui.GImage>(this.getChild("n41"));
		this.m_ad_remen = <WXFUI_ADremen2>(this.getChild("ad_remen"));
		this.m_ad = <WXFUI_ADListHorBig>(this.getChild("ad"));
		this.m_last = <WXFUI_lastChapter>(this.getChild("last"));
		this.m_next = <WXFUI_nextChapter>(this.getChild("next"));
	}
}