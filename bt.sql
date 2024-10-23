CREATE TABLE departments (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    active BOOLEAN DEFAULT TRUE
);

CREATE TABLE employees (
    id SERIAL PRIMARY KEY,
    name VARCHAR(50) NOT NULL,
    salary NUMERIC(15, 2) NOT NULL,
    active BOOLEAN DEFAULT TRUE,
    department_id INTEGER,
    CONSTRAINT fk_department FOREIGN KEY(department_id) REFERENCES departments(id) ON DELETE CASCADE
);

-- Thêm dữ liệu vào bảng departments
INSERT INTO departments (name) VALUES
('HR'),
('Finance'),
('IT'),
('Marketing'),
('Operations');

-- Thêm dữ liệu vào bảng employees
INSERT INTO employees (name, salary, department_id) VALUES
('Nguyen Van A', 12000000, 1),
('Le Thi B', 9000000, 1),
('Tran Van C', 15000000, 2),
('Pham Thi D', 8000000, 2),
('Hoang Van E', 11000000, 3),
('Vo Thi F', 9500000, 3),
('Bui Van G', 14000000, 4),
('Dang Thi H', 6000000, 4),
('Nguyen Van I', 13000000, 5),
('Le Thi J', 7000000, 5);


SELECT e.name AS employee_name, d.name AS department_name
FROM employees e
JOIN departments d ON e.department_id = d.id;


SELECT * FROM employees WHERE salary > 10000000;


SELECT d.name AS department_name, COUNT(e.id) AS employee_count
FROM departments d
LEFT JOIN employees e ON d.id = e.department_id
GROUP BY d.name;


--Cập nhật lương của nhân viên 'Nguyen Van A' thành 13 triệu
UPDATE employees
SET salary = 13000000
WHERE name = 'Nguyen Van A';


-- Ví dụ: Xóa phòng ban có tên 'IT'
DELETE FROM departments WHERE name = 'IT';
