# Why do we override default entrypoint for Potgres?

`docker-entrypoint-initdb.d/` does not support running every time. It runs only if the postgres volume is completely empty. Which is not great if we want to add one more database. We will need to clear MiaB every time when we to change or add something to the init script. While it's ok for one developer, it's not ok for others to remember about this.

[Community asked](https://github.com/docker-library/postgres/issues/191) for some startup script to run every time.
Offical image maintainers do not want to do it ([read this issue comment](https://github.com/docker-library/postgres/issues/191#issuecomment-387221757) & this [pr comment](https://github.com/docker-library/postgres/pull/979)).

So we copy `docker-entrypoint.sh` and add sevaral lines to make [`docker-entrypoint-on-every-start.d/`](https://github.com/docker-library/postgres/issues/191#issuecomment-252498084) possible.

# How do I upgrade entrypoint?

Get the latest `docker-entrypoint.sh` from [official repo](https://github.com/docker-library/postgres/blob/master/docker-entrypoint.sh).
Copy everything between `### OVERRIDE START ###` and `### OVERRIDE END ###` into same place of the new file.