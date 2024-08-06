extends Node2D

@onready var start_menu: StartMenu = $UI/StartMenu
const GAME = preload("res://scenes/game.tscn")

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_menu.start.connect(_start_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _start_game() -> void:
	start_menu.queue_free()
	var game = GAME.instantiate()
	self.add_child(game)
