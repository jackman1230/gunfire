import WXFUI_Player from "../fui/Game/WXFUI_Player";
import { ViewManager } from "../Manager/ViewManager";
import Player from "../View/Player";

export class PlayerCtl {

    public rolePlayer: Player;

    constructor() {

    }

    public initCtl(): void {
        this.rolePlayer = ViewManager.instance.getRolePlayer();
    }
}