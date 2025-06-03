class_name Player
extends CharacterBody2D

@export var TROOP: Troop;
var main_dir := Vector2(0, 0);
var super_dir := Vector2(0, 0);

func _physics_process(delta: float) -> void:
	var dx = Input.get_axis("left", "right");
	var dy = Input.get_axis("up", "down");
	var d = Vector2(dx, dy).normalized();
	
	velocity = d * TROOP.stat.SPEED;
	move_and_slide();
	
	# because on mouseUp event, joystick is reset before we can read it :(
	var x := Input.get_axis('aim_main_left', 'aim_main_right')
	var y := Input.get_axis('aim_main_up', 'aim_main_down')
	main_dir = Vector2(x, y).normalized();
	x = Input.get_axis('aim_super_left', 'aim_super_right')
	y = Input.get_axis('aim_super_up', 'aim_super_down')
	super_dir = Vector2(x, y).normalized();

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() == false:
		if main_dir.length() > 0:
			TROOP.main(main_dir);
		if super_dir.length() > 0:
			TROOP.zuper(super_dir);
