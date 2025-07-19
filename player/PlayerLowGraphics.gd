extends "res://player/Player.gd"

var potion = preload("res://player/weapons/PotionLowGraphics.tscn")
var poison = 0
var count = 0

func upgraded():
	if Globals.upgrades_done[Globals.UPGRADES.FORCE_FIELD] >= 3:
		$Whip1.whipfield = true
		$Whip2.whipfield = true
	$Whip1.set_length(Globals.player_base_weapon_range)
	$Whip2.set_length(Globals.player_base_weapon_range)
	$Whip1.damage = Globals.player_base_weapon_damage
	$Whip2.damage = Globals.player_base_weapon_damage
	if Globals.upgrades_done[Globals.UPGRADES.FORCE_FIELD] > 0:
		$ForceFieldLowGraphics.show()
	else:
		$ForceFieldLowGraphics.hide()

func attack():
	if Globals.upgrades_done[Globals.UPGRADES.SPLASH_DAMAGE] > 0:
		count += 1
		if count % 10 == 0:
			var poison = potion.instance()
			poison.position = position - movement.normalized() * 50
			get_parent().add_child(poison)
	$Whip1.use()
	if Globals.upgrades_done[Globals.UPGRADES.BASE_WEAPON] >= 1:
		$Whip2.use()
