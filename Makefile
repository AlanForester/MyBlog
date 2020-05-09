GITHASH=`git log -1 --pretty=format:"%h" || echo "???"`
CURDATE=`date -u +%Y.%m.%d_%H:%M:%S`
VERSION=dev

APPVERSION=${VERSION}_${GITHASH}_${CURDATE}

install:
	mix deps.get
	mix deps.compile
	mix ecto.create
	mix ecto.create test
	make migrate

tests:
	mix test

server:
	iex -S mix phx.server

migrate:
	mix ecto.migrate

clean:
	mix deps.clean --all

