extends Node2D


@onready var heartsContainer = $CanvasLayer/heartContainer
@onready var player = $TileMap/Player

@onready var pause_menu = $"CanvasLayer2/Pause Menu"
var paused = false


func pauseMenu():
	if paused:
		pause_menu.hide()
		Engine.time_scale = 1
	else:
		pause_menu.show()
		Engine.time_scale = 0

	paused = !paused


# Called when the node enters the scene tree for the first time.
func _ready():
	pause_menu.hide()
	heartsContainer.setMaxHearts(player.maxHealth)
	heartsContainer.updateHearts(player.currentHealth)
	player.healthChanged.connect(heartsContainer.updateHearts)
	
# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	if Input.is_action_just_pressed("pause"):
		pauseMenu()


func _on_inventory_gui_closed():
	get_tree().paused = false


func _on_inventory_gui_opened():
	get_tree().paused = true
