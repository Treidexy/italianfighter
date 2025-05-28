class_name Projectile
extends Area2D

var MOVE: Vector2 = Vector2(-5, 0);
var LIFE: float = 6.9;

func _physics_process(delta: float) -> void:
	position += MOVE * delta;
	LIFE -= delta;
	if LIFE < 0:
		queue_free();

func _on_body_entered(body: Node) -> void:
	print("hit " + str(body)); # Replace with function body.
