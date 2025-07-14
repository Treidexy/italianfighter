class_name FruliHyperSwoopAction
extends Action

@export var HYPER_SWOOP := preload("res://scenes/troops/fruli/fruli_hyper_swoop_projectile.tscn");

var swoop: FruliHyperSwoopProjectile;
var dest: Vector2;

func begin():
	super();
	
	var stat: FruliStat = VICTIM.stat;
	swoop = HYPER_SWOOP.instantiate();
	swoop.position = VICTIM.position;
	swoop.rotation = VICTIM.dir.angle();
	swoop.FATHER = VICTIM;
	swoop.ACTION = self;
	swoop.damage = stat.SNATCH_DAMAGE;
	swoop.life = 0.1;
	get_tree().root.add_child(swoop);
	
	VICTIM.position = dest;

func snatch():
	await get_tree().create_timer(0.1);
	end();

func end():
	super();
	
	VICTIM.end_super();
	#if swoop != null:
		#swoop.die();
