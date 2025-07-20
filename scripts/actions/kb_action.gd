class_name KbAction
extends TimedAction

var force: Vector2;

func begin():
	super();
	
	VICTIM.end_super();

func _physics_process(delta: float) -> void:
	super(delta);
	VICTIM.velocity = force;
	VICTIM.move_and_slide();
