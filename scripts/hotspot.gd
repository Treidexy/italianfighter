class_name Hotspot
extends Area2D

@export var PROGRESS_BAR: ProgressBar;

@export var duration: float;
var progress: float;

var king: Troop;
var capturer: Troop;

func unclaim():
	progress = 0;
	PROGRESS_BAR.value = 0;
	
	if king != null:
		king.has_crown = false;
	if capturer != null:
		capturer.has_flag = false;
	
	capturer = null;
	king = null;
	var o = get_overlapping_bodies().filter(func(x): x is Troop);
	for body in o:
		# not haxy
		_on_body_entered(body);

func capture():
	assert(king != null);
	
	capturer = king;
	king.has_crown = false;
	king.has_flag = true;
	king = null;
	capturer.captures.append(self);
	print('captured');

func _physics_process(delta: float) -> void:
	if king != null:
		progress += delta;
		PROGRESS_BAR.value = progress / duration;
		if progress > duration:
			capture();

func _on_body_entered(body: Node2D) -> void:
	if capturer != null:
		return;
		
	if body is Troop:
		body.current_hotspot = self;
		if king == null:
			king = body;
			body.has_crown = true;

func _on_body_exited(body: Node2D) -> void:
	if capturer != null:
		return;
	
	if body is Troop:
		body.current_hotspot = null;
		
		if body == king:
			unclaim();
