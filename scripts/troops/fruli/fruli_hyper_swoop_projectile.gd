class_name FruliHyperSwoopProjectile
extends Projectile
	
func hit(victim: Troop):
	super(victim);
	
	if victim == FATHER:
		return;
	
	await get_tree().create_timer(0.1).timeout;
	victim.position = FATHER.position;
	
	var action = FruliSnatchedAction.new();
	action.FATHER = FATHER;
	action.VICTIM = victim;
	action.life = 0.5;
	get_tree().root.add_child(action);
	
	var action2 = TimedAction.new();
	action2.VICTIM = FATHER;
	action2.life = 0.1;
	get_tree().root.add_child(action2);
	die();
