extends Bot

func rules():
	while true:
		for i in range(3):
			for x in range(3):
				move_forward()
			turn_left()

