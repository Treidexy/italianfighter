class_name Game
extends Node

@export var player: PlayerCtrl;
var troops: Dictionary[int, Troop] = {};

var troop_presets := [
	preload("res://scenes/troops/tung/tung_troop.tscn"),
	preload("res://scenes/troops/capu/capu_troop.tscn"),
	preload("res://scenes/troops/fruli/fruli_troop.tscn"),
];

func add_troop(id) -> Troop:
	var troop: Troop = troop_presets[id % troop_presets.size()].instantiate();
	troop.name = 'player' + str(id);
	troop.peer_id = id;
	troops[id] = troop;
	add_child(troop, true);
	return troop;
func remove_troop(id):
	troops[id].queue_free();
	troops.erase(id);
