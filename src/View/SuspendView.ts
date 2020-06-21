
import WXFUI_SuspendView from "../fui/Game/WXFUI_SuspendView";
import { GameManager } from "../Manager/GameManager";
import PopUpView from "./PopUpView";
import { SoundManager } from "../Manager/SoundManager";

export default class SuspendView extends PopUpView {

    public view: WXFUI_SuspendView;

    constructor() { super() }

    createView(): void {
        this.view = WXFUI_SuspendView.createInstance();

        this.view.m_back.onClick(this, this.goFirstPage);
    }

    private goFirstPage(): void {
        SoundManager.instance.playSound("btn_click");
        GameManager.instance.goFirstPage();
    }

}