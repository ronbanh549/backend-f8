CREATE DATABASE exam_management;


-- Tạo bảng subject
CREATE TABLE subject (
    id SERIAL PRIMARY KEY,
    name VARCHAR(255) NOT NULL
);

-- Tạo bảng student
CREATE TABLE student (
    id bigserial PRIMARY KEY,
    name text NOT NULL,
    created_at  timestamp with time zone NOT NULL DEFAULT now(),
    created_by  bigint,
    modified_at timestamp with time zone,
    modified_by bigint,
    deleted_at  timestamp with time zone,
    deleted_by  bigint,
    active      boolean                           DEFAULT TRUE,
);

-- Tạo bảng exam
CREATE TABLE exam (
    id bigserial PRIMARY KEY,
    subject_id INT REFERENCES subject(id) ON DELETE CASCADE,
    name text NOT NULL,
    created_at  timestamp with time zone NOT NULL DEFAULT now(),
    created_by  bigint,
    modified_at timestamp with time zone,
    modified_by bigint,
    deleted_at  timestamp with time zone,
    deleted_by  bigint,
    active      boolean                           DEFAULT TRUE,
);
    


-- Tạo bảng question
CREATE TABLE question (
    id bigserial PRIMARY KEY,
    exam_id bigint REFERENCES exam(id) ON DELETE CASCADE,
    question text NOT NULL,
    correct_answer text NOT NULL,
    created_at  timestamp with time zone NOT NULL DEFAULT now(),
    created_by  bigint,
    modified_at timestamp with time zone,
    modified_by bigint,
    deleted_at  timestamp with time zone,
    deleted_by  bigint,
    active      boolean                           DEFAULT TRUE,
);


-- Tạo bảng exam_result
CREATE TABLE exam_result (
    id SERIAL PRIMARY KEY,
    student_id INT REFERENCES student(id) ON DELETE CASCADE,
    question_id INT REFERENCES question(id) ON DELETE CASCADE,
    is_correct BOOLEAN NOT NULL,
    created_at  timestamp with time zone NOT NULL DEFAULT now(),
    created_by  bigint,
    modified_at timestamp with time zone,
    modified_by bigint,
    deleted_at  timestamp with time zone,
    deleted_by  bigint,
    active      boolean                           DEFAULT TRUE,
);

-----Lấy danh sách các bài thi theo subject_id
SELECT * 
FROM exam 
WHERE subject_id = <subject_id>;
----Lấy danh sách các bài thi kèm theo danh sách các câu hỏi, where theo subject_id
SELECT 
    exam.id AS exam_id,
    exam.name AS exam_name,
    question.id AS question_id,
    question.question AS question_text,
    question.correct_answer
FROM exam e
JOIN question q ON exam.id = question.exam_id
WHERE exam.subject_id = <subject_id>
ORDER BY exam.id;

----- Lấy kết quả làm bài của 1 môn học (id học sinh, tên học sinh, danh sách bài thi, danh sách câu hỏi), where theo subject_id
SELECT 
    student.id AS student_id,
    student.name AS student_name,
    exam.id AS exam_id,
    exam.name AS exam_name,
    question.id AS question_id,
    question.question AS question_text,
    result.is_correct
FROM student s
JOIN exam_result r ON student.id = result.student_id
JOIN question q ON result.question_id = question.id
JOIN exam e ON question.exam_id = exam.id
WHERE exam.subject_id = <subject_id>
ORDER BY student.id, exam.id, question.id;
