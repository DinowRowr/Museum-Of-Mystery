extends Node2D

@onready var heartsContainer = $CanvasLayer/heartContainer
@onready var player = $TileMap/Player


var main_scene = preload("res://assets/Wilderness/main.tscn") 
var main_scene_instance = main_scene.instantiate()

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
	#print(main_scene_instance)
	pause_menu.hide()
	main_scene_instance.stop_bgm()
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
