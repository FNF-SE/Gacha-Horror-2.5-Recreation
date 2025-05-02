package states.stages;

class GachaStage extends BaseStage
{
	override function create()
	{
		var gachastage:BGSprite = new BGSprite('stages/gachastage', 300, 170, 0.9, 0.9);
		gachastage.scale.set(1.5, 1.3);
		add(gachastage);
	}
}
