
import BombView from "./BombView";
import { EventManager } from "../Manager/EventManager";
import GameEvent from "../Control/GameEvent";
import { ui } from "../ui/layaMaxUI";

export default class ChopperBomb extends BombView {

    constructor() { super() }

    createView(type: number, dir: number, s: Laya.Point, p: boolean, offPos?: Laya.Point): void {
        this.bombType = type;
        this.parentPos = s;
        this.offPos = offPos;
        this.scene = new ui.ChopperBombUI();
        this.loadComplete();
        // Laya.Scene.load("ChopperBomb.scene", Laya.Handler.create(this, this.loadComplete));
    }


    protected setBombPos(): void {
        this.body.setVelocity({ x: 0, y: 5 });
        this.scene.x = this.parentPos.x + 165;
        this.scene.y = this.parentPos.y + 85;
    }
    protected dispose(s: any): void {
        if (s.s == this.box.owner) {
            this.showBoomView();
            this.disposeAll();
            // console.log("销毁炸弹--", this.bombType);
        }
    }
    protected disposeAll(): void {
        EventManager.instance.offNotice(GameEvent.CLEAR_WAR_VIEW, this, this.disposeAll);
        EventManager.instance.offNotice(GameEvent.PLAYER_BOMB_HIT_ENEMY, this, this.dispose);
        EventManager.instance.offNotice(GameEvent.ENEMY_BOMB_HIT_PLAYER, this, this.dispose);
        EventManager.instance.offNotice(GameEvent.BOMB_DISPOSE, this, this.dispose);
        if (this.scene) {
            this.scene.removeSelf();
        }
        if (this.view) this.view.dispose();
        Laya.Pool.recover("ChopperBomb", this);
    }

}