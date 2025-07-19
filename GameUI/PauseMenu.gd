extends Control

signal unpause

func show():
	.show()
	for i in range(0, 50, 1):
		yield(get_tree().create_timer(0.01), "timeout")
		$ColorRect.color = Color(float(i) / 100, float(i) / 100, float(i) / 100)
	$ColorRect.color = Color(0.5, 0.5, 0.5)
	$CenterContainer.show()

func hide():
	$CenterContainer.hide()
	for i in range(50, 0, -1):
		yield(get_tree().create_timer(0.01), "timeout")
		$ColorRect.color = Color(float(i) / 100, float(i) / 100, float(i) / 100)
	$ColorRect.color = Color(0, 0, 0)
	.hide()
	emit_signal("unpause")

func _on_Button_pressed():
	hide()
