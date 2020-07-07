
import WXFUI_PopUpView from "../fui/Game/WXFUI_PopUpView";
import { ViewManager } from "../Manager/ViewManager";

export default class PopUpView {

    public v: WXFUI_PopUpView;
    public view: fairygui.GComponent;

    private tween: Laya.Tween;
    constructor() {
        this.v = WXFUI_PopUpView.createInstance();
    }

    public showView(showMask: boolean = true, clickMaskHide: boolean = true): void {
        this.layout();
        this.layoutMask();
        Laya.Tween.clearTween(this.tween);
        this.v.addChild(this.view);
        fairygui.GRoot.inst.addChild(this.v);
        this.view.setPivot(0.5, 0.5);
        this.view.setScale(0.4, 0.4);
        this.tween = Laya.Tween.to(this.view, { scaleX: 1, scaleY: 1 }, 250, null, Laya.Handler.create(this, this.showComplete, [showMask, clickMaskHide]));
    }

    public showViewNoTween(): void {
        this.layout();
        this.layoutMask();
        this.view.setScale(1, 1);
        this.v.addChild(this.view);
        fairygui.GRoot.inst.addChild(this.v);
    }

    private layout(): void {
        var w: number = ViewManager.instance.getLayoutWidth();
        this.v.x = w;
    }

    private layoutMask(): void {
        var pro: number = ViewManager.instance.getProportion();
        if (pro > 0)
            this.v.m_mask.setScale(1 + pro, 1 + pro);
    }

    private showComplete(s: boolean, c: boolean): void {
        if (s) {
            // console.log("showComplete---");
            this.v.m_mask.visible = true;
            if (c)
                this.v.m_mask.on(Laya.Event.CLICK, this, this.hideAllView);
        }
        this.view.setScale(1, 1);
    }


    public hideAllView(): void {
        // console.log("hidePopUpView--", this.view);
        this.v.m_mask.off(Laya.Event.CLICK, this, this.hideAllView);
        fairygui.GRoot.inst.removeChild(this.v);
        // this.tween = Laya.Tween.from(this.view, { scaleX: 0, scaleY: 0 }, 300, null, Laya.Handler.create(this, () => {
        // }));
    }

}