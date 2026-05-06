class_name CapuCoffeeProjectile
extends Projectile

func hit(victim: Troop):
	super(victim);
	if victim.team != FATHER.team:
		return;
	
	for curse in victim.curses:
		if curse is CapuCoffeeCurse:
			curse.end();
	
	var curse = CapuCoffeeCurse.new();
	curse.FATHER = FATHER;
	curse.VICTIM = victim;
	var stat: CapuStat = FATHER.stat;
	curse.life = stat.COFFEE_CURSE_DURATION;
	curse.heal_rate = stat.COFFEE_HEAL_RATE;
	curse.speed_mul = stat.COFFEE_SPEED_MUL;
	curse.reload_mul = stat.COFFEE_RELOAD_MUL;
	get_tree().root.add_child(curse);
