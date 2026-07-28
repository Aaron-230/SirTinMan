extends CanvasLayer

@onready var HealthBar: TextureProgressBar = $Container/Health/ProgressBar
@onready var Counter: Label = $Container/Coins/Counter

func _ready():
	GameManager.changeHealth.connect(changeHealth)
	GameManager.changeCoins.connect(addCoins)
	
	HealthBar.value = GameManager.Health
	Counter.text = str(GameManager.Coins)

func changeHealth(NewHealth):
	HealthBar.value = NewHealth
	if NewHealth <= 0:
		GameManager.resetGame()
		get_tree().reload_current_scene()

func addCoins(Coins):
	Counter.text = str(Coins)
