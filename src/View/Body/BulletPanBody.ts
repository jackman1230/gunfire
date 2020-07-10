import { EventManager } from "../../Manager/EventManager";
import GameEvent from "../../Control/GameEvent";
import { GameData } from "../../Data/GameData";


export default class BulletPanBody extends Laya.Script {
    constructor() { super(); }


    onDisable(): void {
    }

    onTriggerEnter(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
        if (other.label == "enemy") {
            EventManager.instance.dispatcherEvt(GameEvent.PLAYER_PAN_HIT_ENEMY, { o: other.owner, s: self.owner, d: GameData.PAN_DAMAGE });
            this.owner.removeSelf();
        }

    }
    onTriggerExit(): void {
    }

    onTriggerStay(other: Laya.BoxCollider, self: Laya.BoxCollider, contact: any): void {
    }
}