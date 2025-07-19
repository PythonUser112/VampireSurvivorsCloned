extends Control

func _ready():
	$HUDLayer/HUD.start_game()

func _on_HUD_pause():
	for i in range(100, 0, -1):
		yield(get_tree().create_timer(0.01), "timeout")
		$CanvasModulate.color = Color(float(i) / 100, float(i) / 100, float(i) / 100)
	$CanvasModulate.color = Color(0, 0, 0)
	$HUDLayer/HUD.continue_pause()


func _on_HUD_unpause():
	for i in range(0, 100, 1):
		yield(get_tree().create_timer(0.01), "timeout")
		$CanvasModulate.color = Color(float(i) / 100, float(i) / 100, float(i) / 100)
	$CanvasModulate.color = Color(1, 1, 1)


func _on_StandardLevel_player_hurt(amount):
	Globals.player_lives -= amount
	if Globals.player_lives < 1:
		$StandardLevel/PlayerLowGraphics.die()
		yield($StandardLevel/PlayerLowGraphics/Sprite, "animation_finished")
		get_tree().quit()
	else:
		$StandardLevel/PlayerLowGraphics.hurt()
func _process(_delta):
	$HUDLayer/HUD.set_lives(Globals.player_lives)

func collect_xp(amount):
	$HUDLayer/HUD.gather_xp(amount)


func _on_HUD_upgraded():
	$StandardLevel/PlayerLowGraphics.upgraded()
