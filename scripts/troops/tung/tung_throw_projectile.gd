class_name TungThrowProjectile
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
		_switch_dir();
	elif not _forward:
		rotation = (FATHER.position - position).angle();
		velocity = velocity.length() * (FATHER.position - position).normalized();
		if position.distance_to(FATHER.position) < DIE_DIST:
			die();
			
func _switch_dir():
	_forward = false;
	velocity = -velocity;
	
	# shhh haxy
	var bodys := get_overlapping_bodies();
	for body in bodys:
		if body is Troop:
			hit(body);

func hit_wall(wall: Wall):
	super(wall);
	
	if _forward:
		_switch_dir();
	else:
		die();

func die():
	super();
	FATHER.end_super();
