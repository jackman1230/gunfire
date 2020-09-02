/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_TipsPopView extends fgui.GComponent {

	public m_tips:fgui.GTextField;
	public m_play:fgui.Transition;
	public static URL:string = "ui://bq3h5insugvixpf";

	public static createInstance():WXFUI_TipsPopView {
		return <WXFUI_TipsPopView>(fgui.UIPackage.createObject("Game", "TipsPopView"));
	}

	protected onConstruct():void {
		this.m_tips = <fgui.GTextField>(this.getChild("tips"));
		this.m_play = this.getTransition("play");
	}
}