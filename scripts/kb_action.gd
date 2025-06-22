class_name KbAction
extends Action

var force: Vector2;

func begin():
	super();
	life = 0.25;

func _physics_process(delta: float) -> void:
	super(delta);
	VICTIM.velocity = force;
	VICTIM.move_and_slide();
