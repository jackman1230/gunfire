export class GameData {
    /**手枪 */
    public static WEAPON_PIS: number = 1;
    /**机枪 */
    public static WEAPON_MAC: number = 2;
    /**来福枪 */
    public static WEAPON_RIFLE: number = 3;
    /**手榴弹 */
    public static WEAPON_GRE: number = 4;
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
    /**敌人武器类型-军官 */
    public static ENEMY_JUNGUAN: number = 6;
    /**敌人武器类型-直升机 */
    public static ENEMY_CHOPPER: number = 10;
    /**敌人武器类型-灰坦克 */
    public static ENEMY_TANK_1: number = 11;
    /**敌人武器类型-黄坦克 */
    public static ENEMY_TANK_2: number = 12;
    /**敌人武器类型-推土坦克 */
    public static ENEMY_TANK_3: number = 13;
    /**敌人武器类型-装甲坦克 */
    public static ENEMY_TANK_4: number = 14;
    /**掉落随机金币最大值*/
    public static RANDOM_COIN: number = 200;
    /**人物手榴弹的伤害*/
    public static BOMB_DAMAGE: number = 5;
    /**障碍物爆炸的伤害*/
    public static OBSTACLE_DAMAGE: number = 10;
    /**声音文件开头的路径 */
    public static SOUND_FONT: string = "res/sound/";
    /**通过一关获得的金币 */
    public static VICTORY_LEVEL_COIN: number = 1000;
    /**平底锅的伤害*/
    public static PAN_DAMAGE: number = 5;

    /**显示每个关卡敌人编号和障碍物编号，方便改变坐标*/
    public static SHOW_ENEMY_NAME: Boolean = false;

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
    /**障碍物--米车 */
    public static ObstacleType_MICHE: number = 3;
    /**障碍物--大车 */
    public static ObstacleType_DACHE: number = 4;
    /**障碍物--车 */
    public static ObstacleType_CHE: number = 5;
    /**障碍物--木围栏 */
    public static ObstacleType_6: number = 6;
    /**障碍物--空车 */
    public static ObstacleType_7: number = 7;
    /**障碍物--吊篮 */
    public static ObstacleType_8: number = 8;
    /**障碍物--木桶 */
    public static ObstacleType_9: number = 9;
    /**障碍物--木车 */
    public static ObstacleType_10: number = 10;
    /**障碍物--汽车 */
    public static ObstacleType_11: number = 11;

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


