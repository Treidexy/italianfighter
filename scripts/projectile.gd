class_name Projectile
extends CharacterBody2D

var FATHER: Troop;
var LIFE: float = 6.9;
#var VEL: Vector2;

func _physics_process(delta: float) -> void:
	LIFE -= delta;
	if LIFE < 0:
		queue_free();
	#velocity = VEL;
	move_and_collide(velocity * delta);

func _on_body_entered(body: Node) -> void:
	print("see " + str(body)); # Replace with function body.
	if body != FATHER:
		print("hit " + str(body)); # Replace with function body.
