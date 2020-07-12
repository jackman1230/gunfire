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
        // var w: number = ViewManager.instance.getProportion();
        if (Laya.Browser.onWeiXin) {
            let wxInfo = wx.getSystemInfoSync();
            var h: number = (wxInfo.windowHeight / 750) * 1334;//游戏所展示的宽度
            this.view.x = 930 * (wxInfo.windowWidth / h);
            this.view.y = 375;
        } else {
            var h: number = (Laya.Browser.height / 750) * 1334;//游戏所展示的宽度
            this.view.x = 930 * (Laya.Browser.width / h);
            this.view.y = 375;
        }

    }

}