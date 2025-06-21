class_name Curse
extends Node
# impl Gluon

var FATHER: Troop;
var VICTIM: Troop;
var life: float;
var damage: float;

func begin():
	print('begin curse');
func end():
	print('end curse');
	queue_free();

func _ready() -> void:
	begin();
func _physics_process(delta: float) -> void:
	FATHER.inflict(self, VICTIM);
	VICTIM.exflict(self);
	life -= delta;
	if life < 0:
		end();
