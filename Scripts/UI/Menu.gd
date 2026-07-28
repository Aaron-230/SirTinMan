extends Control

@export_file("*.tscn") var nextScene: String

func _on_start_pressed():
	get_tree().change_scene_to_file(nextScene)

func _on_end_pressed():
	get_tree().quit()
