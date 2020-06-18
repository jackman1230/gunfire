export class GameData {
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
    /**最多武器类型 */
    public static WEAPON_MAX: number = 3;
    /**敌人武器类型-手枪 */
    public static ENEMY_PIS: number = 1;
    /**敌人武器类型-手榴弹 */
    public static ENEMY_GRE: number = 2;
    /**敌人武器类型-机枪 */
    public static ENEMY_MAC: number = 3;
    /**敌人武器类型-火箭筒 */
    public static ENEMY_FIRE: number = 4;
    /**敌人武器类型-迫击炮 */
    public static ENEMY_MOR: number = 5;
    /**敌人武器类型-直升机 */
    public static ENEMY_CHOPPER: number = 10;
    /**敌人武器类型-灰坦克 */
    public static ENEMY_TANK_1: number = 11;
    /**敌人武器类型-黄坦克 */
    public static ENEMY_TANK_2: number = 12;
    /**掉落随机金币最大值*/
    public static RandomCoin: number = 200;

}

export class BombData {
    /**自己仍的手榴弹 */
    public static BOMB_MY_GRE: number = 1;
    /**敌人的手榴弹 */
    public static BOMB_ENEMY_GRE: number = 2;
    /**直升机导弹 */
    public static BOMB_CHOPPER: number = 3;
    /**坦克的导弹 */
    public static BOMB_TANK: number = 4;
    /**敌人迫击炮的导弹 */
    public static BOMB_MOR: number = 5;

}

export class ShotDirectionData {
    /**左 */
    public static LEFT: number = -1;
    /**右 */
    public static RIGHT: number = 1;
    /**右上 */
    public static RIGHT_UP: number = 2;
    /**左上 */
    public static LEFT_UP: number = -2;

}

export class ObstacleType {
    /**障碍物--沙包 */
    public static ObstacleType_SHABAO: number = 1;
    /**障碍物--油罐 */
    public static ObstacleType_YOUGUAN: number = 2;
    /**障碍物--小车 */
    public static ObstacleType_XIAOCHE: number = 4;
    /**障碍物--车 */
    public static ObstacleType_CHE: number = 5;
    /**障碍物--大车 */
    public static ObstacleType_DACHE: number = 6;

}


export class GoodsType {
    /**物资--药 */
    public static GoodsType_MED: number = 1;
    /**物资--机枪子弹 */
    public static GoodsType_MAC: number = 2;
    /**物资--来福枪子弹 */
    public static GoodsType_RIF: number = 3;
    /**物资--手榴弹 */
    public static GoodsType_GRE: number = 4;
    /**物资--金币 */
    public static GoodsType_COIN: number = 5;

}

