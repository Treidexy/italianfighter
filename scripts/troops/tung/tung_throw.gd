class_name TungThrow
extends Projectile

@export var ROTATE_TIME: float = 0.5;
@export var DIE_DIST: float = 5;
var return_dist: float;
var _origen: Vector2;
var _forward := true;

var die_dist: float = 5;
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
		if position.distance_to(FATHER.position) < DIE_DIST:
			die();

func die():
	super();
	FATHER.end_super();
