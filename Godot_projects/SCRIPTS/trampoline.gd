extends CSGCylinder3D

var Player_going_up = false
var Player
var Player_highest_value = 0

@onready var animation_player = $"../../AnimationPlayer"




func _physics_process(delta):
	if Player_going_up:
		Player.position.y += GlobalVariables.player_gravity * 1.3 *delta
		if Player.position.y > Player_highest_value:
			Player_highest_value = Player.position.y
		elif Player.position.y < Player_highest_value:
			Player_going_up = false
			Player_highest_value = 0




func _on_area_3d_body_entered(body):
	if body.name == "Player":
		Player = body
		Player_going_up = true
		animation_player.play("tram_jump")
