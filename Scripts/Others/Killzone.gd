extends Area2D

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		await get_tree().create_timer(2).timeout
		get_tree().reload_current_scene()
