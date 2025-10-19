extends StaticBody2D

func pick_up():
	DataManager.collect_goal("WIN31")
	queue_free()
