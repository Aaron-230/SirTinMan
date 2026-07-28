extends Area2D

func _on_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		$Sound.play()
		GameManager.addCoins()
		await $Sound.finished
		queue_free()
