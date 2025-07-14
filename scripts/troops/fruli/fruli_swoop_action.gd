class_name FruliSwoopAction
extends DashAction

@export var SWOOP := preload("res://scenes/troops/fruli/fruli_swoop_projectile.tscn");

var swoop: FruliSwoopProjectile;

func begin():
	super();
	
	var stat: FruliStat = VICTIM.stat;
	swoop = SWOOP.instantiate();
	swoop.FATHER = VICTIM;
	swoop.ACTION = self;
	swoop.damage = stat.SNATCH_DAMAGE;
	get_tree().root.add_child(swoop);

func end():
	super();
	
	VICTIM.end_super();
	if swoop != null:
		swoop.die();
