import { BackGroundView } from "../View/BackGroundView";
import { Player } from "../View/Player";
import { WarView } from "../View/WarView";

export class ViewManager {

    private static _instance: ViewManager;


    private bgView: BackGroundView;
    private warView: WarView;
    private player: Player;

    constructor() {

    }
    public static get instance(): ViewManager {
        if (this._instance == null)
            this._instance = new ViewManager();
        return this._instance;
    }

    public initView(): void {
        this.bgView = new BackGroundView();
        this.warView = new WarView();
        this.player = new Player();


        
    }



}