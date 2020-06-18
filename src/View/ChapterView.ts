import WXFUI_ChapterView from "../fui/Game/WXFUI_ChapterView";
import { GameManager } from "../Manager/GameManager";
import PopUpView from "./PopUpView";
import { ViewManager } from "../Manager/ViewManager";

export default class ChapterView extends PopUpView {

    public view: WXFUI_ChapterView;
    constructor() { super() }

    createView(): void {
        this.view = WXFUI_ChapterView.createInstance();
        this.view.m_title.url = "ui://Game/chapter_1";
        // this.view = fairygui.UIPackage.createObject("Game", "ChapterView") as WXFUI_ChapterView;
        for (let t = 1; t <= GameManager.instance.maxLevel; t++) {
            // this.view["m_level_" + t].onClick(this, this.chooseLevel, [t]);
            // this.view["m_level_" + t].offClick(this, this.chooseLevel);
            this.view["m_level_" + t].on(Laya.Event.CLICK, this, this.chooseLevel, [t]);
            // this.view.m_level_8.on(Laya.Event.CLICK, this, this.chooseLevel);
            // this.view.m_level_8.m_ctl.selectedIndex = 2
        }
        this.updateView();
    }

    public updateView(): void {
        this.view.m_last.visible = GameManager.instance.curChapter <= 1 ? false : true;
        this.view.m_next.visible = GameManager.instance.curChapter >= GameManager.instance.maxChapter ? false : true;

        for (let i = 1; i <= GameManager.instance.maxLevel; i++) {
            if (i < GameManager.instance.gotoMaxLevel) {
                this.view["m_level_" + i].m_ctl.selectedIndex = 1;
            } else if (i == GameManager.instance.gotoMaxLevel) {
                this.view["m_level_" + i].m_ctl.selectedIndex = 2;
            } else
                this.view["m_level_" + i].m_ctl.selectedIndex = 0;

        }
    }
    /**选择关卡 */

    public chooseLevel(l: number): void {
        console.log("选择第" + GameManager.instance.curChapter + "章，" + "第" + l + "关");
        if (l > GameManager.instance.gotoMaxLevel) return;//所点击的关卡超过所通过的最大关卡
        GameManager.instance.choiseLevel = l;
        ViewManager.instance.showBeforeWarView();


    }
}