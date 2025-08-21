class_name BombaSwoopAction
extends SwoopAction

@export var EXPLOSION: PackedScene = preload("res://scenes/troops/bomba/bomba_explosion_projectile.tscn");

var explosion_damage: float;
var explosion_count: float;
var _has_exploded_count: float = 0;

func begin():
	super();
	VICTIM.POINTS.rotation = velocity.angle() + TAU/4;

func _physics_process(delta: float) -> void:
	super(delta);
	while traveled / dist >= _has_exploded_count / (explosion_count - 1):
		_has_exploded_count += 1;
		var explosion: BombaExplosionProjectile = EXPLOSION.instantiate();
		explosion.FATHER = VICTIM;
		explosion.life = 0.1;
		explosion.global_position = VICTIM.LEFT.global_position;
		explosion.damage = explosion_damage;
		get_tree().current_scene.add_child(explosion);
		explosion = EXPLOSION.instantiate();
		explosion.FATHER = VICTIM;
		explosion.life = 0.1;
		explosion.global_position = VICTIM.RIGHT.global_position;
		explosion.damage = explosion_damage;
		get_tree().current_scene.add_child(explosion);

func end():
	super();
	VICTIM.end_super();
