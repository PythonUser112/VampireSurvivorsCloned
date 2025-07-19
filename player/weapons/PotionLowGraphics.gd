extends Area2D

var one_time = false
var damage = Globals.potion_damage
var move_speed = 0
var poison = 0

func _ready():
	$CollisionShape2D.shape.radius = Globals.potion_radius
	$MeshInstance2D.mesh.radius = Globals.potion_radius
	$MeshInstance2D.mesh.height = 2*Globals.potion_radius

func _on_DecayTimer_timeout():
	queue_free()

func _on_PotionLowGraphics_area_entered(area):
	area.poison += 10
