class_name FruliSwoopAction
extends DashAction

@export var SWOOP := preload("res://scenes/troops/fruli/fruli_swoop_projectile.tscn");

var swoop: FruliSwoopProjectile;

func begin():
	super();
	
	swoop = SWOOP.instantiate();
	swoop.FATHER = VICTIM;
	swoop.ACTION = self;
	get_tree().root.add_child(swoop);

func end():
	super();
	
	VICTIM.end_super();
	if swoop != null:
		swoop.die();

func snatch(victim: Troop):
	swoop.die();
	
	var action = FruliSnatchedAction.new();
	action.FATHER = VICTIM;
	action.VICTIM = victim;
	get_tree().root.add_child(action);
	
	await get_tree().create_timer(0.1).timeout;
	end();
