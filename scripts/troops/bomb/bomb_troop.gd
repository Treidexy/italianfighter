class_name BombardiroTroop
extends Troop

@export var ROCKET: PackedScene = preload("res://scenes/troops/bomb/bomb_rocket_projectile.tscn");
@export var POINTS: Node2D;
@export var LEFT: Node2D;
@export var RIGHT: Node2D;

func _physics_process(delta: float) -> void:
	super(delta);
	MAIN_HINT.rotation = dir.angle();
	SUPER_HINT.rotation = dir.angle();
	
func main():
	super();
	var stat: BombStat = stat;
	var proj: BombRocketProjectile = ROCKET.instantiate();
	proj.FATHER = self;
	proj.life = stat.ROCKET_LIFE;
	proj.position = position;
	proj.rotation = dir.angle();
	proj.explosion_damage = stat.ROCKET_EXPLOSION_DAMAGE;
	proj.velocity = dir * stat.ROCKET_SPEED;
	get_tree().current_scene.add_child(proj);

func zuper():
	super();
	var stat: BombStat = stat;
	var action := BombSwoopAction.new();
	action.VICTIM = self;
	action.dist = stat.SWOOP_DIST;
	action.velocity = dir * stat.SWOOP_SPEED * stat_boost.speed_mul;
	action.explosion_damage = stat.SWOOP_EXPLOSION_DAMAGE;
	action.explosion_count = stat.SWOOP_EXPLOSION_COUNT;
	get_tree().current_scene.add_child(action);
