BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "folders" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"seqUpdate"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "folders" VALUES (1,'Folder name',0);
COMMIT;
