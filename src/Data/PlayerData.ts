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
    public blood: number;
    public bulletNum: number;
    public bombNum: number;
    public weaponType: number;
    public rolePos: Laya.Point;
    public isDeath: boolean;
    public addMacNum: number;
    public addBombNum: number;
    public addRifNum: number;
    public curChapter: number;
    public curLevel: number;

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

    constructor() {
    }

}

export class ObstacleInfo {
    public type: number;
    public blood: number;
    public pos: Laya.Point;

    constructor() {
    }

}
