extends Node2D

const GAME = preload("res://scenes/game.tscn")
const GAME_OVER = preload("res://scenes/game_over.tscn")

@onready var start_menu: StartMenu = $UI/StartMenu
@onready var ui: Control = $UI

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_menu.start.connect(_start_game)


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta: float) -> void:
	pass

func _start_game() -> void:
	start_menu.queue_free()
	var game = GAME.instantiate()
	game.game_over.connect(_game_over.bind(game))
	self.add_child(game)

func _game_over(score: int, game: Game):
	game.queue_free()
	var game_over = GAME_OVER.instantiate();
	ui.add_child(game_over)
	game_over.set_score(score)
