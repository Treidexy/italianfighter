class_name FruliTroop
extends Troop

@export var WIND := preload("res://scenes/troops/fruli/fruli_wind.tscn");

func _physics_process(delta: float) -> void:
	super(delta);
	
	MAIN_HINT.rotation = dir.angle();

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
