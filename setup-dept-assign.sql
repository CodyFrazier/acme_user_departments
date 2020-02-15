create extension if not exists "uuid-ossp";
DROP TABLE IF EXISTS assignments; -- Child, DELETE CHILDREN FIRST!
DROP TABLE IF EXISTS departments; -- Parent
DROP TABLE IF EXISTS users; -- Parent 

CREATE TABLE departments(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
    name VARCHAR(30) NOT NULL,
    CHECK (char_length(name) > 0)
);
CREATE TABLE users(
    id UUID PRIMARY KEY DEFAULT uuid_generate_v1(),
    name VARCHAR(30) NOT NULL, 
    CHECK (char_length(name) > 0)
);
CREATE TABLE assignments(
    employee_id UUID REFERENCES users(id),
    --employee_name VARCHAR(30), 
    --department_name VARCHAR(30),
    department_id UUID REFERENCES departments(id)
    
);

INSERT INTO departments(name) 
VALUES ('Engineering'),
    ('HR'),
    ('Finance'),
    ('Shipping');

INSERT INTO users(name) 
VALUES ('Pam'),
    ('Dwight'),
    ('Jim'),
    ('Michael');

--
INSERT INTO assignments(employee_id, department_id) 
VALUES (
    (SELECT id FROM users WHERE name = 'Pam'), 
    (SELECT id FROM departments WHERE name = 'Engineering')
        ),
        (
    (SELECT id FROM users WHERE name = 'Pam'), 
    (SELECT id FROM departments WHERE name = 'HR')
        )
    ;
--
SELECT name FROM users;
SELECT name FROM departments;
SELECT * FROM assignments;
