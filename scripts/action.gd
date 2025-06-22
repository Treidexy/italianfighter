class_name Action
extends Node

var VICTIM: Troop;
var life: float;
var does_snare: bool = true;
var does_silence: bool = true;

func begin():
	if VICTIM.current_action != null:
		VICTIM.current_action.end();
	VICTIM.current_action = self;
func end():
	VICTIM.current_action = null;
	queue_free();
func _physics_process(delta: float) -> void:
	life -= delta;
	if life < 0:
		end();

func _ready() -> void:
	begin();
