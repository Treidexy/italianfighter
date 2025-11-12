class_name LiriliTroop
extends Troop

@export var RAM_PROJECTILE := preload("res://scenes/troops/lirili/lirili_ram_projectile.tscn");
@export var CHARGE_PROJECTILE := preload("res://scenes/troops/lirili/lirili_charge_projectile.tscn");

func main():
	super();
	
	var stat: LiriliStat = stat;
	var proj: LiriliRamProjectile = RAM_PROJECTILE.instantiate();
	proj.FATHER = self;
	proj.life = stat.RAM_LIFE;
	print(stat)
	proj.position = position;
	proj.rotation = dir.angle();
	proj.velocity = dir * stat.RAM_SPEED;
	proj.damage = stat.RAM_DAMAGE;
	proj.dot = stat.THORN_DOT;
	proj.dot_life = stat.THORN_DOT_LIFE;
	get_tree().current_scene.add_child(proj);

func zuper():
	super();
	
	var stat: LiriliStat = stat;
	
	var proj := CHARGE_PROJECTILE.instantiate();
	proj.FATHER = self;
	proj.life = 6;
	proj.damage = stat.CHARGE_DAMAGE;
	proj.kb = stat.CHARGE_KB;
	proj.dot = stat.THORN_DOT;
	proj.dot_life = stat.THORN_DOT_LIFE;
	get_tree().current_scene.add_child(proj);
	
	var action := LiriliChargeAction.new();
	action.VICTIM = self;
	action.projectile = proj;
	action.dist = stat.CHARGE_DIST;
	action.velocity = dir * stat.CHARGE_SPEED;
	get_tree().current_scene.add_child(action);
	
func exflict(gluon):
	super(gluon);
	
	if !in_hyper:
		return
	
	var stat: LiriliStat = stat;
	var father: Troop = gluon.FATHER;
	var curse := LiriliThornCurse.new();
	curse.FATHER = self;
	curse.VICTIM = father;
	curse.dot = stat.THORN_DOT;
	curse.life = stat.THORN_DOT_LIFE;
	get_tree().current_scene.add_child(curse);
