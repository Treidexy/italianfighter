class_name Hotspot
extends Area2D

@export var PROGRESS_BAR: ProgressBar;

@export var duration: float;
@export var required_precapture_options: Array[Hotspot] = [];

signal on_capture();

var progress: float;

var king: Troop;
var capturer: Troop;

func uncapture():
	assert(capturer != null and king == null);
	
	capturer.has_flag = false;
	capturer.captured_hotspot = null;
	capturer = null;
	_unclaim();
func unking():
	assert(capturer == null and king != null);
	
	king.has_crown = false;
	king = null;
	_unclaim();

func _unclaim():
	progress = 0;
	PROGRESS_BAR.value = 0;
	
	var o = get_overlapping_bodies().filter(func(x): x is Troop);
	for body in o:
		# not haxy
		_on_body_entered(body);

func capture():
	assert(king != null);
	
	if king.captured_hotspot != null:
		king.captured_hotspot.uncapture();
	
	capturer = king;
	king.has_crown = false;
	king.has_flag = true;
	king = null;
	capturer.captured_hotspot = self;
	print('captured');
	
	on_capture.emit();

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
		if required_precapture_options.size() > 0:
			if not required_precapture_options.has(body.captured_hotspot):
				return;
		
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
			unking();
