extends Node

func _ready():
	if Globals.full_version == false:
# warning-ignore:return_value_discarded
		get_tree().change_scene("res://DemoVersion.tscn")
