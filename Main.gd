extends Node

export (PackedScene) var mob_scene

# Called when the node enters the scene tree for the first time.
func _ready():
	randomize()
	$UserInterface/Retry.hide()


# Called every frame. 'delta' is the elapsed time since the previous frame.
#func _process(delta):
#	pass


func _on_MobTimer_timeout():
	#instanciate scene
	var mob = mob_scene.instance()
	# Random Location from Spawnpath
	var mob_spawn_location = get_node("SpawnPath/SpawnLocation")
	#Random offset
	mob_spawn_location.unit_offset = randf()
	
	var player_position = $Player.transform.origin
	mob.initialize(mob_spawn_location.translation, player_position)
	add_child(mob)
	mob.connect("squashed", $UserInterface/ScoreLabel, "_on_Mob_squashed")


func _on_Player_hit():
	$MobTimer.stop()
	$UserInterface/Retry.show()

func _unhandled_input(event):
	if event.is_action_pressed("ui_accept") and $UserInterface/Retry.visible:
		# This restarts the current scene.
		get_tree().reload_current_scene()