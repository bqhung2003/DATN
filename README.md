## Install library

```
npm install
```

## Grant permission

```
chmod -R 777 ../{project_name}/
```

## Run test

```
./run_newman.sh "{module_name}"
```

## Restore DB with docker mysql

```
docker exec -i {mysql_container} mysql -u {username} -p{password} {database_name} < {sql_file}
```