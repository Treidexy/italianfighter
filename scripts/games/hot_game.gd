class_name HotGame
extends Game

func _ready() -> void:
	var map: HotMap = map;
	map.goal_hotspot.on_capture.connect(
		func():
			print(str(map.goal_hotspot.capturer.peer_id) + ' won!');
	);
