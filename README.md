# Migration-Service

## 1. Build Container
```bash
make docker-build
```

## 2. Start Container
```bash
make docker-up
```

---

## Database Configuration

After starting the container, you can connect to the MySQL database using the following configuration:

- Host: `localhost`
- Port: `3306`
- Database: `devdb`
- Username: `devusr`
- Password: `devpassword`

---

## 3. Run Migration

Run all migration files:
```bash
make migrate-up
```

To create a new migration file:
```bash
make migrate-create name=<filename>
```

---

## 4. Seed Data into Database

Seed all files in the `/seeds` directory:
```bash
make seed-all
```

Seed a specific file:
```bash
make seed-one file=seeds/<filename>
```

---

### Notes

- For seed data files, please download and extract the `seeds` folder into the project directory.
- Download link for seed data:
  [Download seeds.zip](https://drive.google.com/drive/folders/11cjKW-_cXPc4APblPQ3uszl2pzVCe3GB?usp=sharing)
