extends Node

@export var BODY: CharacterBody2D;
@export var TROOP: Troop;
var dir := Vector2(0, 0);

func _physics_process(delta: float) -> void:
	var dx = Input.get_axis("left", "right");
	var dy = Input.get_axis("up", "down");
	var d = Vector2(dx, dy).normalized();
	
	BODY.velocity = d * TROOP.stat.SPEED;
	BODY.move_and_slide();
	
	# because on mouseUp event, joystick is reset before we can read it :(
	var x := Input.get_axis('aim_left', 'aim_right')
	var y := Input.get_axis('aim_up', 'aim_down')
	dir = Vector2(x, y).normalized();

func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton and event.is_pressed() == false and dir.length() > 0:
		TROOP.main(dir);
