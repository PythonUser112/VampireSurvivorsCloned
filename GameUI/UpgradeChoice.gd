extends Control

signal pressed

export (int) var number

var selected = false
var width = 424
var height = 64

func init(label, icon):
	$CenterContainer/VBoxContainer/Title.text = label
	if icon != null:
		$CenterContainer/VBoxContainer/UpgradePicture.texture = icon
	deselect()

func _process(_delta):
	if not get_parent().visible:
		return
	if Input.is_action_pressed("select") and selected:
		emit_signal("pressed", number)

func _input(event):
	if not get_parent().visible:
		return
	if event is InputEventMouseMotion:
		if margin_left <= event.position.x and event.position.x <= margin_left + width \
		and margin_top <= event.position.y and event.position.y <= margin_top + height:
			select()
		else:
			deselect()
	if event is InputEventMouseButton and selected:
		emit_signal("pressed", number)

func select():
	selected = true
	$Background.margin_left = 6
	$Background.margin_right = 418
	$Background.margin_top = 6
	$Background.margin_bottom = 58

func deselect():
	selected = false
	$Background.margin_left = 3
	$Background.margin_right = 421
	$Background.margin_top = 3
	$Background.margin_bottom = 61
