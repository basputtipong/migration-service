## Migration-Service
#### 1. Build container
- `make docker-build`  
#### 2. Start container
- `make docker-up`  
***
#### After container start, then you can connect to database(MySQL) with these configuration
- `host: localhost`
- `port: 3306`
- `database: devdb`
- `username: devusr`
- `password: devpassword`
***
#### 3. Run migrate DB  
- `make migrate-up`  
##### To create new migrate file  
- `make migrate-create name=<filename>` to create migration file  
***
#### 4. Seed data into DB
- *`make seed-all` to seed all file in dir /seeds*  
- *`make seed-one file=seeds/<filename>` to seed single file*  
***
##### *For seeds data file, please see the download link to download seeds.zip*  
##### *Then extract "seeds" folder into project directory.*  
##### Link: <u>[Download-link](https://drive.google.com/drive/folders/11cjKW-_cXPc4APblPQ3uszl2pzVCe3GB?usp=sharing)</u>