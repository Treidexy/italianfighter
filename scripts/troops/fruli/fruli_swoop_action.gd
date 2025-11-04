class_name FruliSwoopAction
extends SwoopAction

var swoop: FruliSwoopProjectile;

func end():
	super();
	
	VICTIM.end_super();
	if swoop != null:
		swoop.die();
