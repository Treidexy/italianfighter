class_name FruliTroop
extends Troop

@export var WIND := preload("res://scenes/troops/fruli/fruli_wind.tscn");

func _physics_process(delta: float) -> void:
	super(delta);
	
	MAIN_HINT.rotation = dir.angle();
	SUPER_HINT.rotation = dir.angle();
	
func snatch(victim: Troop):
	var action = FruliSnatchedAction.new();
	action.FATHER = self;
	action.VICTIM = victim;
	get_tree().root.add_child(action);

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

func zuper():
	super();
	
	var stat: FruliStat = stat;
	var action: FruliSwoopAction = FruliSwoopAction.new();
	action.VICTIM = self;
	action.dist = stat.SWOOP_DIST;
	action.velocity = dir * stat.SWOOP_SPEED;
	get_tree().current_scene.add_child(action);
