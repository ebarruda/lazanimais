CREATE TABLE [animal_caracteristica] ([codigo] INTEGER NOT NULL ON CONFLICT ROLLBACK PRIMARY KEY ON CONFLICT ROLLBACK AUTOINCREMENT UNIQUE ON CONFLICT ROLLBACK, [codigo_animal] INTEGER REFERENCES [animal](codigo), [codigo_caracteristica] INTEGER REFERENCES [caracteristica](codigo));

CREATE TABLE [animal] ([codigo] INTEGER NOT NULL ON CONFLICT ROLLBACK PRIMARY KEY ON CONFLICT ROLLBACK AUTOINCREMENT UNIQUE ON CONFLICT ROLLBACK, [nome] VARCHAR(100) NOT NULL ON CONFLICT ROLLBACK UNIQUE ON CONFLICT ROLLBACK);

CREATE TABLE [caracteristica] ([codigo] INTEGER NOT NULL ON CONFLICT ROLLBACK PRIMARY KEY ON CONFLICT ROLLBACK AUTOINCREMENT UNIQUE ON CONFLICT ROLLBACK, [nome] VARCHAR NOT NULL ON CONFLICT ROLLBACK UNIQUE ON CONFLICT ROLLBACK);

CREATE TRIGGER [delete_animal_caracteristica] BEFORE DELETE ON [animal] BEGIN DELETE FROM animal_caracteristica WHERE codigo_animal = OLD.codigo ; END;

INSERT INTO animal_caracteristica (codigo, codigo_animal, codigo_caracteristica) VALUES (1, 1, 1);
INSERT INTO animal_caracteristica (codigo, codigo_animal, codigo_caracteristica) VALUES (2, 1, 2);
INSERT INTO animal_caracteristica (codigo, codigo_animal, codigo_caracteristica) VALUES (3, 2, 3);
INSERT INTO animal_caracteristica (codigo, codigo_animal, codigo_caracteristica) VALUES (4, 2, 4);



INSERT INTO animal (codigo, nome) VALUES (1, 'cão');
INSERT INTO animal (codigo, nome) VALUES (2, 'galinha');



INSERT INTO caracteristica (codigo, nome) VALUES (1, 'peludo');
INSERT INTO caracteristica (codigo, nome) VALUES (2, 'late');
INSERT INTO caracteristica (codigo, nome) VALUES (3, 'tem bico');
INSERT INTO caracteristica (codigo, nome) VALUES (4, 'tem penas');



