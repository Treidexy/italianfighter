class_name LiriliChargeProjectile
extends Projectile

func _physics_process(delta: float) -> void:
	super(delta);
	
	position = FATHER.position;
