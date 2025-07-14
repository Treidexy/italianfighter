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
	
	victim.end_super();
	ACTION.snatch(victim);
