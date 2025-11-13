class_name Bush
extends Area2D


func _on_body_entered(body: Node2D) -> void:
	if body is Troop:
		body.n_bushes += 1;

func _on_body_exited(body: Node2D) -> void:
	if body is Troop:
		body.n_bushes -= 1;
