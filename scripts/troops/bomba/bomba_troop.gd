class_name BombaTroop
extends Troop

@export var ROCKET: PackedScene = preload("res://scenes/troops/bomba/bomba_rocket_projectile.tscn");
@export var POINTS: Node2D;
@export var LEFT: Node2D;
@export var RIGHT: Node2D;
@export var MAIN_HINT_BAR: ProgressBar;
@export var SUPER_HINT_BAR: ProgressBar;

func _physics_process(delta: float) -> void:
	super(delta);
	var stat: BombaStat = stat;
	MAIN_HINT.rotation = dir.angle();
	SUPER_HINT.rotation = dir.angle();
	MAIN_HINT_BAR.size.x = stat.ROCKET_LIFE * stat.ROCKET_SPEED;
	SUPER_HINT_BAR.size.x = stat.SWOOP_DIST;
	
func main():
	super();
	var stat: BombaStat = stat;
	var proj: BombaRocketProjectile = ROCKET.instantiate();
	proj.FATHER = self;
	proj.life = stat.ROCKET_LIFE;
	proj.position = position;
	proj.rotation = dir.angle();
	proj.explosion_damage = stat.ROCKET_EXPLOSION_DAMAGE;
	proj.velocity = dir * stat.ROCKET_SPEED;
	get_tree().current_scene.add_child(proj);

func zuper():
	super();
	var stat: BombaStat = stat;
	var action := BombaSwoopAction.new();
	action.VICTIM = self;
	action.does_snare = in_hyper;
	action.dist = stat.SWOOP_DIST;
	action.velocity = dir * stat.SWOOP_SPEED * stat_boost.speed_mul;
	action.explosion_damage = stat.SWOOP_EXPLOSION_DAMAGE;
	action.explosion_count = stat.SWOOP_EXPLOSION_COUNT;
	get_tree().current_scene.add_child(action);

# todo maybe: curve super?
func hyper():
	super();
	set_collision_mask_value(3, false);

func end_hyper():
	super();
	set_collision_mask_value(3, true);
