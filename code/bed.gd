extends Area2D

signal patient_task_start(sig_task_id: int)
signal patient_task_completed(sig_task_id: int)
@export var task_id: int = -1


func _ready():
	$TaskTimer.wait_time = randf_range(0.75,2)


func _on_bed_area_entered(body):
	print(body)
	if body.name == "Player":
		emit_signal("patient_task_start", task_id)
		$TaskIcon.show()
		$TaskTimer.start()



func _on_task_timer_timeout():
	emit_signal("patient_task_completed", task_id)
	$TaskIcon.hide()
