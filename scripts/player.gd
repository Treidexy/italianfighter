class_name PlayerCtrl
extends Node

# very creative name ik
enum MainOrSuper {
	NONE,
	MAIN,
	SUPER,
}

@export var VICTIM: Troop;

#var weighted_dir := Vector2(0, 0); # user TROOP.d instead
var butt := MainOrSuper.NONE; # idk what to call ts

func _physics_process(_delta: float) -> void:
	if not VICTIM.can_move():
		return;
	
	var dx := Input.get_axis("left", "right");
	var dy := Input.get_axis("up", "down");
	var d := Vector2(dx, dy).normalized();
	
	VICTIM.velocity = d * VICTIM.stat.SPEED * VICTIM.stat_boost.speed_mul;
	VICTIM.move_and_slide();
	
	var ts_butt = MainOrSuper.NONE;
	
	if Input.is_action_pressed("main"):
		ts_butt = MainOrSuper.MAIN;
	if Input.is_action_pressed("super"):
		ts_butt = MainOrSuper.SUPER;
	dx = Input.get_axis('aim_left', 'aim_right');
	dy = Input.get_axis('aim_up', 'aim_down');
	d = Vector2(dx, dy);
	if d.length() > 0:
		VICTIM.weighted_dir = d;
	else:
		ts_butt = MainOrSuper.NONE;
		
	
	dx = Input.get_axis('aim_main_left', 'aim_main_right');
	dy = Input.get_axis('aim_main_up', 'aim_main_down');
	d = Vector2(dx, dy);
	if d.length() > 0:
		#VICTIM.dir = d.normalized();
		VICTIM.weighted_dir = d;
		ts_butt = MainOrSuper.MAIN;
		
	dx = Input.get_axis('aim_super_left', 'aim_super_right');
	dy = Input.get_axis('aim_super_up', 'aim_super_down');
	d = Vector2(dx, dy);
	if d.length() > 0:
		#VICTIM.dir = d.normalized();
		VICTIM.weighted_dir = d;
		ts_butt = MainOrSuper.SUPER;
		#VICTIM.show_super_hint();
		
	if ts_butt != butt:
		if ts_butt == MainOrSuper.NONE:
			VICTIM.hide_hints();
		if ts_butt == MainOrSuper.MAIN:
			VICTIM.show_main_hint();
		if ts_butt == MainOrSuper.SUPER:
			VICTIM.show_super_hint();
		butt = ts_butt;

func _input(event: InputEvent) -> void:
	if event is InputEventJoypadMotion or event is InputEventJoypadButton:
		#print(str(Input.is_action_pressed("main")) + ', ' + str(Input.is_action_just_released("main")));
		if Input.is_action_just_released("main"):
			VICTIM.hide_hints();
			if butt == MainOrSuper.MAIN and VICTIM.can_main():
				VICTIM.main();
		if Input.is_action_just_released("super"):
			VICTIM.hide_hints();
			if butt == MainOrSuper.SUPER and VICTIM.can_super():
				VICTIM.zuper();
		if Input.is_action_just_released("hyper"):
			if VICTIM.can_hyper():
				VICTIM.hyper();
	if event is InputEventScreenTouch:
		if event.is_released() and event.position.x > get_tree().root.content_scale_size.x / 2.0:
			VICTIM.hide_hints();
			if butt == MainOrSuper.MAIN and VICTIM.can_main():
				VICTIM.main();
			if butt == MainOrSuper.SUPER and  VICTIM.can_super():
				VICTIM.zuper();

func _on_button_pressed() -> void:
	if VICTIM.can_hyper():
		VICTIM.hyper();
