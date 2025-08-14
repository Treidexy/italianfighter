class_name BombardiroSwoopAction
extends DashAction

@export var EXPLOSION: PackedScene = preload("res://scenes/troops/bombardiro/bombardiro_explosion_projectile.tscn");

var explosion_damage: float;

var reload: float;
var _reload_timer: float;

func _physics_process(delta: float) -> void:
	super(delta);
	_reload_timer -= delta;
	if _reload_timer < 0:
		_reload_timer = reload
		var explosion: BombardiroExplosionProjectile = EXPLOSION.instantiate();
		explosion.FATHER = VICTIM;
		explosion.life = 0.1;
		explosion.position = VICTIM.position;
		explosion.damage = explosion_damage;
		get_tree().current_scene.add_child(explosion);

func end():
	super();
	VICTIM.end_super();
