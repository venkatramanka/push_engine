Pusher::Engine.routes.draw do
	get 'push/push_frame' => 'push#push_frame'
	post 'push/send_msg' => 'push#send_msg'
end
