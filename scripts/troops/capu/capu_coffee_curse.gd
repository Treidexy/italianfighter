class_name CapuCoffeeCurse
extends Curse

var speed_mul: float;
var reload_mul: float;

func begin():
	super();
	var stat: CapuStat = FATHER.stat;
	speed_mul = stat.COFFEE_SPEED_MUL;
	reload_mul = stat.COFFEE_RELOAD_MUL;
	VICTIM.stat_boost.speed_mul *= speed_mul;
	VICTIM.stat_boost.reload_mul *= reload_mul;
	
func end():
	super();
	VICTIM.stat_boost.speed_mul /= speed_mul;
	VICTIM.stat_boost.reload_mul /= reload_mul;
