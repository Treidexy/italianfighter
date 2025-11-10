class_name LiriliThornCurse
extends DotCurse

var speed_mul: float = 0.8;

func begin():
	super();
	VICTIM.stat_boost.speed_mul *= speed_mul;
	
func end():
	super();
	VICTIM.stat_boost.speed_mul /= speed_mul;
