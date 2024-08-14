extends Node2D

const GAME = preload("res://scenes/game.tscn")
const GAME_OVER = preload("res://scenes/game_over.tscn")
const PROLOGUE = preload("res://scenes/prologue.tscn")

@onready var start_menu: StartMenu = $UI/StartMenu
@onready var ui: Control = $UI
@onready var animation_player: AnimationPlayer = $UI/AnimationPlayer

# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	start_menu.start.connect(_start_prologue)

# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _start_prologue():
	start_menu.queue_free()
	var prologue = PROLOGUE.instantiate()
	prologue.finished.connect(_start_game.bind(prologue))
	ui.add_child(prologue)

func _start_game(prologue: Prologue) -> void:
	prologue.queue_free()
	var game = GAME.instantiate()
	game.game_over.connect(_game_over.bind(game))
	self.add_child(game)

func _game_over(score: int, game: Game):
	game.queue_free()
	var game_over = GAME_OVER.instantiate();
	ui.add_child(game_over)
	game_over.set_score(score)
