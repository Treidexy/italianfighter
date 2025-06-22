class_name CapuCoffeeProjectile
extends Projectile

func hit(victim: Troop):
	super(victim);
	if victim != FATHER:
		return;
		
	
