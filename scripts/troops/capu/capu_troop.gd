class_name CapuTroop
extends Troop

@export var SLASH: PackedScene = preload("res://scenes/troops/capu/capu_slash.tscn");

func slash():
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

func main():
	super();
	
	var stat := stat as CapuStat;
	var action = CapuDashAction.new();
	action.VICTIM = self;
	action.dist = stat.DASH_DIST;
	action.velocity = dir * stat.DASH_SPEED;
	get_tree().current_scene.add_child(action);

func zuper():
	super();
	
	var stat := stat as CapuStat;
	var action = CapuJumpAction.new();
	action.VICTIM = self;
	action.dest = position + dir * stat.JUMP_DIST;
	action.duration = stat.JUMP_DURATION;
	get_tree().current_scene.add_child(action);
