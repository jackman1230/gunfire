import { GameManager } from "../../Manager/GameManager";
import { ViewManager } from "../../Manager/ViewManager";
import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";

export default class EnemyBody extends Laya.Script {

    private selfCollider: Laya.BoxCollider;//角色碰撞体
    private selfBody: Laya.RigidBody;//角色刚体

    public activeDis: number = 650;
    private isActive: boolean = false;
    public obstacleBox: Laya.PolygonCollider;
    public isDrop: boolean = false;

    constructor() { super(); }

    onAwake(): void {
        this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
        this.selfBody = this.selfCollider.rigidBody;

    }

    onDisable(): void {
    }

    onTriggerEnter(other: Laya.PolygonCollider, self: Laya.BoxCollider, contact: any): void {

        if (other.label == "obstacle") {
            this.obstacleBox = other;
        }

        if ((other.label == "ground" || other.label == "board" || other.label == "obstacle")) {
            // this.otherBox = other;
            //     // this.selfBody.type = "static";
            this.selfBody.gravityScale = 0;
            this.selfCollider.density = 0;
            this.selfBody.setVelocity({ x: 0, y: 0 });
            this.selfCollider.refresh();
            if (this.isDrop)
                ((this.selfBody.owner) as Laya.Sprite).y -= 8;
            // console.log("onTriggerEnter--", other.label);
            // console.log("other--", other.owner);
        }
    }
    onTriggerExit(): void {

        // if ((this.otherBox.label == "ground" || this.otherBox.label == "board" || this.otherBox.label == "obstacle")) {
        //     console.log("this.otherBox--", this.otherBox.owner);
        //     console.log("this.otherBox.label--", this.otherBox.label);
        //     // this.selfBody.type = "dynamic";
        //     this.selfBody.linearDamping = 0;
        //     this.selfCollider.refresh();
        // }
    }

    onTriggerStay(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        // this.setSpeedZero();
    }

    onUpdate(): void {
        // this.setSpeedZero();
        if (this.isActive) return;
        var p: Laya.Point = this.selfBody.getWorldCenter();
        if (Math.abs(ViewManager.instance.rolePlayer.roleSprite.x - p.x) < this.activeDis) {
            this.isActive = true;
            EventManager.instance.dispatcherEvt(GameEvent.ACTIVE_ENEMY, this.owner);
        }
    }
    /**防止斜坡有加速度，将速度设置为0 */
    private setSpeedZero(): void {
        this.selfBody.linearVelocity = { x: 0, y: 0 };
        this.selfBody.angularVelocity = 0;
        this.selfBody.setVelocity({ x: 0, y: 0 });
        this.selfBody.angularDamping = 0;
        this.selfBody.setAngle({ x: 0, y: 0 });
        this.selfBody.linearDamping = 0;
        this.selfCollider.refresh();
    }
}