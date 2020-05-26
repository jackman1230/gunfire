import { ViewManager } from "./ViewManager";

export class GameManager {
    private static _instance: GameManager;
    public static assetsData = [];

    private event: Laya.EventDispatcher;

    constructor() {
    }

    public static get instance(): GameManager {
        if (this._instance == null)
            this._instance = new GameManager();
        return this._instance;
    }

    public startGame(): void {
        ViewManager.instance.showStartView();
    }

}