class_name DashAction
extends Action

var dist: float;
var velocity: Vector2;

var _origen: Vector2;

func begin():
	super();
	life = 99;
	_origen = VICTIM.position;

func _physics_process(delta: float) -> void:
	super(delta);
	VICTIM.velocity = velocity;
	if VICTIM.move_and_slide():
		end();
	if _origen.distance_to(VICTIM.position) > dist:
		end();
