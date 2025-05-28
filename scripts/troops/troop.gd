class_name Troop
extends Node2D

@export var stat: Stat = preload("res://stats/troops/tung/tung_norm.tres");
var hp: float;

func main():
	print("ski")
	pass
func zuper(): pass
func hyper(): pass

func _ready() -> void:
	hp = stat.MAX_HP;
