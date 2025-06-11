class_name Troop
extends CharacterBody2D

@export var NORMAL_STAT: Stat;
@export var HYPER_STAT: Stat;
@export var AMMO_LABEL: RichTextLabel;

var stat: Stat;
var hp: float;
var in_super: bool;
var in_hyper: bool;

var _main_cooldown: float;
var _main_reload: float;
var _main_ammo: int;

var _super_charge: float;
var _hyper_charge: float;
var _hyper_life: float;

###

# normalized Vector2
func main(dir: Vector2):
	_main_cooldown = stat.MAIN_COOLDOWN;
	_main_reload = stat.MAIN_RELOAD;
	_main_ammo -= 1;
func zuper(dir: Vector2):
	in_super = true;
func hyper():
	stat = HYPER_STAT;
	in_hyper = true;
	_hyper_life = stat.HYPER_DURATION;
func end_super():
	in_super = false;
	_super_charge = 0;
func end_hyper():
	in_hyper = false;
	_hyper_charge = 0;
	stat = NORMAL_STAT;

func inflict(projectile: Projectile, troop: Troop):
	_super_charge += projectile.damage;
	_hyper_charge += projectile.damage;
func exflict(projectile: Projectile):
	pass

###

func can_main() -> bool:
	return _main_ammo > 0 and _main_cooldown <= 0;
func can_super() -> bool:
	return not in_super and _super_charge >= stat.MAX_SUPER_CHARGE;
func can_hyper() -> bool:
	return not in_hyper and _hyper_charge >= stat.MAX_HYPER_CHARGE;

func _ready() -> void:
	stat = NORMAL_STAT;
	_main_cooldown = stat.MAIN_COOLDOWN;
	hp = stat.MAX_HP;

func _physics_process(delta: float) -> void:
	AMMO_LABEL.text = str(_main_ammo) + '/' + str(stat.MAX_AMMO)
	_main_cooldown -= delta;
	if _main_ammo < stat.MAX_AMMO:
		_main_reload -= delta;
		if _main_reload < 0:
			_main_reload = stat.MAIN_RELOAD;
			_main_ammo += 1;
	if in_hyper and _hyper_life > 0:
		_hyper_life -= delta;
		if _hyper_life < 0:
			end_hyper();
