class_name Player
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

func _physics_process(delta: float) -> void:
	if not VICTIM.can_move():
		return;
	
	var dx := Input.get_axis("left", "right");
	var dy := Input.get_axis("up", "down");
	var d := Vector2(dx, dy).normalized();
	
	VICTIM.velocity = d * VICTIM.stat.SPEED;
	VICTIM.move_and_slide();
	
	butt = MainOrSuper.NONE;
	
	# because on mouseUp event, joystick is reset before we can read it :(
	dx = Input.get_axis('aim_main_left', 'aim_main_right');
	dy = Input.get_axis('aim_main_up', 'aim_main_down');
	d = Vector2(dx, dy);
	if d.length() > 0:
		VICTIM.dir = d.normalized();
		VICTIM.weighted_dir = d;
		butt = MainOrSuper.MAIN;
		
	dx = Input.get_axis('aim_super_left', 'aim_super_right');
	dy = Input.get_axis('aim_super_up', 'aim_super_down');
	d = Vector2(dx, dy);
	if d.length() > 0:
		VICTIM.dir = d.normalized();
		VICTIM.weighted_dir = d;
		butt = MainOrSuper.SUPER;

func _input(event: InputEvent) -> void:
	if event is InputEventScreenTouch:
		if event.is_pressed() == false:
			if butt == MainOrSuper.MAIN and VICTIM.can_main():
				VICTIM.main();
			if butt == MainOrSuper.SUPER and  VICTIM.can_super():
				VICTIM.zuper();

func _on_button_pressed() -> void:
	if VICTIM.can_hyper():
		VICTIM.hyper();
