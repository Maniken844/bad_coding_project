extends CSGCylinder3D

var IsPlayerOn = false
var Player


func _physics_process(delta):
	if IsPlayerOn:
		Player.position.x -= 6.5 * delta


func _on_area_3d_body_entered(body):
	if body.name == "Player":
		Player = body
		IsPlayerOn = true
	


func _on_area_3d_body_exited(body):
	if body.name == "Player":
		IsPlayerOn = false

