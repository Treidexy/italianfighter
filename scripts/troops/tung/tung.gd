class_name Tung
extends Troop

@export var SLASH: PackedScene = preload("res://scenes/troops/tung/tung_slash.tscn");

func main():
	var proj := SLASH.instantiate();
	get_tree().current_scene.add_child(proj)
	print(str(position))
	proj.position = position;
	pass
