extends CSGCylinder3D

var Player

@onready var animation_player = $"../../AnimationPlayer"
@onready var trampoline = $"../.."

@export var velocity: float


func _ready():
	pass

	




func _on_area_3d_body_entered(body):
	if body.name == "Player":
		Player = body
		Player.velocity.y = velocity
		animation_player.play("tram_jump")
