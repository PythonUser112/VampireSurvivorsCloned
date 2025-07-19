extends Area2D

signal hurt_player

export (int) var damage_to_player
export (int) var attack_speed
export (int) var lives
export (int) var move_speed

var xp_scene = preload("res://player/XP.tscn")
var poison = 0
var playerpos = Vector2(0, 0)

func _ready():
	$ProgressContainer/TextureProgress.max_value = lives
	$ProgressContainer/TextureProgress.value = lives
	if attack_speed > 0:
		$AttackTimer.wait_time = attack_speed
	$AttackTimer.start()

func _on_EnemyBase_body_entered(body):
	if body.get_collision_layer_bit(2):
		emit_signal("hurt_player", damage_to_player)

func _on_EnemyBase_area_entered(area):
	if area.get_collision_layer_bit(4):
		hurt(area.damage)
		if area.one_time == true:
			area.queue_free()

func _on_AttackTimer_timeout():
	attack()

func hurt(damage):
	lives -= damage
	$ProgressContainer/TextureProgress.value = lives
	if lives > 0:
		$AnimatedSprite.play("hurt")
		yield($AnimatedSprite, "animation_finished")
		$AnimatedSprite.play("move")
	else:
		$AnimatedSprite.play("die")
		yield($AnimatedSprite, "animation_finished")
		if randi() % 100 < Globals.loot_chance:
			var xp = xp_scene.instance()
			xp.value = damage
			xp.position = position
			get_parent().add_child(xp)
		queue_free()

# Dummy function to prevent "cyclic reload" errors
func attack():
	pass

func set_player_position(pos):
	playerpos = pos

func _process(delta):
	position += (playerpos - position).normalized() * move_speed * delta
	lives -= poison * delta
