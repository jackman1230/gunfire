import WXFUI_WarView from "../fui/Game/WXFUI_WarView";

export class WarView {

    public warView: WXFUI_WarView;
    private bg: fairygui.GLoader;
    private img: fairygui.GImage;

    private boxCollider: Laya.BoxCollider;
    private rigidBody: Laya.RigidBody;


    constructor() { }
    public initView() {
        this.warView = fairygui.UIPackage.createObject("Game", "WarView") as WXFUI_WarView;
        this.bg = this.warView.getChildAt(0) as fairygui.GLoader;
        this.bg.url = "res/map_1.jpg";
        this.bg.setScale(3.5, 3.5);

        this.img = this.warView.getChildAt(1) as fairygui.GImage;
        this.img.displayObject.addComponent(Laya.RigidBody);
        this.img.displayObject.addComponent(Laya.BoxCollider);
        this.boxCollider = this.img.displayObject.getComponent(Laya.BoxCollider);
        this.rigidBody = this.img.displayObject.getComponent(Laya.RigidBody);
        this.boxCollider.width = this.img.displayObject.width;
        this.boxCollider.height = this.img.displayObject.height;
        // this.boxCollider.fixture = 0;
        this.rigidBody.type = "static";

        Laya.Physics.I.worldRoot = this.warView.displayObject;

        // var img2: fairygui.GImage = this.warView.getChildAt(2) as fairygui.GImage;
        // img2.displayObject.addComponent(Laya.RigidBody);
        // img2.displayObject.addComponent(Laya.BoxCollider);
        // var b: Laya.BoxCollider = img2.displayObject.getComponent(Laya.BoxCollider);
        // var r:Laya.RigidBody = img2.displayObject.getComponent(Laya.RigidBody);
        // b.width = img2.displayObject.width;
        // b.height = img2.displayObject.height;
        // r.type = "static";


    };

    public updateViewPort(moveX: number): void {
        // var player: Player = ViewManager.instance.getRolePlayer();
        // if (player.rolePlayer.x > Laya.Browser.clientWidth / 2) {
        //     var moveX: number = (player.rolePlayer.x - Laya.Browser.clientWidth / 2);
        // this.bg.x -= moveX;
        // this.img.x -= moveX;

        this.warView.x -= moveX;
        // this.tMap.moveViewPort(moveX, 0);
        console.log("this.warView.x:" + this.warView.x);
        // }
    }

}
