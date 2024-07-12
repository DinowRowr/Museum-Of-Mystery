extends TileMap

@onready var animation_intro = $AnimationPlayer

func _ready():
	animation_intro.play("fade_out")
	get_tree().create_timer(3).timeout.connect(start_scene)
 
func start_scene():
	pass
