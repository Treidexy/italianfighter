class_name Bot
extends Node

@export var VICTIM: Troop;

@export var TARGET: Troop;

func _physics_process(_delta: float) -> void:
	if VICTIM.can_main():
		VICTIM.main();
		
	VICTIM.weighted_dir = TARGET.position - VICTIM.position;
