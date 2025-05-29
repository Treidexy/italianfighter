class_name Tung
extends Troop

@export var SLASH: PackedScene = preload("res://scenes/troops/tung/tung_slash.tscn");

func main(dir: Vector2):
	var proj := SLASH.instantiate();
	get_tree().current_scene.add_child(proj);
	if proj is TungSlash:
		proj.FATHER = self;
		proj.LIFE = 0.3;
	if proj is Node2D:
		proj.position = position;
		proj.rotation = dir.angle();
