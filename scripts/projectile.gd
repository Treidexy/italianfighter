class_name Projectile
extends Area2D

var FATHER: Troop;
var LIFE: float = 6.9;

func _physics_process(delta: float) -> void:
	LIFE -= delta;
	if LIFE < 0:
		queue_free();

func _on_body_entered(body: Node) -> void:
	print("see " + str(body)); # Replace with function body.
	if body != FATHER:
		print("hit " + str(body)); # Replace with function body.
