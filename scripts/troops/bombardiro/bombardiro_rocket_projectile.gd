class_name BombardiroRocketProjectile
extends Projectile

@export var EXPLOSION: PackedScene = preload("res://scenes/troops/bombardiro/bombardiro_explosion_projectile.tscn");

var explosion_damage: float;

func hit(victim: Troop):
	super(victim);
	if victim == FATHER:
		return;
	die();
func hit_wall(wall: Wall):
	super(wall);
	die();

func die():
	super();

	
	var explosion: BombardiroExplosionProjectile = EXPLOSION.instantiate();
	explosion.FATHER = FATHER;
	explosion.life = 0.1;
	explosion.position = position;
	explosion.damage = explosion_damage;
	get_tree().current_scene.add_child(explosion);
