class_name Tung
extends Troop

@export var SLASH: PackedScene = preload("res://scenes/troops/tung/tung_slash.tscn");
@export var THROW: PackedScene = preload("res://scenes/troops/tung/tung_throw.tscn");

func main(dir: Vector2):
	var proj: TungSlash = SLASH.instantiate();
	get_tree().current_scene.add_child(proj);
	proj.FATHER = self;
	proj.LIFE = 0.3;
	proj.position = position;
	proj.rotation = dir.angle();

func zuper(dir: Vector2):
	var proj: TungSlash = THROW.instantiate();
	get_tree().current_scene.add_child(proj);
	proj.FATHER = self;
	proj.LIFE = 3.0;
	proj.position = position;
	proj.rotation = dir.angle();
	if stat is TungStat:
		proj.velocity = dir * stat.THROW_SPEED;
