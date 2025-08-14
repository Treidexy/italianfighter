class_name BombardiroTroop
extends Troop

@export var ROCKET: PackedScene = preload("res://scenes/troops/bombardiro/bombardiro_rocket_projectile.tscn");

func _physics_process(delta: float) -> void:
	super(delta);
	MAIN_HINT.rotation = dir.angle();
	SUPER_HINT.rotation = dir.angle();
	
func main():
	super();
	var proj: BombardiroRocketProjectile = ROCKET.instantiate();
	proj.FATHER = self;
	proj.life = 3;
	proj.position = position;
	proj.rotation = dir.angle();
	proj.explosion_damage = 500;
	proj.velocity = dir * 67;
	get_tree().current_scene.add_child(proj);

func zuper():
	super();
