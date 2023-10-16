-- Active: 1697283830777@@127.0.0.1@3306@test_1306A

-- 1. Creati o tabela prezenta care sa aiba o coloana id de tip INTEGER de dimensiune 3, o coloana c_enum de tip ENUM si o coloana c_set de tip SET,
-- unde coloana c_enum contine zilele saptamanii, iar coloana c_set contine caracterele ’p’, ’a’, ’r’, ’m’ (reprezentând „prezent”, „absent”, „recuperare” si
-- „medical”)
CREATE TABLE prezenta (id INTEGER(3), c_enum ENUM ('Luni', 'Marti', 'Miercuri', 'Joi', 'Vineri', 'Sambata', 'Duminica'), c_set SET ('p', 'a', 'r', 'm'));
DESC prezenta;

-- 2. Introduceti valori în tabela prezenta astfel încât suma dintre c_enum si c_set sa fie 7 folosind comanda: INSERT INTO prezenta(id, c_enum, c_set) VALUES (...), etc
-- Valorile din INSERT vor contine pentru c_enum valori numerice si/sau literale, iar în coloana c_set se vor pune valori care respecta conditia din enunt.
-- Pentru verificare se va folosi comanda: SELECT * FROM prezenta WHERE c_enum+c_set=7;
INSERT INTO prezenta(id, c_enum, c_set) VALUES (1, 1, 6), (2, 2, 5), (3, 3, 4), (4, 4, 4), (5, 4, 3), (6, 5, 2), (7, 6, 3), (8, 7, 0);
SELECT * FROM prezenta WHERE c_enum + c_set = 7;

-- 3. Introduceti valoarea 8 în coloana c_enum ¸si afisati valoarea introdusa. Explicati rezultatul. Ce valoare ar trebui introdusa in coloana c_set pentru a
-- obtine acelasi efect?
INSERT INTO prezenta VALUES (9, 8, 0);
SELECT * FROM prezenta WHERE id=9; -- in coloana de c_enum pentru valoarea nou introdusa, nu se afiseaza nimic, deoarece este asociat nicio valoare la indexul 8

INSERT INTO prezenta VALUES (10, 7, 16);
SELECT * FROM prezenta WHERE id=10; -- acelasi efect si pe c_set pentru ca am introdus un numar (16) care se poate forma prin 5 biti, iar noi avem doar 4 biti
                                    -- (sau daca introduc valoarea 0 pe c_set, obtin acelasi efect deoarece nu se afiseaza nicio litera)

DROP DATABASE test_1306A;