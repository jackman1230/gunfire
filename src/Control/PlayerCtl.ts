import WXFUI_Player from "../fui/Game/WXFUI_Player";
import { ViewManager } from "../Manager/ViewManager";

export class PlayerCtl {

    public rolePlayer: WXFUI_Player;

    constructor() {

    }

    public initCtl(): void {
        this.rolePlayer = ViewManager.instance.getRolePlayer();
    }
}