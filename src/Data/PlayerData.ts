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

}

export class BombData {
    /**自己仍的手榴弹 */
    public static BOMB_1: number = 1;
    /**敌人的手榴弹 */
    public static BOMB_2: number = 2;
    /**坦克的导弹 */
    public static BOMB_4: number = 4;
    /**敌人迫击炮的导弹 */
    public static BOMB_5: number = 5;

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