import WXFUI_PlayerCtlView from "../fui/Game/WXFUI_PlayerCtlView";
import { ViewManager } from "../Manager/ViewManager";

export default class PlayerCtlView {

    public view: WXFUI_PlayerCtlView;


    constructor() { this.createView() }

    createView(): void {
        this.view = fairygui.UIPackage.createObject("Game", "PlayerCtlView") as WXFUI_PlayerCtlView;
        this.layout();
    }

    private layout(): void {
        var w: number = ViewManager.instance.getLayoutWidth();
        this.view.x = w;
    }

}