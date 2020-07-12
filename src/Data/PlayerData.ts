export class PlayerData {
    /**主角武器类型 */
    public static WEAPON_TYPE: number = 1;
    /**手枪 */
    public static WEAPON_PIS: number = 1;
    /**机枪 */
    public static WEAPON_MAC: number = 2;
    /**来福枪 */
    public static WEAPON_RIFLE: number = 3;
    /**手榴弹 */
    public static WEAPON_GRE: number = 4;

}

export class PlayerInfo {
    public blood: number = 0;
    public bulletNum: number = 0;
    public bombNum: number = 0;
    public weaponType: number = 0;
    public rolePos: Laya.Point;
    public isDeath: boolean = false;
    public addMacNum: number = 0;
    public addBombNum: number = 0;
    public addRifNum: number = 0;
    public curChapter: number = 0;
    public curLevel: number = 0;
    public totalCoin: number = 0;
    public curlvCoin: number = 0;
    public direction: number = 0;
    public isInvincible: boolean = false;

    constructor() {
    }

}

export class EnemyInfo {
    public type: number;
    public damage: number;
    public blood: number;
    public direction: number;
    public activeDis: number;
    public pos: Laya.Point;
    public expRate: number[] = [];
    public isBoss: boolean = false;
    public name: string = "";

    constructor() {
    }

}

export class ObstacleInfo {
    public type: number;
    public blood: number;
    public pos: Laya.Point;
    public name: string = "";

    constructor() {
    }

}
