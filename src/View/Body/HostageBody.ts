import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";
import { ViewManager } from "../../Manager/ViewManager";


export default class HostageBody extends Laya.Script {

    private selfCollider: Laya.BoxCollider;//子弹碰撞体
    private selfBody: Laya.RigidBody;//子弹刚体

    private oriPosX: number;
    private self: Laya.Sprite;

    public activeDis: number = 150;
    private isActive: boolean = false;

    constructor() { super(); }

    onEnable(): void {
        this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
        this.selfBody = this.selfCollider.rigidBody;
        this.self = this.owner as Laya.Sprite;
        this.oriPosX = this.selfBody.getWorldCenter().x;
    }


    onDisable(): void {
    }

    onTriggerEnter(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {

    }
    onTriggerExit(): void {
    }

    onTriggerStay(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        // this.setSpeedZero();
    }

    onUpdate(): void {
        // this.setSpeedZero();
        if (this.isActive) return;

        if (Math.abs(ViewManager.instance.rolePlayer.roleSprite.x - this.oriPosX) < this.activeDis) {
            this.isActive = true;
            EventManager.instance.dispatcherEvt(GameEvent.ACTIVE_HOSTAGE, this.owner);
        }
    }
}