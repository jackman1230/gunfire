import { GameManager } from "./GameManager";
import { ViewManager } from "./ViewManager";
import GameBinder from "../fui/Game/GameBinder";

export class SaveManager {
    private static _instance: SaveManager;
    constructor() {
    }

    public static get instance(): SaveManager {
        if (this._instance == null)
            this._instance = new SaveManager();
        return this._instance;
    }

    public saveGameData(key: string, value: string): void {
        localStorage.setItem(key, value)
    }

    public getGameData(key: string): string {
        return localStorage.getItem(key);
    }

}

