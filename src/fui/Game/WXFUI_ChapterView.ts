/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_lastChapter from "./WXFUI_lastChapter";
import WXFUI_nextChapter from "./WXFUI_nextChapter";
import WXFUI_LevelItem from "./WXFUI_LevelItem";
import WXFUI_share from "./WXFUI_share";
import WXFUI_setBtn from "./WXFUI_setBtn";
import WXFUI_setting from "./WXFUI_setting";

export default class WXFUI_ChapterView extends fairygui.GComponent {

	public m_chapter:fairygui.Controller;
	public m_n12:fairygui.GImage;
	public m_n14:fairygui.GImage;
	public m_map:fairygui.GLoader;
	public m_last:WXFUI_lastChapter;
	public m_next:WXFUI_nextChapter;
	public m_level_1:WXFUI_LevelItem;
	public m_level_2:WXFUI_LevelItem;
	public m_level_3:WXFUI_LevelItem;
	public m_level_4:WXFUI_LevelItem;
	public m_level_5:WXFUI_LevelItem;
	public m_level_6:WXFUI_LevelItem;
	public m_level_7:WXFUI_LevelItem;
	public m_level_8:WXFUI_LevelItem;
	public m_level_9:WXFUI_LevelItem;
	public m_level_10:WXFUI_LevelItem;
	public m_title:fairygui.GLoader;
	public m_share:WXFUI_share;
	public m_set:WXFUI_setBtn;
	public m_setView:WXFUI_setting;

	public static URL:string = "ui://bq3h5insdr1tnw";

	public static createInstance():WXFUI_ChapterView {
		return <WXFUI_ChapterView><any>(fairygui.UIPackage.createObject("Game","ChapterView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_chapter = this.getController("chapter");
		this.m_n12 = <fairygui.GImage><any>(this.getChild("n12"));
		this.m_n14 = <fairygui.GImage><any>(this.getChild("n14"));
		this.m_map = <fairygui.GLoader><any>(this.getChild("map"));
		this.m_last = <WXFUI_lastChapter><any>(this.getChild("last"));
		this.m_next = <WXFUI_nextChapter><any>(this.getChild("next"));
		this.m_level_1 = <WXFUI_LevelItem><any>(this.getChild("level_1"));
		this.m_level_2 = <WXFUI_LevelItem><any>(this.getChild("level_2"));
		this.m_level_3 = <WXFUI_LevelItem><any>(this.getChild("level_3"));
		this.m_level_4 = <WXFUI_LevelItem><any>(this.getChild("level_4"));
		this.m_level_5 = <WXFUI_LevelItem><any>(this.getChild("level_5"));
		this.m_level_6 = <WXFUI_LevelItem><any>(this.getChild("level_6"));
		this.m_level_7 = <WXFUI_LevelItem><any>(this.getChild("level_7"));
		this.m_level_8 = <WXFUI_LevelItem><any>(this.getChild("level_8"));
		this.m_level_9 = <WXFUI_LevelItem><any>(this.getChild("level_9"));
		this.m_level_10 = <WXFUI_LevelItem><any>(this.getChild("level_10"));
		this.m_title = <fairygui.GLoader><any>(this.getChild("title"));
		this.m_share = <WXFUI_share><any>(this.getChild("share"));
		this.m_set = <WXFUI_setBtn><any>(this.getChild("set"));
		this.m_setView = <WXFUI_setting><any>(this.getChild("setView"));
	}
}