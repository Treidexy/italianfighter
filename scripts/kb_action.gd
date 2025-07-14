class_name KbAction
extends Action

var force: Vector2;
var life: float;

func begin():
	super();
	
	life = 0.25;
	VICTIM.end_super();

func _physics_process(delta: float) -> void:
	super(delta);
	VICTIM.velocity = force;
	VICTIM.move_and_slide();
	life -= delta;
	if life < 0:
		end();
