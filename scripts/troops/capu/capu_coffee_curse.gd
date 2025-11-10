class_name CapuCoffeeCurse
extends Curse

var stat: CapuStat :
	get: return FATHER.stat;
var heal_rate: float :
	get: return stat.COFFEE_HEAL_RATE;
var speed_mul: float :
	get: return stat.COFFEE_SPEED_MUL;
var reload_mul: float :
	get: return stat.COFFEE_RELOAD_MUL;

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
