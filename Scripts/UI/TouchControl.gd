extends CanvasLayer

func _ready():
	if DisplayServer.is_touchscreen_available():
		showControls()
	else:
		hideControls()

func showControls():
	self.visible = true

func hideControls():
	self.visible = false
