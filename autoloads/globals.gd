extends Node

enum UPGRADES {
	BASE_WEAPON = 0,
	SPEED = 1,
	REGEN = 2,
	HEALTH = 3,
	FORCE_FIELD = 4,
	SPLASH_DAMAGE = 5,
	GAME = 6
}

var xp_max = 10
var xp_collected = 0
var player_level = 1
var upgrades_possible = 2
var upgrades_left = 20
var save = "user://settings.txt"
var upgrade_names =    {UPGRADES.BASE_WEAPON: ["A new whip", "Stronger Player", "Longer whips"],
						UPGRADES.SPEED: ["Better boots", "Low-friction boots", "Flying boots"],
						UPGRADES.REGEN: ["Regeneration potion", "Healer exams"],
						UPGRADES.HEALTH: ["Healthier player", "Wooden armor", "Steel armor"],
						UPGRADES.FORCE_FIELD: ["A force field", "Stronger force", "A whipfield"],
						UPGRADES.SPLASH_DAMAGE: ["Posionous potions", "Bigger splash", "Weakening posion"],
						UPGRADES.GAME: ["Intelligent weapons", "More upgrades", "Full version!"]}
var upgrades_done = [0, 0, 0, 0, 0, 0, 0]
var loot_chance = 50

var player_speed = 10
var player_friction = 0.95
var player_max_lives = 15
var player_lives = player_max_lives * 1.0
var player_regeneration = 0.05
var player_base_weapon_range = 160
var player_base_weapon_damage = 1
var force_field_force = 0
var potion_damage = 0
var potion_radius = 100

func _ready():
	randomize()
	
func initialize_upgrades():
	upgrades_done = [0, 0, 0, 0, 0, 0, upgrades_done[UPGRADES.GAME]]

func get_upgrades():
	var up = -1
	var upgrades = []
	for _i in range(upgrades_possible):
		while up < 0:
			up = randi() % 7
			if upgrades_done[up] == len(upgrade_names[up]):
				up = -1
		upgrades.append(up)
		up = -1
	return upgrades


func get_label(upgrade):
	return upgrade_names[upgrade][upgrades_done[upgrade]]

# warning-ignore:unused_argument
func get_icon(upgrade):
	pass

func upgrade(upgrade):
	upgrades_left -= 1
	if upgrades_left == 0:
		xp_max = 100000000
	upgrades_done[upgrade] += 1
	if upgrade == UPGRADES.GAME and upgrades_done[UPGRADES.GAME] >= 2:
		upgrades_possible = 3
	if upgrade == UPGRADES.HEALTH:
		player_max_lives *= 2
		player_lives *= 2
	elif upgrade == UPGRADES.REGEN:
		player_regeneration *= 4
	elif upgrade == UPGRADES.SPEED:
		player_friction += 0.01
		player_speed *= 1.1
	elif upgrade == UPGRADES.BASE_WEAPON:
		if upgrades_done[UPGRADES.BASE_WEAPON] == 2:
			player_base_weapon_damage = 4 * player_base_weapon_damage
		elif upgrades_done[UPGRADES.BASE_WEAPON] == 3:
			player_base_weapon_range = 1.5 * player_base_weapon_range
	elif upgrade == UPGRADES.FORCE_FIELD:
		force_field_force *= 1.5
		force_field_force += 25
	elif upgrade == UPGRADES.SPLASH_DAMAGE:
		if upgrades_done[UPGRADES.SPLASH_DAMAGE] == 1:
			potion_damage = 2
		elif upgrades_done[UPGRADES.SPLASH_DAMAGE] == 2:
			potion_radius *= 2
