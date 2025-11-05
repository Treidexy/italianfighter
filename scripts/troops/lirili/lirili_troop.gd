class_name LiriliTroop
extends Troop

@export var RAM_PROJECTILE := preload("res://scenes/troops/lirili/lirili_ram_projectile.tscn");
@export var CHARGE_PROJECTILE := preload("res://scenes/troops/lirili/lirili_charge_projectile.tscn");

func main():
	super();
	
	var proj: LiriliRamProjectile = RAM_PROJECTILE.instantiate();
	proj.FATHER = self;
	proj.life = 0.1;
	proj.position = position;
	proj.rotation = dir.angle();
	proj.velocity = dir * 200;
	proj.damage = 700;
	proj.dot = 200;
	proj.dot_life = 4;
	get_tree().current_scene.add_child(proj);

func zuper():
	super();
	
	var proj := CHARGE_PROJECTILE.instantiate();
	proj.FATHER = self;
	proj.life = 67;
	proj.damage = 670;
	proj.kb = 275;
	get_tree().current_scene.add_child(proj);
	
	var action := LiriliChargeAction.new();
	action.VICTIM = self;
	action.projectile = proj;
	action.dist = 100;
	action.velocity = dir * 80;
	get_tree().current_scene.add_child(action);

func hyper():
	super();
