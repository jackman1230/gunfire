/** This is an automatically generated class by FairyGUI. Please do not modify it. **/

export default class WXFUI_goodsView extends fgui.GComponent {

	public m_load:fgui.GLoader;
	public static URL:string = "ui://bq3h5insqz5ukq";

	public static createInstance():WXFUI_goodsView {
		return <WXFUI_goodsView>(fgui.UIPackage.createObject("Game", "goodsView"));
	}

	protected onConstruct():void {
		this.m_load = <fgui.GLoader>(this.getChild("load"));
	}
}