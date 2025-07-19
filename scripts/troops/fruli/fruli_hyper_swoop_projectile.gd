class_name FruliHyperSwoopProjectile
extends Projectile
	
func hit(victim: Troop):
	super(victim);
	
	if victim == FATHER:
		return;
	
	# dies bf timer runs out
	#await get_tree().create_timer(0.1).timeout;
	victim.position = FATHER.position;
	
	var action = FruliSnatchedAction.new();
	action.FATHER = FATHER;
	action.VICTIM = victim;
	action.life = 0.7;
	get_tree().root.add_child(action);
	
	var action2 = TimedAction.new();
	action2.VICTIM = FATHER;
	action2.life = 0.1;
	get_tree().root.add_child(action2);
	die();

func die():
	super();
	
	FATHER.end_super();
