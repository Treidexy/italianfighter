class_name LiriliChargeAction
extends DashAction

var projectile: LiriliChargeProjectile;

func end():
	super();
	
	VICTIM.end_super();
	projectile.die();
