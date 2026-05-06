class_name CapuCoffeeCurse
extends Curse

var heal_rate: float;
var speed_mul: float;
var reload_mul: float;

func begin():
	super();
	VICTIM.stat_boost.speed_mul *= speed_mul;
	VICTIM.stat_boost.reload_mul *= reload_mul;
	
func _physics_process(delta: float) -> void:
	super(delta);
	
	VICTIM.hp += heal_rate * delta;
	
func end():
	super();
	VICTIM.stat_boost.speed_mul /= speed_mul;
	VICTIM.stat_boost.reload_mul /= reload_mul;
