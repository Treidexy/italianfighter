class_name CapuTroop
extends Troop

@export var SLASH: PackedScene = preload("res://scenes/troops/capu/capu_slash.tscn");


func main(dir: Vector2):
	super(dir);
	
	var stat := stat as CapuStat;
	var pos = position + dir * stat.DASH_DIST;
	velocity = dir * stat.DASH_DIST;
	move_and_slide();
	
	var proj1: CapuSlash = SLASH.instantiate();
	proj1.FATHER = self;
	proj1.life = 0.3;
	proj1.position = position;
	proj1.rotation = dir.angle();
	proj1.damage = stat.MAIN_HALF_DAMAGE;
	get_tree().current_scene.add_child(proj1);
	
	var proj2: CapuSlash = SLASH.instantiate();
	proj2.FATHER = self;
	proj2.life = 0.3;
	proj2.position = position;
	proj2.rotation = dir.angle();
	proj2.scale.y = -1;
	proj2.damage = stat.MAIN_HALF_DAMAGE;
	get_tree().current_scene.add_child(proj2);
