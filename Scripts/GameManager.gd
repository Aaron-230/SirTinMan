extends Node

var MaxHealth = 100
var Health = MaxHealth
var Coins = 0

signal changeHealth(newHealth)
signal changeCoins()
signal PlayerDied()

func takeDamage(Amount):
	Health -= Amount
	Health = clamp(Health, 0, MaxHealth)
	changeHealth.emit(Health)
	
	if Health <= 0:
		PlayerDied.emit()

func Heal(Amount):
	Health += Amount
	Health = clamp(Health, 0, MaxHealth)
	changeHealth.emit(Health)

func addCoins():
	Coins += 1
	changeCoins.emit(Coins)

func resetHealth():
	Health = MaxHealth
	changeHealth.emit(Health)

func resetGame():
	Health = MaxHealth
	Coins = 0
	
	changeHealth.emit(Health)
	changeCoins.emit(Coins)
