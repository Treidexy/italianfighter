class_name Troop
extends CharacterBody2D

@export var stat: Stat = preload("res://stats/troops/tung/tung_norm.tres");
var hp: float;

# normalized Vector2
func main(dir: Vector2): pass
func zuper(dir: Vector2): pass
func hyper(dir: Vector2): pass

func _ready() -> void:
	hp = stat.MAX_HP;
