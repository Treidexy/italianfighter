class_name Bush
extends Area2D


func _on_body_entered(body: Node2D) -> void:
	body.visible = false;

func _on_body_exited(body: Node2D) -> void:
	body.visible = true;
