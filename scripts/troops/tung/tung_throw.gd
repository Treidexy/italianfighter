class_name TungThrow
extends Projectile

@export var ROTATE_TIME: float = 0.5;
@export var KILL_DIST: float = 5;
var return_dist: float = 80;
var die_dist: float = 5;
var _origen: Vector2;
var _forward := true;
var _lerp := 0.7;

func _ready() -> void:
	_origen = position;
	
func _physics_process(delta: float) -> void:
	super(delta);
	if _forward and position.distance_to(_origen) > return_dist:
		_forward = false;
		velocity = -velocity;
	elif not _forward:
		rotation = (FATHER.position - position).angle();
		velocity = velocity.length() * (FATHER.position - position).normalized();
		if position.distance_to(FATHER.position) < die_dist:
			queue_free();
