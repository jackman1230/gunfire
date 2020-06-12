export default class PlayerAni {

    public body_1: fairygui.GMovieClip;
    public body_2: fairygui.GMovieClip;

    public boomAni_1: fairygui.GMovieClip;
    public boomAni_2: fairygui.GMovieClip;

    public fire_1: fairygui.GMovieClip;
    public fire_2: fairygui.GMovieClip;


    public legJump: fairygui.GMovieClip;
    public legMove: fairygui.GMovieClip;
    public legStay: fairygui.GImage;

    constructor() { }

    public createView(): void {
        this.body_1 = fairygui.UIPackage.createObject("Game", "body_1").asMovieClip;
        this.body_2 = fairygui.UIPackage.createObject("Game", "body_2").asMovieClip;
        this.boomAni_1 = fairygui.UIPackage.createObject("Game", "boom_1").asMovieClip;
        this.boomAni_2 = fairygui.UIPackage.createObject("Game", "boom_2").asMovieClip;

        this.legJump = fairygui.UIPackage.createObject("Game", "legJump").asMovieClip;
        this.legMove = fairygui.UIPackage.createObject("Game", "legMove").asMovieClip;
        this.legStay = fairygui.UIPackage.createObject("Game", "legStay").asImage;

        this.fire_1 = fairygui.UIPackage.createObject("Game", "fire_1").asMovieClip;
        this.fire_2 = fairygui.UIPackage.createObject("Game", "fire_2").asMovieClip;
    }

}