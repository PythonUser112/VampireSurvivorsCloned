extends Area2D

# Used by enemy objects
var one_time = false
var damage = 1

var whipfield = false

export (int) var begin = 0
onready var length = $ColorRect.margin_left + $ColorRect.margin_right

func _ready():
	hide()
	$CollisionShape2D.disabled = true

func set_length(new_length):
	$ColorRect.margin_right = new_length - $ColorRect.margin_left
	($CollisionShape2D.shape as RectangleShape2D).extents = \
	Vector2(new_length, $ColorRect.margin_bottom + $ColorRect.margin_top)
	$CollisionShape2D.position.x = new_length / 2 - $ColorRect.margin_left
	length = new_length

func use():
	if not whipfield:
		$CollisionShape2D.disabled = false
		show()
		$Tween.interpolate_property(self, "rotation_degrees", begin - 45, begin + 45, 0.15)
		$Tween.start()
		yield($Tween, "tween_completed")
		hide()
		$CollisionShape2D.disabled = true
	else:
		$CollisionShape2D.disabled = false
		show()
		$Tween.interpolate_property(self, "rotation_degrees", begin+0, begin+360, 0.3)
		$Tween.start()
		yield($Tween, "tween_completed")
		hide()
		$CollisionShape2D.disabled = true
