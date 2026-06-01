--enrollments
CREATE INDEX enrollments_by_student
ON enrollments(student_id);

CREATE INDEX enrollments_by_course
ON enrollments(course_id);

-- courses
CREATE INDEX courses_by_dept_number_semester
ON courses(department, number, semester);

CREATE INDEX courses_by_semester
ON courses(semester);

CREATE INDEX courses_by_title_semester
ON courses(title, semester);

-- satisfies
CREATE INDEX satisfies_by_course
ON satisfies(course_id);
