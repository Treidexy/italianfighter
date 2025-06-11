class_name Projectile
extends Area2D

var FATHER: Troop;
var life: float = 6.9;
var velocity: Vector2;

var damage: float = 0;

###

func hit(troop: Troop):
	FATHER.inflict(self, troop);
	troop.hp -= damage;
	troop.exflict(self);
func die():
	queue_free();

###

func _physics_process(delta: float) -> void:
	life -= delta;
	if life < 0:
		die();
	#velocity = VEL;
	position += velocity * delta;

func _on_body_entered(body: Node) -> void:
	print("see " + str(body));
	if body is Troop and body != FATHER:
		print("hit " + str(body));
		hit(body);
