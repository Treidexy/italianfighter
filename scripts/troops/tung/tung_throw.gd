class_name TungThrow
extends Projectile

var ROTATE_TIME: float = 0.5;

func _ready() -> void:
	spin();
	
func spin() -> void:
	while true:
		await get_tree().create_timer(ROTATE_TIME).timeout;
		rotate(PI)
