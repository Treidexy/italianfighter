class_name CapuCoffeeCurse
extends Curse

var speed_mul: float;

func begin():
	super();
	var stat: CapuStat = FATHER.stat;
	speed_mul = stat.COFFEE_SPEED_BOOST;
	VICTIM.stat_boost.speed_mul *= speed_mul;
	
func end():
	super();
	VICTIM.stat_boost.speed_mul /= speed_mul;
