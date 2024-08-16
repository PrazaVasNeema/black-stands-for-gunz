extends Timer


var _param_thing
var _func_to_call : Callable


func lock_n_load(param_thing, func_to_call : Callable, tick_time : float):
	_param_thing = param_thing
	_func_to_call = func_to_call

	wait_time = tick_time
	one_shot = false
	stop()
	start()

	timeout.connect(_call_per_tick)


func _call_per_tick():
	_func_to_call.call(_param_thing)