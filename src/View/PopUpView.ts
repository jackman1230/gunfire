
import WXFUI_PopUpView from "../fui/Game/WXFUI_PopUpView";

export default class PopUpView {

    public v: WXFUI_PopUpView;
    constructor(str: string) {
        this.v = WXFUI_PopUpView.createInstance();
        this.v.m_load.url = str;
    }

    public showView(): void {
        fairygui.GRoot.inst.addChild(this.v);
        this.v.m_t0.play();
    }

    public hideView(f?: Function): void {
        this.v.m_t0.playReverse(Laya.Handler.create(this, this.removeView, [f]));
    }

    private removeView(f?: Function): void {
        fairygui.GRoot.inst.removeChild(this.v);
        if (f)
            f.call(this);
    }
}