class_name FruliSwoopProjectile
extends Projectile

var ACTION: FruliSwoopAction;

func _physics_process(delta: float) -> void:
	super(delta);
	
	position = FATHER.position;
	
func hit(victim: Troop):
	super(victim);
	
	if victim == FATHER:
		return;
	
	await get_tree().create_timer(0.1).timeout;
	victim.position = FATHER.position;
	
	var stat: FruliStat = FATHER.stat;
	var action = FruliSnatchedAction.new();
	action.FATHER = FATHER;
	action.VICTIM = victim;
	action.life = stat.SNATCH_DURATION;
	get_tree().root.add_child(action);
	
	ACTION.end();
	die();
