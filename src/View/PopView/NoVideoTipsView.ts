import PopUpView from "../PopUpView";
import { GameManager } from "../../Manager/GameManager";
import { SoundManager } from "../../Manager/SoundManager";
import { ViewManager } from "../../Manager/ViewManager";
import { MooSnowSDK } from "../../Manager/MooSnowSDK";
import WXFUI_freeView from "../../fui/Game/WXFUI_freeView";
import WXFUI_noVideoTips from "../../fui/Game/WXFUI_noVideoTips";
import { VideoData } from "../../Data/VideoData";


export default class NoVideoTipsView extends PopUpView {

    public view: WXFUI_noVideoTips;

    private videoData: VideoData;
    private itemData: any;
    private successFun: Function;
    private closeFun:Function;

    private timeOut: number = 0;

    constructor() { super() }

    createView(): void {
        this.view = WXFUI_noVideoTips.createInstance();
    }

    private showCloseBtn(): void {
        this.view.m_guanbi.visible = true;
    }

    public updateView(v: VideoData, item: any, successFun?: Function, closeFun?: Function): void {
        this.videoData = v;
        this.itemData = item;
        this.successFun = successFun;
        this.closeFun = closeFun;

        this.view.m_guanbi.visible = false;
        this.view.m_guanbi.onClick(this, this.closeHandle)
        this.view.m_queding.onClick(this, this.continueHandle);
        // Laya.timer.clear(this, this.showCloseBtn);
        // Laya.timer.once(3000, this, this.showCloseBtn);
        clearTimeout(this.timeOut);
        this.timeOut = setTimeout(() => {
            this.showCloseBtn();
        }, 3000);
    }

    private continueHandle(): void {
        if (!this.videoData) return;
        MooSnowSDK.showVideo(this.itemData, this.videoData, this.successFun);
    }

    private closeHandle(): void {
        if(this.closeFun){
            this.closeFun();
        }
        this.view.m_guanbi.offClick(this, this.closeHandle)
        this.view.m_queding.offClick(this, this.continueHandle);
        ViewManager.instance.hidePopUpView(this, false);
    }
}