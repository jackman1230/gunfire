
import WXFUI_AfterWar from "../fui/Game/WXFUI_AfterWar";
import PopUpView from "./PopUpView";

export default class AfterWar extends PopUpView {

    public view: WXFUI_AfterWar;
    constructor() { super() }

    createView(): void {
        this.view = WXFUI_AfterWar.createInstance();

        this.view.m_continue_1.onClick(this, this.continueGame);
        this.view.m_continue_2.onClick(this, this.restartGame);
        this.view.m_continue_3.onClick(this, this.continueGameByVideo);

    }
    private continueGame(): void {

    }

    private restartGame(): void {

    }

    private continueGameByVideo(): void {

    }
}