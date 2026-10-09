# Base de datos — Sistema de gestión para tienda de indumentaria

## Requisitos
- PostgreSQL 15 o superior (el esquema usa `UNIQUE NULLS NOT DISTINCT`).

## Instalación local

```bash
createdb tienda_indumentaria
psql -d tienda_indumentaria -f schema.sql
psql -d tienda_indumentaria -f seed.sql   # opcional, datos de prueba
```

## Conexión desde el backend

El backend se conecta con estas variables de entorno (ver `.env.example` en `/backend`):

```
DB_HOST=localhost
DB_PORT=5432
DB_NAME=tienda_indumentaria
DB_USER=<usuario>
DB_PASSWORD=<contraseña>
```

Funciona igual con un cliente `pg` directo o con un ORM (Prisma/TypeORM) que
introspecte esta base ya creada — no depende de esa decisión.

## Notas de diseño

Ver [`DER.md`](../docs/diagramas/DER.md) para el diagrama, la explicación del modelo y las
decisiones de diseño. Solo una nota operativa que no es de diseño: las
contraseñas de `usuario` se guardan como hash; los valores del `seed.sql`
son placeholders que el backend debe reemplazar.
