setup:
	mix deps.get
	mix ecto.setup
	cd assets && npm install