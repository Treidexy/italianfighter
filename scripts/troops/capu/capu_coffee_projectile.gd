class_name CapuCoffeeProjectile
extends Projectile

var curse_life: float;

func hit(victim: Troop):
	super(victim);
	if victim != FATHER:
		return;
	
	for curse in victim.curses:
		if curse is CapuCoffeeCurse:
			curse.end();
	
	var curse = CapuCoffeeCurse.new();
	curse.FATHER = FATHER;
	curse.VICTIM = victim;
	curse.life = FATHER.stat.COFFEE_CURSE_DURATION;
	get_tree().root.add_child(curse);
