extends CanvasLayer

@export_file("*.tscn") var nextScene: String
@export var LevelName: String
@export var LevelNo: int

func _ready():
	$Intro/Label.text = "Level " + str(LevelNo) + ": " + LevelName
	$End/Container/Label.text = "Congrats! You have finished Level: " + LevelName
	$Pause.hide()
	$End.hide()
	$Intro.show()
	
	$Animation.play("Fade")
	await $Animation.animation_finished
	$Intro.hide()

func _unhandled_input(event: InputEvent):
	if event.is_action_pressed("Pause"):
		$Pause.show()
		get_tree().paused = true

func finished():
	$End.show()
	get_tree().paused = true

func _on_resume_pressed():
	get_tree().paused = false
	$Pause.hide()

func _on_exit_pressed() -> void:
	get_tree().paused = false
	get_tree().quit()

func _on_next_pressed() -> void:
	get_tree().paused = false
	get_tree().change_scene_to_file(nextScene)


func _on_finish_body_entered(body: Node2D):
	if body.is_in_group("Player"):
		finished()


func _on_finish_body_shape_entered(body_rid: RID, body: Node2D, body_shape_index: int, local_shape_index: int) -> void:
	pass # Replace with function body.
