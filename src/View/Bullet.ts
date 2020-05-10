import WXFUI_zidan from "../fui/Game/WXFUI_zidan";

export default class Bullet extends Laya.Script {

    public view: WXFUI_zidan;
    public zidan: fairygui.GLoader;

    public bulletType: number = 1;
    public direction: number = 1;

    public theEnd: boolean = false;

    private speed: number = 35;

    constructor() { super(); }

    public initView(): void {
        this.view = fairygui.UIPackage.createObject("Game", "zidan") as WXFUI_zidan;
        this.zidan = this.view.getChildAt(0).asLoader;
    }

    public setBulletData(type: number, dir: number): void {
        this.bulletType = type;
        this.direction = dir;
        this.zidan.url = "ui://Game/zidan" + this.bulletType;
    }

    public flyBullet(): void {
        Laya.timer.frameLoop(3, this, this.updateView);
    }
    private dis: number = 0;
    private updateView(): void {
        this.dis += this.speed;

        if (this.direction == 1) {
            this.view.x += this.speed;
            if (this.dis > Laya.Browser.clientWidth) {
                Laya.timer.clear(this, this.updateView);
                this.dis = 0;
            }
        } else {
            this.view.x -= this.speed;
            if (this.view.x < 0) {
                Laya.timer.clear(this, this.updateView);
                this.dis = 0;
            }
        }
    }



    onEnable(): void {
    }

    onDisable(): void {
    }
}