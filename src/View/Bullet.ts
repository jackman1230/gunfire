import WXFUI_zidan from "../fui/Game/WXFUI_zidan";

export default class Bullet extends Laya.Script {

    public view: WXFUI_zidan;
    public zidan: fairygui.GLoader;

    public bulletType: number = 1;
    public direction: number = 1;

    public theEnd: boolean = false;

    private speed: number = 35;

    public isEnd: boolean = false;

    constructor() { super(); }

    public initView(): void {
        this.view = fairygui.UIPackage.createObject("Game", "zidan") as WXFUI_zidan;
        this.zidan = this.view.getChildAt(0).asLoader;
    }

    public setBulletData(type: number, dir: number): void {
        this.bulletType = type;
        this.direction = dir;
        this.zidan.url = "ui://Game/zidan" + this.bulletType;
        if (this.direction == 1) {
            this.view.setSkew(0, 0);
        } else {
            this.view.setSkew(180, 180);
        }
    }

    // public flyBullet(): void {
    // Laya.timer.frameLoop(3, this, this.updateView);
    // }
    private dis: number = 0;
    public updateView(): void {
        this.dis += this.speed;

        if (this.direction == 1) {
            this.view.x += this.speed;

        } else {
            this.view.x -= this.speed;
            if (this.view.x < 0) {
                this.isEnd = true;
                this.dis = 0;
            }
        }
        if (this.dis > Laya.Browser.clientWidth) {
            this.dis = 0;
            this.isEnd = true;
        }
    }



    onEnable(): void {
    }

    onDisable(): void {
    }
}