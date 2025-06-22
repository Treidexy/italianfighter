class_name TungTroop
extends Troop

@export var SLASH: PackedScene = preload("res://scenes/troops/tung/tung_slash.tscn");
@export var THROW: PackedScene = preload("res://scenes/troops/tung/tung_throw.tscn");

func _physics_process(delta: float) -> void:
	super(delta);
	var stat := stat as TungStat;
	MAIN_HINT.rotation = dir.angle();
	SUPER_HINT.rotation = dir.angle();
	
func main():
	super();
	var stat := stat as TungStat;
	var proj: TungSlash = SLASH.instantiate();
	proj.FATHER = self;
	proj.life = 0.3;
	proj.position = position;
	proj.rotation = dir.angle();
	proj.damage = stat.MAIN_DAMAGE;
	proj.kb = stat.KB;
	get_tree().current_scene.add_child(proj);

func zuper():
	super();	
	var stat := stat as TungStat;
	var proj: TungThrow = THROW.instantiate();
	proj.FATHER = self;
	proj.life = 3.0;
	proj.position = position;
	proj.rotation = dir.angle();
	proj.velocity = dir * stat.THROW_SPEED;
	proj.damage = stat.SUPER_DAMAGE;
	proj.kb = stat.KB;
	proj.return_dist = stat.THROW_DIST;
	get_tree().current_scene.add_child(proj);
