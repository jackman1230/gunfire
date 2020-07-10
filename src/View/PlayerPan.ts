
import { ui } from "../ui/layaMaxUI";
import BulletPanBody from "./Body/BulletPanBody";

export default class PlayerPan {
    public scene: Laya.Sprite;

    constructor() { this.createView() }

    createView(): void {
        this.scene = new ui.BulletPanUI();
        this.loadComplete();
    }

    private loadComplete(): void {
        this.scene.addComponent(BulletPanBody);
        // this.setBulletPos();
    }


    public disposeAll(): void {
        if (this.scene) {
            this.scene.removeSelf();
        }
    }

    private setBulletPos(): void {
    }

}