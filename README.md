# Traefik v2 HTTPS (SSL) on localhost

This repo is a minimal template to use Traefik v2 on localhost with HTTPS support.

To get started, just clone this repo:

```bash
git clone https://github.com/Heziode/traefik-v2-https-ssl-localhost.git
```

Next, go to the root of the repo (`cd traefik-v2-https-ssl-localhost`) and generate certificates using [mkcert](https://github.com/FiloSottile/mkcert) :

```bash
# If it's the firt install of mkcert, run
mkcert -install

# Generate certificate for domain "localhost.dev", "domain.local" and their sub-domains
mkcert -cert-file certs/local-cert.pem -key-file certs/local-key.pem "localhost.dev" "*.localhost.dev" "domain.local" "*.domain.local"

mkcert -cert-file certs/local-cert.pem -key-file certs/local-key.pem "localhost.dev" "*.localhost.dev"  


```

Create networks that will be used by Traefik:

```bash
docker network create proxy
```

Now, start containers with :  

```bash
# Start Traefik
docker-compose -f docker-compose.yml up -d
# Start "whoami" example
docker-compose -f whoami.yml up
```

You can now go to your browser at [whoami.localhost.dev](https://whoami.localhost.dev), enjoy :rocket: !

*Note: you can access to Træfik dashboard at: [traefik.localhost.dev](https://traefik.localhost.dev)*

Don't forget that you can also map TCP and UDP through Træfik.

## hosts file Windows

```txt
127.0.0.1 localhost.dev traefik.localhost.dev whoami.localhost.dev smtp.localhost.dev zitadel.localhost.dev
```

## License

MIT
