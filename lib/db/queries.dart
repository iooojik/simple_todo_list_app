String createFoldersTable = """
CREATE TABLE IF NOT EXISTS "folders" (
	"id"	INTEGER NOT NULL UNIQUE,
	"name"	TEXT NOT NULL,
	"seqUpdate"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
INSERT INTO "folders" VALUES (1,'Folder name',0);
""";

String createTodoItemsTable = """
CREATE TABLE IF NOT EXISTS "todo_items" (
	"id"	INTEGER NOT NULL UNIQUE,
	"text"	TEXT NOT NULL,
	"done"	INTEGER NOT NULL,
	"seqUpdate"	INTEGER NOT NULL,
	"folderId"	INTEGER NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
""";
