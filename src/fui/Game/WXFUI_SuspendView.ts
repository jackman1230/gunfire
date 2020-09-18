/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

import WXFUI_backHomeBtn from "./WXFUI_backHomeBtn";
import WXFUI_continueBtn2 from "./WXFUI_continueBtn2";
import WXFUI_restartBtn from "./WXFUI_restartBtn";

export default class WXFUI_SuspendView extends fairygui.GComponent {

	public m_bg:fairygui.GImage;
	public m_back:WXFUI_backHomeBtn;
	public m_continue:WXFUI_continueBtn2;
	public m_restart:WXFUI_restartBtn;
	public m_n10:fairygui.GImage;

	public static URL:string = "ui://bq3h5insn8qul6";

	public static createInstance():WXFUI_SuspendView {
		return <WXFUI_SuspendView><any>(fairygui.UIPackage.createObject("Game","SuspendView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_bg = <fairygui.GImage><any>(this.getChild("bg"));
		this.m_back = <WXFUI_backHomeBtn><any>(this.getChild("back"));
		this.m_continue = <WXFUI_continueBtn2><any>(this.getChild("continue"));
		this.m_restart = <WXFUI_restartBtn><any>(this.getChild("restart"));
		this.m_n10 = <fairygui.GImage><any>(this.getChild("n10"));
	}
}