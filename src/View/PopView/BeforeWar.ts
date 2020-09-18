import PopUpView from "../PopUpView";
import WXFUI_BeforeWar from "../../fui/Game/WXFUI_BeforeWar";
import { GameManager } from "../../Manager/GameManager";
import { SoundManager } from "../../Manager/SoundManager";
import { ViewManager } from "../../Manager/ViewManager";
import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";
import WXFUI_ADItem from "../../fui/Game/WXFUI_ADItem";
import { MooSnowSDK } from "../../Manager/MooSnowSDK";
import { VideoType, VideoInfo, VideoData } from "../../Data/VideoData";


export default class BeforeWar extends PopUpView {

    public view: WXFUI_BeforeWar;

    private shopData: any;

    constructor() { super() }

    createView(): void {
        this.view = WXFUI_BeforeWar.createInstance();

        this.view.m_enter.onClick(this, this.enterGame);
        this.shopData = GameManager.instance.levelData.shop;
        this.view.m_item_1.visible = this.view.m_item_2.visible = this.view.m_item_3.visible = this.view.m_item_4.visible = false;
        var index: number = 0;
        for (const key in this.shopData) {
            if (this.shopData.hasOwnProperty(key)) {
                index++;
                var d = this.shopData[key];
                this.view["m_item_" + index].m_ani.setAutoPlay(true, -1);
                this.view["m_item_" + index].visible = true;
                this.view["m_item_" + index].m_coin.text = d.coin + "";
                this.view["m_item_" + index].m_info.text = d.name;
                this.view["m_item_" + index].m_icon.url = "ui://Game/goods_" + d.type;
                this.view["m_item_" + index].m_buy.onClick(this, this.buyItem, [d]);
                this.view["m_item_" + index].m_free.onClick(this, this.buyItemByFree, [d]);
                // this.view.m_item_1.m_free.onClick(this, this.buyItem, [d]);
            }
        }

        if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
            this.view.m_ad.m_list.visible = false;
            // MooSnowSDK.showBanner(false);
        } else if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
            this.view.m_ad.m_list.visible = true;
            this.view.m_ad.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem, null, false);
            this.view.m_ad.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
            EventManager.instance.addNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);
        } else if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE) {
            this.view.m_ad.m_list.visible = false;
        } else if (GameManager.instance.platform == moosnow.APP_PLATFORM.VIVO || GameManager.instance.platform == moosnow.APP_PLATFORM.OPPO) {
            this.view.m_ad.m_list.visible = false;
        }



    }
    public showView(s, c): void {
        super.showView(s, c);
        this.view.m_ad.m_list.x = 0;
        this.showADList();
        this.updateView();
    }

    private buyItem(d: any): void {
        SoundManager.instance.playSound("btn_press");
        if (GameManager.instance.roleInfo.totalCoin < d.coin) {
            ViewManager.instance.showTipsView("金币不足！");
            return;
        } else {
            ViewManager.instance.showTipsView("金币-" + d.coin);
            GameManager.instance.roleInfo.totalCoin -= d.coin;
            GameManager.instance.buyShopItem(d);
            this.updateView();
        }
    }

    public updateView(): void {
        this.view.m_coin.text = GameManager.instance.roleInfo.totalCoin + "";
        this.view.m_bulletNum.text = GameManager.instance.buyBullet + "";
        this.view.m_bombNum.text = GameManager.instance.buyGre + "";
    }

    private buyItemByFree(d: any): void {
        SoundManager.instance.playSound("btn_press");
        var v: VideoData = GameManager.instance.createVideoData(VideoType.VIDEOTYPE_ITEM, VideoInfo.VIDEOINFO_ITEM);
        MooSnowSDK.showVideo(d, v);
    }

    private enterGame(): void {
        SoundManager.instance.playSound("btn_click");
        ViewManager.instance.hidePopUpView(this, true);
        if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
            if (MooSnowSDK.misTouchNum == 0) {//没有误触，直接进入游戏
                GameManager.instance.enterGame();
            } else if (MooSnowSDK.misTouchNum > 0) {
                GameManager.instance.misTouchNum++;
                if (GameManager.instance.misTouchNum >= MooSnowSDK.misTouchNum) {
                    GameManager.instance.misTouchNum = 0;
                    ViewManager.instance.showQQWuChuView(1);
                } else {
                    GameManager.instance.enterGame();
                }
            }
        } else if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
            GameManager.instance.enterGame();
        } else if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE) {
            GameManager.instance.enterGame();
        } else {
            GameManager.instance.enterGame();
        }
    }

    private showADList(): void {
        if (GameManager.instance.adList.length < 1) return;
        if (GameManager.instance.platform != moosnow.APP_PLATFORM.WX) return
        EventManager.instance.offNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);
        this.view.m_ad.m_list.width = 136 * GameManager.instance.adList.length;
        this.view.m_ad.m_list.numItems = GameManager.instance.adList.length;
        Laya.Tween.clearTween(this.view.m_ad.m_list);
        this.adMoveLeft();
    }

    private setADItem(index: number, item: WXFUI_ADItem): void {
        var d: any = GameManager.instance.adList[index];
        if (!d) return;
        item.data = d;
        item.m_icon.url = d.img;
        item.m_name.text = d.title;
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

    private adMoveLeft(): void {
        Laya.Tween.to(this.view.m_ad.m_list, { x: this.view.m_ad.width - 136 * GameManager.instance.adList.length }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveRight));
    }

    private adMoveRight(): void {
        Laya.Tween.to(this.view.m_ad.m_list, { x: 0 }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveLeft));
    }

    public hideAllView(): void {
        super.hideAllView();
        Laya.Tween.clearTween(this.view.m_ad.m_list);
    }





}