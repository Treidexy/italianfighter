class_name JumpAction
extends Action

var dest: Vector2;
var duration: float;
var time: float;

var _origen: Vector2;

func begin():
	super();
	_origen = VICTIM.position;

func _physics_process(delta: float) -> void:
	super(delta);
	time += delta;
	VICTIM.position = lerp(_origen, dest, time / duration);
	if time > duration:
		VICTIM.position = dest;
		end();
