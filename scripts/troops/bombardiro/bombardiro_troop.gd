class_name BombardiroTroop
extends Troop

@export var ROCKET: PackedScene = preload("res://scenes/troops/bombardiro/bombardiro_rocket_projectile.tscn");
@export var POINTS: Node2D;
@export var LEFT: Node2D;
@export var RIGHT: Node2D;

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
	
	var action := BombardiroSwoopAction.new();
	action.VICTIM = self;
	action.dist = 100;
	action.velocity = dir * 100 * stat_boost.speed_mul;
	action.explosion_damage = 500;
	action.explosion_count = 8;
	get_tree().current_scene.add_child(action);
