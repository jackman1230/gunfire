import PopUpView from "../PopUpView";
import { GameManager } from "../../Manager/GameManager";
import { ViewManager } from "../../Manager/ViewManager";
import { MooSnowSDK } from "../../Manager/MooSnowSDK";
import WXFUI_freeView from "../../fui/Game/WXFUI_freeView";
import WXFUI_noVideoTips from "../../fui/Game/WXFUI_noVideoTips";
import { VideoData, VideoType, VideoInfo } from "../../Data/VideoData";
import WXFUI_recordView from "../../fui/Game/WXFUI_recordView";
import WXFUI_guanbiBtn from "../../fui/Game/WXFUI_guanbiBtn";


export default class RecordView extends PopUpView {

    public view: WXFUI_recordView;

    private videoData: VideoData;
    private itemData: any;
    private successFun: Function;

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
            MooSnowSDK.startRecord();
            return;
        }
        if (s instanceof WXFUI_guanbiBtn) {
            this.closeHandle();
        } else
            MooSnowSDK.startRecord();
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