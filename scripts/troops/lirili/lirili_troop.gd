class_name LiriliTroop
extends Troop

@export var RAM_PROJECTILE := preload("res://scenes/troops/lirili/lirili_ram_projectile.tscn");
@export var CHARGE_PROJECTILE := preload("res://scenes/troops/lirili/lirili_charge_projectile.tscn");

func main():
	super();
	
	var stat: LiriliStat = stat;
	var proj: LiriliRamProjectile = RAM_PROJECTILE.instantiate();
	proj.FATHER = self;
	proj.life = 0.1;
	proj.position = position;
	proj.rotation = dir.angle();
	proj.velocity = dir * stat.RAM_SPEED;
	proj.damage = stat.RAM_DAMAGE;
	proj.dot = stat.RAM_DOT;
	proj.dot_life = stat.RAM_DOT_LIFE;
	get_tree().current_scene.add_child(proj);

func zuper():
	super();
	
	var stat: LiriliStat = stat;
	
	var proj := CHARGE_PROJECTILE.instantiate();
	proj.FATHER = self;
	proj.life = 6;
	proj.damage = stat.CHARGE_DAMAGE;
	proj.kb = stat.CHARGE_KB;
	proj.dot = stat.CHARGE_DOT;
	proj.dot_life = stat.CHARGE_DOT_LIFE;
	get_tree().current_scene.add_child(proj);
	
	var action := LiriliChargeAction.new();
	action.VICTIM = self;
	action.projectile = proj;
	action.dist = stat.CHARGE_DIST;
	action.velocity = dir * stat.CHARGE_SPEED;
	get_tree().current_scene.add_child(action);

func hyper():
	super();
	
	
