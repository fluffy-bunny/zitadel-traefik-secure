# Zitadel Postrges Traefik Secure

This repo is a minimal template to use Traefik v2 on localhost with HTTPS support.

To get started, just clone this repo:

## Thanks 
[traefik-v2-https-ssl-localhost](https://github.com/Heziode/traefik-v2-https-ssl-localhost)  
[jimsgarage zitadel](https://github.com/JamesTurland/JimsGarage/tree/main/Zitadel)  
[jimsgargage youtube](https://www.youtube.com/watch?v=1T1uxKW06Vs)  

```bash
git clone https://github.com/fluffy-bunny/zitadel-traefik-secure.git
```

Next, go to the root of the repo (`cd zitadel-traefik-secure`) and generate certificates using [mkcert](https://github.com/FiloSottile/mkcert) :

```bash
# If it's the firt install of mkcert, run
mkcert -install

# Generate certificate for domain "localhost.dev"

mkcert -cert-file certs/local-cert.pem -key-file certs/local-key.pem "localhost.dev" "*.localhost.dev"  


```

Create networks that will be used by Traefik:

```bash
docker network create proxy
```

Now, start containers with :  

```bash
# Start Zitadel
docker-compose -f docker-compose.yml up -d
 
```

You can now go to your browser at [whoami.localhost.dev](https://whoami.localhost.dev), enjoy :rocket: !  
You can now go to your browser at [zitadel.localhost.dev](https://zitadel.localhost.dev), enjoy :rocket: !  
You can now go to your browser at [pgadmin.localhost.dev](https://pgadmin.localhost.dev), enjoy :rocket: !  
You can now go to your browser at [smtp.localhost.dev](https://smtp.localhost.dev), enjoy :rocket: !  

*Note: you can access to Træfik dashboard at: [traefik.localhost.dev](https://traefik.localhost.dev)*

Don't forget that you can also map TCP and UDP through Træfik.

## hosts file Windows

```txt
127.0.0.1 localhost.dev traefik.localhost.dev whoami.localhost.dev smtp.localhost.dev zitadel.localhost.dev pgadmin.localhost.dev
```

## Zitadel SMTP

I configured zitadel to use SMTP4DEV  

```bash
smtp4dev:25
```
 

[smtp4dev localhost](https://smtp.localhost.dev/)  

## License

MIT
