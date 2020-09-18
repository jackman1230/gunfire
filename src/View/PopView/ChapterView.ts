import PopUpView from "../PopUpView";
import WXFUI_ChapterView from "../../fui/Game/WXFUI_ChapterView";
import { GameManager } from "../../Manager/GameManager";
import GameEvent from "../../Control/GameEvent";
import { EventManager } from "../../Manager/EventManager";
import { SoundManager } from "../../Manager/SoundManager";
import { ViewManager } from "../../Manager/ViewManager";
import WXFUI_ADItem from "../../fui/Game/WXFUI_ADItem";
import { MooSnowSDK } from "../../Manager/MooSnowSDK";


export default class ChapterView extends PopUpView {

    public view: WXFUI_ChapterView;
    private showSet: boolean = true;
    private showVolume: boolean = true;
    constructor() { super() }

    createView(): void {
        this.view = WXFUI_ChapterView.createInstance();
        this.view.m_title.url = "ui://Game/chapter_1";
        for (let t = 1; t <= GameManager.instance.maxLevel; t++) {
            this.view["m_level_" + t].on(Laya.Event.CLICK, this, this.chooseLevel, [t]);
        }

        // this.view.m_set.onClick(this, this.showSetView);
        this.view.m_setView.onClick(this, this.setVolume);
        this.view.m_last.onClick(this, this.lastHandle);
        this.view.m_next.onClick(this, this.nextHandle);

        // this.view.m_bg.setScale(1.2, 1.2);

        this.updateView();
        EventManager.instance.addNotice(GameEvent.PAUSE_GAME, this, this.pauseGame);

        if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
            this.view.m_ctl.selectedIndex = 1;
            this.view.m_ad_remen2.onClick(this, this.showReMenAD2);
            this.view.m_ad_remen2.m_ani_2.play(null, -1);
            MooSnowSDK.showBanner(false);
        } else if (GameManager.instance.platform == moosnow.APP_PLATFORM.WX) {
            this.view.m_ctl.selectedIndex = 0;
            this.view.m_ad_1.onClick(this, this.onClickADItem, [1]);
            this.view.m_ad_2.onClick(this, this.onClickADItem, [2]);
            this.view.m_ad_3.onClick(this, this.onClickADItem, [3]);
            this.view.m_ad_remen.onClick(this, this.showReMenAD);
            this.view.m_ad.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem, null, false);
            this.view.m_ad.m_list.width = 240 * GameManager.instance.adList.length;
            this.view.m_ad.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
            EventManager.instance.addNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);
            this.view.m_ad.m_n4.width = 1310;
        } else if (GameManager.instance.platform == moosnow.APP_PLATFORM.BYTEDANCE) {
            this.view.m_ctl.selectedIndex = 1;
            this.view.m_ad_remen2.visible = false;
            MooSnowSDK.hideBanner();
        }else if (GameManager.instance.platform == moosnow.APP_PLATFORM.VIVO) {
            this.view.m_ctl.selectedIndex = 1;
            this.view.m_ad_remen2.visible = false;
            MooSnowSDK.showBanner(false);
        }
    }

    public showView(s, c): void {
        super.showView(s, c);
        this.view.m_ad.m_list.x = 0;
        this.showADList();
        if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
            MooSnowSDK.showBanner(false);
        }
    }

    public updateView(): void {
        var c: number = GameManager.instance.curChapter;
        this.view.m_title.url = "ui://Game/chapter_" + c;

        for (let i = 1; i <= GameManager.instance.maxLevel; i++) {
            var index: number = i + (c - 1) * GameManager.instance.maxLevel;
            this.view["m_level_" + i].m_star.m_ctl.selectedIndex = 0;
            this.view["m_level_" + i].m_numF.text = (i + (GameManager.instance.curChapter - 1) * GameManager.instance.maxLevel) + "";
            if (index < GameManager.instance.gotoMaxLevel) {
                this.view["m_level_" + i].m_ctl.selectedIndex = 1;
                this.view["m_level_" + i].m_star.m_ctl.selectedIndex = 3;
            } else if (index == GameManager.instance.gotoMaxLevel) {
                this.view["m_level_" + i].m_ctl.selectedIndex = 2;
                this.view["m_level_" + i].m_star.m_ctl.selectedIndex = 1;
            } else {
                this.view["m_level_" + i].m_ctl.selectedIndex = 0;
                this.view["m_level_" + i].m_star.m_ctl.selectedIndex = 0;
            }
        }

        if (GameManager.instance.platform == moosnow.APP_PLATFORM.QQ) {
            this.view.m_ad_remen2.m_ani_2.play(null, -1);
        }
    }
    /**选择关卡 */

    public chooseLevel(l: number): void {
        SoundManager.instance.playSound("btn_click");
        console.log("选择第" + GameManager.instance.curChapter + "章，" + "第" + l + "关");
        if (l + (GameManager.instance.curChapter - 1) * GameManager.instance.maxLevel > GameManager.instance.gotoMaxLevel) return;//所点击的关卡超过所通过的最大关卡
        GameManager.instance.choiseLevel = l + (GameManager.instance.curChapter - 1) * GameManager.instance.maxLevel;
        console.log("选择第" + GameManager.instance.choiseLevel + "关");
        ViewManager.instance.showBeforeWarView();
    }

    private setVolume(): void {
        SoundManager.instance.playSound("btn_click");
        this.showVolume = !this.showVolume;
        if (this.showVolume) {
            this.view.m_setView.m_ctl.selectedIndex = 0;
            SoundManager.instance.openSound();
        } else {
            this.view.m_setView.m_ctl.selectedIndex = 1;
            SoundManager.instance.offSound();
        }
    }

    private lastHandle(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.curChapter--;
        if (GameManager.instance.curChapter < 1) {
            GameManager.instance.curChapter = GameManager.instance.maxChapter;
        }
        this.updateView();
    }

    private nextHandle(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.curChapter++;
        if (GameManager.instance.curChapter > GameManager.instance.maxChapter) {
            GameManager.instance.curChapter = 1;
        }
        this.updateView();
    }

    private showReMenAD(): void {
        SoundManager.instance.playSound("btn_click");
        ViewManager.instance.showADListView();
    }

    private showReMenAD2(): void {
        SoundManager.instance.playSound("btn_click");
        console.log("showReMenAD2");
        MooSnowSDK.showQQADBox();
    }

    private showADList(): void {
        if (GameManager.instance.adList.length < 1) return;
        if (GameManager.instance.platform != moosnow.APP_PLATFORM.WX) return;
        EventManager.instance.offNotice(GameEvent.SHOW_AD_LIST, this, this.showADList);
        this.view.m_ad.m_list.width = 240 * GameManager.instance.adList.length;
        this.view.m_ad.m_list.numItems = GameManager.instance.adList.length;
        Laya.Tween.clearTween(this.view.m_ad.m_list);
        Laya.timer.clear(this, this.changeAD);
        this.adMoveLeft();
        this.view.m_ad_1.m_ani_1.play(null, -1);
        this.view.m_ad_2.m_ani_1.play(null, -1);
        this.view.m_ad_3.m_ani_1.play(null, -1);
        this.view.m_ad_remen.m_ani.play(null, -1);
        this.changeAD();
        Laya.timer.loop(3000, this, this.changeAD);
    }

    private changeAD(): void {
        this.view.m_ad_1.data = this.getRandomAdData();
        this.view.m_ad_2.data = this.getRandomAdData();
        this.view.m_ad_3.data = this.getRandomAdData();

        this.view.m_ad_3.m_ad.m_icon.url = this.view.m_ad_3.data["img"];
        this.view.m_ad_3.m_ad.m_name.text = this.view.m_ad_3.data["title"];

        this.view.m_ad_2.m_ad.m_icon.url = this.view.m_ad_2.data["img"];
        this.view.m_ad_2.m_ad.m_name.text = this.view.m_ad_2.data["title"];

        this.view.m_ad_1.m_ad.m_icon.url = this.view.m_ad_1.data["img"];
        this.view.m_ad_1.m_ad.m_name.text = this.view.m_ad_1.data["title"];
    }

    private setADItem(index: number, item: WXFUI_ADItem): void {
        var d: any = GameManager.instance.adList[index];
        if (!d) return;
        item.data = d;
        item.m_icon.url = d.img;
        item.m_name.text = d.title;
    }


    private onClickADItem(index: number): void {
        var m: moosnowAdRow = this.view["m_ad_" + index].data as moosnowAdRow;
        if (!m) return;
        console.log("onClickADItem--", m);
        moosnow.platform.navigate2Mini(m, (res) => {
            console.log('跳转成功 ', res)
        }, (res) => {
            console.log('跳转失败 ', res)
            ViewManager.instance.showADListView();
        });
    }

    private onClickItem(e: WXFUI_ADItem): void {
        var m: moosnowAdRow = e.data as moosnowAdRow;
        console.log("ad--", m);
        if (!m) return;

        moosnow.platform.navigate2Mini(m, (res) => {
            console.log('跳转成功 ', res)
        }, (res) => {
            console.log('跳转失败 ', res)
            ViewManager.instance.showADListView();
        });
    }

    private adMoveLeft(): void {
        Laya.Tween.to(this.view.m_ad.m_list, { x: this.view.m_ad.width - 240 * GameManager.instance.adList.length }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveRight));

    }

    private adMoveRight(): void {
        Laya.Tween.to(this.view.m_ad.m_list, { x: 0 }, GameManager.instance.adTime, null, Laya.Handler.create(this, this.adMoveLeft));
    }

    private pauseGame(): void {
        if (GameManager.instance.isPauseGame) {
            this.hideADList();
        } else {
            this.showADList();
        }
    }

    private hideADList(): void {
        this.view.m_ad_1.m_ani_1.stop(null);
        this.view.m_ad_2.m_ani_1.stop(null);
        this.view.m_ad_3.m_ani_1.stop(null);
        this.view.m_ad_remen.m_ani.stop(null);
        Laya.Tween.clearTween(this.view.m_ad.m_list);
        Laya.timer.clear(this, this.changeAD);
    }

    public hideAllView(): void {
        super.hideAllView();
        this.hideADList();
    }

    private getRandomAdData(): any {
        var r: number = Math.floor(Math.random() * GameManager.instance.adList.length);
        return GameManager.instance.adList[r];
    }
}