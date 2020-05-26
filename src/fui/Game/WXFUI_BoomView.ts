/** This is an automatically generated class by FairyGUI. Please do not modify it. **/



export default class WXFUI_BoomView extends fairygui.GComponent {

	public m_boom:fairygui.GLoader;

	public static URL:string = "ui://bq3h5inske5wdt";

	public static createInstance():WXFUI_BoomView {
		return <WXFUI_BoomView><any>(fairygui.UIPackage.createObject("Game","BoomView"));
	}

	public constructor() {
		super();
	}

	protected onConstruct(): void {
		this.m_boom = <fairygui.GLoader><any>(this.getChildAt(0));
	}
}