
import WXFUI_BackGround from "../fui/Game/WXFUI_BackGround";
import { ViewManager } from "../Manager/ViewManager";
import Player from "./Player";
import WXFUI_Player from "../fui/Game/WXFUI_Player";

export class BackGroundView {

    public view: WXFUI_BackGround;

    private bg: fairygui.GLoader;

    private tMap: Laya.TiledMap;

    private warWidth: number = 4900;
    private warHeight: number = 784;

    constructor() { }

    public initView() {
        this.view = fairygui.UIPackage.createObject("Game", "BackGround") as WXFUI_BackGround;
        this.bg = this.view.getChildAt(0) as fairygui.GLoader;
        this.bg.url = "res/map_1.jpg";
        this.view.setScale(3.5, 3.5);



        //创建TiledMap实例
        // this.tMap = new Laya.TiledMap();
        //创建Rectangle实例，视口区域
        // var viewRect: Laya.Rectangle = new Laya.Rectangle();
        //创建TiledMap地图
        // this.tMap.createMap("res/tiledMap/test2.json", viewRect, Laya.Handler.create(this, this.showMap));

    };

    private showMap(): void {
        // this.tMap.scale = 4;

        // var player: Player = ViewManager.instance.getRolePlayer();
        // Laya.stage.addChild(player.rolePlayer.displayObject);
        // player.rolePlayer.x = 200;
        // player.rolePlayer.y = 400;

        // this.tMap.changeViewPortBySize()
        // player.setJump();

        // this.tMap.
        // var x: number = 1;
        // Laya.timer.loop(100, this, () => {
        //     x++;
        //     this.tMap.moveViewPort(x, 0);
        //     console.log(this.tMap.x + "    :--:   " + this.tMap.viewPortX);
        // })
    }

    public updateViewPort(moveX: number): void {
        var player: Player = ViewManager.instance.getRolePlayer();
        // if (player.rolePlayer.x > Laya.Browser.clientWidth / 2) {
        //     var moveX: number = (player.rolePlayer.x - Laya.Browser.clientWidth / 2);
        this.bg.x -= moveX / 2;
        // this.tMap.moveViewPort(moveX, 0);
        console.log("this.bg.x:" + this.bg.x + " ---: " + player.rolePlayer.x);
        // }
    }
}
