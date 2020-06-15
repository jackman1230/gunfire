
import BombView from "./BombView";

export default class ChopperBomb extends BombView {

    constructor() { super() }

    createView(type: number, dir: number, s: Laya.Point, p: boolean, offPos?: Laya.Point): void {
        this.bombType = type;
        this.parentPos = s;
        this.offPos = offPos;
        Laya.Scene.load("ChopperBomb.scene", Laya.Handler.create(this, this.loadComplete));
    }


    protected setBombPos(): void {
        this.body.setVelocity({ x: 0, y: 5 });
        this.scene.x = this.parentPos.x + this.offPos.x;
        this.scene.y = this.parentPos.y + this.offPos.y;
    }

}