import WXFUI_WarView from "../fui/Game/WXFUI_WarView";

export class WarView {

    public warView: WXFUI_WarView;
    private bg: fairygui.GLoader;
    private img: fairygui.GImage;


    constructor() { }
    public initView() {
        this.warView = fairygui.UIPackage.createObject("Game", "WarView") as WXFUI_WarView;
        this.bg = this.warView.getChildAt(0) as fairygui.GLoader;
        this.bg.url = "res/map_1.jpg";
        this.bg.setScale(3.5, 3.5);

        this.img = this.warView.getChildAt(1) as fairygui.GImage;
    };

    public updateViewPort(moveX: number): void {
        // var player: Player = ViewManager.instance.getRolePlayer();
        // if (player.rolePlayer.x > Laya.Browser.clientWidth / 2) {
        //     var moveX: number = (player.rolePlayer.x - Laya.Browser.clientWidth / 2);
        this.bg.x -= moveX;
        this.img.x -= moveX;
        // this.tMap.moveViewPort(moveX, 0);
        console.log("this.bg.x:" + this.bg.x);
        // }
    }

}
