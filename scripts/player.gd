extends Node

@export var BODY: CharacterBody2D;
@export var TROOP: Troop;

func _physics_process(delta: float) -> void:
	var dx = Input.get_axis("left", "right");
	var dy = Input.get_axis("up", "down");
	var d = Vector2(dx, dy).normalized();
	
	BODY.velocity = d * TROOP.stat.SPEED;
	BODY.move_and_slide();

 
func _input(event: InputEvent) -> void:
	if event is InputEventMouseButton:
		TROOP.main();
		print("hi")
