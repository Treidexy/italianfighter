class_name Hotspot
extends Area2D

@export var PROGRESS_BAR: ProgressBar;

@export var duration: float;

var king: Troop;
var capturer: Troop;

func _physics_process(delta: float) -> void:
	if king != null:
		PROGRESS_BAR.value = king.hotspot_progress / duration;
		if king.hotspot_progress > duration:
			capturer = king;
			print('captured');
	else:
		PROGRESS_BAR.value = 0;

func _on_body_entered(body: Node2D) -> void:
	if body is Troop:
		body.current_hotspot = self;
		body.hotspot_progress = 0;
		if king == null:
			king = body;
			body.is_hotspot_king = true;

func _on_body_exited(body: Node2D) -> void:
	if body is Troop:
		body.current_hotspot = null;
		body.hotspot_progress = 0;
		body.is_hotspot_king = false;
		
		if body == king:
			king = null;
			for troop: Troop in get_overlapping_bodies():
				if king == null or troop.hotspot_progress > king.hotspot_progress:
					king = troop;
			if king != null:
				king.is_hotspot_king = true;
