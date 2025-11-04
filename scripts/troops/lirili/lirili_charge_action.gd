class_name LiriliChargeAction
extends SwoopAction

var projectile: LiriliChargeProjectile;

func end():
	super();
	
	VICTIM.end_super();
	projectile.die();
