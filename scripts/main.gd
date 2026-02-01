extends Node2D
@onready var score_label: Label = $HUD/ScorePanel/ScoreLabel

var score: int = 0


# Called when the node enters the scene tree for the first time.
func _ready() -> void:
	_setup_level()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(_delta: float) -> void:
	pass

func _setup_level() -> void:
	
	#connect turtles
	var turtles = $LevelRoot.get_node_or_null("Turtles")
	if turtles:
		for turtle in turtles.get_children():
			turtle.collected.connect(increase_score)
			
	#connect enimies
	var enemies = $LevelRoot.get_node_or_null("Enemies")
	if enemies:
		for enemy in enemies.get_children():
			enemy.player_died.connect(_on_player_died)


#--------------------------
# SIGNAL HANDLERS
#--------------------------
func _on_player_died(body):
	body.die()
	print("Player Killed")

#--------------------------
# SCORE
#--------------------------
func increase_score() -> void:
	score += 1
	score_label.text = "SCORE: %s" % score
