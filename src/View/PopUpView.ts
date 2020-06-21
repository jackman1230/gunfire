
import WXFUI_PopUpView from "../fui/Game/WXFUI_PopUpView";
import { ViewManager } from "../Manager/ViewManager";

export default class PopUpView {

    public v: WXFUI_PopUpView;
    public view: fairygui.GComponent;

    private tween: Laya.Tween;
    constructor() {
        this.v = WXFUI_PopUpView.createInstance();
    }

    public showView(showMask: boolean = true): void {
        Laya.Tween.clearAll(this);
        this.v.addChild(this.view);
        fairygui.GRoot.inst.addChild(this.v);
        this.view.setPivot(0.5, 0.5);
        this.view.setScale(0.4, 0.4);
        this.tween = Laya.Tween.to(this.view, { scaleX: 1, scaleY: 1 }, 250, null, Laya.Handler.create(this, this.showComplete, [showMask]));

    }

    private showComplete(s: boolean): void {
        if (s) {
            console.log("showComplete---");
            this.v.m_mask.visible = true;
            this.v.m_mask.on(Laya.Event.CLICK, this, this.hideAllView);
        }
        this.view.setScale(1, 1);
    }


    public hideAllView(): void {
        console.log("hidePopUpView--", this.view);
        this.v.m_mask.off(Laya.Event.CLICK, this, this.hideAllView);
        fairygui.GRoot.inst.removeChild(this.v);
        // this.tween = Laya.Tween.from(this.view, { scaleX: 0, scaleY: 0 }, 300, null, Laya.Handler.create(this, () => {
        // }));
    }

}