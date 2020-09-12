import PopUpView from "../PopUpView";
import WXFUI_AfterWar from "../../fui/Game/WXFUI_AfterWar";
import { SoundManager } from "../../Manager/SoundManager";
import { GameManager } from "../../Manager/GameManager";
import WXFUI_ADItem from "../../fui/Game/WXFUI_ADItem";
import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";
import { MooSnowSDK } from "../../Manager/MooSnowSDK";
import { ViewManager } from "../../Manager/ViewManager";
import { VideoData, VideoType, VideoInfo } from "../../Data/VideoData";



export default class AfterWar extends PopUpView {

    public view: WXFUI_AfterWar;
    private viewType: number = 1;

    private hotNum: number = 6;
    private adList: any[] = [];

    private _checkBoxMistouch: boolean = false;
    private _clickCount: number = 0;
    private _misTouchIndex: number;
    private _randomList: number[] = [];
    constructor() { super() }

    createView(): void {
        this.view = WXFUI_AfterWar.createInstance();

        this.view.m_coin.text = " 0";

        this.view.m_ad_1.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem1, null, false);
        this.view.m_ad_2.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem2, null, false);


        EventManager.instance.addNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);

        this.view.m_adHot.m_jixu.onClick(this, this.hideADHot);

        var sdkData: any = MooSnowSDK.getAllConfig();
        if (sdkData && sdkData.checkBoxMistouch != "0") {
            this._checkBoxMistouch = true;
            this._randomList = MooSnowSDK.getAllConfig().checkBoxProbabilitys;
        }

    }

    private clickHotAdItem(n: number): void {
        var m: moosnowAdRow = this.view.m_adHot["m_ad_" + n].data as moosnowAdRow;
        if (!m) return;
        console.log("ad--", m);
        moosnow.platform.navigate2Mini(m, (res) => {
            console.log('跳转成功 ', res)
        }, (res) => {
            console.log('跳转失败 ', res)
            // ViewManager.instance.showADListView();
            this.changeAdItem(n);
        });

    }

    private changeAdItem(n: number): void {
        var d: any = this.getRandomAdItem();
        if (!d) return;
        this.view.m_adHot["m_ad_" + n].data = d;
        this.view.m_adHot["m_ad_" + n].m_icon.url = d.img;
        this.view.m_adHot["m_ad_" + n].m_name.text = d.title;
    }

    private hideADHot(): void {
        // this.view.m_adHot.visible = false;
        MooSnowSDK.hideBanner();
        ViewManager.instance.showADListView(1);
    }

    public showView(s, c): void {
        super.showView(s, c);
        this.view.m_continue_1.onClick(this, this.continueGame);
        this.view.m_continue_2.onClick(this, this.restartGame);
        this.view.m_continue_3.onClick(this, this.continueGameByVideo);
        this.view.m_return.onClick(this, this.returnHandle);
        this.view.m_abandon.onClick(this, this.abandonHandle);
        this.view.m_nextBtn.onClick(this, this.onNextHandle);
        this.view.m_gou.onClick(this, this.gouHandle);
        this.view.m_ad_1.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
        this.view.m_ad_2.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);

        this.view.m_ad_1.m_list.y = 0;
        this.view.m_adHot.visible = false;
        if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
            this.showADList();
            MooSnowSDK.showBanner(false);
            this.view.m_ad_1.visible = this.view.m_ad_2.visible = true;
        }
        if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
            MooSnowSDK.hideBanner();
            this.view.m_ad_1.visible = this.view.m_ad_2.visible = false;
            EventManager.instance.addNotice(GameEvent.CLOSE_APP_AD_BOX, this, this.closeAppBox);
        }
        if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE) {
            MooSnowSDK.hideBanner();
            this.view.m_ad_1.visible = this.view.m_ad_2.visible = false;
            this.view.m_gou.selected = true;
        }
    }

    private closeAppBox(): void {
        MooSnowSDK.showBanner(false);
    }

    private showHotAdList(): void {
        for (let i = 1; i <= 6; i++) {
            var d: any = this.getRandomAdItem();
            if (!d) continue;
            this.view.m_adHot["m_ad_" + i].data = d;
            this.view.m_adHot["m_ad_" + i].m_icon.url = d.img;
            this.view.m_adHot["m_ad_" + i].m_name.text = d.title;
            this.view.m_adHot["m_ad_" + i].onClick(this, this.clickHotAdItem, [i]);
        }
    }
    /**
     * 显示关卡战斗之后界面
     * @param type 1胜利界面，2失败界面，3放弃界面
     */
    public updateView(type: number): void {
        this.viewType = type;
        this.updateCoin();
        if (type == 3) {
            this.view.m_abandon.visible = false;
            Laya.timer.once(2000, this, this.showAbondon);
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX)
                ViewManager.instance.showADListView();
        } else if (type == 1) {
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
                this.view.m_adHot.visible = true;
                this.adList = GameManager.instance.adList.concat();
                this.showHotAdList();
            }
            if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE) {
                this.view.m_ctl.selectedIndex = 3;
                this._clickCount = 0;
                if (this._checkBoxMistouch)
                    this.getRandomMisTouchIndex();
            }
        }


    }

    private showAbondon(): void {
        this.view.m_abandon.visible = true;
    }

    private updateCoin(): void {
        this.view.m_coin.text = " " + GameManager.instance.roleInfo.curlvCoin + " ";
    }
    private continueGame(): void {
        SoundManager.instance.playSound("btn_click");
        // ViewManager.instance.showChapterView();
        GameManager.instance.goFirstPage();
        MooSnowSDK.endGame(GameManager.instance.choiseLevel, true);
    }

    private restartGame(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.restartGame();
    }

    private continueGameByVideo(): void {
        SoundManager.instance.playSound("btn_click");
        // this.restartGame();
        var v: VideoData = GameManager.instance.createVideoData(VideoType.VIDEOTYPE_LIFE, VideoInfo.VIDEOINFO_LIFE);
        MooSnowSDK.showVideo(null, v);
    }

    private abandonHandle(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.goFirstPage();
        MooSnowSDK.endGame(GameManager.instance.choiseLevel, false);
    }

    private onNextHandle(): void {
        if (this.view.m_gou.selected) {
            this.watchVideo();
        } else {
            this.continueGame();
        }
    }

    private gouHandle(): void {
        if (this._checkBoxMistouch) {
            if (this._clickCount == this._misTouchIndex) {
                this.watchVideo();
            }
            this._clickCount++;
        }
    }

    private watchVideo(): void {
        var v: VideoData = GameManager.instance.createVideoData(VideoType.VIDEOTYPE_DOUBLE_COIN, VideoInfo.VIDEOINFO_DOUBLE_COIN);
        MooSnowSDK.showVideo(null, v);
    }

    private returnHandle(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.goFirstPage();
    }

    private _tweenNum: Laya.Tween;
    private showADList(): void {
        if (GameManager.instance.adList.length < 1) return;
        if (GameManager.instance.platform != moosnow.APP_PLATFORM.WX) return
        EventManager.instance.offNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);
        Laya.Tween.clearTween(this.view.m_ad_1.m_list);
        this.view.m_ad_1.m_list.numItems = GameManager.instance.adList.length;
        this.view.m_ad_2.m_list.numItems = GameManager.instance.adListRever.length;
        this.view.m_ad_1.m_list.height = this.view.m_ad_2.m_list.height = 311 * GameManager.instance.adList.length + 2;
        this.adMoveUp();
    }

    private onClickItem(e: WXFUI_ADItem): void {
        var m: moosnowAdRow = e.data as moosnowAdRow;
        console.log("ad--", m);
        moosnow.platform.navigate2Mini(m, (res) => {
            console.log('跳转成功 ', res)
        }, (res) => {
            console.log('跳转失败 ', res)
            ViewManager.instance.showADListView();
        });
    }

    private setADItem1(index: number, item: WXFUI_ADItem): void {
        var d: any = GameManager.instance.adList[index];
        if (!d) return;
        item.data = d;
        item.m_icon.url = d.img;
        item.m_name.text = d.title;
    }
    private setADItem2(index: number, item: WXFUI_ADItem): void {
        var d: any = GameManager.instance.adListRever[index];
        if (!d) return;
        item.data = d;
        item.m_icon.url = d.img;
        item.m_name.text = d.title;
    }

    private adMoveDown(): void {
        this._tweenNum = Laya.Tween.to(this.view.m_ad_1.m_list, { y: 0 }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveUp));
        this._tweenNum.update = Laya.Handler.create(this, this.updateTween, null, false);

    }

    private adMoveUp(): void {
        this._tweenNum = Laya.Tween.to(this.view.m_ad_1.m_list, { y: this.view.m_ad_1.height - 311 * GameManager.instance.adList.length }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveDown));
        this._tweenNum.update = Laya.Handler.create(this, this.updateTween, null, false);

    }

    private updateTween(): void {
        // console.log("updateTween--", this.view.m_ad_1.m_list.y);
        this.view.m_ad_2.m_list.y = this.view.m_ad_1.m_list.y;
    }

    public hideAllView(): void {
        super.hideAllView();
        this.view.m_continue_1.offClick(this, this.continueGame);
        this.view.m_continue_2.offClick(this, this.restartGame);
        this.view.m_continue_3.offClick(this, this.continueGameByVideo);
        this.view.m_return.offClick(this, this.returnHandle);
        this.view.m_abandon.offClick(this, this.abandonHandle);
        this.view.m_nextBtn.offClick(this, this.onNextHandle);
        this.view.m_gou.offClick(this, this.gouHandle);
        this.view.m_ad_1.m_list.off(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
        this.view.m_ad_2.m_list.off(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
        Laya.Tween.clearTween(this.view.m_ad_1.m_list);
        if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
            MooSnowSDK.hideBanner();
        }
        for (let i = 1; i <= 6; i++) {
            this.view.m_adHot["m_ad_" + i].offClick(this, this.clickHotAdItem, [i]);
        }
        EventManager.instance.offNotice(GameEvent.CLOSE_APP_AD_BOX, this, this.closeAppBox);
    }

    private getRandomAdItem(): any {
        if (this.adList.length > 0) {
        } else {
            this.adList = GameManager.instance.adList.concat();
        }
        var n: number = Math.floor(Math.random() * this.adList.length);
        var d: any = this.adList.splice(n, 1)[0];
        console.log("d---", d);
        return d;
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