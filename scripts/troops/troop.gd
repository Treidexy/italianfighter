class_name Troop
extends CharacterBody2D

@export var NORMAL_STAT: Stat;
@export var HYPER_STAT: Stat;
@export var UI: TroopUi;

var stat: Stat;
var hp: float;
var in_super: bool = false;
var in_hyper: bool = false;
#var in_snare: bool = false;
#var in_silence: bool = false;
var current_action: Action = null;
var dir: Vector2 = Vector2.from_angle(0);
var weighted_dir: Vector2 = Vector2.from_angle(0);

var _main_cooldown: float;
var _main_reload: float;
var _main_ammo: int;

var _super_charge: float = 0;
var _hyper_charge: float = 0;
var _hyper_life: float;

###

# normalized Vector2
func main():
	_main_cooldown = stat.MAIN_COOLDOWN;
	_main_reload = stat.MAIN_RELOAD;
	_main_ammo -= 1;
func zuper():
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

func inflict(gluon, troop: Troop):
	if gluon is Projectile:
		_super_charge += gluon.damage;
		_hyper_charge += gluon.damage;
func exflict(gluon):
	hp -= gluon.damage;
	if hp <= 0:
		die();
func die(): pass
	
###

func show_hint(): pass
func hide_hint(): pass

###

func can_move() -> bool:
	return not in_snare();
func can_main() -> bool:
	return not in_silence() and _main_ammo > 0 and _main_cooldown <= 0;
func can_super() -> bool:
	return not in_silence() and not in_super and _super_charge >= stat.MAX_SUPER_CHARGE;
func can_hyper() -> bool:
	return not in_silence() and not in_hyper and _hyper_charge >= stat.MAX_HYPER_CHARGE;

func in_snare() -> bool:
	return current_action != null and current_action.does_snare;
func in_silence() -> bool:
	return current_action != null and current_action.does_silence;

###

func _ready() -> void:
	stat = NORMAL_STAT;
	_main_cooldown = stat.MAIN_COOLDOWN;
	hp = stat.MAX_HP;
	# todo: actually stylize
	var sb = StyleBoxFlat.new();
	sb.bg_color = Color(255, 0, 0);
	UI.HEALTH_BAR.add_theme_stylebox_override("fill", sb);
	
	var sb1 = StyleBoxFlat.new();
	sb1.bg_color = Color(255, 255, 0);
	UI.AMMO_BAR.add_theme_stylebox_override("fill", sb1);

func _physics_process(delta: float) -> void:	
	UI.HEALTH_BAR.value = hp / stat.MAX_HP;
	UI.AMMO_BAR.value = (_main_ammo + 1 - _main_reload / stat.MAIN_RELOAD) / stat.MAX_AMMO;
	UI.CAN_SUPER_INDICATOR.visible = can_super();
	UI.IN_SUPER_INDICATOR.visible = in_super;
	UI.CAN_HYPER_INDICATOR.visible = can_hyper();
	UI.IN_HYPER_INDICATOR.visible = in_hyper;
	
	if _main_cooldown > 0:
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
