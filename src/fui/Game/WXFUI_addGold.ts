/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_addGold extends fgui.GComponent {

	public m_num:fgui.GTextField;
	public m_icon:fgui.GLoader;
	public m_com:fgui.GGroup;
	public m_ani:fgui.Transition;
	public static URL:string = "ui://bq3h5ins8mn4xsz";

	public static createInstance():WXFUI_addGold {
		return <WXFUI_addGold>(fgui.UIPackage.createObject("Game", "addGold"));
	}

	protected onConstruct():void {
		this.m_num = <fgui.GTextField>(this.getChild("num"));
		this.m_icon = <fgui.GLoader>(this.getChild("icon"));
		this.m_com = <fgui.GGroup>(this.getChild("com"));
		this.m_ani = this.getTransition("ani");
	}
}