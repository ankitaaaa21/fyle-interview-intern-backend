-- Write query to find the number of grade A's given by the teacher who has graded the most assignments
WITH TeacherAssignmentCounts AS (
    SELECT 
        teacher_id,
        COUNT(*) AS graded_assignments
    FROM 
        assignments
    WHERE 
        grade IS NOT NULL
    GROUP BY 
        teacher_id
),
TopGradingTeacher AS (
    SELECT 
        teacher_id
    FROM 
        TeacherAssignmentCounts
    ORDER BY 
        graded_assignments DESC
    LIMIT 1
)
SELECT 
    COUNT(*) AS grade_A_count
FROM 
    assignments
WHERE 
    grade = 'A'
    AND teacher_id IN (SELECT teacher_id FROM TopGradingTeacher);
