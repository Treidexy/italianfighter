# for troops that are *being* snatched by a fruli
class_name FruliSnatchedAction
extends TimedAction

var FATHER: FruliTroop;

func _physics_process(delta: float) -> void:
	super(delta);
	
	VICTIM.position += Vector2.from_angle(randf() * TAU);
