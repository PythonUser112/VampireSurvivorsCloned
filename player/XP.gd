extends Area2D

export (int) var value

var poison = 0

signal pickup

func _on_XP_body_entered(body):
	if body.get_collision_layer_bit(2):
		emit_signal("pickup", value)
		queue_free()


func _on_DecayTimer_timeout():
	queue_free()
