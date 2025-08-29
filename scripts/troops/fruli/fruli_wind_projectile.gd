class_name FruliWindProjetile
extends Projectile

func hit(victim: Troop):
	super(victim);
	
	if victim.team == FATHER.team:
		return;
	
	var stat: FruliStat = FATHER.stat;
	if stat.WIND_SNARE_DURATION > 0:
		var action = TimedAction.new();
		action.does_silence = false;
		action.life = stat.WIND_SNARE_DURATION;
		get_tree().root.add_child(action);
