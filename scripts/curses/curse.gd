class_name Curse
extends Node

var FATHER: Troop;
var VICTIM: Troop;
var life: float;

func begin():
	VICTIM.curses.append(self);
func end():
	VICTIM.curses.erase(self);
	queue_free();

func _ready() -> void:
	begin();
	
func _physics_process(delta: float) -> void:
	life -= delta;
	if life < 0:
		end();
