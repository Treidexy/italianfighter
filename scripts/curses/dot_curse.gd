class_name DotCurse
extends Curse

var dot: float;
# set_once
var dot_rate: float = 1;

func begin():
	super();
	
	var timer := Timer.new();
	add_child(timer);
	timer.wait_time = dot_rate;
	timer.one_shot = false;
	timer.timeout.connect(tick_damage);
	timer.start();

func tick_damage():
	var gluon := Gluon.new();
	gluon.damage = dot;
	FATHER.inflict(gluon, VICTIM);
	VICTIM.exflict(gluon);
