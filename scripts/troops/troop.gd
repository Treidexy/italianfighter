class_name Troop
extends CharacterBody2D

var peer_id: int;
@export var team: int;

@export var NORMAL_STAT: Stat;
@export var HYPER_STAT: Stat;
@export var UI: TroopUi;
@export var MAIN_HINT: Node2D;
@export var SUPER_HINT: Node2D;

var stat: Stat;
var stat_boost: StatBoost = StatBoost.new();
# between 0 and 1. used so that health scaling is nice
var rel_hp: float;
var hp: float :
	get:
		return rel_hp * stat.MAX_HP;
	set(v):
		rel_hp = v / stat.MAX_HP;
var in_super: bool = false;
var in_hyper: bool = false;

var curses: Array[Curse] = [];

#var in_snare: bool = false;
#var in_silence: bool = false;
var current_action: Action = null;
var dir: Vector2 :
	get:
		return weighted_dir.normalized();
var weighted_dir: Vector2 = Vector2.from_angle(0);

var _main_cooldown: float;
var _main_reload: float;
var _main_ammo: int;

var _super_charge: float = 0;
var _hyper_charge: float = 0;
var _hyper_life: float;

var _recovery_cooldown: float = 0;

###

func main():
	_sync(_main_rpc, weighted_dir);
	
	_main_cooldown = stat.MAIN_COOLDOWN;
	_main_reload = stat.MAIN_RELOAD * stat_boost.reload_mul;
	_main_ammo -= 1;
	
	_recovery_cooldown = stat.RECOVERY_COOLDOWN;
func zuper():
	_sync(_super_rpc, weighted_dir);
	
	in_super = true;
	_recovery_cooldown = stat.RECOVERY_COOLDOWN;
func hyper():
	_sync(_hyper_rpc);
	
	stat = HYPER_STAT;
	in_hyper = true;
	_hyper_life = stat.HYPER_DURATION;
	_recovery_cooldown = stat.RECOVERY_COOLDOWN;
func end_super():
	#_end_super_rpc.rpc();
	
	in_super = false;
	_super_charge = 0;
func end_hyper():
	#_end_hyper_rpc.rpc();
	
	in_hyper = false;
	_hyper_charge = 0;
	stat = NORMAL_STAT;

func inflict(gluon, _troop: Troop):
	_super_charge += gluon.damage;
	_hyper_charge += gluon.damage;
func exflict(gluon):
	hp -= gluon.damage;
	if hp <= 0:
		die();

	_recovery_cooldown = stat.RECOVERY_COOLDOWN;
func die(): pass
func heal(amt: float):
	hp += amt;
	if hp > stat.MAX_HP:
		hp = stat.MAX_HP;
func heal_rel(amt: float):
	rel_hp += amt;
	if rel_hp > 1:
		rel_hp = 1;
	
###

func show_main_hint():
	MAIN_HINT.visible = true;
	
func show_super_hint():
	SUPER_HINT.visible = true;
	
func hide_hints():
	MAIN_HINT.visible = false;
	SUPER_HINT.visible = false;

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
	_sync(_info_rpc, position, rel_hp);
	
	UI.HEALTH_BAR.value = rel_hp;
	UI.HEALTH_LABEL.text = str(int(hp));
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
			
	if _recovery_cooldown > 0:
		_recovery_cooldown -= delta;
	else:
		heal_rel(stat.RECOVERY_RATE * delta);

###

# bc godot is a fucking clanker and doesn't support vaargs
func _sync(fn, arg0 = null, arg1 = null) -> void:
	if peer_id == multiplayer.get_unique_id():
		if arg0 == null:
			fn.rpc();
		elif arg1 == null:
			fn.rpc(arg0);
		else:
			fn.rpc(arg0, arg1);
@rpc("any_peer", "call_remote", "reliable")
func _main_rpc(weighted_dir):
	self.weighted_dir = weighted_dir;
	main();
@rpc("any_peer", "call_remote", "reliable")
func _super_rpc(weighted_dir):
	self.weighted_dir = weighted_dir;
	zuper();
@rpc("any_peer", "call_remote", "reliable")
func _hyper_rpc():
	hyper();
## SHOULD BE HANDLED BY EACH CLIENT ALR
#@rpc("any_peer", "call_remote", "reliable")
#func _end_super_rpc():
	#end_super();
#@rpc("any_peer", "call_remote", "reliable")
#func _end_hyper_rpc():
	#end_super();
@rpc("any_peer", "call_remote", "unreliable")
func _info_rpc(pos: Vector2, rel_hp: float):
	position = pos;
	self.rel_hp = rel_hp;
