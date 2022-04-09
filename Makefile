up:
	docker-compose up -d

stop:
	docker-compose stop

down:
	docker-compose down

ssl-certs:
	mkcert -cert-file certs/local-cert.pem -key-file certs/local-key.pem "apollo.localhost" "*.apollo.localhost" "apollo.local" "*.apollo.local"
