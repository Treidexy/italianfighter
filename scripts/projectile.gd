class_name Projectile
extends Area2D
# impl Gluon

var FATHER: Troop;
var life: float = 6.9;
var velocity: Vector2;

var kb: float = 0;
var damage: float = 0;

###

func hit(victim: Troop):
	FATHER.inflict(self, victim);
	#troop.hp -= damage; # troop.exflict deals w ts
	if kb > 0:
		var d = victim.position - position;
		# bc nga godot has no fking .set-length()
		d = d.normalized() * (1 / sqrt(d.length()) * kb);
		var curse = KbAction.new();
		curse.VICTIM = victim;
		curse.force = d;
		get_tree().root.add_child(curse);
	victim.exflict(self);
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
	#print("see " + str(body));
	if body is Troop and body != FATHER:
		#print("hit " + str(body));
		hit(body);
