class_name Bot
extends Node

@export var VICTIM: Troop;
@export var DODGE: Area2D;

@export var TARGET: Troop;

func _physics_process(_delta: float) -> void:
	if VICTIM.can_main():
		VICTIM.main();
		
	VICTIM.weighted_dir = TARGET.position - VICTIM.position;
	
	DODGE.global_position = VICTIM.global_position;
	for body in DODGE.get_overlapping_areas():
		if body is Projectile and body.FATHER.team != VICTIM.team:
			var dir := VICTIM.position - body.position;
			VICTIM.move(dir);
