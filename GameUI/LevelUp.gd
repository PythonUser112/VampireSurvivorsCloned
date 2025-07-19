extends Control

signal chosen

var upgrade_chosen
var upgrade_ids

func show():
	.show()
	upgrade_ids = Globals.get_upgrades()
	print(upgrade_ids)
	$Upgrade1.init(Globals.get_label(upgrade_ids[0]), Globals.get_icon(upgrade_ids[0]))
	$Upgrade2.init(Globals.get_label(upgrade_ids[1]), Globals.get_icon(upgrade_ids[1]))
	if Globals.upgrades_possible == 2:
		$Upgrade3.hide()
	else:
		$Upgrade3.show()
		$Upgrade3.init(Globals.get_label(upgrade_ids[2]), Globals.get_icon(upgrade_ids[2]))


func _on_Upgrade_chosen(number):
	hide()
	upgrade_chosen = number
	emit_signal("chosen")
	yield(get_tree().create_timer(0.5), "timeout")
	get_tree().paused = false
