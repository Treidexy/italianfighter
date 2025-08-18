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

func _physics_process(delta: float) -> void:
	super(delta);
	VICTIM.velocity = velocity;
	VICTIM.move_and_collide(VICTIM.velocity);
	if _origen.distance_to(VICTIM.position) > dist:
		end();
