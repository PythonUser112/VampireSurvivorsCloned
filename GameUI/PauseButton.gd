extends Control

signal pressed

var selected = false
var width = 150
var height = 64

func _ready():
	deselect()

func _process(_delta):
	if not visible:
		return
	if Input.is_action_pressed("select") and selected:
		emit_signal("pressed")
	
func _input(event):
	if not visible:
		return
	if event is InputEventMouseMotion:
		if margin_left <= event.position.x and event.position.x <= margin_left + width \
		and margin_top <= event.position.y and event.position.y <= margin_top + height:
			select()
		else:
			deselect()
	if event is InputEventMouseButton and selected:
		emit_signal("pressed")

func select():
	selected = true
	$Background.margin_left = 6
	$Background.margin_right = 194
	$Background.margin_top = 6
	$Background.margin_bottom = 58

func deselect():
	selected = false
	$Background.margin_left = 3
	$Background.margin_right = 197
	$Background.margin_top = 3
	$Background.margin_bottom = 61
