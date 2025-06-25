class_name CapuJumpAction
extends JumpAction

var CAPU_COFFEE := preload("res://scenes/troops/capu/capu_coffee.tscn");

func end():
	super();
	VICTIM.end_super();
	
	var stat: CapuStat = VICTIM.stat;
	var proj: CapuCoffeeProjectile = CAPU_COFFEE.instantiate();
	proj.FATHER = VICTIM;
	proj.position = VICTIM.position;
	proj.life = stat.COFFEE_PROJECTILE_DURATION;
	get_tree().root.add_child(proj);
