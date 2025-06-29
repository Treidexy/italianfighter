class_name CapuCoffeeCurse
extends Curse

var heal_rate: float;
var speed_mul: float;
var reload_mul: float;

func begin():
	super();
	var stat: CapuStat = FATHER.stat;
	heal_rate = stat.COFFEE_HEAL_RATE;
	speed_mul = stat.COFFEE_SPEED_MUL;
	reload_mul = stat.COFFEE_RELOAD_MUL;
	VICTIM.stat_boost.speed_mul *= speed_mul;
	VICTIM.stat_boost.reload_mul *= reload_mul;
	
func _physics_process(delta: float) -> void:
	super(delta);
	
	VICTIM.hp += heal_rate * delta;
	
func end():
	super();
	VICTIM.stat_boost.speed_mul /= speed_mul;
	VICTIM.stat_boost.reload_mul /= reload_mul;
