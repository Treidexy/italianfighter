class_name TimedAction
extends Action

var life: float = 6.9;

func _physics_process(delta: float) -> void:
	super(delta);
	
	life -= delta;
	if life < 0:
		end();
