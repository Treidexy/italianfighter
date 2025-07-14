class_name FruliHyperSwoopProjectile
extends Projectile

var ACTION: FruliHyperSwoopAction;
	
func hit(victim: Troop):
	super(victim);
	
	if victim == FATHER:
		return;
	
	await get_tree().create_timer(0.1).timeout;
	victim.position = FATHER.position;
	
	var action = FruliSnatchedAction.new();
	action.FATHER = FATHER;
	action.VICTIM = victim;
	get_tree().root.add_child(action);
	
	ACTION.snatch();
	die();
