class_name LiriliChargeProjectile
extends Projectile

var dot: float;
var dot_life: float;

func _physics_process(delta: float) -> void:
	super(delta);
	
	position = FATHER.position;
	
func hit_wall(wall: Wall):
	if wall.breakable:
		wall.queue_free();

func hit(victim: Troop):
	super(victim);
	
	if victim.team == FATHER.team:
		return;
		
	var curse := LiriliThornCurse.new();
	curse.FATHER = FATHER;
	curse.VICTIM = victim;
	curse.dot = dot;
	curse.life = dot_life;
	get_tree().current_scene.add_child(curse);
