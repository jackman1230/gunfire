import { GameManager } from "../../Manager/GameManager";
import { ViewManager } from "../../Manager/ViewManager";
import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";
import { GameData } from "../../Data/GameData";

export default class ObstacleBoomBody extends Laya.Script {

    // private selfCollider: Laya.BoxCollider;//角色碰撞体
    // private selfBody: Laya.RigidBody;//角色刚体

    // private otherBox: Laya.BoxCollider;

    constructor() { super(); }

    onAwake(): void {
        // this.selfCollider = this.owner.getComponent(Laya.BoxCollider);
        // this.selfBody = this.selfCollider.rigidBody;

    }

    onDisable(): void {
    }

    onTriggerEnter(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {

        // this.otherBox = other;
        // if (other.label == "enemy") {
        //     console.log("GameEvent.PLAYER_BOMB_HIT_ENEMY");
        //     EventManager.instance.dispatcherEvt(GameEvent.PLAYER_BOMB_HIT_ENEMY, { o: other.owner, s: self.owner, d: GameData.OBSTACLE_DAMAGE })
        // }
    }
    onTriggerExit(): void {

        // if ((this.otherBox.label == "enemy")) {
        //     console.log("this.ObstacleBody.label--", this.otherBox.label);
        //     // this.selfBody.type = "dynamic";
        //     this.otherBox.rigidBody.linearDamping=0;
        //     // this.otherBox.linearDamping = 0;
        //     this.otherBox.refresh();
        // }
    }
}