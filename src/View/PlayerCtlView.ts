import { GameManager } from "../Manager/GameManager";
import { EventManager } from "../Manager/EventManager";
import GameEvent from "../Control/GameEvent";
import { GoodsType } from "../Data/GameData";
import { PlayerData } from "../Data/PlayerData";
import WXFUI_PlayerCtlView from "../fui/Game/WXFUI_PlayerCtlView";

export default class PlayerCtlView {

    public view: WXFUI_PlayerCtlView;


    constructor() { this.createView() }

    createView(): void {
        this.view = fairygui.UIPackage.createObject("Game", "PlayerCtlView") as WXFUI_PlayerCtlView;


    }

}