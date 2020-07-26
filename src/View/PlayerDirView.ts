import { ViewManager } from "../Manager/ViewManager";
import WXFUI_PlayerDirView from "../fui/Game/WXFUI_PlayerDirView";

export default class PlayerDirView {

    public view: WXFUI_PlayerDirView;


    constructor() { this.createView() }

    createView(): void {
        this.view = fairygui.UIPackage.createObject("Game", "PlayerDirView") as WXFUI_PlayerDirView;
        this.layout();
    }

    private layout(): void {
        // var p: number = ViewManager.instance.getProportion();
        // this.view.x = 300 * p;
        if (Laya.Browser.onWeiXin) {
            let wxInfo = wx.getSystemInfoSync();
            // var h: number = (wxInfo.windowHeight / 750) * 1334;//游戏所展示的宽度
            // this.view.x = 320 * (wxInfo.windowWidth / h);
            this.view.x = 300 * (Laya.stage.width / 1334);
            this.view.y = 720;
        } else {
            var h: number = (Laya.Browser.height / 750) * 1334;//游戏所展示的宽度
            this.view.x = 320 * (Laya.Browser.width / h);
            this.view.y = 720;
        }
    }

}