class_name StatBoost
extends Resource

@export var speed_mul: float = 1;
@export var reload_mul: float = 1;

func apply(other: StatBoost):
	speed_mul *= other.speed_mul;
	reload_mul *= other.reload_mul;
