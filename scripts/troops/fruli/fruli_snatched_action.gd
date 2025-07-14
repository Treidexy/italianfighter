# for troops that are *being* snatched by a fruli
class_name FruliSnatchedAction
extends Action

var FATHER: FruliTroop;
var life: float = 0.5;

func begin():
	super();
	
	var gluon = Gluon.new();
	gluon.damage = 1000;
	FATHER.inflict(gluon, VICTIM);
	VICTIM.exflict(gluon);

func _physics_process(delta: float) -> void:
	super(delta);
	
	life -= delta;
	if life < 0:
		end();
	VICTIM.position += Vector2.from_angle(randf() * TAU);
