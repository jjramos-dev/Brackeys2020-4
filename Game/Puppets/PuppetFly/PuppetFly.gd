extends Puppet

func apply_charge():
	if energy > 0:
		direction = 1
		velocity.y = 0
	elif direction > 0.01:
		direction *= stop_speed
	else:
		direction = 0
	velocity.x = speed * direction
	velocity = move_and_slide(velocity,Vector2.UP)
