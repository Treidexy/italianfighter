class_name FruliTroop
extends Troop

@export var WIND := preload("res://scenes/troops/fruli/fruli_wind.tscn");
@export var HYPER_SWOOP := preload("res://scenes/troops/fruli/fruli_hyper_swoop_projectile.tscn");
@export var SUPER_HINT_PROGRESS_BAR: ProgressBar;

func _physics_process(delta: float) -> void:
	super(delta);
	
	var stat: FruliStat = stat;
	MAIN_HINT.rotation = dir.angle();
	SUPER_HINT.rotation = dir.angle();
	SUPER_HINT_PROGRESS_BAR.size.x = stat.SWOOP_DIST;

func main():
	super();
	
	var stat: FruliStat = stat;
	var proj: FruliWindProjetile = WIND.instantiate();
	proj.FATHER = self;
	proj.position = position;
	proj.rotation = dir.angle();
	proj.life = 0.2;
	proj.damage = stat.WIND_DAMAGE;
	get_tree().current_scene.add_child(proj);
	
	print(str(_super_charge) + ', ' + str(stat.MAX_SUPER_CHARGE));

func zuper():
	super();
	
	var stat: FruliStat = stat;
	if in_hyper:
		var swoop: FruliHyperSwoopProjectile = HYPER_SWOOP.instantiate();
		swoop.position = position;
		position += dir * stat.SWOOP_DIST;
		swoop.rotation = dir.angle();
		swoop.FATHER = self;
		swoop.damage = stat.SNATCH_DAMAGE;
		swoop.life = 0.1;
		get_tree().root.add_child(swoop);
	else:
		var action := FruliSwoopAction.new();
		action.VICTIM = self;
		action.dist = stat.SWOOP_DIST;
		action.velocity = dir * stat.SWOOP_SPEED;
		get_tree().current_scene.add_child(action);
