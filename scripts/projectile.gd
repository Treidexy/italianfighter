class_name Projectile
extends Area2D
# impl Gluon

var FATHER: Troop;
var life: float = 6.9;
var velocity: Vector2 = Vector2(0, 0);

var kb: float = 0;
var damage: float = 0;

@export var ray: RayCast2D;

###

func hit(victim: Troop):
	# ik hacky right
	if victim == FATHER:
		return;
	
	FATHER.inflict(self, victim);
	#troop.hp -= damage; # troop.exflict deals w ts
	if kb > 0:
		var d = victim.position - position;
		# bc nga godot has no fking .set-length()
		d = d.normalized() * (1 / sqrt(d.length()) * kb);
		var curse = KbAction.new();
		curse.VICTIM = victim;
		curse.force = d;
		curse.life = 0.25;
		get_tree().root.add_child(curse);
	victim.exflict(self);
func hit_wall(wall: Wall): pass
func die():
	queue_free();

###

func _physics_process(delta: float) -> void:
	life -= delta;
	if life < 0:
		die();
	#velocity = VEL;
	position += velocity * delta;

func _on_body_entered(body: Node2D) -> void:
	#print("see " + str(body));
	#if body is Wall:
		#hit_wall(body);
	ray.target_position = body.position - position;
	ray.clear_exceptions();
	ray.add_exception_rid(FATHER.get_rid());
	ray.add_exception_rid(body.get_rid());
	ray.force_raycast_update();
	var result = ray.get_collider();
	if result != null:
		print(result.name);
		return;
	if body is Troop:
		#print("hit " + str(body));
		#if not thru_walls:
		hit(body);
