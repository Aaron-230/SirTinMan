extends CanvasLayer

@onready var HealthBar: TextureProgressBar = $ProgressBar
var Health: int = 100

func _ready():
	HealthBar.value = Health

func changeHealth(amount):
	HealthBar.value = amount
