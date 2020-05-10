import { BackGroundView } from "../View/BackGroundView";
import { WarView } from "../View/WarView";
import WXFUI_Player from "../fui/Game/WXFUI_Player";
import Player from "../View/Player";
import Enemy from "../View/Enemy";

export class ViewManager {

    private static _instance: ViewManager;


    // private bgView: BackGroundView;
    public warView: WarView;
    private player: Player;
    private enemy: Enemy;

    constructor() {

    }
    public static get instance(): ViewManager {
        if (this._instance == null)
            this._instance = new ViewManager();
        return this._instance;
    }

    public showStartView(): void {
        this.initView();

        // Laya.stage.addChild(this.bgView.view.displayObject);
        Laya.stage.addChild(this.warView.warView.displayObject);
        this.warView.warView.addChild(this.player.rolePlayer);
        this.player.rolePlayer.x = 200;
        this.player.rolePlayer.y = 400;
        // this.player.setStay();
        console.log("开始初始化界面");

        Laya.stage.addChild(this.enemy.enemy.displayObject);
        this.enemy.enemy.x = 800;
        this.enemy.enemy.y = 400;
        this.enemy.setFire();
    }

    public initView(): void {
        // this.bgView = new BackGroundView();
        this.warView = new WarView();
        this.player = new Player();
        this.enemy = new Enemy();

        // this.bgView.initView();
        this.warView.initView();
        this.player.initView();
        this.enemy.initView();
    }

    public getRolePlayer(): Player {
        return this.player;

    }

    public updateViewPort(moveX: number): void {
        // this.bgView.updateViewPort(moveX);
        this.warView.updateViewPort(moveX);
    }

}