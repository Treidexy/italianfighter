extends Node

@export var default_addr: Addr;

@export var port_input: TextEdit;
@export var ip_input: TextEdit;
@export var connect_panel: CanvasLayer;

@export var id_label: Label;
@export var game_scene := preload("res://scenes/game.tscn");

func _ready() -> void:
	multiplayer.peer_connected.connect(_on_connect1);
	multiplayer.connected_to_server.connect(_on_connect);
	multiplayer.peer_disconnected.connect(_on_disconnect1);
	
	multiplayer.server_disconnected.connect(_on_disconnect);
	multiplayer.connection_failed.connect(_on_fail);
	
	if default_addr == null:
		default_addr = Addr.new();
	port_input.text = str(default_addr.port);
	ip_input.text = default_addr.ip;

func make():
	print('make');
	connect_panel.queue_free();
	var peer = ENetMultiplayerPeer.new();
	var error = peer.create_server(int(port_input.text));
	if error:
		print('errm ' + str(error));
		return;
	
	multiplayer.multiplayer_peer = peer;
	
	# haxy
	_on_connect();

func join():
	print('join');
	connect_panel.queue_free();
	var peer = ENetMultiplayerPeer.new();
	var error = peer.create_client(ip_input.text, int(port_input.text));
	if error:
		print('errj ' + str(error));
		return;
	multiplayer.multiplayer_peer = peer;

###

func _on_connect():
	add_child(game_scene.instantiate());
	
	var id = multiplayer.get_unique_id();
	id_label.text = 'id = ' + str(id);
	print("connected " + str(id));
	add_player(id);

func _on_connect1(id):
	print("connected1 " + str(id));
	add_player(id);

func _on_disconnect():
	print('disconnect');
	
func _on_disconnect1(id):
	print('disconnect1 ' + str(id));
	remove_player(id);

func _on_fail():
	print('faile');

###

func add_player(id): pass
func remove_player(id): pass
