extends Control

signal pause
signal unpause
signal upgraded

var time_in_seconds = 0

func gather_xp(xp):
	Globals.xp_collected += xp
	if Globals.xp_collected >= Globals.xp_max:
		Globals.xp_collected -= Globals.xp_max
		Globals.player_level += 1
		$StatusContainer.hide()
		$MainTimer.stop()
		$LevelUp.show()
		get_tree().paused = true
		yield($LevelUp, "chosen")
		get_tree().paused = false
		$LevelUp.hide()
		Globals.upgrade($LevelUp.upgrade_ids[$LevelUp.upgrade_chosen - 1])
		$MainTimer.start()
		$StatusContainer.show()
		Globals.xp_max = int(Globals.xp_max * 1.375 + 0.5)
		emit_signal("upgraded")
		set_lives(Globals.player_lives)
		set_lives_maximum(Globals.player_max_lives)
	$StatusContainer/MainArranger/LevelXPArranger/XPContainer/XPBar.value = 100 * Globals.xp_collected / Globals.xp_max
	$StatusContainer/MainArranger/LevelXPArranger/XPContainer/XPLabel.text = str(Globals.xp_collected)

func set_lives_maximum(max_lives):
	$StatusContainer/MainArranger/LivesContainer/Arranger/LivesBar.max_value = max_lives

func set_lives(lives):
	$StatusContainer/MainArranger/LivesContainer/Arranger/LivesBar.value = int(lives)
	$StatusContainer/MainArranger/LivesContainer/Arranger/CenterContainer/LivesLabel.text = "Lives: " + str(int(lives))


func start_game():
	Globals.initialize_upgrades()
	$MainTimer.start()
	$StatusContainer/MainArranger/LivesContainer/Arranger/LivesBar.max_value = Globals.player_max_lives
	set_lives(Globals.player_max_lives)

func _on_MainTimer_timeout():
	time_in_seconds += 1
	var minutes = time_in_seconds / 60
	var hours = minutes / 60
	var str_seconds = str(time_in_seconds - 60 * minutes)
	if time_in_seconds - 60 * minutes < 10:
		str_seconds = "0" + str_seconds
	var str_minutes = str(minutes - 60 * hours)
	if minutes - 60 * hours < 10:
		str_minutes = "0" + str_minutes
	$StatusContainer/MainArranger/TimeLabel.text = str(hours) + ":" + str_minutes + ":" + str_seconds


func _on_PauseButton_pressed():
	get_tree().paused = true
	$StatusContainer.hide()
	$PauseButton.hide()
	$MainTimer.stop()
	emit_signal("pause")

func continue_pause():
	$PauseMenu.show()
	yield($PauseMenu, "unpause")
	$PauseButton.show()
	$StatusContainer.show()
	$MainTimer.start()
	emit_signal("unpause")

