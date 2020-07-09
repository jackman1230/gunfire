import WXFUI_ChapterView from "../fui/Game/WXFUI_ChapterView";
import { GameManager } from "../Manager/GameManager";
import PopUpView from "./PopUpView";
import { ViewManager } from "../Manager/ViewManager";
import { SoundManager } from "../Manager/SoundManager";

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
            } else{
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
}