class_name LiriliTroop
extends Troop

@export var RAM_PROJECTILE := preload("res://scenes/troops/lirili/lirili_ram_projectile.tscn");

func main():
	super();
	
	var proj: LiriliRamProjectile = RAM_PROJECTILE.instantiate();
	proj.FATHER = self;
	proj.life = 0.1;
	proj.position = position;
	proj.rotation = dir.angle();
	proj.velocity = dir * 200;
	proj.damage = 69;
	get_tree().current_scene.add_child(proj);

func zuper():
	super();

func hyper():
	super();
