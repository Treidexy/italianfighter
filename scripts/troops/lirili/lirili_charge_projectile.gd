class_name LiriliChargeProjectile
extends Projectile

func _physics_process(delta: float) -> void:
	super(delta);
	
	position = FATHER.position;
	
func hit_wall(wall: Wall):
	if wall.breakable:
		wall.queue_free();
