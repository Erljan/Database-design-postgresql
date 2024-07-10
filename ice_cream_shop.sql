
DROP TABLE IF EXISTS locations CASCADE;
CREATE TABLE locations (
    loc_id SERIAL PRIMARY KEY,
    loc_name VARCHAR(20) NOT NULL
);

INSERT INTO locations(loc_name) 
    VALUES
        ('New York'),
        ('Wisconsin'),
        ('California');


DROP TABLE IF EXISTS shop CASCADE;
CREATE TABLE shop(
    id SERIAL PRIMARY KEY,
    empl_id INT ,
    inventory_id INT,
    sales_id INT NOT NULL,
    loc_id INT NOT NULL,

    FOREIGN KEY (empl_id) REFERENCES employees(empl_id),
    FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id),
    FOREIGN KEY (sales_id) REFERENCES sales(sales_id),
    FOREIGN KEY (loc_id) REFERENCES locations(loc_id)
);

-- SELECT setval('shop_id_seq', (SELECT MAX(id) FROM shop));
-- INSERT INTO shop (empl_id) VALUES (2);
INSERT INTO shop (empl_id,loc_id, sales_id) 
    VALUES
        (1,1,1),
        (2, 2,1);


DROP TABLE IF EXISTS work_hrs CASCADE;
CREATE TABLE work_hrs (
    hours_id SERIAL PRIMARY KEY,
    working_hour VARCHAR(20)
);


INSERT INTO work_hrs (working_hour) VALUES 
    ('9AM-3PM'),
    ('3PM-9PM');

DROP TABLE IF EXISTS employee_work_hrs;
CREATE TABLE employee_work_hrs(
    ewh_id SERIAL PRIMARY KEY,
    empl_id INT,
    hours_id INT,
    FOREIGN KEY (empl_id) REFERENCES employees(empl_id),
    FOREIGN KEY (hours_id) REFERENCES work_hrs(hours_id)
);

INSERT INTO employee_work_hrs (empl_id, work_hrs) 
    VALUES
        (1, 1),
        (2,1),
        (3, 2);


DROP TABLE IF EXISTS employees CASCADE;
CREATE TABLE employees (
    empl_id SERIAL PRIMARY KEY,
    empl_name VARCHAR(255),
    empl_num INT CHECK (empl_num >= 3),
    position VARCHAR(20) DEFAULT('Clerk')
);

INSERT INTO employees (empl_name, hours_id, position) VALUES
    ('Erljan','Manager'),
    ('Andrew','Clerk'),
    ('Kenny', 'Clerk');


-- SELECT *
-- FROM shop
-- JOIN employees
-- ON shop.empl_id = employees.empl_id

-- SELECT setval('employees_empl_id_seq', (SELECT MAX(empl_id) FROM employees));


DROP TABLE IF EXISTS inventory CASCADE;
CREATE TABLE inventory (
    inventory_id SERIAL PRIMARY KEY,
    bucket_id INT NOT NULL,
    cones_id INT NOT NULL,
    FOREIGN KEY (bucket_id) REFERENCES buckets(bucket_id),
    FOREIGN KEY (cones_id) REFERENCES cones(cones_id)
);

INSERT INTO inventory (bucket_id, cones_id) VALUES (1, 1);


DROP TABLE IF EXISTS buckets CASCADE;
CREATE TABLE buckets(
    bucket_id SERIAL PRIMARY KEY,
    flavors VARCHAR(100) NOT NULL,
    bucket_num INT NOT NULL
);
INSERT INTO buckets(flavors, bucket_num) 
    VALUES 
        ('Vanilla', 3),
        ('Chocolate', 5),
        ('Strawberry', 2);


DROP TABLE IF EXISTS cones CASCADE;
CREATE TABLE cones(
    cones_id SERIAL PRIMARY KEY,
    cones_type VARCHAR(100) NOT NULL,
    cones_number INT NOT NULL
);

INSERT INTO cones (cones_type, cones_number) 
    VALUES
        ('waffle', 9),
        ('sugar', 8),
        ('cake', 5);


SELECT obj_description('cones'::regclass);

EXPLAIN ANALYZE SELECT * FROM cones WHERE cones_number > 5;
        
DROP TABLE IF EXISTS sales CASCADE;
CREATE TABLE sales(
    sales_id SERIAL PRIMARY KEY,
    transac_id BIGINT NOT NULL,
    FOREIGN KEY (transac_id) REFERENCES transactions(transac_id)
);
INSERT INTO sales(transac_id) 
    VALUES 
        (1);
        -- (2),
        -- (3);



DROP TABLE IF EXISTS transactions CASCADE;
CREATE TABLE transactions (
    transac_id SERIAL PRIMARY KEY,
    price DECIMAL(4,2) NOT NULL,
    cones_id INT NOT NULL,
    FOREIGN KEY (cones_id) REFERENCES cones(cones_id)
);

INSERT INTO transactions (price, cones_id) 
    VALUES
        (7.99, 1);
        -- (6.99, 2),
        -- (7.99, 1);

SELECT *
FROM transactions
JOIN sales
ON transactions.transac_id = sales.transac_id;



SELECT shop.id, shop.empl_id, employees.empl_id, employees.empl_name, employees.position
FROM shop
JOIN employees
ON shop.empl_id = employees.empl_id;


SELECT shop.id, shop.empl_id, employees.empl_id, employees.empl_name, employees.position
FROM shop
LEFT JOIN employees
ON shop.empl_id = employees.empl_id;


SELECT shop.id, shop.empl_id, employees.empl_id, employees.empl_name, employees.position
FROM shop
RIGHT JOIN employees
ON shop.empl_id = employees.empl_id;


SELECT shop.id, shop.empl_id, employees.empl_id, employees.empl_name, employees.position
FROM shop
FULL OUTER JOIN employees
ON shop.empl_id = employees.empl_id;