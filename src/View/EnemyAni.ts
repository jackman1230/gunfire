export default class EnemyAni {

    public death_1: fairygui.GMovieClip;
    public death_2: fairygui.GMovieClip;
    public death_3: fairygui.GMovieClip;
    public death_4: fairygui.GMovieClip;

    public run_1: fairygui.GMovieClip;
    public run_2: fairygui.GMovieClip;
    public run_3: fairygui.GMovieClip;
    public run_4: fairygui.GMovieClip;

    public fire_1: fairygui.GMovieClip;
    public fire_2: fairygui.GMovieClip;
    public fire_3: fairygui.GMovieClip;
    public fire_4: fairygui.GMovieClip;


    // public legJump: fairygui.GMovieClip;
    // public legMove: fairygui.GMovieClip;
    public stay: fairygui.GMovieClip;

    public enemyType: number = 1;

    constructor() { }

    public initView(type: number): void {
        this.enemyType = type;
        this.death_1 = fairygui.UIPackage.createObject("Game", "death_1").asMovieClip;
        this.death_2 = fairygui.UIPackage.createObject("Game", "death_2").asMovieClip;
        this.death_3 = fairygui.UIPackage.createObject("Game", "death_3").asMovieClip;
        this.death_4 = fairygui.UIPackage.createObject("Game", "death_4").asMovieClip;

        this.fire_1 = fairygui.UIPackage.createObject("Game", "enemy_1").asMovieClip;
        this.fire_2 = fairygui.UIPackage.createObject("Game", "enemy_2").asMovieClip;
        this.fire_3 = fairygui.UIPackage.createObject("Game", "enemy_fire_3").asMovieClip;
        this.fire_4 = fairygui.UIPackage.createObject("Game", "enemy_fire_4").asMovieClip;

        this.run_1 = fairygui.UIPackage.createObject("Game", "enemyRun").asMovieClip;
        this.run_2 = fairygui.UIPackage.createObject("Game", "enemyRun").asMovieClip;
        this.run_3 = fairygui.UIPackage.createObject("Game", "enemy_3").asMovieClip;
        this.run_4 = fairygui.UIPackage.createObject("Game", "enemy_4").asMovieClip;

        // this.legJump = fairygui.UIPackage.createObject("Game", "legJump").asMovieClip;
        // this.legMove = fairygui.UIPackage.createObject("Game", "legMove").asMovieClip;
        this.stay = fairygui.UIPackage.createObject("Game", "enemyStay").asMovieClip;

    }

    public get deathAni(): fairygui.GMovieClip {
        return this["death_" + this.enemyType];
    }

    public get fireAni(): fairygui.GMovieClip {
        return this["fire_" + this.enemyType];
    }

    public get runAni(): fairygui.GMovieClip {
        return this["run_" + this.enemyType];
    }

}