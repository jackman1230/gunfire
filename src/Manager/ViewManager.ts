import { BackGroundView } from "../View/BackGroundView";
import { WarView } from "../View/WarView";
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import Player from "../View/Player";

export class ViewManager {

    private static _instance: ViewManager;


    private bgView: BackGroundView;
    private warView: WarView;
    private player: Player;

    constructor() {

    }
    public static get instance(): ViewManager {
        if (this._instance == null)
            this._instance = new ViewManager();
        return this._instance;
    }

    public showStartView(): void {
        this.initView();

        Laya.stage.addChild(this.bgView.view.displayObject);
        this.bgView.view.addChild(this.player.rolePlayer);
        // this.bgView.view.m_bg.url="bin/res/map_1.jpg";
        this.player.rolePlayer.x = 200;
        this.player.rolePlayer.y = 400;
        this.player.setJump();
        console.log("开始初始化界面");

    }

    public initView(): void {
        this.bgView = new BackGroundView();
        this.warView = new WarView();
        this.player = new Player();

        this.bgView.initView();
        this.player.initView();
        this.warView.initView();
    }

    public getRolePlayer(): WXFUI_Player {
        if (this.player) {
            return this.player.rolePlayer;
        }
        return null;
    }



}