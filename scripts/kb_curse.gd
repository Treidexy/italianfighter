class_name KbCurse
extends Curse

var force: Vector2;

func begin():
	super();
	VICTIM.in_snare = true;
	
func _physics_process(delta: float) -> void:
	super(delta);
	VICTIM.velocity = force;
	VICTIM.move_and_slide();
	
func end():
	super();
	VICTIM.in_snare = false;
