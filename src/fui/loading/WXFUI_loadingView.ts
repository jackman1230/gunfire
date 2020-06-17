/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_loadingBar from "./WXFUI_loadingBar";

export default class WXFUI_loadingView extends fairygui.GComponent {

	public m_n7:fairygui.GImage;
	public m_n6:fairygui.GImage;
	public m_bar:WXFUI_loadingBar;
	public m_txt:fairygui.GTextField;

	public static URL:string = "ui://nr80du74n8quil";

	public static createInstance():WXFUI_loadingView {
		return <WXFUI_loadingView><any>(fairygui.UIPackage.createObject("loading","loadingView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_n7 = <fairygui.GImage><any>(this.getChild("n7"));
		this.m_n6 = <fairygui.GImage><any>(this.getChild("n6"));
		this.m_bar = <WXFUI_loadingBar><any>(this.getChild("bar"));
		this.m_txt = <fairygui.GTextField><any>(this.getChild("txt"));
	}
}