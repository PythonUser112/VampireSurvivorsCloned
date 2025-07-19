extends Area2D

var poison = 0

func _on_ForceField_area_entered(area):
	area.move_speed -= Globals.force_field_force

func _on_ForceField_area_exited(area):
	area.move_speed += Globals.force_field_force
