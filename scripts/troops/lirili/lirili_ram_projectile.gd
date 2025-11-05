class_name LiriliRamProjectile
extends Projectile

var dot: float;
var dot_life: float;

func hit(victim: Troop):
	super(victim);
	
	if victim.team == FATHER.team:
		return;
		
	var curse := LiriliThornCurse.new();
	curse.FATHER = FATHER;
	curse.VICTIM = victim;
	curse.dot = dot;
	curse.life = dot_life;
	get_tree().current_scene.add_child(curse);
