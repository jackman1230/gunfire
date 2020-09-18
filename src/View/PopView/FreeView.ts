import PopUpView from "../PopUpView";
import { GameManager } from "../../Manager/GameManager";
import { SoundManager } from "../../Manager/SoundManager";
import { ViewManager } from "../../Manager/ViewManager";
import { MooSnowSDK } from "../../Manager/MooSnowSDK";
import WXFUI_freeView from "../../fui/Game/WXFUI_freeView";
import { VideoType, VideoInfo, VideoData } from "../../Data/VideoData";


export default class FreeView extends PopUpView {

    public view: WXFUI_freeView;


    private _checkBoxMistouch: boolean = false;
    private _clickCount: number = 0;
    private _misTouchIndex: number;
    private _randomList: number[] = [];
    private _isFirst: boolean = true;

    constructor() { super() }

    createView(): void {
        this.view = WXFUI_freeView.createInstance();
        var sdkData: any = MooSnowSDK.getAllConfig();
        if (sdkData && sdkData.checkBoxMistouch != "0") {
            this._checkBoxMistouch = true;
            this._randomList = MooSnowSDK.getAllConfig().checkBoxProbabilitys;
        }


    }
    public showView(s, c): void {
        super.showView(s, c);
        this.updateView();
    }


    public updateView(): void {
        this.view.m_ctl.selectedIndex = 0;
        this._clickCount = 0;
        if (this._checkBoxMistouch)
            this.getRandomMisTouchIndex();
        this._isFirst = true;
        this.view.m_gou.selected = true;
        this.view.m_cha.visible = false;

        this.view.m_lingqu.onClick(this, this.lingquHandle)
        this.view.m_gou.onClick(this, this.gouHandle);
        this.view.m_fangqi.onClick(this, this.fangqiHandle);
        this.view.m_cha.onClick(this, this.closeHandle);
    }

    private showFangQiBtn(): void {
        Laya.timer.clear(this, this.showCloseBtn);
        this.view.m_ctl.selectedIndex = 1;
        Laya.timer.once(3000, this, this.showCloseBtn);
    }

    private showLingQuBtn(): void {
        this.view.m_ctl.selectedIndex = 0;
        Laya.timer.clear(this, this.showCloseBtn);
    }

    private showCloseBtn(): void {
        this.view.m_cha.visible = true;
    }
    private gouHandle(): void {
        // console.log("m_gou.selected--", this.view.m_gou.selected);

        if (this._checkBoxMistouch) {
            if (this._clickCount == this._misTouchIndex) {
                this.watchVideo();
            } else {
                if (!this.view.m_gou.selected) {
                    this.showFangQiBtn();
                } else {
                    this.showLingQuBtn();
                }
            }
            this._clickCount++;
        } else {
            if (!this.view.m_gou.selected) {
                this.showFangQiBtn();
            } else {
                this.showLingQuBtn();
            }
        }
    }

    private lingquHandle(): void {
        this.watchVideo();
    }

    private closeHandle(): void {
        this.enterGame();
    }

    private fangqiHandle(): void {
        if (MooSnowSDK.misTouchNum == 0) {//没有误触，直接开箱
            this.enterGame();
        } else if (MooSnowSDK.misTouchNum > 0) {
            GameManager.instance.misTouchNum++;
            if (GameManager.instance.misTouchNum >= MooSnowSDK.misTouchNum) {
                GameManager.instance.misTouchNum = 0;
                this.watchVideo();
            } else {
                // this.enterGame();
            }
        }
    }

    private enterGame(): void {
        Laya.timer.clear(this, this.showCloseBtn);
        SoundManager.instance.playSound("btn_click");
        ViewManager.instance.hidePopUpView(this, true);
        GameManager.instance.enterGame();
    }

    private watchVideo(): void {
        if (!this.view.m_gou.selected) {
            this.showFangQiBtn();
        } else {
            this.showLingQuBtn();
        }
        Laya.timer.clear(this, this.showCloseBtn);
        var d = GameManager.instance.levelData.shop["item_4"];
        var v: VideoData = GameManager.instance.createVideoData(VideoType.VIDEOTYPE_ITEM, VideoInfo.VIDEOINFO_ITEM);
        MooSnowSDK.showVideo(d, v, this.enterGame.bind(this), null, null, this.timeShowCloseBtn.bind(this));
    }

    private timeShowCloseBtn(): void {
        console.log("timeShowCloseBtn-");
        Laya.timer.clear(this, this.showCloseBtn);
        if (!this.view.m_gou.selected)
            Laya.timer.once(3000, this, this.showCloseBtn);
    }


    public hideAllView(): void {
        super.hideAllView();
        Laya.timer.clear(this, this.showCloseBtn);
        this.view.m_lingqu.offClick(this, this.lingquHandle)
        this.view.m_gou.offClick(this, this.gouHandle);
        this.view.m_fangqi.offClick(this, this.fangqiHandle);
        this.view.m_cha.offClick(this, this.closeHandle);
    }

    private getRandomMisTouchIndex() {
        var arr: number[] = [];
        var idx: number = 0;
        for (var i = 0; i < this._randomList.length; i++) {
            var num = this._randomList[i];
            for (var j = 0; j < num; j++)
                arr.push(idx);
            idx++;
        }
        if (arr.length > 0)
            this._misTouchIndex = arr[Math.floor(Math.random() * arr.length)];
        else
            this._misTouchIndex = 1000000;
    }
}