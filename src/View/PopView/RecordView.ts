import PopUpView from "../PopUpView";
import { ViewManager } from "../../Manager/ViewManager";
import { MooSnowSDK } from "../../Manager/MooSnowSDK";
import { VideoData, VideoType, VideoInfo } from "../../Data/VideoData";
import WXFUI_recordView from "../../fui/Game/WXFUI_recordView";
import WXFUI_guanbiBtn from "../../fui/Game/WXFUI_guanbiBtn";


export default class RecordView extends PopUpView {

    public view: WXFUI_recordView;

    constructor() { super() }

    createView(): void {
        this.view = WXFUI_recordView.createInstance();
    }
    public showView(s, c): void {
        super.showView(s, c);
        this.view.m_guanbi.visible = false;
        this.view.m_guanbi.onClick(this, this.closeHandle);
        Laya.timer.once(3000, this, this.showCloseBtn);
        this.view.onClick(this, this.recordHandle);
    }

    private showCloseBtn(): void {
        this.view.m_guanbi.visible = true;
    }

    private recordHandle(e: any): void {
        var s: Laya.Sprite = e.target["$owner"];
        if (!s) {
            MooSnowSDK.shareRecord();
            return;
        }
        if (s instanceof WXFUI_guanbiBtn) {
            this.closeHandle();
        } else
            MooSnowSDK.shareRecord();
    }

    private closeHandle(): void {
        ViewManager.instance.hidePopUpView(this, false);
        ViewManager.instance.showResultView();
    }

    public hideAllView(): void {
        super.hideAllView();
        this.view.m_guanbi.offClick(this, this.closeHandle);
    }

}