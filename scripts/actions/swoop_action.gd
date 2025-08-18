class_name SwoopAction
extends Action

var dist: float;
var velocity: Vector2;
var traveled: float :
	get:
		return _origen.distance_to(VICTIM.position);

var _origen: Vector2;

func begin():
	super();
	_origen = VICTIM.position;
	VICTIM.set_collision_mask_value(3, false); # walls

func _physics_process(delta: float) -> void:
	super(delta);
	VICTIM.velocity = velocity;
	VICTIM.move_and_slide();
	if _origen.distance_to(VICTIM.position) > dist:
		end();

func end():
	super();
	VICTIM.set_collision_mask_value(3, true);
