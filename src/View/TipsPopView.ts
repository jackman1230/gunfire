

import WXFUI_TipsPopView from "../fui/Game/WXFUI_TipsPopView";

export default class TipsPopView {

    public v: WXFUI_TipsPopView;
    private isShow: boolean = false;
    constructor() {
        this.v = WXFUI_TipsPopView.createInstance();
    }

    public showView(str: string): void {
        if (this.isShow) return;
        this.isShow = true;
        this.v.x = (Laya.stage.width - this.v.width) / 2;
        this.v.y = (Laya.stage.height - this.v.height) / 2;
        this.v.m_tips.text = str;
        Laya.stage.addChildAt(this.v.displayObject, 1);
        this.v.m_play.play(Laya.Handler.create(this, this.hideView), 1, 0, 0);
    }

    public hideView(): void {
        Laya.stage.removeChild(this.v.displayObject);
        this.isShow = false;
    }

}