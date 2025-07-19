extends Node2D

var enemy_container
var enemy_classes =    [preload("res://enemies/LowGraphics/BatLowGraphics.tscn"),
						preload("res://enemies/LowGraphics/SkelletonLowGraphics.tscn"),
						preload("res://enemies/LowGraphics/GiantLowGraphics.tscn")]
var enemy_count = []

func _ready():
	for _i in range(len(enemy_classes)):
		enemy_count.append(0)
	enemy_count[0] = 1

func stimulate():
	for i in range(len(enemy_classes)):
		for _j in range(enemy_count[i]):
			var enemy = enemy_classes[i].instance()
			enemy.position = position
			yield(get_tree().create_timer(0.5), "timeout")
			enemy_container.add_child(enemy)
		if enemy_count[i]:
			enemy_count[i] += 1
		if enemy_count[i] == 8 and i < len(enemy_classes) - 1:
			enemy_count[i + 1] = 1 
		if enemy_count[i] > 16:
			enemy_count[i] = 16
