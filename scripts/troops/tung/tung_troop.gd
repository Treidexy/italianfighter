class_name TungTroop
extends Troop

@export var SLASH: PackedScene = preload("res://scenes/troops/tung/tung_slash.tscn");
@export var THROW: PackedScene = preload("res://scenes/troops/tung/tung_throw.tscn");

func main(dir: Vector2):
	super(dir);
	var proj: TungSlash = SLASH.instantiate();
	proj.FATHER = self;
	proj.life = 0.3;
	proj.position = position;
	proj.rotation = dir.angle();
	if stat is TungStat:
		proj.damage = stat.MAIN_DAMAGE;
		proj.kb = stat.KB;
	get_tree().current_scene.add_child(proj);

func zuper(dir: Vector2):
	super(dir);	
	var proj: TungThrow = THROW.instantiate();
	proj.FATHER = self;
	proj.life = 3.0;
	proj.position = position;
	proj.rotation = dir.angle();
	if stat is TungStat:
		proj.velocity = dir * stat.THROW_SPEED;
		proj.damage = stat.SUPER_DAMAGE;
		proj.kb = stat.KB;
	get_tree().current_scene.add_child(proj);
