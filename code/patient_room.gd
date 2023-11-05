extends Node

var db = load("res://code/tidz_db.gd")


func _ready():
	$Player.start($Room/Marker2D.position)
	db.commit_to_db_tester()


# Called every frame. 'delta' is the elapsed time since the previous frame.
func _process(delta):
	pass




func _on_patient_task_completed(sig_task_id):
	$RoomHUD.task_completed(sig_task_id)
