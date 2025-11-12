class_name Game
extends Node

@export var player: PlayerCtrl;
@export var map: Map;

var troops: Dictionary[int, Troop] = {};

var troop_presets := [
	preload("res://scenes/troops/tung/tung_troop.tscn"),
	preload("res://scenes/troops/capu/capu_troop.tscn"),
	preload("res://scenes/troops/fruli/fruli_troop.tscn"),
	preload("res://scenes/troops/bomba/bomba_troop.tscn"),
	preload("res://scenes/troops/lirili/lirili_troop.tscn"),
];

func _ready() -> void:
	map.goal_hotspot.on_capture.connect(
		func():
			print(str(map.goal_hotspot.capturer.peer_id) + ' won!');
	);

func add_troop(id: int, choice: int) -> Troop:
	if choice < 0 or choice > troop_presets.size():
		choice = randi_range(0, troop_presets.size());
	var troop: Troop = troop_presets[choice].instantiate();
	troop.name = 'player' + str(id);
	troop.peer_id = id;
	troops[id] = troop;
	add_child(troop, true);
	return troop;
func remove_troop(id):
	troops[id].queue_free();
	troops.erase(id);
