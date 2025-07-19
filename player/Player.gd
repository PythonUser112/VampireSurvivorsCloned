extends KinematicBody2D

signal dead

var movement = Vector2(0, 0)

func _ready():
	$AttackTimer.start()

func hurt():
	$Sprite.play("hurt")
	yield($Sprite, "animation_finished")
	$Sprite.play("move")

func die():
	$Sprite.play("die")
	yield($Sprite, "animation_finished")
	emit_signal("dead")
	queue_free()

func _physics_process(delta):
	if Input.is_action_pressed("up"):
		movement.y -= Globals.player_speed
	if Input.is_action_pressed("down"):
		movement.y += Globals.player_speed
	if Input.is_action_pressed("right"):
		movement.x += Globals.player_speed
		$Sprite.flip_h = false
	if Input.is_action_pressed("left"):
		movement.x -= Globals.player_speed
		$Sprite.flip_h = true
	movement = move_and_slide(movement, -movement.normalized()) * Globals.player_friction
	if Globals.player_lives < Globals.player_max_lives:
		Globals.player_lives += delta * Globals.player_regeneration
	else:
		Globals.player_lives = Globals.player_max_lives

func _on_AttackTimer_timeout():
	attack()

func upgraded():
	pass

func attack():
	pass
