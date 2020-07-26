import WXFUI_ChapterView from "../fui/Game/WXFUI_ChapterView";
import { GameManager } from "../Manager/GameManager";
import PopUpView from "./PopUpView";
import { ViewManager } from "../Manager/ViewManager";
import { SoundManager } from "../Manager/SoundManager";
import WXFUI_ADItem from "../fui/Game/WXFUI_ADItem";

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

        this.showADList();
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
    }
    /**选择关卡 */

    public chooseLevel(l: number): void {
        SoundManager.instance.playSound("btn_click");
        console.log("选择第" + GameManager.instance.curChapter + "章，" + "第" + l + "关");
        if (l + (GameManager.instance.curChapter - 1) * GameManager.instance.maxLevel > GameManager.instance.gotoMaxLevel) return;//所点击的关卡超过所通过的最大关卡
        GameManager.instance.choiseLevel = l + (GameManager.instance.curChapter - 1) * GameManager.instance.maxLevel;
        ViewManager.instance.showBeforeWarView();
    }

    private setVolume(): void {
        SoundManager.instance.playSound("btn_click");
        this.showVolume = !this.showVolume;
        if (this.showVolume) {
            this.view.m_setView.m_ctl.selectedIndex = 0;
        } else {
            this.view.m_setView.m_ctl.selectedIndex = 1;
        }
        SoundManager.instance.offSound();
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

    private showADList(): void {
        this.view.m_ad.m_list.itemRenderer = Laya.Handler.create(this, this.setADItem, null, false);
        this.view.m_ad.m_list.numItems = 10;
        this.view.m_ad.m_list.width = 135 * 10;
        this.view.m_ad.m_list.on(fairygui.Events.CLICK_ITEM, this, this.onClickItem);
        this.adMoveLeft();


        this.view.m_ad_1.m_ani_1.play(null, -1);
        this.view.m_ad_2.m_ani_1.play(null, -1);
        this.view.m_ad_3.m_ani_1.play(null, -1);
        this.view.m_ad_remen.m_ani_2.play(null, -1);
    }

    private setADItem(index: number, item: WXFUI_ADItem): void {

    }

    private onClickItem(e: WXFUI_ADItem): void {
        console.log(this.view.m_ad.m_list.getChildIndex(e));

    }

    private adMoveLeft(): void {
        Laya.Tween.to(this.view.m_ad.m_list, { x: this.view.m_ad.width - 135 * 10 }, 5000, null, Laya.Handler.create(this, this.adMoveRight));

    }

    private adMoveRight(): void {
        Laya.Tween.to(this.view.m_ad.m_list, { x: 0 }, 5000, null, Laya.Handler.create(this, this.adMoveLeft));
    }
}