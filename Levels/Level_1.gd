extends Node2D

signal player_hurt

var enemy_spawner = preload("res://enemies/LowGraphics/EnemySpawnerLowGraphics.tscn")

func _on_PlayerLowGraphics_dead():
	get_tree().quit()

func _ready():
	for cell in $GroundMap.get_used_cells():
		var cell_value = $GroundMap.get_cellv(cell)
		if cell_value == 2:
			var spawner = enemy_spawner.instance()
			spawner.position = cell * $GroundMap.cell_size.x
			spawner.enemy_container = $EnemyContainer
			$EnemySpawners.add_child(spawner)
	stimulate()
	$WaveTimer.start()

func stimulate():
	for spawner in $EnemySpawners.get_children():
		spawner.stimulate()

func _process(_delta):
	for obj in $EnemyContainer.get_children():
		if obj.get_collision_layer_bit(3) and not obj.is_connected("pickup", self, "xp_collect"):
			obj.connect("pickup", self, "xp_collect")
		elif obj.get_collision_layer_bit(1) and not obj.is_connected("hurt_player", self, "player_hurt"):
			obj.connect("hurt_player", self, "player_hurt")
	for enemy in $EnemyContainer.get_children():
		if enemy.get_collision_layer_bit(1):
			enemy.set_player_position($PlayerLowGraphics.position)

func player_hurt(amount):
	emit_signal("player_hurt", amount)

func xp_collect(amount):
	get_parent().collect_xp(amount)
